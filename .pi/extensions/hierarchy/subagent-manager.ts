/**
 * SubagentManager — tracks live subagent processes for the hierarchy extension.
 *
 * Each subagent is a long-lived `pi --mode rpc` child process wrapped in an
 * RpcClient. The manager:
 *   - assigns a short, parent-stable id to each subagent
 *   - records the last entry id we've seen per subagent (a durable cursor)
 *   - forwards subagent `turn_end` / `agent_settled` / `exit` events to the
 *     parent via a callback, so the parent model can be kept informed without
 *     polling
 *   - keeps a bounded ring of recent turn summaries per subagent so the
 *     `observe_subagent` tool can return something useful even before the
 *     parent has been notified
 *
 * Subagents may themselves load this extension and spawn their own
 * subagents. The manager does not assume it is at the top of the tree; it
 * only manages its own direct children. Nesting is handled recursively by
 * each tier loading the same extension (the leaf tiers are non-interactive
 * `pi --mode rpc` processes, which is fine — RPC mode runs extensions).
 */

import type { RpcClient, RpcEvent } from "./rpc-client.ts";

export interface SubagentSpawnOptions {
  /** Initial prompt. If omitted, the subagent starts idle. */
  prompt?: string;
  /** Working directory for the subprocess. Defaults to parent cwd. */
  cwd?: string;
  /** Extra args appended to `pi --mode rpc`. e.g. ["--model","sonnet"]. */
  extraArgs?: string[];
  /** Human-readable label shown in notifications. */
  label?: string;
}

export interface SubagentRecord {
  id: string;
  label: string;
  client: RpcClient;
  cwd?: string;
  /** Cursor: id of the last session entry we've surfaced to the parent. */
  lastSeenEntryId?: string;
  /** Cursor: id of the last `hierarchy_report` custom entry we've consumed as
   * an explicit report. Used to detect new explicit reports on each settle. */
  lastReportEntryId?: string;
  /** Bounded ring of recent turn summaries, oldest first. */
  recentTurns: TurnSummary[];
  /** Running tally of usage across the subagent's lifetime. */
  usage: {
    turns: number;
    input: number;
    output: number;
    cost: number;
  };
  status: "starting" | "idle" | "working" | "exited";
  exitCode: number | null;
  /** Set once the subagent produces its first turn_end. */
  startedAt: number;
  /**
   * Subtree-intrinsic idleness.
   *
   * `agent_settled` (pi's own notion) means "this process won't continue
   * without external input" — no retry, compaction retry, or queued
   * follow-up remains. That is a *process-level* property: a coordinator
   * whose children are still running still fires `agent_settled` the moment
   * its own turn ends. That is the bug this field fixes.
   *
   * `intrinsicallyIdle` is the *subtree-level* property: this node is idle
   * AND all of its direct children managed by THIS extension instance are
   * intrinsically idle. (Each tier of the tree runs its own copy of this
   * extension and applies the same rule to its own direct children, so the
   * recursion is sound across tiers: a child's own subtree is enforced by
   * the child's extension before that child reports to us.)
   *
   * Only the transition INTO intrinsic idleness triggers an (implicit)
   * report to the parent, and only if the agent didn't explicitly report
   * during this stall episode.
   */
  intrinsicallyIdle: boolean;
  /**
   * True once this node has reported to its parent during the current stall
   * episode (either explicitly via a `hierarchy_report` entry, or implicitly
   * via the intrinsic-idle fallback). Prevents double-reporting. Reset to
   * false whenever the node resumes (agent_start, steer/follow_up delivered,
   * or a child starts working again) so a *second* stall can report again.
   */
  reportedThisEpisode: boolean;
  /**
   * True if an explicit `hierarchy_report` entry has already been consumed
   * for the current episode, so the intrinsic-idle fallback is suppressed.
   * Distinct from `reportedThisEpisode` because an explicit report does not
   * itself make the node intrinsically idle (the node may keep working after
   * reporting); the implicit fallback is only suppressed until the node
   * next resumes.
   */
  explicitReportThisEpisode: boolean;
  /**
   * Cursor: id of the last `hierarchy_tree` custom entry we've consumed from
   * this child. Used by snapshot() to fetch only newer tree snapshots.
   */
  lastTreeEntryId?: string;
  /**
   * Cached full-subtree snapshot for this child, as most recently read from
   * its `hierarchy_tree` entry. Held so the poll and list_subagents can
   * return a tree without re-reading unchanged children, and so a failed
   * read doesn't blow away a known-good picture.
   */
  cachedSubtree?: HierarchyNode[];
  /** Cached revision of the child's last-read tree, for cheap change checks. */
  cachedTreeRev?: number;
}

