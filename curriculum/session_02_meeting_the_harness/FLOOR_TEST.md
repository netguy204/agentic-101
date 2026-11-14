# Test-student protocol — Session 2

<!-- Chunk: docs/chunks/fluency_session_02 - Session 2 floor test protocol and results -->

A session is proven by a test student working through it (DEC-014): one
person at the audience floor (DEC-004: comfortable with everyday computer
use, **no programming or terminal background**) takes the session on the
platform, self-paced, with you available as their instructor. What they
hit is fixed in the material. Findings go to `docs/trunk/FRICTION.md` and
the results log below.

Session 1's test measures comprehension. This one measures whether a person
who has never used a terminal can **type the right things and correctly
read what comes back**, from the written text, with nobody beside them.

[`DRY_RUN.md`](DRY_RUN.md) established that the commands work and that the
text describes them accurately. It says nothing about whether a person can
follow them; that is what this test is for.

## Preconditions

- A test student at the floor who has **not** seen the material, has never
  used a terminal, and has not been coached. Someone who has "picked up a
  bit of command line" tests a different session.
- The student's own machine, set up from `setup/README.md` with
  `course-smoke-test` reporting PASS before they start. Setup is tested
  separately (`setup/DRY_RUN.md`, `env/FLOOR_TEST.md`); if the smoke test
  fails, that's a setup finding, and this test starts after it's fixed.
- **The real interactive pi.** The dry run used print mode; this is the
  first time the text meets the interface the student actually sees.
- The session published on the platform at a tag, exactly as a student
  receives it, and a Session 1 inventory (their own, or Priya's).
- You do not explain anything before they start. Help only through the
  normal route ("Stuck on this session?", then "Send to your instructor"),
  and log every time they use it.

## How the test runs

1. **The student works alone on the platform**, prework through
   submission. Ask them to note, per step, how long it took and anything
   that made them stop.
2. **You answer threads as you would for any student**, and copy each
   question into the results log verbatim. In this session every thread is
   likely to be a terminal moment worth fixing in the text.
3. **Read the checkpoint result**, including near-miss rounds and
   escalations, and the submitted session log against the worksheet.
4. **Hold a debrief call** of 20–30 minutes after they submit. Ask the
   questions under "Watch-fors". Then ask, cold: "Tell me what you asked
   for, what tools it used, what you checked, and whether you used
   revert."

**If you can, watch exercises 2 and 4 live** over a screen share, saying
nothing except "what are you thinking?" when they go quiet for more than
~30 seconds. A stuck student in a terminal looks distressed, and the urge
to help is strong. Helping destroys the data. If they can't go on, record
it as a defect and *then* help.

## What to record

- **Time per step**, against the times the session page shows:
  prework 15 min, audio 15, exercises 1–2 25, exercise 3 15,
  exercises 4–5 25, solo lap 20, two real ones 15 each, one worksheet 10.
- Hesitations longer than ~10 seconds, and what was on screen.
- **Every keystroke that wasn't the instruction**: typed the `$`, typed a
  smart quote, pressed Enter twice, retyped a command that had worked.
- Words they misread or asked about. Suspects: "checkpoint", "revert",
  "delegation", "tool call", "harness", "prompt", "session".
- Every question they asked, verbatim, and where: course assistant,
  checkpoint conversation, or you.
- **Every moment they believed something had gone wrong when it hadn't.**
  The richest data in the session, and the easiest to miss, because they
  rarely say so. Ask in the debrief.
- **Defect** = they could not proceed without a person, or reached an
  outcome they didn't intend. **Observation** = friction that didn't block.
  Log both; defects block the next student until fixed.

## Watch-fors specific to this session

1. **The blank or unexpected response.** Does a command that prints
   nothing, or prints something unfamiliar, read as failure? How often do
   they retype a command that worked?
2. **The `$` and the prompt.** Do they type the `$`? Do they know when the
   terminal is ready and when it's busy?
3. **`revert`'s four questions.** The dry run found two traps: "Wait —"
   reads as an error, and the checkpoint they want is number 2. The
   exercise warns about both. **Does the warning work?** If they still
   type `1`, the list ordering in `env/bin/revert` is a candidate defect.
4. **Does the safety net remove the fear?** Ask after exercise 2 and again
   after exercise 5 (in the debrief if you didn't watch): *"On a scale of
   one to ten, how worried are you about breaking something?"* **If the
   number doesn't drop, the session has failed at its central job**,
   however many exercises were completed.
5. **The exercise 3 prompt.** How long between reading it and sending it?
   Did they describe the material or the task? Did the two sentences from
   the prework help, or did they rewrite them?
6. **Box 3 of the worksheet.** Something specific, or "looked fine"? Did
   they look at the file, or only at the terminal?
7. **The tool-call boxes.** Can they point at one and say what it is? Do
   they tell a tool call from the agent's prose without being told? If not,
   the concept track's explanation needs work.
8. **`/quit` and `pi -c`.** Do they remember them, reach for the card, or
   get stuck? Reaching for the card is a **pass**.
9. **Does the practice week read as replacing work or adding it?** Ask. If
   it reads as homework, they won't do it.
10. **Did they know when to ask for help, and how?** In particular: when the
    smoke test failed, did they stop and send the output, or start
    searching the error?

## Instructor dry run (separate, technical)

See [`DRY_RUN.md`](DRY_RUN.md), which is complete for macOS on an unpinned
pi. Before the first test student: re-run on the pinned version, run
exercises 1–5 on Windows (installation through functional pi is already
operator-verified), and run once through the real interactive pi.

## Results log

### Test student

**PENDING** — not yet performed. Needs a test student at the audience floor
on their own set-up machine. Whether a non-programmer can be made unafraid
of a terminal and an agent in one session can't be verified without one.

### Windows pass

**PARTIAL.** The operator has verified Windows installation end to end
through a functional pi, and exercise 2's `commit`/`revert` (DRY_RUN.md,
addendum). The rest of the Session 2 path is **PENDING**: `explorer .`,
editing and deleting through File Explorer, exercises 1 and 3–5, their
timings, and how a student reads them on Windows.

### Interactive pi pass

**PENDING** — the dry run used pi's print mode. `Ctrl+O`, `Escape`,
`/quit` and interactive `pi -c` are described from pi's documentation and
haven't been exercised against this session's text.
