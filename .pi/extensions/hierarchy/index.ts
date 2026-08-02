/**
 * Hierarchy — hierarchical orchestration of pi subagents.
 *
 * This extension lets the parent agent launch long-lived subagents
 * (each a `pi --mode rpc` child process), observe their progress turn by
 * turn, inject messages into their input queue, and receive reports — the
 * primitives needed to build workflows like deep research and persistent
 * multi-tier agent trees.
 *
 * Tools exposed to the parent model:
 *   - spawn_subagent        start a subagent, optionally with an initial prompt
 *   - steer_subagent        inject a steering message (delivered after the
 *                           current turn's tool calls, before the next LLM call)
 *   - follow_up_subagent   queue a message for when the subagent next idles
 *   - observe_subagent      read recent messages / turns from a subagent,
 *                           paginated to protect the parent's context
 *   - await_subagent        block until a subagent's process is idle or exits,
 *                           returning its last assistant text (NOT 'done')
 *   - abort_subagent        cancel the subagent's current run (keeps process)
 *   - dispose_subagent      terminate a subagent process
 *   - list_subagents        summarize all live subagents
 *
 * Tool exposed to subagent processes (rpc mode only):
 *   - report                deliver a result/finding/question to this
 *                           subagent's parent. Repeatable; does not mean 'done'.
 *
 * Recursion: subagents are launched with this same extension loaded, so a
 * non-interactive tier-2 subagent can spawn tier-3 subagents of its own.
 *
 * Reporting model (read this — it is NOT 'settled means done'):
 *
 * A subagent never declares "done." It only REPORTS, then ends its turn and
 * becomes INTRINSICALLY IDLE — a normal, resumable resting state. The parent
 * is woken in exactly two cases:
 *
 *   1. Explicit report — the subagent called the `report` tool, which wrote a
 *      `hierarchy_report` custom entry into its own session. We detect it via
 *      get_entries on the turn's turn_end and deliver the payload to the
 *      parent immediately. The subagent may keep working and report again.
 *
 *   2. Implicit intrinsic-idle report — the subagent ended its turn WITHOUT
 *      calling `report`, and nothing in its subtree can continue without
 *      external intervention. The harness forwards the subagent's last
 *      assistant output, honestly labeled as inferred. This is the safety net
 *      for the forgotten explicit report.
 *
 * `settled` is pi's process-level idle signal ("this process won't continue
 * without external input"). It is NOT a report and is NOT delivered to the
 * parent conversation — it only drives report *detection* (we read the
 * child's entries to decide explicit vs implicit) and the live-tree refresh.
 *
 * Why: a coordinator that spawns children and then ends its turn fires
 * `agent_settled` the moment its own turn ends, even though its children are
 * still running. Treating `settled` as a report meant the coordinator was
 * falsely reported "done" to its parent while its real work was unstarted.
 * Subtree-intrinsic idleness is the property that actually means "nothing
 * left to do without intervention," and that is the only thing that reports
 * up implicitly.
 *
 * Per-episode reset: any resume (agent_start, a new turn, or a steer from the
 * parent) clears the episode flags so a subsequent stall can report again.
 * This makes "report → idle → parent steers → report again" a repeatable
 * cycle for persistent hierarchies, not a one-shot.
 */

import * as path from "node:path";
import type { ExtensionAPI, ExtensionContext } from "@earendil-works/pi-coding-agent";
import { Type } from "typebox";
import { RpcClient } from "./rpc-client.ts";
import {
  SubagentManager,
  type SubagentNotification,
  type HierarchyNode,
} from "./subagent-manager.ts";

// Bound the work observe_subagent can return per call. The parent can always
// call again with a `since` cursor for more — this is the whole point of
// letting the parent protect its own context.
const OBSERVE_DEFAULT_LIMIT = 5;
const OBSERVE_MAX_LIMIT = 40;
const FINAL_OUTPUT_CAP = 32 * 1024;
// Default cap on how long await_subagent blocks. The previous default was 0
// (wait forever), which is what let a hung subagent pin the parent overnight.
// A subagent that hasn't settled in 10 minutes is almost certainly stuck;
// callers who genuinely want unbounded wait can pass timeout_ms: 0 explicitly.
const AWAIT_DEFAULT_TIMEOUT_MS = 10 * 60 * 1000;

// Widget id used for the live subagent tree (rendered above the editor).
const TREE_WIDGET_ID = "hierarchy-tree";
const TREE_STATUS_ID = "hierarchy";
//
// Deep-subtree reactivity. Direct children push their own events to us, but a
// grandchild's state change (e.g. tokens being spent three tiers down) does
// NOT produce an event at our tier — it goes to its parent's process, not
// ours. To keep the TUI tree responsive while a coordinator sits idle atop a
// busy subtree, we poll each direct child's latest `hierarchy_tree` snapshot
// entry on this interval and re-render if it changed. This is a read-only
// poll: pure get_entries RPC reads, no model turns, no LLM context injection.
// It's the one place we depart from the extension's "no polling" philosophy,
// and only because the protocol offers no push channel for deep state.
const TREE_POLL_INTERVAL_MS = 1500;