export interface TurnSummary {
  /** Session entry id of the turn's final assistant message. */
  entryId?: string;
  turnIndex?: number;
  /** Last assistant text from the turn, truncated. */
  text: string;
  /** Tool calls made during the turn, as "name(arg-preview)". */
  toolCalls: string[];
  isError: boolean;
  at: number;
}

export interface SubagentNotification {
  subagentId: string;
  label: string;
  /**
   * - `turn_end`: per-turn signal (UI only, not injected into parent context)
   * - `settled`: pi's process-level idle. NOT a report. Used internally to
   *   recompute subtree-intrinsic idleness; never delivered to the parent as
   *   a conversation turn.
   * - `intrinsically_idle`: subtree is quiescent and the agent did not
   *   explicitly report this episode. This is the implicit-report fallback:
   *   the parent should be woken so it can decide to steer, observe, or dispose.
   * - `report`: the agent explicitly called the `report` tool, producing a
   *   `hierarchy_report` custom entry. Delivered to the parent immediately.
   * - `exit` / `error`: terminal / failure signals.
   */
  kind: "turn_end" | "settled" | "intrinsically_idle" | "report" | "exit" | "error";
  summary?: TurnSummary;
  /** Carried by `report` and `intrinsically_idle` notifications. */
  reportText?: string;
 /** True on `report`/`intrinsically_idle` when the payload came from an
   * explicit `hierarchy_report` entry; false when it was inferred from the
   * last assistant text (the agent ended its turn without reporting). */
  explicit?: boolean;
  exitCode?: number;
  message?: string;
}

export type NotifyFn = (n: SubagentNotification) => void;

/**
 * Serialized snapshot of one node in the subagent tree, including its full
 * subtree. Written by each tier's extension as a `hierarchy_tree` custom
 * entry in its OWN session; read by the parent via `get_entries` to assemble
 * the full tree without ever connecting to grandchildren directly.
 *
 * The recursion: a node's `children` array is itself a list of
 * `HierarchyNode` snapshots, each produced by that child's own extension.
 * So the root reads its direct children's `hierarchy_tree` entries and gets
 * the entire tree in one level of RPC reads — depth is carried inside the
 * snapshots, not traversed by the parent.
 */
export interface HierarchyNode {
  id: string;
  label: string;
  status: "starting" | "idle" | "working" | "exited";
  intrinsicallyIdle: boolean;
  exitCode: number | null;
  usage: { turns: number; input: number; output: number; cost: number };
  startedAt: number;
  /** Nested snapshots of this node's direct children (their full subtrees). */
  children: HierarchyNode[];
  /**
   * Monotonic counter the writing extension bumps on every state change, so
   * readers can cheaply detect "something changed" without deep comparison.
   */
  rev: number;
}

/** Shape we read back from a child's `hierarchy_tree` custom entry. */
export interface HierarchyTreeEntryData {
  tree: HierarchyNode[];
  rev: number;
}

const RECENT_TURNS_MAX = 16;
const TURN_TEXT_MAX = 1200;
/** Custom entry type used to publish this tier's subtree snapshot. */
const TREE_ENTRY_TYPE = "hierarchy_tree";

export class SubagentManager {
  private subagents = new Map<string, SubagentRecord>();
  private counter = 0;
  /**
   * Monotonic revision of THIS tier's subtree. Bumped on every local state
   * change (spawn, dispose, status transition, intrinsic-idle, report) so
   * the snapshot we publish carries a cheap change indicator for our parent.
   */
  private rev = 0;
  private notify: NotifyFn;

  constructor(notify: NotifyFn) {
    this.notify = notify;
  }

