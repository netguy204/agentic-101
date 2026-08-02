---
name: subagent-context-hygiene
description: Keep the parent agent's context window clean while using hierarchy subagents. Covers the notification model, paginated observation via the since cursor, capping await_subagent, and disposing finished subagents. Use whenever you delegate to subagents and want to avoid context bloat.
---

# Subagent Context Hygiene

The hierarchy extension is designed so the parent's context window stays
under **your** control. That only works if you use the tools the way the
design intends. This skill is the rulebook for not bloating yourself.

## The core rule

**`turn_end` and `settled` are signals, not content; `report` and
`intrinsically_idle` inject content.** Per-turn `turn_end` and the
process-idle `settled` event are surfaced via `ctx.ui.notify` — one-line
UI previews that are **not** injected into your conversation context.
`settled` is not a report (a subagent that settles may just be between
turns, or a coordinator waiting on its own children). Content is injected
only when a subagent **reports** (explicit, via its `report` tool) or
goes **intrinsically idle** (implicit fallback — it ended its turn
without reporting and its subtree can't progress). Both inject a real
user message (capped at 32 KiB) and start a new turn — you wake up with
the result automatically, no `observe_subagent` needed.

So: let `turn_end`/`settled` signals flow without pulling detail, and trust
that the report will arrive on its own. Use `observe_subagent` only when
you need the *intermediate* history (tool calls, mid-run progress) beyond
the delivered report.

## Observing without bloating

`observe_subagent` is paginated on purpose. Use the pagination:

- **Pass `since`.** Every call returns a `nextSince` cursor. Store it and
  pass it on the next call so you only get **new** entries, never a re-read
  of what you've already seen.
- **Keep `limit` small.** Default is 5, max is 40. Reach for the max only
  when you genuinely need a long history; usually the recent slice is
  enough to decide whether to steer or wait.
- **Skip turn summaries when you don't need them.** `include_turn_summaries: false`
  returns just the raw new entries — cheaper when you only want to confirm
  progress.
- **Observe one subagent at a time, only the ones that matter.** Don't
  round-robin `observe_subagent` across every live subagent each turn.

## Awaiting safely

`await_subagent` returns the subagent's **last assistant text**, capped
at 32 KiB, plus a fallback to its last turn. It blocks your turn while
waiting. To use it without wrecking your context or freezing yourself:

- **Prefer not calling it at all** — let the report/intrinsic-idle
  notification deliver the text to you as a new turn. (See `subagent-async`.)
- **If you must block, pass a short `timeout_ms`.** The default is 10
  minutes, which exists so a hung child fails fast rather than pinning you
  overnight. For a subagent you expect to finish in seconds, pass
  `timeout_ms: 30000` or similar. Pass `0` only when you truly want to
  wait forever.
- **You don't need to `observe` after `await`.** `await_subagent` already
  hands you the last output. Re-observing just re-pulls history you
  largely have.

## Disposing

Every live subagent is a `pi --mode rpc` child process holding memory and
possibly file handles. When you've harvested what you need:

```
dispose_subagent(subagent_id)
```

Do this even for subagents that exited on their own — `dispose` clears
them from the live list. The extension disposes all subagents on session
shutdown, but don't rely on that for a long interactive session; clean up
as you go.

## What bloats the parent context (avoid these)

- Calling `observe_subagent` with no `since` repeatedly — you re-read the
  same recent slice every time.
- Pulling `limit: 40` turn summaries from every subagent each turn.
- `await_subagent`-ing a subagent whose report was already injected on
  settle — you pay for the same text twice. Since reports now auto-deliver,
  reserve `await_subagent` for subagents you spawned and then *must* block
  on before they report.
- Pasting a subagent's entire output back into a *new* subagent's prompt.
  Pass a pointer or a summary instead, and let the new subagent read the
  source itself.
- Spawning many subagents whose reports all auto-inject — each report
  costs your context up to 32 KiB. Dispose subagents you're done with, and
  don't fan out more than you intend to read.
- Letting many finished-but-undisposed subagents accumulate so
  `list_subagents` returns a wall of text.

## Quick checklist per subagent

1. Spawned with a tight prompt + minimal `tools`.
2. Let it run; react to notifications, don't poll.
3. When you need detail: `observe_subagent` with `since` + small `limit`.
4. When it **reports** (or goes intrinsically idle): act on the delivered text.
5. `dispose_subagent` when you're done.

## Related skills

- `subagent-async` — the non-blocking habit that makes hygiene possible.
- `subagent-parallel-research` — fanning out many at once.

See also: `.pi/extensions/hierarchy/README.md`, especially the
"Notification model" and "Design notes" sections.
