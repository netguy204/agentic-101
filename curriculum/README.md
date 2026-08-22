# The curriculum

<!-- Chunk: docs/chunks/fluency_session_01 - Establishes the per-session directory convention -->

This directory holds the deliverable course material: one directory per
session, in teaching order. `docs/` holds the project's documentation about
the curriculum; `curriculum/` holds the curriculum itself.

| Session | Directory | Arc |
|---|---|---|
| 1 | [`session_01_mental_models/`](session_01_mental_models/) | Fluency |
| 2 | [`session_02_meeting_the_harness/`](session_02_meeting_the_harness/) | Fluency |
| 3 | [`session_03_anatomy_of_a_delegation/`](session_03_anatomy_of_a_delegation/) | Fluency |

Later sessions are added by their own chunks. `docs/trunk/SPEC.md`
(Curriculum Structure) holds the planned progression.

---

## Directory naming

`session_<NN>_<slug>/` — two-digit number first, so a directory listing is
in teaching order, then a short slug naming the session's subject
(`session_01_mental_models`, `session_02_meeting_the_harness`). The slug
names the subject, not the activity.

## Required files

Every session directory contains these seven files. A session chunk creates
all seven even when one of them is short — a missing file reads as "this
session doesn't have one", which is never what we mean.

| File | What it is | Audience |
|---|---|---|
| `README.md` | Session index: the outcome, the teaching spine, links to the rest | Anyone opening the directory |
| `PREWORK.md` | What the participant does before the session, ≤30 min | Participant |
| `FACILITATOR_GUIDE.md` | Timing, talking points, demo scripts, anticipated failure points, recovery moves | Facilitator |
| `EXERCISES.md` | The in-session steps the participant follows, with the canned fallback | Participant |
| `EXERCISE_RUNSHEET.md` | Per-exercise running order for the facilitator: timing, what to say, observable output, misfires, fallbacks — points at `EXERCISES.md` for the steps | Facilitator |
| `PRACTICE.md` | Between-session application to the participant's own toil, ≤90 min | Participant |
| `CHECKPOINT.md` | The observable behavior that says the session's outcome landed | Facilitator |

The six names other than `README.md` map onto the Session Anatomy list in
`docs/trunk/SPEC.md`, which is the authority on what each must contain —
one-to-one, except that the in-session exercises element is two files, one
per reader: `EXERCISES.md` for the participant and `EXERCISE_RUNSHEET.md`
for the facilitator (DEC-011). This directory's convention is only about
*where* they live and *what they're called*.

## Optional, by convention

- `handouts/` — participant-facing material a facilitator prints or shares:
  worksheets, canned examples, reference cards. Lowercase, hyphenated
  filenames (`handouts/toil-inventory.md`), because these are things people
  are handed rather than documents in the repository's voice.
- `FLOOR_TEST.md` — the floor-test protocol for this session and its
  results log. Required before a session is taught for the first time
  (`docs/trunk/TESTING_PHILOSOPHY.md`, Floor Testing); test results live
  alongside the material they test, not in a central log.
- `DRY_RUN.md` — the record of executing the session's exercises end to end
  from their written instructions, for sessions with steps that can be
  executed. A session with no hands-on tooling (Session 1) has nothing to
  dry-run and omits the file; a session whose steps execute (Session 2) must
  have one, and it is written by running the material rather than by
  describing it.

## Rules that cross sessions

- **Fixed names, so references can precede existence.** A chunk may write
  `curriculum/session_04_workflow_design/EXERCISES.md` into a plan before
  Session 4 is authored, and be right.
- **Artifacts a later session depends on are handouts owned by the session
  that introduced them.** The toil inventory is
  `session_01_mental_models/handouts/toil-inventory.md` and stays there
  even though Sessions 2–6 all use it. A later session that extends it
  edits that file and says so in its own README; it does not fork a copy.
  Session 2 does exactly this to both of Session 1's handouts — a row in the
  inventory's usage table, and a "For Session 2" section in
  `handouts/canned-toil.md`.
- **Every session from Session 2 opens with `course-update`.** The prework's
  run-the-commands step and the first thing in `EXERCISES.md` both say it,
  so a fix published between sessions reaches every participant's machine
  before the room uses it (`docs/trunk/DECISIONS.md`, DEC-012). Session 1 is
  exempt — no terminal before Session 2.
- **The runsheet never restates a step.** `EXERCISE_RUNSHEET.md` refers to
  `EXERCISES.md` by exercise and step ("exercise 2, step 6") and adds only
  what the facilitator needs — timing, what to say, what to watch for, what
  to do when it goes wrong. Commands, prompts, and on-screen text have
  exactly one source, so the two files cannot drift apart.
- **Participant-facing text assumes only what has been taught.** No
  terminal knowledge before Session 2, no harness mechanics before Session
  2, no code anywhere (`docs/trunk/DECISIONS.md`, DEC-004). An exercise
  that needs an untaught skill is a curriculum bug, not a prerequisite.

The convention itself is recorded as DEC-010 in
`docs/trunk/DECISIONS.md`.