  /** Spawn a new subagent and start watching its event stream. */
  async spawn(opts: SubagentSpawnOptions, factory: (o: SubagentSpawnOptions) => RpcClient): Promise<string> {
    const id = `sub-${(++this.counter).toString(36)}`;
    const label = opts.label ?? id;
    const client = factory(opts);

    const rec: SubagentRecord = {
      id,
      label,
      client,
      cwd: opts.cwd,
      lastSeenEntryId: undefined,
      lastReportEntryId: undefined,
      recentTurns: [],
      usage: { turns: 0, input: 0, output: 0, cost: 0 },
      status: "starting",
      exitCode: null,
      startedAt: Date.now(),
      intrinsicallyIdle: false,
      reportedThisEpisode: false,
      explicitReportThisEpisode: false,
      lastTreeEntryId: undefined,
      cachedSubtree: undefined,
      cachedTreeRev: undefined,
    };
    this.subagents.set(id, rec);

    this.attach(id, rec);

    // NOTE: we do NOT send the initial prompt here. The child process isn't
    // started yet (index.ts calls client.start() after spawn returns), and
    // even after start() the parent must await the readiness handshake before
    // the prompt is written — otherwise the prompt races child startup and can
    // be written to a stdin nothing is reading, producing the exact "0 turns,
    // stuck forever" hang we're fixing. index.ts calls sendInitialPrompt()
    // after start() resolves.
    rec.status = "idle";

    // Publish AFTER setting idle, so the first snapshot shows the new child
    // as idle rather than "starting".
    this.bump(); // a new child joined the tier — republish our snapshot

    return id;
  }

  /**
   * Send the subagent's initial prompt. Must be called AFTER the parent has
   * awaited `client.start()` (which handshakes readiness). Resolves once the
   * child has accepted the prompt (not once the turn completes — turn_end
   * events drive ongoing observation). On failure, transitions the record to a
   * terminal error state and notifies, so `await_subagent` and `observe_subagent`
   // don't report "working" forever.
   */
  async sendInitialPrompt(id: string, message: string): Promise<void> {
    const rec = this.subagents.get(id);
    if (!rec) throw new Error(`Unknown subagent: ${id}`);
    if (rec.status === "exited") throw new Error(`Subagent ${id} has exited`);
    rec.status = "working";
    this.bump();
    try {
      // prompt() resolves on acceptance, not completion. Give the *acceptance*
      // a finite deadline so a child that never acknowledges doesn't hang the
      // record at "working" indefinitely — the parent's await_subagent has its
      // own, larger timeout for the actual work.
      await rec.client.prompt(message, undefined);
    } catch (err) {
      rec.status = "exited";
      rec.exitCode = null;
      this.notify({
        subagentId: id,
        label: rec.label,
        kind: "error",
        message: `Initial prompt failed: ${String((err as Error)?.message ?? err)}`,
      });
      throw err;
    }
  }

  private attach(id: string, rec: SubagentRecord): void {
    const client = rec.client;

    client.on("turn_end", (e: RpcEvent) => {
      const summary = summarizeTurn(e);
      rec.recentTurns.push(summary);
      if (rec.recentTurns.length > RECENT_TURNS_MAX) rec.recentTurns.shift();
      rec.usage.turns++;
      // The message entry id isn't on turn_end directly; we approximate with
      // leaf tracking via get_entries when the parent observes. Still record
      // turn-level usage if present.
      const u = e.message?.usage;
      if (u) {
        rec.usage.input += u.input || 0;
        rec.usage.output += u.output || 0;
        rec.usage.cost += u.cost?.total || 0;
      }
      rec.status = "working"; // more turns may follow
      // A new turn means the node resumed from any prior stall: reset the
      // report-episode flags so a subsequent stall can report again. This is
      // what makes "report → idle → parent steers → report again" work as a
      // persistent-hierarchy cycle rather than firing exactly once.
      this.resetEpisode(id);
      this.bump();
      this.notify({ subagentId: id, label: rec.label, kind: "turn_end", summary });
    });

    client.on("agent_settled", () => {
      rec.status = "idle";
      // pi's agent_settled = "this process won't continue without external
      // input." That is process-idle, NOT a report. Do NOT notify the parent
      // with a reporting kind here. Emit a `settled` notification purely so
      // `index.ts` can refresh the live tree; the reporting decision
      // (explicit vs implicit intrinsic-idle) is made by `index.ts`, which
      // can read the child's session for a `hierarchy_report` entry.
      this.bump();
      this.notify({ subagentId: id, label: rec.label, kind: "settled" });
    });

    client.on("agent_start", () => {
      rec.status = "working";
      // Resumed by a steer/follow_up from the parent (or by a child waking
      // it). Reset the episode so it can report again on the next stall.
      this.resetEpisode(id);
      this.bump();
    });

    client.on("exit", (code: number | null) => {
      rec.status = "exited";
      rec.exitCode = code;
      this.bump();
      this.notify({ subagentId: id, label: rec.label, kind: "exit", exitCode: code ?? undefined });
    });

    client.on("error", (err: Error) => {
      this.notify({
        subagentId: id,
        label: rec.label,
        kind: "error",
        message: String(err?.message ?? err),
      });
    });
  }

