# The curriculum

<!-- Chunk: docs/chunks/fluency_session_01 - Establishes the per-session directory convention -->

This directory holds the deliverable course material: one directory per
session, in teaching order. `docs/` holds the project's documentation about
the curriculum; `curriculum/` holds the curriculum itself.

| Session | Directory | Arc |
|---|---|---|
| 1 | [`session_01_mental_models/`](session_01_mental_models/) | Fluency |

Later sessions are added by their own chunks. `docs/trunk/SPEC.md`
(Curriculum Structure) holds the planned progression.

---

## Directory naming

`session_<NN>_<slug>/` — two-digit number first, so a directory listing is
in teaching order, then a short slug naming the session's subject
(`session_01_mental_models`, `session_02_meeting_the_harness`). The slug
names the subject, not the activity.

## Required files

Every session directory contains these six files. A session chunk creates
all six even when one of them is short — a missing file reads as "this
session doesn't have one", which is never what we mean.

| File | What it is | Audience |
|---|---|---|
| `README.md` | Session index: the outcome, the teaching spine, links to the rest | Anyone opening the directory |
| `PREWORK.md` | What the participant does before the session, ≤30 min | Participant |
| `FACILITATOR_GUIDE.md` | Timing, talking points, demo scripts, anticipated failure points, recovery moves | Facilitator |
| `EXERCISES.md` | The in-session hands-on work, with a fallback per exercise | Facilitator and participant |
| `PRACTICE.md` | Between-session application to the participant's own toil, ≤90 min | Participant |
| `CHECKPOINT.md` | The observable behavior that says the session's outcome landed | Facilitator |

The five names other than `README.md` map one-to-one onto the Session
Anatomy list in `docs/trunk/SPEC.md`, which is the authority on what each
must contain. This directory's convention is only about *where* they live
and *what they're called*.

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
  dry-run and omits the file.

## Rules that cross sessions

- **Fixed names, so references can precede existence.** A chunk may write
  `curriculum/session_04_workflow_design/EXERCISES.md` into a plan before
  Session 4 is authored, and be right.
- **Artifacts a later session depends on are handouts owned by the session
  that introduced them.** The toil inventory is
  `session_01_mental_models/handouts/toil-inventory.md` and stays there
  even though Sessions 2–6 all use it. A later session that extends it
  edits that file and says so in its own README; it does not fork a copy.
- **Participant-facing text assumes only what has been taught.** No
  terminal knowledge before Session 2, no harness mechanics before Session
  2, no code anywhere (`docs/trunk/DECISIONS.md`, DEC-004). An exercise
  that needs an untaught skill is a curriculum bug, not a prerequisite.

The convention itself is recorded as DEC-010 in
`docs/trunk/DECISIONS.md`.
