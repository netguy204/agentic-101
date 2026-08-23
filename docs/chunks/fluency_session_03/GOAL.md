---
status: ACTIVE
ticket: null
parent_chunk: null
code_paths:
- curriculum/README.md
- curriculum/session_03_anatomy_of_a_delegation/README.md
- curriculum/session_03_anatomy_of_a_delegation/PREWORK.md
- curriculum/session_03_anatomy_of_a_delegation/FACILITATOR_GUIDE.md
- curriculum/session_03_anatomy_of_a_delegation/EXERCISES.md
- curriculum/session_03_anatomy_of_a_delegation/EXERCISE_RUNSHEET.md
- curriculum/session_03_anatomy_of_a_delegation/PRACTICE.md
- curriculum/session_03_anatomy_of_a_delegation/CHECKPOINT.md
- curriculum/session_03_anatomy_of_a_delegation/FLOOR_TEST.md
- curriculum/session_03_anatomy_of_a_delegation/DRY_RUN.md
- curriculum/session_03_anatomy_of_a_delegation/handouts/delegation-brief.md
- curriculum/session_01_mental_models/handouts/toil-inventory.md
- curriculum/session_01_mental_models/handouts/canned-toil.md
- docs/trunk/SPEC.md
code_references:
- ref: curriculum/session_03_anatomy_of_a_delegation/README.md
  implements: "The session index: outcome, artifact table, reading order, the four-step teaching spine, constraints on edits, and the from/to-later-sessions tables"
- ref: curriculum/session_03_anatomy_of_a_delegation/PREWORK.md
  implements: "Prework in ~25 minutes: the three reasons and the four things, finishing the worst-delegation worksheet and its one sentence, picking the entry to brief, course-update"
- ref: curriculum/session_03_anatomy_of_a_delegation/FACILITATOR_GUIDE.md
  implements: "The re-teachable session: reading Session 2's tally, the 90/60 timing table with cutting rules that protect exercises 1 and 4, the near-miss round as the cold open, the anatomy beat with SPEC's delegation definition, the revert-to-before projector move, the sentence to land, anticipated failures including the stall and the clean first run, FAQ, and the appendix from the dry run"
- ref: curriculum/session_03_anatomy_of_a_delegation/EXERCISES.md
  implements: "Participant-only steps: the sentence round and the three reasons; writing the brief; the commit → run → read → commit → change one box → revert to before → run → commit loop with the verified revert --list shape; what would I have failed to catch; the stall and the clean-first-run cases"
- ref: curriculum/session_03_anatomy_of_a_delegation/EXERCISE_RUNSHEET.md
  implements: "Facilitator-only running order: the board tally with worked placements from the dry run, work-one-live on Priya's roll-up, observable outputs, misfires (several boxes at once; right despite a bad brief; don't-decide briefs), fallbacks, remote delivery"
- ref: curriculum/session_03_anatomy_of_a_delegation/PRACTICE.md
  implements: "Displacement-shaped practice: run the brief on the real task, change one box, run again, one sentence; the gate linked to Session 2; the optional out-entry brief; bring to Session 4"
- ref: curriculum/session_03_anatomy_of_a_delegation/CHECKPOINT.md
  implements: "The observable bar (brief written, ran twice, named change, named miss), the eight-minute round, pass and near-miss sounds, private recovery, the tally Session 4 is planned from, and what it feeds"
- ref: curriculum/session_03_anatomy_of_a_delegation/FLOOR_TEST.md
  implements: "Floor-test protocol: verbatim tasks, timings against 12/12/24/10, watch-fors on the Inputs box, pasted column 2, the what-you-type rule, finding the box, revert to before, box 5; results PENDING"
- ref: curriculum/session_03_anatomy_of_a_delegation/DRY_RUN.md
  implements: "Real runs of Priya's three briefs on the course model: the verified revert --list shape, Brief B's stall as first written and its invented threshold with the folder named, Brief C correct with a vague checkpoint, the text corrections the run made, and honest limits"
- ref: curriculum/session_03_anatomy_of_a_delegation/handouts/delegation-brief.md
  implements: "The cross-session delegation brief: four boxes with prompts and examples, the fifth line, the one-change sentence, and its usage table through Session 6"
