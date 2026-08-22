# Floor Test Protocol — Session 3

<!-- Chunk: docs/chunks/fluency_session_03 - Session 3 floor test protocol and results -->

Per `docs/trunk/TESTING_PHILOSOPHY.md` (Floor Testing): before this session
is taught for the first time, at least one person matching the audience floor
(DEC-004: comfortable with everyday computer use, **no programming or
terminal background**) works through its prework and exercises while an
author observes silently. Observed friction is fixed, not explained away;
findings route to `docs/trunk/FRICTION.md`.

Session 2's floor test measured whether a person could **type the right
things and interpret what came back**. This one measures something that sits
on top of that and is harder to fake: whether a person can **write down, on
one page, what an agent needs** — and then read a run against that page and
say *which part* of it let them down. The mechanics are Session 2's; the
skill is new.

[`DRY_RUN.md`](DRY_RUN.md) establishes that Priya's briefs run, what they
produce on the course model, and which one goes wrong. It establishes
nothing about whether a human can fill the brief in from the handout alone
or find the box that failed. Those are this protocol's questions.

## Preconditions

- A tester at the floor who has **done Session 2's exercises** (or Session
  2's floor test) — this session assumes the loop and the tool-call boxes.
  Someone who has not run a delegation tests Session 2, not this.
- A machine set up exactly as a participant's would be, with
  `course-update` reporting *Nothing to do* and a practice folder that has
  been used at least once.
- The tester's own toil inventory with one `in` entry starred, **or**
  Priya's sheet with Brief B chosen for them (B is the one built to go
  wrong in the first run, which is the experience the test needs to see).
- A filled-in `what-did-it-do.md` worksheet on a delegation that went badly
  — their own from the practice week, or one the observer runs with them
  beforehand on a deliberately under-specified prompt, so the tester has a
  sentence for exercise 1.
- Printed [`handouts/delegation-brief.md`](handouts/delegation-brief.md)
  (two), Session 2's terminal card, and `canned-toil.md`.
- The prework sent as an email a week ahead, no verbal preamble.
- A timer. The exercise timings are assertions: 12 / 12 / 24 / 10.
- Observer says nothing after the start except "what are you thinking?"
  when the tester goes quiet for more than ~30 seconds. If they cannot
  proceed, that is a defect; record it and *then* help.

## Tasks (read to the tester verbatim)

1. "Here's an email you'd have got before the session. Do what it asks."
   ([`PREWORK.md`](PREWORK.md), cold, timed against 25 minutes. Watch: do
   the three reasons read as obvious or as jargon? Does part 2 produce a
   *sentence* or a paragraph? Does part 3 pick an entry with a file in it?)
2. "Say your one sentence about the one that went worst. Now — which of
   these three was it?" (Exercise 1, one person. Point at the three reasons
   written on a card. Time how long the placement takes and whether they
   need the fourth bucket.)
3. "Now fill in the brief for your starred entry." ([`EXERCISES.md`](EXERCISES.md),
   exercise 2, unaided, from the handout alone, timed against 12 minutes.
   **The single most important observation in the protocol** — see
   watch-fors 1–3. Do *not* work Priya's roll-up on the board first; the
   test is whether the handout carries the form on its own.)
4. "Run it as the sheet says, and stop when you get to step 7." (Exercise
   3, steps 1–6, timed. Watch the what-you-type rule: do they send the
   Instruction box or something longer?)
5. "Steps 7 and 8." (Which box, and why — the session's evidence. Time how
   long from reading the result to naming a box.)
6. "Finish exercise 3." (The `revert`-to-before move, unaided from the
   text; then the second run. Timed against the remaining budget.)
7. "Exercise 4." (Timed against 10 minutes. The written miss, and whether
   they add a check or write *out*.)
8. "Tell me which box you changed and why, and what your check would still
   miss." (The checkpoint, cold.)
9. "Read this and tell me what you'd do over the next week."
   ([`PRACTICE.md`](PRACTICE.md). Watch whether "run it on the real task"
   reads as replacing work or adding it, and whether the gate paragraph
   reads as a real gate or as boilerplate.)

## What the observer records

- **Time per exercise**, against the claims: 12 / 12 / 24 / 10.
- Hesitations longer than ~10 seconds, and what was on the screen or page.
- **Every box the tester left blank, wrote "see above" in, or filled with
  a copy of another box.**
