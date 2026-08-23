# Authoring for the platform

<!-- Chunk: docs/chunks/platform_authoring_guide - How to write session material that lands well on the self-paced platform -->

This course now has two deliveries. The one it was written for is a room:
a facilitator, twelve people, a checkpoint round in the last ten minutes.
The second is a self-paced platform (the peer repository
`../learning-platform`) that serves the same sessions to students who never
sit in the room: it reads the concept material aloud on a commute, hands
out the lab for the desk, collects what the student made, applies the
checkpoint as an automated rubric — including the corrective question a
facilitator would ask on a near-miss — and grounds a virtual TA in the
facilitator's own documents.

The platform owns no content. It fetches this repository at a git tag and
reads it through the `platform/` directory, whose mechanics are documented
in [`platform/README.md`](../../platform/README.md). That README is the
downstream half: how to transcribe a finished session into manifest,
rubric, recall prompts, and audio script. **This document is the upstream
half: how to write the session in the first place so the transcription is
possible, faithful, and cheap.** Author for the room first — that rule
stands — but an author who knows how each file is consumed writes material
that needs no reshaping later.

## How the platform consumes a session

| You write | The room uses it as | The platform uses it as |
|---|---|---|
| `PREWORK.md`, `README.md` | Reading before the session | The **concept track** — rendered as text and read aloud as audio. **Students see every file listed as a concept source.** |
| `EXERCISES.md`, `PRACTICE.md`, `handouts/` | The in-room steps and the week's practice | The **lab** — desk material, unlocked when the previous session certifies |
| `CHECKPOINT.md` | The bar the facilitator applies in the round | The **rubric** (via `platform/rubrics/`) that an automated certifier applies, near-miss corrections included |
| `FACILITATOR_GUIDE.md`, `EXERCISE_RUNSHEET.md`, `FLOOR_TEST.md`, `DRY_RUN.md` | Your side of the room | The **TA's knowledge** — the virtual TA reads and cites them; students never see them |
| `docs/trunk/FRICTION.md` | The between-cohort revision loop | The TA's friction corpus (intended; not yet wired — see "Known gaps") |

Two consequences an author must hold in mind:

**Session `README.md` files are student-visible.** The manifest lists them
as concept sources, so a self-paced student reads them — including, today,
the artifact tables that link to `FACILITATOR_GUIDE.md` and the
"Constraints on edits" sections addressed to authors. The platform
neutralizes the links and strips HTML comments, but the prose remains. When
writing or revising a session README, either keep it in the course's voice
(a student may read this) or move author-facing material into the
facilitator documents, which the platform correctly withholds.

**`CHECKPOINT.md` is never TA knowledge.** It is the source the rubric is
transcribed from; giving it to the TA would hand students the answers to
their own checkpoint. Anything you want the TA to be able to say belongs in
the facilitator guide or the runsheet instead.

## Writing a checkpoint that becomes a rubric

The checkpoints for Sessions 1 and 2 are the model; they transcribed almost
verbatim because they already had the shape the certifier needs. That shape
is worth stating as rules:

1. **The bar is a numbered list of binary items.** "All four" is a bar a
   machine can apply. A holistic paragraph is not.
2. **Each item names its evidence.** Session 2's checkpoint says outright
   which items "are facts you can see" and which "you have to hear" — that
   sentence decides, item by item, whether the platform checks
   deterministically or judges with a model. Write it for every session.
3. **"What a pass sounds like" and "what a near-miss sounds like" are not
   color — they are the calibration set.** The certifier judges against
   your exemplars; rubric-only grading is measurably too strict and
   example-only too lenient. Two or three verbatim quotes of each, per
   item, is the target.
4. **Every near-miss row carries the corrective question, in your words.**
   On a near-miss the platform opens a bounded "checkpoint conversation":
   it asks your corrective question, and a corrected answer passes — a
   near-miss corrected on the spot counts as a pass, exactly as in the
   room. A near-miss without a corrective question can only fail, which is
   not the room's behavior.
5. **The recovery section is the escalation map.** Causes a facilitator
   handles privately at the end become the cases the platform routes to
   the instructor. Name them, with what you'd do — that text becomes the
   instructor's suggested starting point on the ticket.

## Choose evidence a self-paced student can submit

