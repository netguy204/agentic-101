---
status: ACTIVE
ticket: null
parent_chunk: null
code_paths:
- curriculum/README.md
- curriculum/session_01_mental_models/EXERCISES.md
- curriculum/session_01_mental_models/EXERCISE_RUNSHEET.md
- curriculum/session_01_mental_models/README.md
- curriculum/session_01_mental_models/FACILITATOR_GUIDE.md
- curriculum/session_01_mental_models/handouts/canned-toil.md
- curriculum/session_02_meeting_the_harness/EXERCISES.md
- curriculum/session_02_meeting_the_harness/EXERCISE_RUNSHEET.md
- curriculum/session_02_meeting_the_harness/README.md
- curriculum/session_02_meeting_the_harness/FACILITATOR_GUIDE.md
- curriculum/session_02_meeting_the_harness/DRY_RUN.md
- curriculum/session_02_meeting_the_harness/FLOOR_TEST.md
- docs/trunk/SPEC.md
- docs/trunk/DECISIONS.md
- docs/chunks/fluency_session_01/GOAL.md
- docs/chunks/fluency_session_02/GOAL.md
code_references:
- ref: curriculum/README.md
  implements: "The seven-file per-session convention with the exercises element split by reader, and the rule that the runsheet refers to EXERCISES.md by exercise and step and never restates one"
- ref: docs/trunk/SPEC.md
  implements: "Repository Layout names EXERCISE_RUNSHEET.md among the seven fixed filenames, one per Session Anatomy element with the exercises element split by reader"
- ref: docs/trunk/DECISIONS.md
  implements: "DEC-011 records the split and its rejected alternatives; DEC-010 carries the amendment pointer"
- ref: curriculum/session_01_mental_models/EXERCISES.md
  implements: "Session 1 participant-only exercise steps in second person, with what-you-should-see and the canned-sheet fallback"
- ref: curriculum/session_01_mental_models/EXERCISE_RUNSHEET.md
  implements: "Session 1 facilitator-only runsheet: timing, say-it-like-this, observable output, misfires, stall triage, fallbacks, remote delivery"
- ref: curriculum/session_02_meeting_the_harness/EXERCISES.md
  implements: "Session 2 participant-only exercise steps, including the single-source revert answers table and the exercise prompts"
- ref: curriculum/session_02_meeting_the_harness/EXERCISE_RUNSHEET.md
  implements: "Session 2 facilitator-only runsheet; refers to EXERCISES.md by exercise and step, carries the projector walkthrough and the exercise-5 prompt rationale"
- ref: curriculum/session_01_mental_models/README.md
  implements: "Session 1 file table lists both files with their audiences and the reading order names both"
- ref: curriculum/session_02_meeting_the_harness/README.md
  implements: "Session 2 file table lists both files with their audiences and the reading order names both"
- ref: curriculum/session_01_mental_models/FACILITATOR_GUIDE.md
  implements: "Pre-session reading names both files; the block is run from the runsheet"
- ref: curriculum/session_02_meeting_the_harness/FACILITATOR_GUIDE.md
  implements: "Pre-session reading names both files; the exercise block is run from the runsheet with participants following EXERCISES.md"
- ref: curriculum/session_02_meeting_the_harness/DRY_RUN.md
  implements: "Records that the split happened after the 2026-08-07 run without re-running the unchanged steps"
narrative: null
investigation: null
subsystems: []
friction_entries: []
depends_on: []
created_after: ["fluency_safety_relevance"]
---


# Chunk Goal

## Minor Goal

Every session directory under `curriculum/` separates its in-session
exercise material by reader. `EXERCISES.md` is **participant-only**: the
numbered steps a participant follows in the room, written to "you", with
what they should see at each step and the canned fallback for anyone who
cannot use their own work. `EXERCISE_RUNSHEET.md` is **facilitator-only**: the
per-exercise running order — time budget, what participants are doing, what
to say and when, what to work live on the projector first, the observable
output that says the exercise landed, the misfires and how to recover them,
stall triage, and pairing/remote logistics. The runsheet points at
`EXERCISES.md` by exercise and step number and never restates the steps, so
commands, prompts, and on-screen text have exactly one source. The
per-session convention (`curriculum/README.md`, `docs/trunk/SPEC.md`
Repository Layout, DEC-010) names seven fixed files, and Sessions 1 and 2
are already in that shape.

