# Floor Test Protocol — Session 1

<!-- Chunk: docs/chunks/fluency_session_01 - Session 1 floor test protocol and results -->

Per `docs/trunk/TESTING_PHILOSOPHY.md` (Floor Testing): before this session
is taught for the first time, at least one person matching the audience
floor (DEC-004: comfortable with everyday computer use, **no programming
or terminal background**) works through its prework and exercises while an
author observes silently. Observed friction is fixed, not explained away;
findings route to `docs/trunk/FRICTION.md`.

Session 1 has no software in it, so unlike `env/FLOOR_TEST.md` there is
nothing to install and nothing to break. What is being tested here is
**comprehension**: whether the written material produces the right
thinking in someone who has never encountered any of these ideas.

## Preconditions

- A tester at the floor who has **not** seen the material, has not
  discussed the course, and does not know the observer's thesis. Someone
  who already agrees with the leverage argument tests nothing.
- The prework sent exactly as a participant would receive it, by email,
  with no verbal preamble.
- A printed inventory sheet and printed canned-toil sheet.
- A timer. The prework claim (≤30 min) and the exercise timings are
  assertions, and this is where they get checked.
- Observer says nothing after the session starts except "what are you
  thinking?" when the tester goes silent for more than ~30 seconds.

## Tasks (read to the tester verbatim)

1. "Here's an email you'd have got before the course. Do what it asks."
   (`platform/prework/01_mental_models.md`, cold, timed. Watch for: does
   the five-task list produce real tasks or job-description phrases?)
2. "Read this sheet and tell me, in your own words, what the four columns
   want from you." (`handouts/toil-inventory.md`, no facilitator
   explanation. This is the hardest test in the protocol — the sheet has
   to survive being read alone, because participants will re-read it
   during the practice week with nobody to ask.)
3. "Fill in the first two columns for the five tasks you listed."
   (Exercise 1 from the written text alone.)
4. "Now fill in the last two columns." (Exercise 2, unaided and timed.
   Twelve minutes is the claim.)
5. Observer plays the skeptic for two of the tester's entries.
   (Exercise 3. Watch whether the tester experiences it as help or as an
   exam.)
6. "Pick one task and tell me whether it's inside or outside your
   judgment boundary, and why." (The checkpoint, cold, without having
   been coached on the phrase.)
7. "Read this and tell me what you'd do over the next week."
   (`PRACTICE.md`. Watch whether the 55-minute budget reads as
   reasonable or as homework.)

## What the observer records

- **Time per task**, against the claims: prework ≤30 min total, exercise 1
  = 7 min, exercise 2 = 12 min, exercise 3 = 8 min.
- Hesitations longer than ~10 seconds, and what was on the page.
- Words the tester misread or asked about. Particular suspects:
  "judgment boundary", "toil", "delegable", "judgeability", "harness".
- Every question asked aloud, verbatim.
- Wrong guesses — what they wrote where we didn't expect it.
- **Defect** = the tester could not proceed without help, or proceeded to
  an outcome they didn't intend. **Observation** = friction that didn't
  block. Both get logged; defects block cohort use until fixed.

## Watch-fors specific to this session

1. **"I can't do it" vs "I can't check it."** The single most likely
   comprehension failure, and the one the whole session turns on. Does the
   tester mark things **out** because they lack the expertise? If the
   written material can't prevent this without a facilitator, the sheet
   and the exercise text need work — the practice week has no facilitator
   in it.
2. **Does the cold open read as argument or as flattery?** Ask afterwards:
   "did that feel like it was buttering you up?" A tester who felt
   flattered will not have believed it, and the whole recruitment beat
   fails silently — they'll be polite about it in the room.
3. **Frequency in the judgeability column.** Does anyone write "every
   week" or "often" in column 3? If the column label invites it, relabel.
4. **The check column going vague.** How many entries get "I'd read it
   over" or similar? If it's most of them, the worked example in the
   handout isn't doing enough work.
5. **Does the prework's part 3 actually stop a failed-setup participant
   from debugging?** Ask a tester who reports FAIL what they'd do next. If
   the answer is "search the error message", the wording isn't emphatic
   enough — and this one costs a participant an evening.
6. **Blank-page freeze on the five-task list.** How long before the first
   line is written? If it's over two minutes, the prompts need to move
   above the instruction rather than below it.
7. **Is the sheet fillable on paper?** Column widths, whether the check
   column has room for a real sentence. Trivial, and it invalidates the
   exercise if wrong.

## Facilitator dry-run (separate, technical)

The demo is the only executable thing in the session, and it needs its own
pass — see `docs/trunk/TESTING_PHILOSOPHY.md`, Exercise Dry-Runs: agentic
steps run at least twice, because model behaviour varies.

- Run the `headcount.csv` demo **at least three times** on the pinned
  model, from a clean folder each time.
- Record, per run: did the agent fold `Brand & Mktg` into Marketing? Did it
  fold `Field`/`Field Sales`? Did it ask a clarifying question instead of
  deciding? Did it do anything else worth scripting a recovery for?
- If the reveal row is wrong-as-expected in fewer than two of three runs,
  the demo file needs a more reliably ambiguous row before first teach.
- Confirm the appendix transcript still resembles what the model actually
  produces; it is read aloud as a fallback and shouldn't sound dated.

## Results log

### Human floor test

**PENDING** — not yet performed. Requires a tester at the audience floor;
operator follow-up. Nothing in this session can be verified without one:
there is no automated check that tells you whether an argument persuaded
someone.

### Facilitator demo dry-run

**PENDING** — not yet performed. Requires a working pi install on the
pinned model (`setup/pins.env`) and three runs of the `headcount.csv`
demo.

### First teach

**PENDING** — checkpoint results (the table in
[`CHECKPOINT.md`](CHECKPOINT.md)) get summarised here after the first live
delivery, along with actual timings against the timing table in
[`FACILITATOR_GUIDE.md`](FACILITATOR_GUIDE.md). The 90-minute budget is a
first estimate and is expected to move.