- Words the tester misread or asked about. Particular suspects: "brief",
  "inputs", "checkpoint", "delegation", "out of bounds", "revert to before".
- Every question asked aloud, verbatim.
- **The sentence written in "Which box let me down"** — verbatim. This is
  the session's outcome and the richest single data point.
- **Defect** = the tester could not proceed without help, or proceeded to
  an outcome they didn't intend. **Observation** = friction that didn't
  block. Both get logged; defects block cohort use until fixed.

## Watch-fors specific to this session

1. **The Inputs box.** Does the tester name *facts* as well as files, or
   only files? The handout's one-line prompt ("and the facts it needs that
   aren't written anywhere") is the only thing carrying this. If the box
   holds only a filename, the prompt isn't enough and the handout needs
   the example row moved up.
2. **Column 2 pasted in as the instruction.** Does the Instruction box name
   a file and a result, or is it the inventory's "done right" sentence
   verbatim ("the tracker is tidy")? The exercise asks for "one sentence it
   can act on"; watch whether that phrase does anything.
3. **"I'll read it over."** Does the Checkpoints box say what they'd be
   reading *for*? Session 1 taught this and Session 2 used it; if it has
   regressed on the brief, the box's prompt needs the Session 1 question
   printed on it.
4. **The what-you-type rule.** Do they send the Instruction box word for
   word, or rewrite it at the keyboard, add "please", add explanation? If
   they rewrite, the brief is being treated as notes rather than as the
   thing sent — and the second run can't tell them what the brief was
   worth.
5. **Finding the box.** After the first run, how long until they name a
   box — and is it the right one? The runsheet predicts the agent gets it
   right for a third of the room; if the tester's run is clean, do they
   reach for the Checkpoints box on their own or write "nothing"?
6. **Changing one box.** Do they change one, or several? Is the sentence
   a box and a reason, or "I made it clearer"?
7. **`revert` to *before run 1*.** Do they read the names? Do they pick
   *after run 1* by mistake, and if so do they recover from the text alone?
   This is the one new mechanical move; if it fails unaided, the exercise
   needs the projector demo moved into the participant text.
8. **Box 5.** Do they name something their checkpoints would *not* catch,
   or something they would? Do they reach *out* honestly, as an exit, or
   not at all? Ask afterwards: "was writing *out* a relief, a failure, or
   a finding?" — the answer tells you whether the session's framing landed.
9. **Does the practice assignment read as replacing work or adding it?**
   Ask directly, as in Session 2. And: does "it does, you decide" survive
   being linked rather than restated?

## Facilitator dry-run (separate, technical)

See [`DRY_RUN.md`](DRY_RUN.md): Priya's three briefs run for real on the
course model, each at least twice, with the `revert`-to-before move, from
the written text. Before first teach: re-run on the pinned pi version, run
exercise 3 once on Windows, run once through the real interactive TUI, and
perform this human floor test.

## Results log

### Human floor test

**PENDING** — not yet performed. Requires a tester at the audience floor
who has done Session 2, and a provisioned machine; **operator follow-up**.
Nothing in this session's central claim — that a non-programmer can write
down what an agent needs and read a run against it — can be verified
without one. The dry run tells you the briefs run. It cannot tell you
whether anyone can write one.

### Windows pass

**PENDING** — the dry run was macOS only. Exercise 3's steps are the same
commands Session 2 verified partially on Windows on 2026-08-22
(`commit`/`revert` through Git Bash), plus `pi -p`-equivalent runs that were
not exercised there; the `revert`-to-before move has not been done on
Windows.

### Interactive TUI pass

**PENDING** — the dry run used pi's print mode. `/quit`, `Ctrl+O`, `Escape`
and the interactive session are described from pi's documentation and
Session 2's text; they have not been exercised against this session's
steps.

### First teach

**PENDING** — checkpoint results (the table in
[`CHECKPOINT.md`](CHECKPOINT.md)) get summarised here after the first live
delivery, along with actual timings against the timing table in
[`FACILITATOR_GUIDE.md`](FACILITATOR_GUIDE.md) and the exercise-1 tally. The
90-minute budget is a first estimate; exercise 3's twenty-four minutes is
the number most likely to move, in either direction, depending on how many
first runs come back clean.
