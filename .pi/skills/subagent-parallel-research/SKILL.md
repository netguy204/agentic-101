---
name: subagent-parallel-research
description: Fan out multiple hierarchy subagents in parallel for research or multi-part tasks, observe them selectively, and synthesize their results. Use when a task decomposes into independent subtasks that each warrant their own context window.
---

# Subagent Parallel Research

When a task splits into independent parts, run them as parallel subagents
rather than one big sequential pass. Each subagent gets its own context
window, so none of them pollutes the others (or the parent) with
intermediate detail.

## When to fan out

- **Independent research questions** about the same codebase or topic.
- **Explore + implement**: one subagent investigates while another drafts.
- **Multiple files/modules** that can be read or modified independently.
- **Comparison**: run the same question with different models or prompts.

Do **not** fan out when the subtasks are tightly coupled and each step
depends on the last — that's a single subagent with `follow_up_subagent`
chaining, not parallelism.

## The pattern

1. **Spawn all of them up front**, back to back, each with a focused
   prompt. Do not wait between spawns.

   ```
   spawn_subagent(prompt="Read docs/trunk/GOAL.md and summarize the goal", label="goal")
   spawn_subagent(prompt="List docs/chunks and describe recent work",   label="chunks")
   spawn_subagent(prompt="Audit the test layout and report gaps",       label="tests")
   ```

   You now have three ids. End your turn or do other work.

2. **Let notifications arrive.** Each subagent streams `turn_end` previews
   (non-intrusive, one line). When one **reports** (explicitly via its
   `report` tool) or goes **intrinsically idle** (implicit fallback), you
   get its text as a new turn. You do not need to babysit all three.

3. **Observe selectively.** If a subagent's preview looks off-track, call
   `observe_subagent` on just that one and `steer_subagent` to correct it.
   Don't pull detail from the ones that are fine — protect your context.

4. **Synthesize when they're done.** Once all have reported (or gone
   intrinsically idle), combine their outputs into the answer the user
   asked for. Track which are finished with `list_subagents` if you've
   lost track. Note: a subagent that reported may still be working —
   "reported" is not "done." When you ask for research, tell each
   subagent to call `report` with its findings.

5. **Dispose.** `dispose_subagent` each one when you've harvested its
   output.

## Giving each subagent a tight scope

Parallel works best when each subagent has a small, well-bounded job. In
the `spawn_subagent` call:

- Set `tools` to the minimum it needs (e.g. `"read,grep,find,ls"` for
  read-only research — no `write`/`edit`/`bash` if it shouldn't mutate).
- Write the prompt to produce a **specific deliverable** ("summarize X",
  "list Y", "return the path of Z") rather than an open-ended exploration.
- Consider a cheaper/faster `model` for mechanical subtasks and a stronger
  one for synthesis-heavy ones.

## Tracking state across many subagents

With more than ~3 in flight, keep a mental (or written) table:

| id | label | job | status |
|----|-------|-----|--------|
| sub-1 | goal | summarize GOAL.md | settled |
| sub-2 | chunks | recent work | running |
| sub-3 | tests | audit gaps | running |

`list_subagents` gives you the live version of this (status + turn/cost
totals). Use it when you've lost the thread.

## Pitfalls

- **Spawning then immediately `await_subagent`-ing the first one.** This
  serializes your fan-out and blocks you from steering the others. See the
  `subagent-async` skill — don't block.
- **Pulling full history from every subagent.** That defeats the point of
  isolated context windows. Use `observe_subagent`'s `since` cursor and
  small `limit`, and only on subagents you actually need detail from.
- **Forgetting to dispose.** Idle subagents still hold a `pi --mode rpc`
  process. Clean up when you're done.
- **Nesting too deep.** Subagents can spawn their own subagents, but a
  tier-2 subagent's notifications go to the tier-2 process, not to you.
  Keep the tree shallow unless you've designed for the depth.

## Related skills

- `subagent-async` — the non-blocking habit this builds on.
- `subagent-context-hygiene` — keeping the parent's context clean while
  many subagents report back.

See also: `.pi/extensions/hierarchy/README.md`.