- ref: curriculum/session_01_mental_models/handouts/toil-inventory.md
  implements: "The Session 3 row in the inventory's usage table (columns 2 and 4 become the brief's instruction and checkpoints)"
- ref: curriculum/session_01_mental_models/handouts/canned-toil.md
  implements: "For Session 3 — Priya's briefs A (full), B (stale undefined, folder named after the dry run), C (vague checkpoint), with the inputs sentences"
- ref: curriculum/README.md
  implements: "Session 3 row in the session table"
- ref: docs/trunk/SPEC.md
  implements: "Curriculum Structure item 3 marked settled with its summary"
narrative: null
investigation: null
subsystems:
- subsystem_id: session_anatomy
  relationship: implements
friction_entries: []
depends_on: []
created_after: ["onboarding_course_update"]
---


# Chunk Goal

## Minor Goal

`curriculum/session_03_anatomy_of_a_delegation/` owns Session 3 of the
fluency arc — "Anatomy of a delegation" — as the full session anatomy
defined in SPEC.md and the directory convention in `curriculum/README.md`
(DEC-010 as amended by DEC-011): `README.md`, `PREWORK.md`,
`FACILITATOR_GUIDE.md`, `EXERCISES.md` (participant-only),
`EXERCISE_RUNSHEET.md` (facilitator-only), `PRACTICE.md`, `CHECKPOINT.md`,
plus `FLOOR_TEST.md` and `DRY_RUN.md` (the steps execute, so they are
executed from their written instructions before they are taught). It owns
one new cross-session handout, `handouts/delegation-brief.md` — the
one-page form of a delegation (inputs, instruction, outputs, checkpoints)
that Session 4 extends into a workflow and Session 6 gates the capstone
design on — and it extends Session 1's `handouts/canned-toil.md` in place
with a "For Session 3" section. The session is 90 minutes in the shape of
Sessions 1–2.

**This is the session where a delegation stops being a sentence and
becomes a structure.** Session 2 proved participants can hand an agent
work and read what it did; Session 3 teaches *why the ones that went badly
went badly* and how to write instructions that survive contact with the
agent. Its teaching spine:

1. **Open on the near-misses, not on new material.** Participants arrive
   with a `what-did-it-do.md` worksheet on their worst practice-week
   delegation and one sentence about it (Session 2 `PRACTICE.md`, "Bring
   to Session 3"). The first ten to fifteen minutes go round the room on
   those sentences. The facilitator sorts them live into the three reasons
   a delegation goes wrong — **it didn't know something** (a missing
   input), **it decided something** (an unstated choice the agent made),
   **I couldn't tell** (no check that would have caught it) — and that
   sorting *is* the anatomy the session then names. Session 2's checkpoint
   obligates this opening when its own round went badly ("open it with the
   worksheets rather than with new material … using the sessions still
   sitting on people's laptops, `pi -r` finds them"); on a good Session 2 it
   is still the opening, because a room full of near-misses is the
   material.
2. **The anatomy, named from their examples.** A delegation is four
   things: **inputs** (what the agent must be able to see — files, facts,
   the thing it will otherwise guess), **the instruction** (what "done
   right" looks like — column 2 of the toil inventory, now made precise
   enough to act on), **outputs** (what done produces, and where), and
   **checkpoints** (where you will look, and what for — column 4 of the
   inventory, turned into a step rather than a hope). SPEC.md's definition
   is quoted verbatim: a **delegation** is "handing a task to an agent with
   enough structure that it completes without step-by-step supervision";
   "enough structure" is the four parts. Each of the three near-miss
   reasons maps to a missing part, which is how the opening pays off.
3. **Write it down, then run it.** The exercise block: each participant
   writes a **delegation brief** (the new handout) for one real inventory
   entry — the one they delegated worst, or a fresh `in` entry that passes
   Session 2's four-question gate — runs it in `~/course-practice`
   (`commit` → `pi` → check → `commit`, the loop from Session 2), compares
   what happened against the brief box by box, revises the brief *once*
   for a reason they can name, and runs it again. The canned fallback is
   Priya's tasks with pre-written briefs in `canned-toil.md`, one of them
   deliberately under-specified so the fallback path meets the same
   near-miss the real-task path does.
4. **"What would I have failed to catch?"** — exercise 4, promised by name
   in Session 2 ("that's exercise 4 of Session 3, arriving early"). Each
   participant names the failure their checkpoint would *not* detect, and
   either adds a second checkpoint to the brief or rules the task out as
   outside their judgment boundary. This is Session 1's judgment boundary
   turned into a design step, and it hands Session 4 its subject: where to
   concentrate judgment, and which failure modes to guard against.
5. **Checkpoint.** Every participant leaves with one brief that ran twice,
   the second run better than the first *for a reason they can name*, and a
   written answer to "what would I have failed to catch". Observable on
   paper and in `~/course-practice`.

### Why

The project GOAL's fluency success criterion asks that a non-programmer
can, unaided, "decompose a real task into an agent-runnable workflow with
judgment concentrated at the checkpoints that matter, and articulate the
failure modes to guard against." Session 3 owns the decomposition half —
one task, one delegation, its four parts — and deliberately stops short of
workflows, leverage and repeatability, which SPEC.md assigns to Session 4.
The near-miss opening exists because Session 2's practice was designed to
produce exactly one bad delegation per participant; a session that
explained the anatomy first and looked at their examples second would
waste the best material the course has ever had in the room.

### How it is built

**The shape it follows.** `curriculum/session_02_meeting_the_harness/` is the
template for every file: README with the artifact table and the
from/to-later-sessions tables; FACILITATOR_GUIDE with "Before the room",
a minute-level **Timing** table with a 60-minute variant and cutting rules,
beats, the anticipated-failure table, and the FAQ; EXERCISES.md in second
person with "What you should see" and fallbacks; EXERCISE_RUNSHEET.md with
**What participants do / Say it like this / Observable output / misfires /
Fallback** per exercise and "Steps: `EXERCISES.md`, exercise N" instead of
restated steps (DEC-011 — the runsheet never restates a step); PRACTICE.md
with the time-budget table, displacement framing, "Bring to Session 4",
and "If the week gets away from you"; CHECKPOINT.md with the observable
round, the pass/near-miss discrimination, the private recovery path, the
tally table, and "What this checkpoint feeds"; FLOOR_TEST.md and DRY_RUN.md
as in Session 2 (`DRY_RUN.md` records real runs of every agent step, at
least twice each, on the pinned pi — `setup/pins.env` `PI_VERSION`/
`PI_MODEL` — with honest limits; Windows recorded as not run if not run).
`docs/chunks/fluency_session_02/GOAL.md` and `PLAN.md` record how that
session was specified and built; the voice source is `pi-learning-paths.md`
at the repo root.

**What Session 2 promised about this session** (each is honored):
- Opens from the practice-week worksheets and the "one sentence about the
  one that went worst" — asked for "in the first ten minutes" (S2
  `PRACTICE.md`, "Bring to Session 3").
- Assumes every participant can run a delegation unaided and read its
  tool calls; S2 `CHECKPOINT.md` names the recovery if that failed
  room-wide (fifteen minutes on "what did yours actually do" using `pi -r`)
  and the tally table Session 3 is "planned from" — the facilitator guide's
  "Before the room" reads that tally.
- "What would you have failed to catch?" is exercise 4 (S2 runsheet,
  exercise 4 early-finisher question).
- Participants bring: the worksheet, the toil inventory with ticks, the
  sentence. PRACTICE.md told them "if the task turns out to be a bad fit …
  write down what was missing. It's the most useful thing you can bring."
- Vocabulary quoted verbatim from SPEC.md Terminology so Sessions 3–5
  share words: *delegation*, *judgment boundary*, *harness*, *agent*.
  Session 3 adds *delegation* as its word; *workflow* and *leverage* are
  Session 4's and are mentioned only as "next time".

