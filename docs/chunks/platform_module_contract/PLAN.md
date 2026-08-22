# Implementation Plan

## Approach

Build **inside-out from `CHECKPOINT.md`**, one session at a time. The
checkpoint documents already contain nearly everything a rubric needs, in a
shape that was designed for a facilitator holding a clipboard: a numbered bar,
two pass exemplars in the facilitator's voice, a near-miss table whose third
column is the exact sentence to say, and a recovery section that names the
causes. Structuring that is transcription plus one decision per criterion —
*can a machine see this, or does someone have to hear it?* Nothing is invented.
A criterion that does not trace to a sentence of the bar does not go in the
file, and a near-miss row that gets dropped takes a facilitator's best line
out of the self-paced course.

The schema is Module Contract v1, which lives in the delivery platform's
repository (`src/contract/`, and its SPEC.md § Module Contract). Its validator
runs against this directory from outside, so authoring is a loop: write, run
the validator, read the errors, fix. The validator is the same code the
platform runs at ingest, so a clean run here is the real answer and not a
rehearsal.

Three things about this course make the mapping non-obvious, and each is
settled here rather than discovered mid-file:

**The seven fixed filenames are already the mapping.** DEC-010 and DEC-011
give every session the same seven files, and they divide cleanly by audience:
`PREWORK.md` and `README.md` are concept, `EXERCISES.md`, `PRACTICE.md` and
`handouts/` are lab, and `FACILITATOR_GUIDE.md`, `EXERCISE_RUNSHEET.md`,
`FLOOR_TEST.md` and `DRY_RUN.md` are the facilitator's — which on the platform
means the virtual TA may read them and a student may not. The convention pays
off here for the first time outside this repository.

**`revert` is ours, not the agent's.** Session 2's fourth bar item is "used
`revert` at least once". The obvious place to look is the agent's session log,
and it is the wrong place: `revert` is a course command the participant types
in their own terminal (`env/bin/revert`), so pi never sees it. What it does
leave behind is a checkpoint named `Back to: <name>` — which `revert --list`
prints. So the student pastes that listing, and the check is that the listing
says `Back to:`. This is the same move the setup gate makes with
`course-smoke-test` output, and it has the same virtue: the evidence is
something the participant can see on their own screen and recognise.

**The judgment claim is spoken.** Session 1's bar is explicitly "say out loud",
and its remote-cohort note already accepts a written answer. On the platform
the artifact is declared as either a voice note or text, and the student
chooses — which is closer to the room than forcing prose would be.

Testing, per `docs/trunk/TESTING_PHILOSOPHY.md`: this directory is data, and
its test is the validator that will read it in anger. Outcome-checked, not
output-checked — the criteria are checked against what the participant can
produce, not against what a model will say. The scripts get the check a machine
cannot do: read a segment aloud, against a clock, and hear whether it is
listenable.

## Sequence

### Step 1: `platform/module.yaml`

The manifest first, because every other file is found through it and its
errors are the cheapest to discover. Sessions 1 and 2 plus the setup gate.
Artifacts per session — for Session 1 the inventory sheet and the boundary
claim; for Session 2 the pi session log, the "what did it actually do?"
worksheet, the pasted `revert --list`, and the practice folder's files.

### Step 2: `platform/rubrics/setup.yaml`

One criterion over pasted `course-smoke-test` output. Read the script's PASS
path and quote only the parts of its `[ok]` lines that do not interpolate a
pin — the pi version and the model name change with `setup/pins.env`, and a
rubric that quotes them fails the whole cohort the day a pin moves.

### Step 3: `platform/rubrics/01_mental_models.yaml`

Session 1's two-part bar: the sheet, and the spoken claim. The sheet's three
deterministic checks quote the four column headers exactly as
`handouts/toil-inventory.md` prints them. All five rows of the near-miss table,
including the one the checkpoint says to *accept* ("I'd have to check every
line") — its corrective is the acknowledgment, and dropping the row would lose
the instruction to accept it.

### Step 4: `platform/rubrics/02_meeting_the_harness.yaml`

Session 2's four-part bar, one criterion each. Items 1 and 4 are the facts the
checkpoint says "you can see"; items 2 and 3 are the ones it says "you have to
hear", and they are judged. All six near-miss rows with their correctives.

### Step 5: The listenable scripts

`platform/audio/01_mental_models.md` and
`platform/audio/02_meeting_the_harness.md`. Session 1 is already an audio
session — no software, no screen — and its prework carries the leverage
argument in almost the right register. Session 2 is the hard one: it is 59
minutes of hands-on, so the track carries only the *why* — what a terminal
actually is, why the safety net comes before the first delegation, the
difference between an agent acting and a chatbot conversing, and why the
paragraph it writes about itself is not evidence. Every command, the terminal
card, and the mechanics of `commit` and `revert` go to `> Lab card:` lines.

### Step 6: The recall prompts

After the scripts, because a prompt has to ask about what its segment actually
said. Four to eight per session, model answers in the course's voice, each
pinned to its segment.

### Step 7: `platform/pronunciation.yaml` and `platform/README.md`

The terms a voice will mangle. Then the README: what the directory is, how to
add a session, and the rule that `CHECKPOINT.md` is the source and a change to
a bar is not finished until the rubric has been re-read.

### Step 8: Validate and tag

Validator to zero errors, `ve validate` clean, small commits, then a tag so the
platform ingests a fixed version rather than whatever `main` says today.

## Dependencies

- Module Contract v1 and its validator, in the delivery platform's repository.
- Sessions 1 and 2 as they stand after `fluency_exercise_split` (DEC-011).

## Risks and Open Questions

- **Deterministic checks quote handout text.** `worksheet.column_filled` names
  a column header as printed. Reword a header in `handouts/toil-inventory.md`
  and the criterion does not error — it fails every student. The README says
  so, and it is the reason this directory lives in this repository.
- **Sessions 3–6.** Session 3 exists and its checkpoint is complete; 4–6 do
  not. The manifest describes what it serves, so later sessions arrive by
  extending this directory.
- **Nobody has heard the scripts yet.** Reading one segment aloud catches
  register and length; it does not catch what a real TTS voice does to a
  sentence. First render is the real test.

## Deviations

<!-- Populated during implementation. -->