  get(id: string): SubagentRecord | undefined {
    return this.subagents.get(id);
  }

  list(): SubagentRecord[] {
    return Array.from(this.subagents.values());
  }

  /** Current revision of this tier's subtree (bumps on every local change). */
  localRev(): number {
    return this.rev;
  }

  /**
   * Sync snapshot of THIS tier's direct children, with empty `children`
   * arrays. This is what we publish as a `hierarchy_tree` custom entry: each
   * node's own subtree is published by THAT node's extension, and the parent
   * nests them when it assembles the full tree. Cheap, no RPC.
   */
  localSnapshot(): HierarchyNode[] {
    return Array.from(this.subagents.values()).map((r) => ({
      id: r.id,
      label: r.label,
      status: r.status,
      intrinsicallyIdle: r.intrinsicallyIdle,
      exitCode: r.exitCode,
      usage: { ...r.usage },
      startedAt: r.startedAt,
      children: [],
      rev: 0,
    }));
  }

  /**
   * Register the function used to publish a `hierarchy_tree` custom entry
   * into THIS process's own session. Injected from `index.ts` (the manager
   * must not depend on the pi API directly). Called by `bump()`.
   */
  setTreePublisher(fn: (data: HierarchyTreeEntryData) => void): void {
    this.publishTreeEntry = fn;
  }

  private publishTreeEntry: ((data: HierarchyTreeEntryData) => void) | null = null;

  /**
   * Bump this tier's revision and republish our subtree snapshot. Called on
   * every local state change so the parent (and the root, transitively) can
   * see the new picture. Publishing is a custom-entry append — no model turn.
   */
  bump(): void {
    this.rev++;
    if (this.publishTreeEntry) {
      try {
        this.publishTreeEntry({ tree: this.localSnapshot(), rev: this.rev });
      } catch {
        // Best-effort: never let publishing break a state transition.
      }
    }
  }

  /**
   * Assemble the full tree rooted at this tier, recursing through each direct
   * child's latest `hierarchy_tree` custom entry. Async because each child
   * read is an RPC round-trip — but no model turns anywhere in the tree.
   *
   * Children that fail to respond (process exited, RPC error) keep whatever
   * subtree we last cached for them, so a transient read failure doesn't
   * erase a known-good picture.
   */
  async snapshot(): Promise<HierarchyNode[]> {
    const kids = Array.from(this.subagents.values());
    const nodes = await Promise.all(kids.map((r) => this.snapshotNode(r)));
    return nodes;
  }

  private async snapshotNode(rec: SubagentRecord): Promise<HierarchyNode> {
    let subtree: HierarchyNode[] = rec.cachedSubtree ?? [];
    let childRev: number | undefined = rec.cachedTreeRev;
    if (rec.status !== "exited") {
      try {
        const res = await rec.client.getEntries(rec.lastTreeEntryId);
        const latest = (res.entries ?? [])
          .filter((e) => e?.type === "custom" && e?.customType === TREE_ENTRY_TYPE)
          .pop();
        if (latest) {
          rec.lastTreeEntryId = latest.id;
          const data = latest.data as HierarchyTreeEntryData | undefined;
          if (data && Array.isArray(data.tree)) {
            subtree = data.tree;
            childRev = data.rev;
            rec.cachedSubtree = subtree;
            rec.cachedTreeRev = childRev;
          }
        }
      } catch {
        // keep cached subtree
      }
    }
    return {
      id: rec.id,
      label: rec.label,
      status: rec.status,
      intrinsicallyIdle: rec.intrinsicallyIdle,
      exitCode: rec.exitCode,
      usage: { ...rec.usage },
      startedAt: rec.startedAt,
      children: subtree,
      rev: childRev ?? 0,
    };
  }

  /** Inject a steering message (delivered after the current turn's tool calls). */
  async steer(id: string, message: string): Promise<void> {
    const rec = this.subagents.get(id);
    if (!rec) throw new Error(`Unknown subagent: ${id}`);
    if (rec.status === "exited") throw new Error(`Subagent ${id} has exited`);
    await rec.client.steer(message);
    rec.status = "working";
    this.resetEpisode(id);
    this.bump();
  }

  /** Queue a follow-up message (delivered when the subagent next becomes idle). */
  async followUp(id: string, message: string): Promise<void> {
    const rec = this.subagents.get(id);
    if (!rec) throw new Error(`Unknown subagent: ${id}`);
    if (rec.status === "exited") throw new Error(`Subagent ${id} has exited`);
    await rec.client.followUp(message);
    // followUp doesn't immediately resume the node, so don't reset the
    // episode yet — it resets when agent_start fires on delivery.
  }