**The handout — `handouts/delegation-brief.md`.** One printable page,
lowercase-hyphenated filename per `curriculum/README.md`. Four boxes in
this order, each with a one-line prompt and a filled-in example row:
**Inputs** ("What must it be able to see? Name the files and facts. If
it can't see it, it will guess."), **Instruction** ("What does done right
look like? Column 2 of your inventory, made precise: one sentence it can
act on."), **Outputs** ("What does done produce, and where?"),
**Checkpoints** ("Where will you look, and what for? Column 4 of your
inventory, as a step you will actually take."), plus a fifth line at the
bottom: **What would I have failed to catch?** (filled in exercise 4). The
handout states it is owned by Session 3 and used by Sessions 4 and 6,
mirrors the toil inventory's "How this sheet is used later" table, and
adds a **Session 3** row to the toil inventory's own usage table
(`session_01_mental_models/handouts/toil-inventory.md`, the "How this
sheet is used later" table — edit in place, never fork; the inventory's
rule is that later sessions may add a row or column but not rename the
four). The brief's instruction box is column 2 of the inventory and its
checkpoints box is column 4 — say so on the page, so the inventory is
visibly the source.

**The fallback — `canned-toil.md` "For Session 3".** Session 1's handout
is extended in place (cross-session rule) with a section shaped like "For
Session 2": three of Priya's tasks with pre-written briefs — A complete, B
with "stale" deliberately undefined so a canned-set participant meets a real
near-miss in exercise 3's first run and fixes it in the revision, C with a
vague checkpoint for exercise 4. Every instruction names the folder (the
dry run found that an unlocated file stalls the agent on a whole-disk
search). No answer key for exercise 4. Session 2's three neutral synthetic
options stay as they are.

**Constraints the session honors.**
- Audience floor (DEC-004): no code, no programming vocabulary, no
  "prompt engineering". The word is *brief*, the frame is delegating to a
  colleague who cannot see your screen.
- Every capability demo is paired with "how would you check this"
  (DEC-005). The brief's checkpoints box is that rule made into a form.
- The environment is fixed and shipped (DEC-006–DEC-009): `~/course-practice`,
  pinned pi and model, `commit`/`revert`. Any claim about pi's behavior
  comes from `docs/chunks/onboarding_setup_guide/pi-reference.md`.
- `course-update` opens the session (DEC-012): PREWORK's run-the-commands
  step says `course-update` (the smoke test is not needed again unless the
  facilitator asks for it), `EXERCISES.md` starts with the "Before exercise
  1" paragraph, and the runsheet carries the facilitator side, in Session
  2's wording.
- Real-task use is governed by Session 2 `PRACTICE.md`'s four-question gate
  (evaluable / authorized / appropriate and non-consequential /
  human-approved before external action) and its "it does, you decide"
  example; Session 3's PRACTICE links to it and restates it in one line
  rather than copying it. In-room exercises use invented data or the
  participant's described shape, as Session 2 did.
- Nondeterminism is taught, not hidden (TESTING_PHILOSOPHY.md): the
  facilitator guide scripts the surprising-agent moment as the best thing
  that can happen, and the runsheet's misfires include the agent doing the
  right thing despite a bad brief (which is the hardest case to teach
  from — say so).
- Setup triage is lighter than Session 2's but not absent: a one-line
  "who did `course-update` say *Nothing to do* to?" and pairing for anyone
  whose environment is broken; the session proceeds on time.
- Timing: 90 minutes, 60-minute variant, cutting rules that protect the
  opening and exercise 4 and cut *within* the run-revise-run block.
- `curriculum/README.md`'s session table has the Session 3 row and
  SPEC.md's Curriculum Structure item 3 is settled with a summary in the
  style of items 1 and 2; Session 2's README "To later sessions" row for 3
  stays true.

**PRACTICE (≤90 min, displacement-shaped).** Run the brief on the real task
twice in the week (the second time after revising it), keep the brief and
the worksheet, and bring the brief to Session 4 — where it becomes the
first step of a workflow. Optional: write a brief for an **out** entry and
notice which box you cannot fill. "Bring to Session 4" names the brief, the
inventory, and one sentence on what the second run caught that the first
did not.

**CHECKPOINT.** Observable: a brief that ran twice (the two `commit`
names in `revert --list` are the evidence on disk), a named reason the
second run was better, and a written "what would I have failed to catch".
The tally table Session 4 is planned from: brief written / ran twice /
named the improvement / named the miss / note.

## Success Criteria

- All seven required files exist per `curriculum/README.md`, plus
  `FLOOR_TEST.md` and `DRY_RUN.md`; content conforms to SPEC.md's Session
  Anatomy; `EXERCISES.md` is participant-only and `EXERCISE_RUNSHEET.md`
  facilitator-only per DEC-011 (the audience-purity checks from
  `docs/chunks/fluency_exercise_split/PLAN.md` Step 5 pass).
- `handouts/delegation-brief.md` exists with the four boxes, the fifth
  line, a filled example, and the ownership/usage statement; the toil
  inventory's usage table has a Session 3 row; `canned-toil.md` has a
  "For Session 3" section with at least one deliberately under-specified
  brief; Session 2's synthetic options are untouched.
- The session opens from the practice-week worksheets and sentences,
  names the three near-miss reasons, and maps each to a missing part of
  the brief; "what would I have failed to catch" is exercise 4.
- Every exercise operates on the participant's own inventory entry where
  possible, with the canned fallback taking the same time and producing
  the same artifact.
- PREWORK ≤30 minutes, opens with `course-update`, and works for someone
  who did only Session 2's solo lap; PRACTICE ≤90 minutes, displacement-
  shaped, links the four-question gate, names what to bring to Session 4.
- CHECKPOINT is observable: a brief that ran twice, a named improvement,
  a written miss; tally table present; recovery paths private; "what this
  checkpoint feeds" names Session 4 and the capstone.
- FACILITATOR_GUIDE is sufficient for a facilitator who did not author it:
  reads Session 2's tally, 90-minute timing with 60-minute variant and
  cutting rules, the near-miss sorting move scripted, anticipated failures
  (the agent gets it right despite a bad brief; a participant's worst
  delegation was outside their boundary; nobody brought a worksheet), FAQ.
- `DRY_RUN.md` records real runs of every agent step from the written
  instructions, at least twice each, on the pinned pi and model, including
  the under-specified canned brief producing a visible near-miss at least
  once; honest limits recorded (Windows, TUI keys).
- `curriculum/README.md` session table and SPEC.md item 3 updated to
  settled; Session 2's forward references to Session 3 remain true;
  `uvx --from vibe-engineer ve validate` passes and all relative links
  under `curriculum/` resolve.

## Rejected Ideas

### Teach workflows and leverage in Session 3

Decomposition naturally wants to continue into "and then chain them".

Rejected because: SPEC.md assigns repeatable workflows, failure modes and
concentrating judgment at the checkpoints that buy the most leverage to
Session 4. Session 3 is one delegation, anatomised. Stopping there is what
lets Session 4 open with "you already have a brief — now make it run
every week."

### Extend the toil inventory with new columns instead of a new handout

The inventory rule allows later sessions to add columns, so inputs and
checkpoints could be columns 5 and 6.

Rejected because: a brief is a per-delegation document (it is revised and
re-run), not a per-task row; the inventory has to stay fillable with a pen
in a room in ten seconds; and Session 4 and the capstone need a document
they can extend into a workflow, which a row cannot carry. The brief
visibly *draws* from columns 2 and 4 instead.

### A Session-3-only worksheet, deciding later whether Sessions 4–6 adopt it

Rejected because: Sessions 4 and 6 would then either fork a second
template or retrofit this one; owning it from Session 3 (as Session 1 owns
the inventory) gives it one home and one usage table.

### Reuse Session 2's synthetic tasks as the only fallback

Rejected because: they have no built-in near-miss, so a canned-set
participant would never meet the session's central experience. Priya's
tasks with one deliberately under-specified brief do.

### Make it 120 minutes to fit two full runs plus discussion

Rejected because: the 90-minute shape is a cross-session contract with
cohorts' calendars (DEC-002); the exercise block cuts within the
run-revise-run loop rather than dropping the opening or exercise 4.

### Teach "prompt engineering" techniques

Rejected because: it names the wrong skill (DEC-004, DEC-005). The session
teaches what a colleague who cannot see your screen needs to be told, in
the participant's own words; the brief's four boxes are the whole
technique.