// --- Resolve this extension's directory so we can pass it to children. ---
// __dirname works because pi loads extensions via jiti with a real file path.
const SELF_DIR = __dirname;

export default function hierarchy(pi: ExtensionAPI) {
  // Late-bound UI helpers, set on session_start. We keep the manager itself
  // session-scoped so a /resume or /new tears down old subagents cleanly.
  let manager: SubagentManager | null = null;
  let ctxRef: ExtensionContext | null = null;
  // Tracks which subagents have already had an `exit` note delivered to the
  // parent as a turn, so a later event can't double-deliver. (Report delivery
  // uses the manager's per-episode flags, not this set.)
  const deliveredFinal = new Set<string>();

  // Inject a user message into the parent's conversation so the parent model
  // is woken with the subagent's result as a new turn. `followUp` is safe in
  // both states: immediate delivery if the parent is idle, queued after the
  // current turn's tools if the parent is mid-run. Throws are swallowed so a
  // delivery failure can never break the broader notification flow.
  const deliverToParent = (message: string) => {
    try {
      pi.sendUserMessage(message, { deliverAs: "followUp" });
    } catch (err) {
      // Best-effort: log to the UI if available, but never throw out of notify.
      ctxRef?.ui.notify(`⚠ failed to deliver subagent result to parent: ${String((err as Error)?.message ?? err)}`, "error");
    }
  };

  const notifyParent = (n: SubagentNotification) => {
    const mgr = manager;
    // UI signal (one-line preview) — only when there's a TUI to show it.
    if (ctxRef?.hasUI) {
      const icon =
        n.kind === "turn_end"
          ? "↻"
          : n.kind === "settled"
            ? "✓"
            : n.kind === "report"
              ? "📤"
              : n.kind === "intrinsically_idle"
                ? "💤"
                : n.kind === "exit"
                  ? "■"
                  : "⚠";
      let line = `${icon} [${n.label}]`;
      if (n.kind === "turn_end" && n.summary) {
        const tools = n.summary.toolCalls.length ? ` · ${n.summary.toolCalls.join(", ")}` : "";
        const preview = n.summary.text.slice(0, 140).replace(/\s+/g, " ");
        line += ` turn #${n.summary.turnIndex ?? "?"}${tools}`;
        if (preview) line += ` — ${preview}`;
      } else if (n.kind === "settled") {
        line += ` idle`;
      } else if (n.kind === "report") {
        line += ` reported`;
      } else if (n.kind === "intrinsically_idle") {
        line += ` intrinsically idle`;
      } else if (n.kind === "exit") {
        line += ` exited (code ${n.exitCode ?? "?"})`;
      } else if (n.kind === "error") {
        line += ` error: ${n.message ?? "unknown"}`;
      }
      ctxRef.ui.notify(line, n.kind === "error" ? "error" : "info");
    }

    // Context injection: the reporting model.
    //
    // A subagent never declares "done." It only REPORTS, then ends its turn
    // and becomes intrinsically idle — a normal, resumable resting state.
    // The parent is woken in exactly two cases:
    //
    //   1. `report` — the agent explicitly called the `report` tool, which
    //      wrote a `hierarchy_report` custom entry into its own session. We
    //      detected it (in detectReport below) and the manager fired a
    //      `report` notification carrying the entry's payload. Deliver it
    //      immediately; the node may keep working and report again later.
    //
    //   2. `intrinsically_idle` — the agent ended its turn WITHOUT explicitly
    //      reporting, and nothing in its subtree can continue without
    //      external intervention. This is the implicit fallback: the agent
    //      forgot to call `report`, so the harness forwards its last
    //      assistant output, honestly labeled as inferred.
    //
    // `settled` is pi's process-level idle signal. It is NOT a report and is
    // NOT delivered to the parent conversation — it only drives report
    // *detection* (we read the child's entries to decide explicit vs
    // implicit) and the live-tree refresh. This is the fix for the bug where
    // a coordinator that spawned children and then ended its turn would
    // "settle" and be falsely reported as done to its parent while its
    // children were still running.
    //
    // `exit` is delivered once as a terminal note. `turn_end`/`error` are
    // signal-only.
    if (n.kind === "report") {
      const body =
        `Subagent "${n.label}" (${n.subagentId}) reported:\n\n${n.reportText ?? "(empty report)"}`;
      deliverToParent(body);
    } else if (n.kind === "intrinsically_idle") {
      const text = n.reportText && n.reportText.length > 0 ? n.reportText : null;
      const body = text
        ? `Subagent "${n.label}" (${n.subagentId}) ended its turn without an explicit report; ` +
          `its subtree is quiescent. Last assistant output (inferred):\n\n${text}`
        : `Subagent "${n.label}" (${n.subagentId}) ended its turn without an explicit report ` +
          `and its subtree is quiescent. (No assistant output was captured.)`;
      deliverToParent(body);
    } else if (n.kind === "exit" && !deliveredFinal.has(n.subagentId)) {
      deliveredFinal.add(n.subagentId);
      deliverToParent(
        `Subagent "${n.label}" (${n.subagentId}) exited (code ${n.exitCode ?? "?"}). No report was delivered.`,
      );
    } else if (n.kind === "turn_end" && n.summary) {
      // If the turn included a `report` tool call, the `hierarchy_report`
      // entry was just written; read the child's entries now and deliver it
      // explicitly. Gating on the tool name avoids an RPC call on every turn.
      if (n.summary.toolCalls.some((t) => t.startsWith("report("))) {
        void detectAndDeliverReport(n.subagentId);
      }
    } else if (n.kind === "settled") {
      // Process went idle. Decide explicit-vs-implicit by reading entries. If a
      // fresh `hierarchy_report` is present, the explicit path already fired
      // via turn_end above; otherwise this is the implicit intrinsic-idle
      // fallback (the agent forgot to report, or is a coordinator whose
      // subtree just finished).
      void detectAndDeliverReportOrImplicit(n.subagentId);
    }

    // Any subagent state change is also a reason to refresh the live tree.
    void refreshTree();
  };

  /**
   * Read a child's session entries since our cursor and look for a fresh
   * `hierarchy_report` custom entry. If found, fire an explicit report to the
   * parent (via the manager) and advance `lastReportEntryId`. Also advances
   * `lastSeenEntryId` so repeated calls don't re-process entries.
   *
   * Returns true if an explicit report was found and fired.
   */
  async function detectAndDeliverReport(subagentId: string): Promise<boolean> {
    const mgr = manager;
    const rec = mgr?.get(subagentId);
    if (!rec) return false;
    let res;
    try {
      res = await rec.client.getEntries(rec.lastSeenEntryId);
    } catch {
      return false;
    }
    if (res.leafId) rec.lastSeenEntryId = res.leafId;
    const report = (res.entries ?? [])
      .filter((e) => e?.type === "custom" && e?.customType === "hierarchy_report")
      .pop(); // most recent
    if (!report) return false;
    if (rec.lastReportEntryId && report.id === rec.lastReportEntryId) return false;
    rec.lastReportEntryId = report.id;
    const text = report?.data?.text ?? "";
    mgr?.fireExplicitReport(subagentId, text);
    return true;
  }

  /**
   * Called on `settled`. First try to find a fresh explicit report entry (the
   * agent may have reported as its final action). If none, the node is
   * intrinsically idle: fire the implicit fallback carrying the last
   * assistant text, labeled as inferred.
   */
  async function detectAndDeliverReportOrImplicit(subagentId: string): Promise<void> {
    const mgr = manager;
    const rec = mgr?.get(subagentId);
    if (!rec) return;
    const found = await detectAndDeliverReport(subagentId);
    if (found) return;
    // No explicit report this episode → implicit intrinsic-idle fallback.
    let text: string | null = null;
    try {
      text = await rec.client.getLastAssistantText();
    } catch {
      // process may have exited
    }
    if (text == null || text === "") {
      text = rec.recentTurns[rec.recentTurns.length - 1]?.text ?? null;
    }
    const payload = text ? truncate(text, FINAL_OUTPUT_CAP) : null;
    mgr?.fireIntrinsicIdle(subagentId, payload);
  }

  // Interval handle for the deep-subtree reactivity poll (TUI mode only).
  let pollHandle: ReturnType<typeof setInterval> | null = null;
  // Compact signature of the last tree we rendered, so the poll only
  // re-renders when something actually changed — not every interval tick.
  let lastRenderedSignature = "";

  /**
   * Re-render the subagent tree as a widget above the editor, plus a one-line
   * status in the footer. Async because rendering the full tree requires
   * reading each direct child's latest `hierarchy_tree` snapshot entry (one
   * RPC round-trip per direct child; no model turns). Guarded on TUI mode:
   * RPC/print/json children run this same extension for its tools, but have no
   * TUI to render into.
   *
   * `force` bypasses the signature change check (used by the poll, which
   * wants to re-render only when the tree actually changed).
   */
  async function refreshTree(force = false): Promise<void> {
    const ctx = ctxRef;
    if (!ctx || ctx.mode !== "tui") return;
    const mgr = manager;
    const tree = mgr ? await mgr.snapshot() : [];
    const sig = treeSignature(tree);
    if (!force && sig === lastRenderedSignature) return; // nothing changed
    lastRenderedSignature = sig;

    if (tree.length === 0) {
      ctx.ui.setWidget(TREE_WIDGET_ID, undefined);
      ctx.ui.setStatus(TREE_STATUS_ID, undefined);
      return;
    }

    // Count working nodes across the WHOLE tree (recursive) for the footer.
    const stats = countTree(tree);
    const lines: string[] = [];
    lines.push(`hierarchy · ${stats.total} subagent${stats.total === 1 ? "" : "s"}`);
    for (const n of tree) {
      lines.push(`  ${formatTreeNode(n, /*depth=*/ 1)}`);
    }
    ctx.ui.setWidget(TREE_WIDGET_ID, lines);
    ctx.ui.setStatus(
      TREE_STATUS_ID,
      ctx.ui.theme.fg("accent", `⌘ hierarchy: ${stats.total} live`) +
        (stats.working ? ctx.ui.theme.fg("warning", ` · ${stats.working} working`) : ""),
    );
  }

  function formatTreeNode(n: HierarchyNode, depth: number): string {
    const ctx = ctxRef;
    const pad = "  ".repeat(depth);
    const icon = nodeIcon(n);
    const statusColor =
      n.status === "working"
        ? "accent"
        : n.status === "idle"
          ? n.intrinsicallyIdle
            ? "muted"
            : "success"
          : n.status === "exited"
            ? "muted"
            : "dim";
    const iconStr = ctx ? ctx.ui.theme.fg(statusColor, icon) : icon;
    const label = n.label === n.id ? n.id : `${n.label} (${n.id})`;
    const tail =
      ` — ${n.usage.turns}t ↑${n.usage.input} ↓${n.usage.output} $${n.usage.cost.toFixed(4)}` +
      (n.status === "exited" ? ` exit=${n.exitCode ?? "?"}` : "");
    let line = `${pad}${iconStr} ${label}${ctx ? ctx.ui.theme.fg("dim", tail) : tail}`;
    for (const c of n.children) {
      line += `\n${formatTreeNode(c, depth + 1)}`;
    }
    return line;
  }

  function nodeIcon(n: HierarchyNode): string {
    if (n.status === "exited") return "■";
    if (n.status === "working") return "↻";
    if (n.intrinsicallyIdle) return "💤";
    if (n.status === "idle") return "✓";
    return "·";
  }

  /** Recursive count + working tally for the footer status line. */
  function countTree(nodes: HierarchyNode[]): { total: number; working: number } {
    let total = 0;
    let working = 0;
    const walk = (ns: HierarchyNode[]) => {
      for (const n of ns) {
        total++;
        if (n.status === "working" || n.status === "starting") working++;
        if (n.children.length) walk(n.children);
      }
    };
    walk(nodes);
    return { total, working };
  }

  /**
   * Compact string signature of a tree for cheap change detection. Only
   * includes fields that affect rendering, so transient usage-token updates
   * don't thrash the widget, but status transitions do.
   */
  function treeSignature(nodes: HierarchyNode[]): string {
    const walk = (ns: HierarchyNode[]): string =>
      ns.map((n) => `${n.id}:${n.status}:${n.intrinsicallyIdle ? 1 : 0}:${n.exitCode ?? "-"}[${walk(n.children)}]`).join(",");
    return walk(nodes);
  }

  /**
   * Start (if needed) the deep-subtree reactivity poll. The poll reads each
   * direct child's latest snapshot and re-renders the TUI only when the tree
   * signature changed. Stopped when there are no live subagents or on
   * session shutdown. TUI mode only.
   */
  function ensurePoll(): void {
    const ctx = ctxRef;
    if (!ctx || ctx.mode !== "tui") return;
    if (pollHandle) return;
    pollHandle = setInterval(() => {
      const mgr = manager;
      if (!mgr || mgr.list().length === 0) {
        // Nothing live: stop polling until the next spawn restarts it.
        if (pollHandle) {
          clearInterval(pollHandle);
          pollHandle = null;
        }
        return;
      }
      void refreshTree(true);
    }, TREE_POLL_INTERVAL_MS);
  }

  pi.on("session_start", async (_event, ctx) => {
    ctxRef = ctx;
    // Rebuild a fresh manager per session; disposeAll on shutdown.
    manager?.disposeAll().catch(() => {});
    manager = new SubagentManager(notifyParent);
    // Clear per-session delivery flags so a /new or /resume starts clean.
    deliveredFinal.clear();
    // Register the child-side `report` tool for subagent processes only. The
    // root interactive parent (tui mode) has no parent to report to and is
    // excluded so the tool doesn't clutter its tool list. Subagents run in
    // rpc mode, so this tool is available exactly where it's needed.
    if (ctx.mode !== "tui") {
      registerReportTool();
    } else {
      // Root interactive session: start the deep-subtree poll so the TUI
      // tree stays responsive to grandchild state changes even while a
      // coordinator sits idle atop a busy subtree.
      ensurePoll();
    }
    // Publish this tier's subtree snapshot into our own session so any parent
    // (we may BE a subagent of a higher root) can read it. Publishing is a
    // custom-entry append, not a model turn.
    manager.setTreePublisher((data) => {
      try {
        pi.appendEntry("hierarchy_tree", data);
      } catch {
        // best-effort
      }
    });
    void refreshTree();
  });

  pi.on("session_shutdown", async () => {
    if (pollHandle) {
      clearInterval(pollHandle);
      pollHandle = null;
    }
    await manager?.disposeAll();
    if (ctxRef?.mode === "tui") {
      ctxRef.ui.setWidget(TREE_WIDGET_ID, undefined);
      ctxRef.ui.setStatus(TREE_STATUS_ID, undefined);
    }
    manager = null;
  });

  // ---------- Tool: spawn_subagent ----------
  pi.registerTool({
    name: "spawn_subagent",
    label: "Spawn Subagent",
    description: [
      "Launch a long-lived subagent (a separate `pi --mode rpc` process) with an",
      "isolated context window. Optionally give it an initial prompt. The subagent",
      "streams turn-end notifications back to you. Use observe_subagent to read its",
      "progress and await_subagent to block until it finishes. Subagents can spawn",
      "their own subagents.",
    ].join(" "),
    parameters: Type.Object({
      prompt: Type.Optional(
        Type.String({
          description:
            "Initial prompt to send immediately. If omitted, the subagent starts idle and waits for steer/follow_up.",
        }),
      ),
      cwd: Type.Optional(Type.String({ description: "Working directory for the subagent process." })),
      label: Type.Optional(Type.String({ description: "Human-readable label for notifications." })),
      model: Type.Optional(
        Type.String({
          description:
            "OPTIONAL — omit unless the caller explicitly requests a different model. When omitted, the subagent inherits the spawning harness's active model (PI_MODEL / PI_PROVIDER), which is almost always what you want. Only pass a model pattern (e.g. 'sonnet', 'anthropic/claude-sonnet-4-5') when someone has specifically asked for a different model; passing a bare alias can resolve against an unconfigured provider and fail with 'No API key found'.",
        }),
      ),
      tools: Type.Optional(
        Type.String({ description: "Comma-separated allowlist of built-in tool names, e.g. 'read,grep,find,ls,bash'." }),
      ),
    }),
    async execute(_toolCallId, params, _signal, _onUpdate, ctx) {
      const mgr = ensureManager();
      const extraArgs: string[] = [];
      if (params.model) extraArgs.push("--model", params.model);
      if (params.tools) extraArgs.push("--tools", params.tools);
      // Load this same extension into the child so it can spawn its own subagents.
      extraArgs.push("--extension", path.join(SELF_DIR, "index.ts"));

      const id = await mgr.spawn(
        {
          prompt: params.prompt,
          cwd: params.cwd,
          extraArgs,
          label: params.label,
        },
        (o) =>
          new RpcClient({
            extraArgs: o.extraArgs,
            cwd: o.cwd ?? ctx.cwd,
            onExit: () => {},
          }),
      );
      // Actually start the process (spawn above only constructed the client).
      // start() handshakes readiness; only then is it safe to send the
      // initial prompt — sending it earlier races child startup and can lose
      // the prompt to a stdin nothing is reading (the overnight hang).
      const rec = mgr.get(id)!;
      try {
        await rec.client.start();
      } catch (err) {
        await mgr.dispose(id);
        return {
          content: [{ type: "text", text: `Failed to start subagent: ${String((err as Error).message)}` }],
          isError: true,
        };
      }
      if (params.prompt) {
        try {
          await mgr.sendInitialPrompt(id, params.prompt);
        } catch (err) {
          await mgr.dispose(id);
          return {
            content: [{ type: "text", text: `Subagent started but the initial prompt failed: ${String((err as Error).message)}` }],
            isError: true,
          };
        }
      }
      // Show the new subagent in the live tree immediately, before its first
      // turn_end arrives (covers the spawn → first-event window). Also
      // (re)start the poll if it had auto-stopped when the tree went empty.
      ensurePoll();
      void refreshTree();
      return {
        content: [
          {
            type: "text",
            text: `Spawned subagent ${id}${params.label ? ` (${params.label})` : ""}. ${
              params.prompt ? "It is running your prompt." : "It is idle and waiting for messages."
            } Use observe_subagent to watch progress or await_subagent to block until it settles.`,
          },
        ],
      };    },
  });

  // ---------- Tool: steer_subagent ----------
  pi.registerTool({
    name: "steer_subagent",
    label: "Steer Subagent",
    description:
      "Inject a steering message into a running subagent. Delivered after the current turn finishes its tool calls, before the next LLM call. Use to redirect mid-run.",
    parameters: Type.Object({
      subagent_id: Type.String({ description: "Subagent id from spawn_subagent." }),
      message: Type.String({ description: "Steering message to deliver." }),
    }),
    async execute(_toolCallId, params) {
      const mgr = ensureManager();
      try {
        await mgr.steer(params.subagent_id, params.message);
        return { content: [{ type: "text", text: `Steering message queued for ${params.subagent_id}.` }] };
      } catch (err) {
        return {
          content: [{ type: "text", text: String((err as Error).message) }],
          isError: true,
        };
      }
    },
  });

  // ---------- Tool: follow_up_subagent ----------
  pi.registerTool({
    name: "follow_up_subagent",
    label: "Follow-up Subagent",
    description:
      "Queue a message for a subagent, delivered when it next becomes idle. Useful for chaining tasks without interrupting the current run.",
    parameters: Type.Object({
      subagent_id: Type.String({ description: "Subagent id from spawn_subagent." }),
      message: Type.String({ description: "Follow-up message to deliver once the subagent settles." }),
    }),
    async execute(_toolCallId, params) {
      const mgr = ensureManager();
      try {
        await mgr.followUp(params.subagent_id, params.message);
        return { content: [{ type: "text", text: `Follow-up queued for ${params.subagent_id}.` }] };
      } catch (err) {
        return { content: [{ type: "text", text: String((err as Error).message) }], isError: true };
      }
    },
  });

  // ---------- Tool: observe_subagent ----------
  pi.registerTool({
    name: "observe_subagent",
    label: "Observe Subagent",
    description: [
      "Read recent progress from a subagent without blocking. Returns recent turn",
      "summaries and, if requested, new session entries since a cursor. Paginated",
      "to protect your context — call again with the returned `nextSince` for more.",
    ].join(" "),
    parameters: Type.Object({
      subagent_id: Type.String({ description: "Subagent id from spawn_subagent." }),
      since: Type.Optional(
        Type.String({
          description:
            "Session-entry cursor. Only entries strictly after this id are returned. Omit for the most recent slice.",
        }),
      ),
      limit: Type.Optional(
        Type.Number({
          description: `Max entries to return (default ${OBSERVE_DEFAULT_LIMIT}, max ${OBSERVE_MAX_LIMIT}).`,
        }),
      ),
      include_turn_summaries: Type.Optional(
        Type.Boolean({
          description: "Also include the cached per-turn summaries (tool calls + text preview). Default true.",
        }),
      ),
    }),
    async execute(_toolCallId, params) {
      const mgr = ensureManager();
      const rec = mgr.get(params.subagent_id);
      if (!rec) {
        return { content: [{ type: "text", text: `Unknown subagent: ${params.subagent_id}` }], isError: true };
      }
      const limit = clamp(params.limit ?? OBSERVE_DEFAULT_LIMIT, 1, OBSERVE_MAX_LIMIT);

      // Pull entries newer than `since` (or, if none given, just the last slice).
      // We track our own cursor so repeated observe calls don't re-report.
      const since = params.since ?? rec.lastSeenEntryId;
      let entries: any[] = [];
      let leafId: string | null = null;
      try {
        const res = await rec.client.getEntries(since);
        entries = (res.entries ?? []).slice(0, limit);
        leafId = res.leafId;
        // Advance our cursor only when the caller didn't supply their own.
        if (!params.since && leafId) rec.lastSeenEntryId = leafId;
      } catch (err) {
        return {
          content: [{ type: "text", text: `Failed to read subagent entries: ${String((err as Error).message)}` }],
          isError: true,
        };
      }

      const parts: string[] = [];
      parts.push(`subagent ${rec.id} (${rec.label}) — status: ${rec.status}`);
      if (rec.status === "exited") parts.push(`exit code: ${rec.exitCode}`);
      parts.push(
        `usage: ${rec.usage.turns} turns, ↑${rec.usage.input} ↓${rec.usage.output}, $${rec.usage.cost.toFixed(4)}`,
      );

      if (params.include_turn_summaries !== false && rec.recentTurns.length) {
        parts.push("", "recent turns:");
        for (const t of rec.recentTurns) {
          const tools = t.toolCalls.length ? ` [${t.toolCalls.join(", ")}]` : "";
          parts.push(`  #${t.turnIndex ?? "?"}${tools}${t.isError ? " (error)" : ""}`);
          if (t.text) parts.push(`    ${indent(t.text, 4)}`);
        }
      }

      if (entries.length) {
        parts.push("", `new entries (<= ${limit}):`);
        for (const e of entries) {
          parts.push(`  ${formatEntry(e)}`);
        }
      } else if (!since) {
        parts.push("", "no new entries yet");
      }

      parts.push("");
      parts.push(`nextSince: ${leafId ?? rec.lastSeenEntryId ?? "(none)"}`);

      return { content: [{ type: "text", text: parts.join("\n") }] };
    },
  });

  // ---------- Tool: await_subagent ----------
  pi.registerTool({
    name: "await_subagent",
    label: "Await Subagent",
    description:
      "Block until the subagent's process becomes idle (agent_settled) or exits, then return its last assistant text. Resolves immediately if already idle. Note: 'process idle' is NOT 'done' — a subagent that reports and goes intrinsically idle can be resumed by steer/follow_up. Use this to block for a single quiescent point, not as a completion signal. Defaults to a 10-minute timeout; pass timeout_ms: 0 to wait forever.",
    parameters: Type.Object({
      subagent_id: Type.String({ description: "Subagent id from spawn_subagent." }),
      timeout_ms: Type.Optional(
        Type.Number({
          description: `Max time to wait in ms. Default ${10 * 60 * 1000} (10 min). Pass 0 to wait forever.`,
        }),
      ),
    }),
    async execute(_toolCallId, params) {
      const mgr = ensureManager();
      const rec = mgr.get(params.subagent_id);
      if (!rec) {
        return { content: [{ type: "text", text: `Unknown subagent: ${params.subagent_id}` }], isError: true };
      }

      const settled = await waitForSettled(rec, params.timeout_ms ?? AWAIT_DEFAULT_TIMEOUT_MS);
      if (!settled) {
        return {
          content: [
            { type: "text", text: `Timed out waiting for ${params.subagent_id} (status: ${rec.status}).` },
          ],
        };
      }

      let finalText: string | null = null;
      try {
        finalText = await rec.client.getLastAssistantText();
      } catch {
        // Process may have exited; fall back to recent turns.
      }
      const fallback = rec.recentTurns[rec.recentTurns.length - 1]?.text ?? "";
      const text = finalText ?? fallback;
      return {
        content: [
          {
            type: "text",
            text: `${rec.id} ${rec.status === "exited" ? `exited (code ${rec.exitCode})` : "idle"}.\n\nLast assistant output:\n${truncate(text, FINAL_OUTPUT_CAP)}`,
          },
        ],
      };
    },
  });

  // ---------- Tool: abort_subagent ----------
  pi.registerTool({
    name: "abort_subagent",
    label: "Abort Subagent",
    description: "Cancel the subagent's current run without killing the process. It returns to idle.",
    parameters: Type.Object({
      subagent_id: Type.String({ description: "Subagent id from spawn_subagent." }),
    }),
    async execute(_toolCallId, params) {
      const mgr = ensureManager();
      try {
        await mgr.abort(params.subagent_id);
        return { content: [{ type: "text", text: `Aborted current run for ${params.subagent_id}.` }] };
      } catch (err) {
        return { content: [{ type: "text", text: String((err as Error).message) }], isError: true };
      }
    },
  });

  // ---------- Tool: dispose_subagent ----------
  pi.registerTool({
    name: "dispose_subagent",
    label: "Dispose Subagent",
    description: "Terminate a subagent process and remove it. Use when you're done with it.",
    parameters: Type.Object({
      subagent_id: Type.String({ description: "Subagent id from spawn_subagent." }),
    }),
    async execute(_toolCallId, params) {
      const mgr = ensureManager();
      await mgr.dispose(params.subagent_id);
      // Drop the disposed node from the live tree immediately.
      void refreshTree();
      return { content: [{ type: "text", text: `Disposed ${params.subagent_id}.` }] };
    },
  });

  // ---------- Tool: list_subagents ----------
  pi.registerTool({
    name: "list_subagents",
    label: "List Subagents",
    description: [
      "List all live subagents in the FULL tree (including grandchildren and deeper),",
      "each with status, intrinsic-idle flag, and usage. This is the authoritative view of",
      "your whole hierarchy. Direct children are read from local state; deeper tiers are",
      "read from each child's published `hierarchy_tree` snapshot. Cheap RPC reads, no",
      "model turns anywhere in the tree.",
    ].join(" "),
    parameters: Type.Object({}),
    async execute() {
      const mgr = ensureManager();
      const tree = await mgr.snapshot();
      if (tree.length === 0) {
        return { content: [{ type: "text", text: "No live subagents." }] };
      }
      const lines: string[] = [];
      const dump = (nodes: HierarchyNode[], depth: number) => {
        for (const n of nodes) {
          const pad = "  ".repeat(depth);
          const parts = [
            `${pad}${n.id} (${n.label})`,
            `status=${n.status}`,
            n.intrinsicallyIdle ? "intrinsically-idle" : "",
            `turns=${n.usage.turns}`,
            `↑${n.usage.input} ↓${n.usage.output}`,
            `$${n.usage.cost.toFixed(4)}`,
            n.status === "exited" ? `exit=${n.exitCode}` : "",
          ].filter(Boolean);
          lines.push(parts.join("  "));
          if (n.children.length) dump(n.children, depth + 1);
        }
      };
      dump(tree, 0);
      return { content: [{ type: "text", text: lines.join("\n") }] };
    },
  });

  /**
   * Child-side `report` tool. Available only to subagent processes (rpc
   * mode), not the interactive root. A subagent calls this to explicitly
   * hand a result/finding/question to its parent WITHOUT ending its work —
   * reporting is a normal, repeatable communication act, not "done."
   *
   * Mechanism: append a `hierarchy_report` custom entry to this process's
   * own session. The parent's extension instance detects it (via
   * get_entries) on this turn's `turn_end` and delivers the payload to the
   * parent's conversation immediately. Because the entry is a typed custom
   * entry (not free-form assistant text), the explicit report is reliably
   * distinguishable from the implicit intrinsic-idle fallback.
   */
  function registerReportTool(): void {
    pi.registerTool({
      name: "report",
      label: "Report to Parent",
      description: [
        "Deliver a report (result, finding, or question) to your parent agent. This is the",
        "intended way to hand work up: reporting is a normal, repeatable act — you may report",
        "and then keep working, or report and end your turn. Reporting does NOT mean 'done'; it",
        "just sends a message up. If you end your turn without calling report, the harness will",
        "implicitly forward your last assistant output to your parent as an inferred report.",
        "Call report explicitly when you have a deliberate result to hand up.",
      ].join(" "),
      parameters: Type.Object({
        text: Type.String({
          description:
            "The report content to deliver to your parent. Be complete but concise — this is what they will see.",
        }),
      }),
      async execute(_toolCallId, params) {
        const text = params.text ?? "";
        // Persist as a typed custom entry so the parent can detect it via
        // get_entries rather than parsing free-form assistant text.
        try {
          pi.appendEntry("hierarchy_report", { text, timestamp: Date.now() });
        } catch (err) {
          return {
            content: [{ type: "text", text: `Failed to record report: ${String((err as Error).message)}` }],
            isError: true,
          };
        }
        return {
          content: [
            {
              type: "text",
              text: `Report delivered to parent (${text.length} chars). You may continue working, or end your turn — if you continue, you can report again later.`,
            },
          ],
        };
      },
    });
  }

  function ensureManager(): SubagentManager {
    if (!manager) {
      // Interactive sessions get session_start before tool calls, but be defensive.
      manager = new SubagentManager(notifyParent);
    }
    return manager;
  }
}