  /** Abort the subagent's current run without killing the process. */
  async abort(id: string): Promise<void> {
    const rec = this.subagents.get(id);
    if (!rec) throw new Error(`Unknown subagent: ${id}`);
    if (rec.status === "exited") return;
    await rec.client.abort();
    this.bump();
  }

  /**
   * Reset the report-episode flags for a node. Called whenever the node
   * resumes (agent_start, a new turn_end, or a steer delivered from the
   * parent) so a *later* stall can report again. This is what makes
   * "report → idle → parent steers → report again" a repeatable cycle for
   * persistent hierarchies rather than a one-shot.
   */
  resetEpisode(id: string): void {
    const rec = this.subagents.get(id);
    if (!rec) return;
    if (rec.reportedThisEpisode || rec.explicitReportThisEpisode) {
      rec.reportedThisEpisode = false;
      rec.explicitReportThisEpisode = false;
      rec.intrinsicallyIdle = false;
    }
  }

  /**
   * Declare a tracked node intrinsically idle and fire the implicit-report
   * fallback to the parent, unless the agent already reported explicitly
   * this episode or we already reported this episode.
   *
   * The subtree-quiescence *decision* is made by the caller in `index.ts`
   * (which can read the child's session for a `hierarchy_report` entry and
   * knows the in-tier picture). This method just owns the reporting state
   * and the notification. We do NOT recompute across tiers here — each tier
   * runs its own extension instance and enforces the rule for its own direct
   * children before letting them report up.
   */
  fireIntrinsicIdle(id: string, reportText: string | null): void {
    const rec = this.subagents.get(id);
    if (!rec) return;
    if (rec.reportedThisEpisode) return; // explicit report already went up
    rec.intrinsicallyIdle = true;
    rec.reportedThisEpisode = true;
    this.bump();
    this.notify({
      subagentId: id,
      label: rec.label,
      kind: "intrinsically_idle",
      reportText: reportText ?? undefined,
      explicit: false,
    });
  }

  /**
   * Fire an explicit report to the parent immediately. Called by `index.ts`
   * when it consumes a `hierarchy_report` custom entry from the child's
   * session (written by the child's own `report` tool). Delivery is
   * immediate and does not require the child to be intrinsically idle — a
   * node may report mid-run and keep working.
   */
  fireExplicitReport(id: string, reportText: string): void {
    const rec = this.subagents.get(id);
    if (!rec) return;
    rec.reportedThisEpisode = true;
    rec.explicitReportThisEpisode = true;
    this.bump();
    this.notify({
      subagentId: id,
      label: rec.label,
      kind: "report",
      reportText,
      explicit: true,
    });
  }

  /** Terminate a subagent process. */
  async dispose(id: string): Promise<void> {
    const rec = this.subagents.get(id);
    if (!rec) return;
    await rec.client.dispose();
    this.subagents.delete(id);
    this.bump(); // a child left the tier — republish our snapshot
  }

  /** Terminate everything. Called from session_shutdown. */
  async disposeAll(): Promise<void> {
    const all = Array.from(this.subagents.values());
    this.subagents.clear();
    await Promise.allSettled(all.map((r) => r.client.dispose()));
  }
}

/** Extract a compact, parent-context-safe summary from a turn_end event. */
function summarizeTurn(e: RpcEvent): TurnSummary {
  const msg = e.message ?? {};
  const text = extractText(msg);
  const toolCalls: string[] = [];
  if (Array.isArray(msg.content)) {
    for (const part of msg.content) {
      if (part?.type === "toolCall") {
        const argPreview = JSON.stringify(part.arguments ?? {})
          .slice(0, 80);
        toolCalls.push(`${part.name}(${argPreview})`);
      }
    }
  }
  return {
    turnIndex: e.turnIndex,
    text: truncate(text, TURN_TEXT_MAX),
    toolCalls,
    isError: msg.stopReason === "error" || msg.stopReason === "aborted",
    at: Date.now(),
  };
}

function extractText(msg: any): string {
  if (!msg) return "";
  if (typeof msg.content === "string") return msg.content;
  if (Array.isArray(msg.content)) {
    return msg.content
      .filter((p: any) => p?.type === "text")
      .map((p: any) => p.text ?? "")
      .join("\n")
      .trim();
  }
  return "";
}

function truncate(s: string, n: number): string {
  if (s.length <= n) return s;
  return s.slice(0, n) + " …[truncated]";
}