In the room the evidence is in the air — you hear the answer, you glance at
the screen. The platform only has what a student uploads: a worksheet, free
text, files from the practice folder, a pi session log, a short voice note.
When designing an exercise, ask early: **where does the evidence of the
outcome land, and can a student hand it to us?**

Two lessons from the first transcription, worth designing around rather
than rediscovering:

- **Course shell commands leave no trace in pi's session log.** `commit`
  and `revert` are things the participant types in the terminal, not tools
  pi calls, so "used revert at least once" is invisible in the log the
  student submits. Session 2's answer: have the student paste the output of
  `revert --list`, which shows the checkpoint history — the evidence moves
  into a submittable artifact. Prefer designs where the exercise itself
  produces a pasteable, uploadable residue.
- **Worksheets are graded by their structure.** A handout with named
  columns can be checked mechanically ("≥3 rows with the judgeability
  column filled"). A handout that invites free prose can only be judged by
  a model. Both are fine; know which you are writing.

## Handout wording is a contract

Deterministic checks quote handout text exactly — table headings, column
names, printed output — down to punctuation (`platform/README.md`, "The
rules"). Reword a heading in a handout, or change what a course command
prints, and a rubric check does not error: **it silently fails every
student**. Editing a handout or a command's output is therefore not
finished until you have grepped `platform/` for the old wording. This is
the platform's version of DEC-010's rule that later sessions extend the
inventory rather than renaming its columns: printed words that something
else reads are frozen interfaces.

## Concept prose: the why is listenable, the how is not

The concept track is consumed with no hands and no screen — the design case
is a car. The evidence behind this delivery (see the platform repository's
`docs/investigations/prior_art_learning_platforms/`) is blunt: audio
carries conceptual material as well as text, and loses badly on procedures,
tables, and anything the listener must look at.

So when writing prework and concept material, keep the *why* and the *how*
separable at the paragraph level. The listenable script will carry the why
and hand everything else off with a "this is on your lab card" line; prose
that interleaves a concept with the keystrokes that demonstrate it, sentence
by sentence, cannot be split without rewriting. Session 2 is the worked
example: *why the safety net exists, and why it comes before the first
delegation* survives a commute; the mechanics of `commit` and `revert` stay
at the desk.

While drafting, mark the recall-worthy moments — the three to six ideas per
session a student should be able to answer a question about a day later.
Those become the recall prompts that close each audio segment and get
replayed, spaced, in later sessions. If you cannot write a one-sentence
question with a one-sentence model answer for a section, it is exposition,
not a concept — fine, but know it.

## Publishing, and what a tag means

The platform ingests this repository **at a git tag** (`platform-YYYY-MM`),
and every enrollment pins the tag it was sold at. Students on an existing
tag keep seeing exactly what they enrolled in; a fix or a new session
reaches new students by cutting a new tag. The consequences:

- A tag is a release. `pnpm contract:validate` (run from the platform
  checkout) must be clean before tagging; read the warnings.
- Mid-cohort fixes to the *environment* still travel by `course-update`
  (DEC-012); fixes to *material* travel by tag. Do not expect an edit on
  `main` to reach an enrolled student.
- The rubric a student was shown at submission time is the rubric applied.
  Tightening a bar affects future tags, not people mid-session.

## A new session, in order

1. Write the session for the room — the seven files of DEC-010/DEC-011 —
   with this document's rules in mind: binary bar with named evidence,
   exemplars and corrective questions, submittable residue, separable
   why/how, student-safe README.
2. Floor-test and dry-run it as ever. The platform inherits the room's
   quality bar; it does not replace it.
3. Transcribe it into `platform/` following
   [`platform/README.md`](../../platform/README.md), "Adding a session".
4. Validate, tag, and tell the platform's instructor surface to ingest the
   new tag.

## Known gaps (check before relying on this section)

Current as of 2026-08-22; each should disappear, so verify before working
around it:

- `docs/trunk/FRICTION.md` is intended to feed the TA's friction corpus but
  the Module Contract has no manifest key for it yet, so the platform never
  fetches it. Friction still reaches the TA the long way: platform-side
  candidates the instructor accepts.
- HTML comments in a listenable script are spoken by the voice; the
  validator does not yet catch them. Nothing goes in a script you would not
  say aloud (`platform/README.md` records the same rule).
- Session README files reach students unedited (see above); a
  student-facing session index that replaces `README.md` in
  `concept.sources` is the likely eventual fix.
