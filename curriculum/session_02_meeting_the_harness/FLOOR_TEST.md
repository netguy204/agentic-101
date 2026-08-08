# Floor Test Protocol — Session 2

<!-- Chunk: docs/chunks/fluency_session_02 - Session 2 floor test protocol and results -->

Per `docs/trunk/TESTING_PHILOSOPHY.md` (Floor Testing): before this session
is taught for the first time, at least one person matching the audience floor
(DEC-004: comfortable with everyday computer use, **no programming or
terminal background**) works through its prework and exercises while an
author observes silently. Observed friction is fixed, not explained away;
findings route to `docs/trunk/FRICTION.md`.

Session 1's floor test measured **comprehension** — whether an argument
landed. This one measures something harder and more falsifiable: whether a
person who has never used a terminal can **type the right things and
correctly interpret what comes back**, unaided, from the written text. That
is a much sharper test, and it is the one that decides whether this session
is teachable.

[`DRY_RUN.md`](DRY_RUN.md) has already established that the commands work and
that the text describes them accurately. It establishes nothing at all about
whether a human can follow them. Those are different questions and this is
the second one.

## Preconditions

- A tester at the floor who has **not** seen the material, has never used a
  terminal, and has not been coached. Someone who has "picked up a bit of
  command line" tests a different session.
- **A machine set up exactly as a participant's would be**: the environment
  installer run, `setup/install-pi.sh` run with a real key, and
  `course-smoke-test` reporting PASS *before* the tester sits down. The floor
  test is not a test of setup — `setup/DRY_RUN.md` and
  `env/FLOOR_TEST.md` own that.
- **The real interactive pi**, not print mode. The one thing the dry run
  could not exercise is the interface the tester will actually meet.
- The prework sent exactly as a participant would receive it, by email, with
  no verbal preamble, a week ahead.
- Printed [`handouts/terminal-card.md`](handouts/terminal-card.md) and
  [`handouts/what-did-it-do.md`](handouts/what-did-it-do.md), and a filled-in
  toil inventory (the tester's own, or Priya's).
- A timer. The exercise timings are assertions, and this is where they get
  checked.
- Observer says nothing after the start except "what are you thinking?" when
  the tester goes quiet for more than ~30 seconds. **The temptation to help
  is enormous in this session** — a stuck tester in a terminal looks
  genuinely distressed. Helping destroys the data. If they cannot proceed,
  that is a defect; record it and *then* help.

## Tasks (read to the tester verbatim)

1. "Here's an email you'd have got before the session. Do what it asks."
   ([`PREWORK.md`](PREWORK.md), cold, timed. Watch: does the concept-map
   table get read or skipped? Does part 2 produce a *material* sentence or a
   *task* sentence? Does part 3 get run at all?)
2. "Work through this and stop when you get to exercise 2."
   ([`EXERCISES.md`](EXERCISES.md), exercise 1, unaided, timed against 11
   minutes.)
3. "Now exercise 2." (Timed against 14 minutes. **The single most important
   observation in the protocol** — see watch-fors 3 and 4.)
4. "Here's what pi is." (Read the facilitator guide's beat 4 aloud, once,
   exactly as written. Then:) "What are the four tools?" Ask it thirty
   minutes later too.
