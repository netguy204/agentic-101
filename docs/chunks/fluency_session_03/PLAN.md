<!-- This document captures HOW you'll achieve the chunk's GOAL. -->

# Implementation Plan

## Approach

Copy Session 2's shape file for file and fill it with Session 3's content;
do not invent a new shape. `curriculum/session_02_meeting_the_harness/` is
read end to end first and used as the structural template for each
artifact (README tables, facilitator-guide beats/timing/failures/FAQ,
participant-only EXERCISES and facilitator-only RUNSHEET, PRACTICE budget
table, CHECKPOINT round/tally/recovery, FLOOR_TEST protocol, DRY_RUN
record). Voice comes from the existing sessions and `pi-learning-paths.md`.

Build inside-out: the handout first (the brief is what every other file
points at), then the fallback (`canned-toil.md` "For Session 3"), then the
participant steps (EXERCISES) and the facilitator runsheet against them,
then the guide, prework, practice, checkpoint, README, then the dry run
(real pi runs, recorded honestly), then FLOOR_TEST, then the convention
files (curriculum/README.md session table, SPEC item 3). Every claim about
pi is checked against `docs/chunks/onboarding_setup_guide/pi-reference.md`.

Testing per `docs/trunk/TESTING_PHILOSOPHY.md`: the dry run executes the
written steps literally (deviations recorded, text fixed where the runner
had to improvise), each agent step at least twice, including the
under-specified canned brief until it produces a visible near-miss; the
mechanical checks from `fluency_exercise_split` (audience purity, link
integrity, `ve validate`) run at the end. The floor test is written as a
protocol with PENDING results — it cannot be executed by the author.

## Sequence

### Step 1: Read the template
Read all of `session_02_meeting_the_harness/` (every file, both handouts),
Session 1's two handouts, `pi-reference.md` §3 (essential workflow,
sessions: `pi -c`, `pi -r`, `/quit`, `Ctrl+O`, `Escape`), and
`docs/chunks/fluency_session_02/PLAN.md` and `DRY_RUN.md` for how the dry
run was driven (print mode, which model, how runs were recorded).

### Step 2: `handouts/delegation-brief.md`
One printable page: title, one-paragraph why ("a colleague who cannot see
your screen"), the four boxes (Inputs / Instruction / Outputs /
Checkpoints) each with a one-line prompt and a filled example row drawn from
Session 2's "messy sample → cleaned up" task, the fifth line "What would I
have failed to catch?", a note that Instruction = inventory column 2 and
Checkpoints = column 4, and a "How this sheet is used later" table
(Session 3 / Practice / Session 4 / Session 6). Backreference to this chunk.