### Why

Both existing `EXERCISES.md` files interleave the two readers paragraph by
paragraph: a numbered participant step sequence, then **Say it like this.**,
**Observable output.**, **Most common misfire.**, **If someone stalls.**,
**Fallback.**, **Work one live before they start.**, **Remote delivery.**,
and a **Before starting, say this out loud:** preamble — all facilitator
voice — wrapped around steps written for the participant. The operator found
the mix awkward to use from either seat: a participant reading along hits
stage directions about themselves; a facilitator scanning for the next cue
wades through steps they already know. Splitting by audience lets each file
be focused on what its reader needs, and makes the participant document
safe to hand out or put on a screen as-is.

### How the split is laid out

**The files**
- `curriculum/session_01_mental_models/EXERCISES.md` and
  `EXERCISE_RUNSHEET.md` — three exercises (brain dump, check column,
  skeptic pass), 27 minutes, paper only; before the split the facilitator
  material was roughly half of one file.
- `curriculum/session_02_meeting_the_harness/EXERCISES.md` and
  `EXERCISE_RUNSHEET.md` — five exercises (where am I, the safety net,
  first delegation, what did it actually do, break it on purpose), 59
  minutes. The `revert` four-question table lives in `EXERCISES.md`; the
  "read the names, not the numbers" rule, the exercise-5 prompt rationale
  ("Why this prompt and not 'delete everything'"), and pairing fallbacks
  live in the runsheet.

**What lives where** (the bold lead-ins were the seam)
- In `EXERCISES.md` (participant): the exercise title; the numbered steps
  with exact commands, prompts, and the text the screen shows; "what you
  should see"; the participant's side of the fallback ("if you can't use
  your own work, use the Session 2 section of `canned-toil.md`"); the
  worksheet/handout they fill in; a one-line "if you're stuck, say so — the
  facilitator will pair you" where the runsheet has stall triage. Second
  person throughout. No stage directions, no timings in the headings (the
  facilitator owns the clock), no misfire commentary, no "say it like this".
- In `EXERCISE_RUNSHEET.md` (facilitator): the block overview and time
  budget (currently the opening paragraphs, e.g. "Five exercises, 59 minutes
  … cut *within* an exercise rather than dropping one"); **Before starting,
  say this out loud**; per exercise — minutes, **What participants do** (one
  paragraph, then "steps: `EXERCISES.md` exercise N"), **Work … live before
  they start**, **Say it like this**, **Observable output**, **If someone
  stalls**, every **misfire**, **Fallback** logistics (pairs, odd numbers,
  remote breakouts), **Remote delivery**, and **Wrapping the block**.
  It references participant steps as "exercise 2, step 5", never by
  copying them.
- Facts that both readers need (e.g. the `revert` answers table: Enter,
  Enter, `2`, `yes`) live once, in `EXERCISES.md`; the runsheet says where
  to look and adds only the facilitator's reason to care (the "typing `1`"
  misfire).

**Voice and floor** — participant text keeps DEC-004's audience floor and
`curriculum/README.md`'s rule that participant-facing text assumes only
what has been taught. The split separated and re-addressed the steps
without rewriting them; where a step said "participants" it now says
"you".

**The convention**
- `curriculum/README.md` — the "Required files" table has seven rows:
  `EXERCISES.md` with audience "Participant" and `EXERCISE_RUNSHEET.md`
  with audience "Facilitator"; the Session Anatomy "in-session exercises"
  element maps to those two files, one per reader, and a cross-session
  rule says the runsheet never restates a step.
- `docs/trunk/SPEC.md` Repository Layout lists the seven fixed filenames.
- `docs/trunk/DECISIONS.md` — DEC-011 records the decision; DEC-010
  carries an **Amended** pointer to it so its six-file statement does not
  stand uncorrected.

**References that resolve to the split files** (`ve validate` passes)
- Session READMEs' file tables and reading-order prose:
  `session_01_mental_models/README.md:26`,
  `session_02_meeting_the_harness/README.md:25,35`.
