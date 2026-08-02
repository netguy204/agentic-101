# Hierarchy — hierarchical subagent orchestration for pi

A pi extension that gives the parent agent primitives to launch, observe,
steer, and harvest long-lived subagents. Built for workflows like deep
research where you want a tree of agents, each with its own context window,
working in parallel and reporting back.

This is a **starting point / scaffold**, not a finished product. It's
deliberately minimal so you can shape it to your workflow.

## Model

Each subagent is a long-lived `pi --mode rpc` child process with its own
isolated context window. The parent (this extension) talks to it over the
JSONL RPC protocol:

```
parent (interactive pi)
  └─ hierarchy extension
       ├─ subagent A  ──┐
       ├─ subagent B  ──┤  each = `pi --mode rpc --no-session`
       └─ subagent C  ──┘  each loads THIS extension → can spawn its own children
```

Recursion is free: every subagent is launched with `--extension <self>`,
so a tier-2 subagent gets the same `spawn_subagent` tool and can spawn
tier-3 subagents. Tier 2+ are non-interactive RPC processes; only the root
parent is typically interactive.

## Tools exposed to the parent

| Tool | Purpose |
|------|---------|
| `spawn_subagent` | Start a subagent, optionally with an initial prompt |
| `steer_subagent` | Inject a steering message (delivered after the current turn's tool calls, before the next LLM call) |
| `follow_up_subagent` | Queue a message for when the subagent next becomes idle |
| `observe_subagent` | Read recent turns/entries, paginated via a `since` cursor |
| `await_subagent` | Block until the subagent's process is idle or exits; returns its last assistant text (NOT 'done') |
| `abort_subagent` | Cancel the current run without killing the process |
| `dispose_subagent` | Terminate the subagent process |
| `list_subagents` | Full nested tree of all live subagents (including grandchildren) with status, intrinsic-idle flag, and usage |

## Tool exposed to subagent processes (rpc mode only)

| Tool | Purpose |
|------|---------|
| `report` | Deliver a result/finding/question to this subagent's parent. Repeatable; does not mean 'done'. The intended way to hand work up; if a subagent ends its turn without calling it, the harness forwards its last assistant output as an inferred report. |

## How the requirements map

- **Launch subagents** → `spawn_subagent` spawns `pi --mode rpc` and (optionally) sends an initial `prompt`.
- **Observe progress** → subagent `turn_end` events are summarized and cached; `observe_subagent` returns recent turns + new session entries since a cursor.
- **Notified on termination** → subagent `exit` and `agent_settled` events are surfaced to the parent via `ctx.ui.notify`. `await_subagent` blocks the parent's tool call until then.
- **Add messages to the input queue** → `steer_subagent` (interject mid-run) and `follow_up_subagent` (append for after the run) map directly onto pi's RPC `steer` / `follow_up` commands — which are a real prioritized queue.
- **Receive final output** → `await_subagent` returns `get_last_assistant_text`; `observe_subagent` gives paginated history.
- **Protect parent context** → turn-end notifications are short one-line previews. Full detail only flows in when the parent calls `observe_subagent`, and that tool is paginated (`since` cursor, `limit` capped at 40). The parent model decides how much to pull.

## Notification model (important) — report vs settled

**A subagent never declares "done." It only reports, then becomes
intrinsically idle — a normal, resumable resting state.** There is no
"done" signal; disposition (dispose/keep) is a separate parent decision.

The parent is woken in exactly two cases:

1. **Explicit report** — the subagent called the `report` tool (available
   to subagent processes in rpc mode), which writes a `hierarchy_report`
   custom entry into its own session. The parent's extension detects it via
   `get_entries` on that turn's `turn_end` and delivers the payload to the
   parent's conversation immediately. A subagent may report and keep
   working, then report again.

2. **Implicit intrinsic-idle report** — the subagent ended its turn WITHOUT
   calling `report`, and nothing in its subtree can continue without
   external intervention. The harness forwards the subagent's last assistant
   output, honestly labeled as inferred. This is the safety net for a
   forgotten explicit report.

`settled` is pi's **process-level** idle signal ("this process won't
continue without external input"). It is **not** a report and is **not**
delivered to the parent conversation — it only drives report *detection*
(reading the child's entries to decide explicit vs implicit) and the
live-tree refresh. `turn_end` and `error` stay signal-only (UI line, not
injected).

**Why this design:** a coordinator that spawns children and then ends its
turn fires `agent_settled` the moment its own turn ends, even though its
children are still running. Treating `settled` as a report meant the
coordinator was falsely reported "done" to its parent while its real work
was unstarted. **Intrinsic idleness** — the subtree is quiescent and
cannot progress without intervention — is the only thing that reports up
implicitly. Each tier of the tree runs its own copy of this extension and
enforces the rule for its own direct children before letting them report
up, so the recursion is sound across tiers.

**Per-episode reset:** any resume (`agent_start`, a new turn, or a steer
from the parent) clears the episode flags, so a subsequent stall can report
again. This makes "report → idle → parent steers → report again" a
repeatable cycle for persistent hierarchies, not a one-shot.

This keeps the parent's context window under the model's control, which
matters for long deep-research runs.

## Live tree view (TUI) — full hierarchy, including grandchildren

In interactive (`tui`) mode, the extension renders a **live subagent
tree** as a widget above the input editor. The tree is **recursive** — it
shows the whole hierarchy, not just direct children:

```
hierarchy · 4 subagents
  ↻ coordinator (sub-2) — 2t ↑4020 ↓880 $0.0310
    ↻ expert-a (sub-1) — 3t ↑51020 ↓4400 $0.0620
    ↻ expert-b (sub-3) — 1t ↑980 ↓120 $0.0041
  ✓ planner (sub-1) — 1t ↑1200 ↓540 $0.0021
```

Status icons: `↻` working (accent), `✓` idle (success), `💤` intrinsically
idle (muted), `📤` reported, `■` exited (muted), `·` starting (dim). A
footer status line summarizes the **total** node count and how many are
working across the whole tree.

**How deep state reaches the root.** Direct children push their own events
to the root, but a grandchild's state change does NOT produce an event at
the root's tier — it goes to its parent's process, not the root's. To keep
the tree responsive while a coordinator sits idle atop a busy subtree, each
tier publishes its subtree as a `hierarchy_tree` custom entry in its own
session; the root reads those snapshots to assemble the full tree. This is
done two ways:

- **On any direct-child event** (turn_end / settled / exit / report), the
  root re-reads its direct children's latest snapshots and re-renders.
- **On a poll** (~1.5s in TUI mode) the root re-reads snapshots and
  re-renders only if something changed. This poll is read-only — pure
  `get_entries` RPC reads, **no model turns, no LLM context injection** — and
  is the one place we depart from the extension's "no polling" philosophy,
  because the RPC protocol offers no push channel for deep state. The poll
  self-stops when the tree is empty and restarts on the next spawn.

The widget clears itself when the last subagent is disposed or the session
shuts down, so it never lingers empty. `list_subagents` returns the same
full nested tree as text, so a non-TUI parent can query the whole
hierarchy too.

## Install

This is a project-local extension. To enable it for this project, trust the
project (pi will prompt on startup) — it lives at
`.pi/extensions/hierarchy/index.ts` and is auto-discovered.

To try it from the CLI without trusting the project:

```bash
pi -e .pi/extensions/hierarchy/index.ts
```

## Try it

Start pi in this repo:

```bash
pi
```

Then:

```
Use spawn_subagent to start a subagent with the prompt:
"List the files in the current directory and summarize what this project is."
Then observe_subagent to watch it, and await_subagent to get its answer.
```

Or a deeper tree:

```
Spawn two subagents in parallel (call spawn_subagent twice):
  - one to read docs/trunk/GOAL.md and summarize the project's goal
  - one to list docs/chunks and describe what work has been done
Then observe both, and when they're done, write me a synthesis.
```

## Design notes / why RPC over the one-shot subagent example

Pi ships an official `subagent` extension example (one-shot: `pi -p --mode
json`, block to completion, return final text). This extension is different
on purpose:

- **Long-lived, not one-shot.** RPC mode keeps the child alive so the parent
  can steer mid-run and read incremental progress.
- **Turn-end notifications.** The one-shot model only returns at the end.
  Deep research needs the parent to react to partial results.
- **Input queue.** `steer` / `follow_up` are a real queue with defined
  delivery semantics; the one-shot model has nowhere to inject mid-run.
- **Pagination.** `observe_subagent` + `get_entries` with a cursor lets the
  parent read as much or as little as it wants, protecting its own context.

## Skills (practical usage patterns)

Three project-local skills (`.pi/skills/`) document the intended way to
*use* these tools well. They load automatically once the project is trusted:

- **`subagent-async`** — the core habit: spawn, keep working, and wake on a
  **report** or **intrinsic-idle** notification. Do **not** `await_subagent`
  right after spawning. (Note: `settled` is no longer the wake signal — a
  subagent that settles may just be between turns. You're woken when it
  reports or when its subtree goes intrinsically idle.)
- **`subagent-parallel-research`** — fanning out N subagents in parallel,
  observing selectively, synthesizing results.
- **`subagent-context-hygiene`** — keeping the parent's context window
  clean: paginated `observe_subagent` via the `since` cursor, capping
  `await_subagent`, disposing finished subagents.

Read these before orchestrating subagents — they encode the patterns the
extension was designed around.

## Known limitations / next steps

This is a scaffold. Things you'll likely want to add:

- **Prompt templates / agent presets** like the official subagent example's
  `scout`/`planner`/`worker` `.md` definitions, so `spawn_subagent` can take
  a named agent role instead of a raw prompt.
- **Parallel + chain modes** on `spawn_subagent` (the official example has
  these; here the parent model orchestrates by calling the tool N times,
  which is more flexible but more verbose).
- **Richer notification throttling** — if a subagent takes 50 turns, you'll
  get 50 notifications. Consider coalescing or a digest.
- **Cost/usage budgets** per subagent and per tree.
- **Auto-dispose** of idle subagents after a TTL.
- **Structured reports** — the `report` tool carries free text. A future
  variant could return a JSON document or a written-to-disk artifact path.
- **Deep progress text** — full *state* of the tree (status, idle,
  usage) now reaches the root via snapshots + poll (see Live tree view), but
  a grandchild's per-turn *text output* still does not stream to the root —
  only its status does. The root must `observe_subagent` a direct child (or
  the coordinator must report) to see content from deeper tiers. Surfacing
  deep streaming text to the root would need a pi protocol extension.