5. "Exercise 3." (Timed against 14 minutes. Watch the prompt they compose
   before they send it — that is the exercise's real difficulty.)
6. "Exercise 4, and fill in the worksheet." (Timed against 13 minutes. This
   is the session's outcome; everything else is instrumentation.)
7. "Exercise 5." (Timed against 7 minutes.)
8. "Tell me what you asked for, what tools it used, what you checked, and
   whether you used revert." (The checkpoint, cold.)
9. "Read this and tell me what you'd do over the next week."
   ([`PRACTICE.md`](PRACTICE.md). Watch whether the 60-minute budget reads as
   reasonable or as homework, and whether "two real ones" reads as
   *replacing* work or *adding* it.)

## What the observer records

- **Time per exercise**, against the claims: 11 / 14 / 14 / 13 / 7 minutes.
- Hesitations longer than ~10 seconds, and what was on the screen.
- **Every keystroke that wasn't the instruction** — typed the `$`, typed a
  smart quote, hit Enter twice, retyped a command that had already worked.
- Words the tester misread or asked about. Particular suspects: "checkpoint",
  "revert", "delegation", "tool call", "harness", "prompt", "session".
- Every question asked aloud, verbatim.
- **Every moment the tester believed something had gone wrong when it hadn't.**
  This is the richest data in the session and the easiest to miss, because
  they usually don't say anything — watch the face and the pause.
- **Defect** = the tester could not proceed without help, or proceeded to an
  outcome they didn't intend. **Observation** = friction that didn't block.
  Both get logged; defects block cohort use until fixed.

## Watch-fors specific to this session

1. **The blank or unexpected response.** Does a command that prints nothing —
   or prints something unfamiliar — read as failure? Count how many times the
   tester types a working command a second time because they didn't believe
   it worked.
2. **The prompt versus the `$`.** Do they type the `$`? Do they know when the
   terminal is ready for them and when it is busy?
3. **`revert`'s four questions.** The dry run found two traps here: the word
   "Wait —" reads as an error, and the checkpoint they want is number 2, not
   1. The exercise now warns about both. **Does the warning work?** If the
   tester still types `1`, the fix isn't the text — the command's list
   ordering is a candidate defect in `env/bin/revert` and should be logged
   there.
4. **Does the safety net actually remove the fear?** Ask directly after
   exercise 2: *"On a scale of one to ten, how worried are you about breaking
   something?"* Ask again after exercise 5. **If the number doesn't drop, the
   session has failed at its central job**, regardless of how many exercises
   were completed. This is the most important single question in the
   protocol.
5. **Composing the exercise-3 prompt.** How long between reading the fill-in
   sentence and sending it? Do they describe the *material* or the *task*?
   The prework asks them to write this sentence in advance — did having done
   so help, or did they rewrite it anyway?
6. **Box 3 of the worksheet.** Does it contain something specific, or "looked
   fine"? Did they look at the *file*, or at the terminal? Watch which window
   they click on — this is observable and it is the whole session.
7. **The tool-call boxes.** Can the tester point at one on screen and say
   what it is? Do they distinguish a tool call from the agent's prose without
   being told which is which? If not, the beat-4 script needs work — the
   facilitator gets one pass at that explanation and it has to hold.
8. **`/quit` and `pi -c`.** Two pieces of vocabulary carried across three
   exercises. Does the tester remember them, or reach for the card, or get
   stuck? Reaching for the card is a **pass** — that's what it's for.
9. **Does the practice assignment read as replacing work or adding it?** Ask
   directly. If it reads as homework, the framing has failed and the audience
   will quietly not do it.

## Facilitator dry-run (separate, technical)

See [`DRY_RUN.md`](DRY_RUN.md), which is complete for macOS on an unpinned pi
and lists four things outstanding before first teach: re-run on the pinned
version, run once end to end on Windows, run once through the real
interactive TUI, and this floor test.

## Results log

### Human floor test

**PENDING** — not yet performed. Requires a tester at the audience floor and
a fully provisioned machine; **operator follow-up**. Nothing in this session's
central claim — that a non-programmer can be made unafraid of a terminal and
an agent in ninety minutes — can be verified without one. The dry run tells
you the commands work. It cannot tell you whether anyone can follow them.

### Windows pass

**PENDING** — no Windows machine was available. `explorer .`, double-clicking
a `.txt` to edit it, deleting from File Explorer, and the whole managed
Windows Terminal path are unverified (`env/README.md` records the installer
itself as authored-but-untested).

### Interactive TUI pass

**PENDING** — the dry run used pi's print mode. `Ctrl+O`, `Escape`, `/quit`
and interactive `pi -c` are described in the material from pi's documentation
and have not been exercised against this session's text.

### First teach

**PENDING** — checkpoint results (the table in
[`CHECKPOINT.md`](CHECKPOINT.md)) get summarised here after the first live
delivery, along with actual timings against the timing table in
[`FACILITATOR_GUIDE.md`](FACILITATOR_GUIDE.md), and the setup-triage tally.
The 90-minute budget is a first estimate; the triage opening in particular is
a guess at eight minutes and is the most likely thing to move.