- Facilitator guides: `session_01_mental_models/FACILITATOR_GUIDE.md:28`;
  `session_02_meeting_the_harness/FACILITATOR_GUIDE.md:27,176,286` — the
  block is run from `EXERCISE_RUNSHEET.md`; pre-session reading names both
  files.
- `session_02_meeting_the_harness/FLOOR_TEST.md:56` and `DRY_RUN.md:6` —
  the dry run executes participant steps, so they point at
  `EXERCISES.md`; DRY_RUN.md notes the split happened after its run.
- `session_01_mental_models/handouts/canned-toil.md:154` links to Session
  2's `EXERCISES.md`.
- `docs/chunks/fluency_session_01/GOAL.md` and
  `docs/chunks/fluency_session_02/GOAL.md` — `code_paths` include
  `EXERCISE_RUNSHEET.md` and their `code_references` describe both files.
  Both runsheets and both `EXERCISES.md` files carry a
  `<!-- Chunk: docs/chunks/fluency_exercise_split - … -->` backreference
  alongside the session chunk's own.

**Corrections carried through the split** (2026-08-22): the Session 2
`revert` table's first row reads *"Wait — 1 thing in this
folder has changed since your last checkpoint… Type 1, 2 or 3."*; the
lead-in reads "four questions, one at a time — the first offers three
numbered choices"; the same wording in the "second misfire" note and the
facilitator guide's warn-line; and the facilitator guide's failure-point
row for the Windows CRLF warning.

## Success Criteria

- `curriculum/session_01_mental_models/` and
  `curriculum/session_02_meeting_the_harness/` each contain
  `EXERCISES.md` (participant-only) and `EXERCISE_RUNSHEET.md`
  (facilitator-only), and no paragraph in either file addresses the other
  reader: `EXERCISES.md` has no "say it like this", "observable output",
  "misfire", "fallback" logistics, or timings; the runsheet has no numbered
  participant step sequences.
- Every command, prompt, expected on-screen text, and worksheet instruction
  appears in exactly one of the two files (`EXERCISES.md`); the runsheet
  references them by exercise and step.
- Nothing taught is lost: every bold-lead-in paragraph from the current
  files can be found in the runsheet, and every numbered step in
  `EXERCISES.md`. The Session 2 corrections listed above survive verbatim.
- `curriculum/README.md`, `docs/trunk/SPEC.md` Repository Layout, and
  DECISIONS.md (DEC-010 amended or superseded) describe seven fixed files
  with the exercise element split by reader, so a later session chunk can
  reference `curriculum/session_04_workflow_design/EXERCISE_RUNSHEET.md`
  before it exists.
- All links and prose references listed above resolve; `uvx --from
  vibe-engineer ve validate` passes; `fluency_session_01` and
  `fluency_session_02` GOAL.md `code_paths`/`code_references` reflect the new
  files.
- `session_02_meeting_the_harness/DRY_RUN.md` still reads correctly against
  the participant file (its quoted passages exist in `EXERCISES.md`), and a
  note in its deviations or addendum records that the file was split after
  the 2026-08-07 run without re-running the steps (the steps themselves are
  unchanged).
- `bash env/tests/test-commands.sh` is unaffected (no env/ changes expected)
  — run it anyway to confirm the working tree is clean of collateral damage.

## Rejected Ideas

### Fold the facilitator material into FACILITATOR_GUIDE.md

Keeps the six-file convention untouched; the per-exercise cues become a
"Running the exercises" section of the guide.

Rejected because: the guide would grow by ~200 lines per session and become
unwieldy to scan mid-session, and the facilitator already runs the exercise
block from a dedicated document (the guide says "Run it from
`EXERCISES.md`"). A separate runsheet preserves that working pattern.

### Keep EXERCISES.md as the facilitator sheet; put participant steps in handouts/exercises.md

Rejected because: participant-facing uppercase documents already exist
(`PREWORK.md`, `PRACTICE.md`), the steps are a document in the course's
voice rather than a printable reference card, and the fixed-name rule
(references can precede existence) wants the participant steps at a fixed
uppercase name too.

### One file, two sections per audience

Rejected because: that is the current state — the interleaving is the
problem, and sectioning within one file still forces each reader to scroll
past the other's material.

### Split Session 2 only

Rejected because: the operator wants the convention settled for Sessions
3–6, and leaving Session 1 in the old shape would make the convention false
for an existing session.