// ---------- helpers ----------

function clamp(n: number, lo: number, hi: number): number {
  return Math.max(lo, Math.min(hi, n));
}

function truncate(s: string, n: number): string {
  if (!s) return "(no output)";
  if (s.length <= n) return s;
  return s.slice(0, n) + `\n\n…[truncated, ${s.length - n} chars omitted]`;
}

function indent(s: string, n: number): string {
  const pad = " ".repeat(n);
  return s.split("\n").map((l) => pad + l).join("\n");
}

function formatEntry(e: any): string {
  if (!e) return "(null)";
  const t = e.timestamp ? new Date(e.timestamp).toISOString().slice(11, 19) : "??:??:??";
  const m = e.message;
  if (!m) return `${e.type ?? "?"} ${e.id ?? "?"}`;
  const role = m.role ?? "?";
  if (role === "user") {
    const txt = extractEntryText(m);
    return `${t} user ${truncateOneLine(txt, 120)}`;
  }
  if (role === "assistant") {
    const txt = extractEntryText(m);
    const tools = (Array.isArray(m.content) ? m.content : [])
      .filter((p: any) => p?.type === "toolCall")
      .map((p: any) => p.name)
      .join(",");
    return `${t} assistant${tools ? ` [${tools}]` : ""} ${truncateOneLine(txt, 120)}`;
  }
  if (role === "toolResult") {
    const txt = extractEntryText(m);
    return `${t} tool(${m.toolName ?? "?"}) ${truncateOneLine(txt, 120)}`;
  }
  return `${t} ${role}`;
}

function extractEntryText(m: any): string {
  if (!m) return "";
  if (typeof m.content === "string") return m.content;
  if (Array.isArray(m.content)) {
    return m.content
      .filter((p: any) => p?.type === "text")
      .map((p: any) => p.text ?? "")
      .join(" ")
      .trim();
  }
  return "";
}

function truncateOneLine(s: string, n: number): string {
  const one = s.replace(/\s+/g, " ").trim();
  if (one.length <= n) return one;
  return one.slice(0, n) + "…";
}

function waitForSettled(rec: { client: RpcClient; status: string }, timeoutMs: number): Promise<boolean> {
  if (rec.status === "idle" || rec.status === "exited") return Promise.resolve(true);
  return new Promise<boolean>((resolve) => {
    let done = false;
    const finish = (val: boolean) => {
      if (done) return;
      done = true;
      rec.client.off("agent_settled", onSettled);
      rec.client.off("exit", onExit);
      clearTimeout(timer);
      resolve(val);
    };
    const onSettled = () => finish(true);
    const onExit = () => finish(true);
    rec.client.on("agent_settled", onSettled);
    rec.client.on("exit", onExit);
    const timer =
      timeoutMs > 0 ? setTimeout(() => finish(false), timeoutMs) : undefined;
  });
}
