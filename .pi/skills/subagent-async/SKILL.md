---
name: subagent-async
description: Use the hierarchy extension's subagents without blocking the parent. Spawn a subagent, return to your own work, and let the REPORT or INTRINSICALLY-IDLE notification wake you. Subagents are not 'done' when they settle; they report. Use this whenever you delegate work via spawn_subagent instead of calling await_subagent immediately.
---

# Subagent Async — fire and keep working

The hierarchy extension (`.pi/extensions/hierarchy`) gives you long-lived
subagents. The single most important habit: **do not block on a subagent
unless you genuinely cannot proceed without its result.**

## The mental model (read this — it changed)

A subagent never declares "done." It only **reports**, then ends its turn
and becomes **intrinsically idle** — a normal, resumable resting state.
`settled` means the subagent's *process* went idle; it does **not** mean the
subagent finished its task. You are woken by a **report**, not by a settle.

There are two ways a subagent reports to you:

1. **Explicit report** — the subagent called its `report` tool to hand you a
   result/finding/question. This is delivered to your context immediately as a
   real user message. The subagent may keep working and report again.
2. **Implicit intrinsic-idle report** — the subagent ended its turn *without*
   calling `report`, and nothing in its subtree can continue without
   intervention. The harness forwards its last assistant output, labeled as
   *inferred*. This is the safety net for a subagent that forgot to report.

This matters most for **coordinators** (subagents that spawn their own
subagents): a coordinator that fans out a team and then ends its turn fires
`settled` immediately, even though its children are still running. Under the
old model that falsely woke you with "done." Now the coordinator's own
extension holds its report until its subtree is actually quiescent — so when
you're woken, it genuinely has something to say.

## The pattern

1. `spawn_subagent` with an initial prompt → you get back an id immediately.
   (Tell the subagent, as part of its prompt, to call `report` to hand you
   results.)
2. **Stop.** End your turn or move on to other work for the user. Do **not**
   call `await_subagent`.
3. The subagent streams `turn_end` notifications back to you (visible in the
   UI, one-line previews). These are **not** injected into your context —
   they're signals, not content.
4. When the subagent **reports** (explicit) or goes **intrinsically idle**
   (implicit), the hierarchy extension injects its output into your
   conversation as a **real user message**, which starts a new turn. That is
   your wake-up: you resume automatically, no polling required. (If you're
   mid-run when it arrives, the message is queued and delivered after your
   current turn's tool calls finish.)
5. Act on what you were handed. A reported subagent is **not** disposed — it's
   idle and resumable. `steer_subagent` / `follow_up_subagent` to push it
   through more turns, or `dispose_subagent` when you're done with it. Only
   call `observe_subagent` (with the `since` cursor) if you need history
   beyond the delivered report.

## Persistent hierarchies

Because reporting doesn't mean done, a subagent can report → go idle → you
steer a clarifying question → it runs again → reports again. This cycle is
first-class. Don't assume a subagent that reported is finished; decide
explicitly whether to steer or dispose.

## Why not `await_subagent`?

`await_subagent` **blocks your current turn** until the subagent settles or
the timeout fires (default 10 min). While blocked you cannot do anything
else — you can't answer the user, can't steer another subagent, can't react
to new input. For a subagent that finishes in 30 seconds, that's 30 seconds
of a frozen parent. For one that hangs, it's a 10-minute stall that ends in
a timeout either way.

Blocking is the wrong default. The completion notification already wakes
you. Use blocking only when the user's *current* request literally cannot
be answered until the subagent returns.

## When blocking IS appropriate

- The user asked a direct question whose answer **is** the subagent's
  output, and there's nothing else to do in the meantime.
- You're at a hard serialization point in a multi-step plan and the next
  step strictly depends on this result.
- You've spawned something quick (a single tool call's worth of work) and
  the round-trip of a notification would be noisier than just waiting.

Even then, prefer a short explicit `timeout_ms` over the 10-minute default
so a stuck child fails fast.

## Tools, in order of preference

| Tool | Use it when |
|------|-------------|
| `spawn_subagent` | Starting work. Always returns immediately. |
| *(do nothing)* | While it runs. Let the notification wake you. |
| `observe_subagent` | You want a deliberate, non-blocking peek at progress or paginated detail. |
| `steer_subagent` | Redirect a running subagent mid-flight. |
| `follow_up_subagent` | Queue the *next* task for after it settles. |
| `await_subagent` | Rare. Only when you truly must block for the result. |
| `dispose_subagent` | When you're done with a subagent. Don't leak processes. |

## Anti-patterns

```
spawn_subagent(...)        # good
await_subagent(id)         # ← don't. You just froze yourself for no reason.
```

If you catch yourself writing `await_subagent` right after `spawn_subagent`
with nothing in between, stop. End the turn instead. The report will come
to you.

Also: **don't treat a `settled` subagent as finished.** If a subagent ends
its turn without reporting and its subtree is quiescent, you get an
*inferred* report — that's a prompt to look, not a success signal. Decide
whether to steer it for a real result or dispose it.

## If you are a coordinator (you spawned your own subagents)

When your subagents finish, call **`report`** to hand your synthesis to your
parent. Do **not** just end your turn and assume your parent will be woken
— ending your turn without reporting means your parent only gets an
*inferred* report (your raw last output), which is a weaker handoff than an
explicit `report`. And if your own subagents are still running when you end
your turn, you will *not* be reported up at all until your subtree is
quiescent — so make sure to either `await_subagent` your children (with a
short timeout) or keep working until you can `report` a synthesis.

## Related skills

- `subagent-parallel-research` — fanning out several async subagents at once.
- `subagent-context-hygiene` — keeping your context clean while many run.

See also: `.pi/extensions/hierarchy/README.md` for the full tool reference
and notification model.