### Step 3: Extend Session 1's handouts in place
- `toil-inventory.md` "How this sheet is used later": add the Session 3 row
  ("You write a delegation brief for one entry; columns 2 and 4 become its
  instruction and checkpoints").
- `canned-toil.md`: add "## For Session 3 — Priya's briefs" after the
  Session 2 section: three briefs (Monday roll-up fully specified; one with
  a deliberately missing input — e.g. the regional spreadsheets' sheet names
  not given — flagged only in the facilitator runsheet, not on the handout;
  one whose checkpoint is vague so exercise 4 has something to catch). No
  answer key. A one-line note in "How to use this in the exercises".

### Step 4: `EXERCISES.md` (participant) and `EXERCISE_RUNSHEET.md`
Exercises, 90-min shape (timings only in the runsheet):
1. *Your worst one* (10) — sentence round; the facilitator's sort into
   didn't-know / decided / couldn't-tell (runsheet), participant writes
   which of the three theirs was on the worksheet.
2. *The brief* (12) — fill in the four boxes for one real `in` entry that
   passes the four-question gate (or a canned brief), drawing columns 2/4
   across.
3. *Run it, read it, fix it* (22) — `commit` → `pi` with the brief's
   instruction → read tool calls and file → compare each box → revise once
   for a named reason → `commit` → run again → `commit`. "What you should
   see": two checkpoints with names in `revert --list`.
4. *What would I have failed to catch?* (10) — the fifth line; add a second
   checkpoint or rule the task out.
5. *Wrapping up* — the checkpoint round question.
Before exercise 1: `course-update` (copy Session 2's paragraph). Runsheet
per DEC-011: no restated steps; What participants do / Say it like this /
Work one live first (the facilitator briefs Priya's roll-up on the board) /
Observable output / misfires (the agent gets it right despite a bad brief;
a brief that is column 2 verbatim with no inputs; revising twice; "it
decided something" read as the agent's fault) / Fallback / Remote.

### Step 5: FACILITATOR_GUIDE.md
Before the room (read Session 2's tally; print the brief, one per person
plus spares, and canned-toil; verify own environment with `course-update`);
Timing table 90/60 with cutting rules (protect ex 1 and 4; cut inside ex
3's second run first); Cold open (the near-miss round is the open — script
the sort, with the three sentences written on the board and an example of
each); the anatomy beat (the four parts, SPEC's delegation definition
verbatim, each near-miss reason → the missing part); exercise beats that
point at the runsheet; the sentence to land before the break ("enough
structure that it completes without you" — and what "enough" is); the
checkpoint round; anticipated failures table (from the GOAL); FAQ ("isn't
this just prompt engineering?", "what if the agent asks me questions?",
"can I reuse the brief at work?" → PRACTICE's gate).

### Step 6: PREWORK.md, PRACTICE.md, CHECKPOINT.md, README.md
PREWORK (≤30): `course-update`; finish the worst-one worksheet if not done;
read the brief handout once; pick the entry you'll brief (an `in` that
passes the gate) and star it; bring the three things. Works after only the
solo lap. PRACTICE (≤90): run the brief on the real task twice in the week
(revise between); optional: brief an `out` entry and note the box you can't
fill; bring the brief + inventory + one sentence to Session 4; "if the week
gets away from you: run it once, revised or not". CHECKPOINT: the round
(brief ran twice; the named improvement; the written miss), pass/near-miss
sounds, private recovery (a participant with no real entry; one whose brief
never ran; one who can't name a miss — "then it's out, and that's a pass"),
tally table, what it feeds (Session 4 opens with the briefs; Session 6).
README: artifact table (nine files + handout), reading order, from/to
tables (from 1: inventory columns 2/4, judgment boundary; from 2: the loop,
the worksheet, the near-miss; to 4: the brief becomes step one of a
workflow; to 6: the capstone design is a brief).

### Step 7: DRY_RUN.md — run it
In a throwaway practice folder with the course's pinned model over
OpenRouter (record the pi version actually used, as Session 2 did): run
exercise 3 with (a) a real-shaped brief, (b) the under-specified Priya
brief, (c) the vague-checkpoint brief — each at least twice, noting where
the near-miss appeared and where the model did the right thing anyway.
Run `commit`/`revert --list` to confirm the "two checkpoints" evidence.
Record deviations, text corrections made, and limits (Windows, TUI keys,
pi version).

### Step 8: FLOOR_TEST.md
Mirror Session 2's: preconditions, verbatim tasks (a non-programmer fills
the brief from the handout alone in ≤12 min; follows exercise 3 unaided),
timing against every claimed budget, watch-fors (copies column 2 verbatim
with no inputs; can't separate "it decided" from "it was wrong"; reads the
agent's paragraph instead of the boxes again), results PENDING.

### Step 9: Convention files and verification
`curriculum/README.md` session table row 3; SPEC.md item 3 → settled with
a summary paragraph; confirm Session 2's README "To later sessions" row 3
is still true. Checks: audience purity (no facilitator voice in
EXERCISES.md, no numbered steps in the runsheet), relative links under
`curriculum/` resolve, `course-update` paragraph present, `ve validate`,
and the GOAL's success criteria read back one by one.

## Dependencies

`fluency_session_02` (ACTIVE) — the template and the promises;
`fluency_exercise_split` (ACTIVE) — the two-file exercise shape;
`onboarding_course_update` (ACTIVE) — the session-start rule. All shipped.

## Risks and Open Questions

- **The model may do the right thing despite the under-specified brief.**
  Nondeterminism cuts both ways; the dry run needs enough runs to see the
  near-miss at least once, and the facilitator guide needs the "it got it
  right anyway" move scripted.
- **The authoring machine's pi is newer than the pin** (0.84.x vs 0.83.0),
  as in Session 2's dry run; record it as a deviation and re-pin or re-run
  per the pre-cohort checklist.
- **Participant near-misses may not sort cleanly** into three reasons; the
  guide should give the facilitator a fourth bucket ("the task was out of
  bounds") and say it is a pass, not a failure.
- **Length.** Five files of prose at Session 2's density is a lot; the
  cutting rules and the runsheet's "Steps: EXERCISES.md" discipline keep
  it from duplicating.

## Deviations

<!-- POPULATE DURING IMPLEMENTATION. -->
