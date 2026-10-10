# Authoring for the platform

<!-- Chunk: docs/chunks/platform_authoring_guide - How to write session material that lands well on the self-paced platform -->
<!-- Chunk: docs/chunks/platform_lab_parts - "A lab is parts" pointed at the manifest key that carries it -->
<!-- Chunk: docs/chunks/platform_dual_authoring - "A new session, in order" as the dual-authoring flow (DEC-013, superseded by DEC-014) -->
<!-- Chunk: docs/chunks/platform_student_index - The student index a served session owes, and the README the platform stopped serving -->

The course is delivered on a self-paced platform (the peer repository
`../learning-platform`), combined with one-on-one or one-on-many virtual
sessions with a human facilitator (DEC-014). The platform reads the concept
material aloud or shows it as a page, hands out the lab for the desk,
collects what the student made, applies the checkpoint as an automated
rubric — including the corrective question a facilitator would ask on a
near-miss — and grounds a virtual TA in the facilitator's own documents.
Every student can reach a facilitator; the automated help comes first.

The platform owns no content. It fetches this repository at a git tag and
reads it through the `platform/` directory, whose mechanics are documented
in [`platform/README.md`](../../platform/README.md). That README is the
downstream half: how to transcribe a finished session into manifest,
rubric, recall prompts, and audio script. **This document is the upstream
half: how to write the session in the first place so the transcription is
possible, faithful, and cheap.** Write every session for a student working
alone, with a facilitator reachable when they need one.

## One delivery, proven with test students

Each session is proven by a test student working through it — self-paced,
with facilitator sessions — before the platform serves it (DEC-014, which
replaced the classroom-first DEC-013). The test student and the facilitator
sessions are where the near-misses, the misfires, the corrective questions
and the recovery moves are found; those become the rubric exemplars, the
TA's knowledge, and the checkpoint conversation.

What this means in practice:

- **Iterate on `main`; release to the platform by tag.** Session material
  changes freely on `main`; the platform sees a new version only when you
  cut a tag.
- **The platform artifacts are derivatives, never forks.** One
  `CHECKPOINT.md`, one set of exercises, one facilitator guide — the
  `platform/` directory transcribes them. If students need different
  wording, fix the shared source or the transcription; never maintain a
  second copy of a session.
- **Friction is one loop.** What students hit (via the platform's friction
  triage) and what the facilitator sees in live sessions both land in this
  repo's `FRICTION.md`.

## How the platform consumes a session

| You write | A facilitator uses it as | The platform uses it as |
|---|---|---|
| `PREWORK.md` | Being retired (DEC-014). Session 1 has none | Nothing directly. Where one remains, the platform serves its derivative (next row) instead. |
| `platform/prework/<NN>_<slug>.md` | The prework to point a student at | Part of the **concept track**, written for the student working alone. For Session 1 it is the only prework. **Students see every file listed as a concept source.** |
| `README.md` | The session's index for you and a facilitator | Nothing. The platform does not serve it; its student-facing counterpart does that job instead. |
| `platform/index/<NN>_<slug>.md` | What the student sees first | The **student's index** for the session, listed first in `concept.sources`: the outcome, what they will do, honest minutes, what they submit |
| `EXERCISES.md`, `PRACTICE.md`, `handouts/` | The steps, when working through them live with a student | The **lab** — desk material, unlocked when the previous session certifies |
| `CHECKPOINT.md` | The bar the facilitator applies in a live session | The **rubric** (via `platform/rubrics/`) that an automated certifier applies, near-miss corrections included |
| `FACILITATOR_GUIDE.md`, `EXERCISE_RUNSHEET.md`, `FLOOR_TEST.md`, `DRY_RUN.md` | Preparation for live sessions (still written for a room; see DEC-014) | The **TA's knowledge** — the virtual TA reads and cites them; students never see them |
| `docs/trunk/FRICTION.md` | The revision loop | The TA's friction corpus (intended; not yet wired — see "Known gaps") |

Two consequences an author must hold in mind:

**A served session owes a student index.** The session `README.md` is
written for you and for a facilitator — artifact tables that link the
facilitator's documents, "Constraints on edits", the from/to-session
tables — so the platform does not serve it. Each served session instead
has `platform/index/<NN>_<slug>.md`: a one-page derivative of `README.md`
and `PREWORK.md`, in the course's voice and addressed to the student,
carrying the outcome, what they will do, honest minutes that match
`estimated_minutes`, and what they submit. It is part of a session's
platform version exactly as the rubric, the recall prompts and the script
are, and it obeys the same transcription rule: it may not say anything its
sources do not, so a change to a session's outcome, shape or timings is
not finished until its index has been re-read.

**And a student prework.** `platform/prework/<NN>_<slug>.md` is the
prework the student is served, written for the student working alone.
Session 1 has no `PREWORK.md`; Sessions 2 and 3 still derive theirs from
one until their voice passes retire it (DEC-014). Whichever applies, the
rule from chunk platform_cohort_prework holds: **no served document may
tell the student to skip classroom instructions.** Cut room-facing
material out of what the student is served.

The rule underneath is the one to hold on to: **everything listed in
`concept.sources` is read by a student alone at 9pm.** The platform
neutralizes links it will not serve and strips HTML comments, but prose
addressed to somebody other than the student survives — so it belongs in
the facilitator documents, which the platform correctly withholds, or in
the README, which it no longer serves at all.

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
   near-miss corrected on the spot counts as a pass, as it would in a
   live session. A near-miss without a corrective question can only fail,
   which is not what a facilitator would do.
5. **The recovery section is the escalation map.** Causes a facilitator
   handles privately at the end become the cases the platform routes to
   the instructor. Name them, with what you'd do — that text becomes the
   instructor's suggested starting point on the ticket.

## Choose evidence a self-paced student can submit

In a live session the evidence is in the air — you hear the answer, you
glance at the screen. The platform only has what a student uploads: a worksheet, free
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

The script is also read. As of 2026-08-25 the platform renders each
listenable script twice from the same source — spoken audio and a
per-segment reading view sharing one position — so **write every segment
to survive silent reading**: no "as I said a moment ago", no "you are
hearing this on a drive", no reference to the medium at all. Segment
titles and recall questions render as page headings and disclosure text,
so write them to stand alone on a page as well as in the ear. (Forward
guidance from the platform, not a retag: existing S1/S2 scripts mostly
read fine; fix medium references when a script is next edited anyway.)

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

## Design for the student who is alone

In a live session a facilitator absorbs confusion in real time: reads the
stalled face, re-times the block, says the corrective sentence. The
platform student has none of that — and the first pilot's finding is
blunt: session material rendered as-is becomes a 15,000-pixel wall of
text, and the student's commonest question is "what do I do next?" (the
platform's jobs-to-be-done analysis:
`../learning-platform/docs/design/student-experience-brief.md`, a
cross-repository reference). The platform's interface work carries most of
the load, but it can only present the structure the material gives it.
When writing session material, give it this structure:

- **Everything is sized in honest minutes.** A self-paced student decides
  whether to start based on what it costs; "about 20 minutes" they can
  trust is an affordance, "an exercise" is a wall. The manifest's
  `estimated_minutes` is a promise — dry-run it.
- **A lab is parts, not a document.** Three to six parts (the manifest
  allows two to six), each around 10–25 minutes, each with one outcome and a
  visible residue (a filled row, a pasted output, a file that exists). Parts
  are where a student stops and resumes: assume every session is consumed in
  two to four sittings and never let a part's meaning depend on the sitting
  before it being fresh. The manifest carries them — `lab.parts` in
  `platform/module.yaml`, one per exercise or practice lap, anchored at the
  heading the part begins at; see `platform/README.md` § The rules. The
  practice week is part of the lab, not something after it: a self-paced
  student has no "between sessions".
- **The contract comes before the work.** State what the student will hand
  in and what "done" looks like at the top of the exercises, in their
  language, so an evening's work has a visible destination. (The platform
  surfaces this from the rubric; exercises that bury or contradict it
  fight their own certification.)
- **Every stopping point answers "what do I do next?"** End each part by
  naming the next one. Never end material on background reading.
- **Say "not yet", never "failed."** The checkpoint conversation exists so
  a near-miss gets the facilitator's question instead of a grade; write
  corrective questions the way you would say them to a person's face.
- **Do not compensate for the missing facilitator with more prose.** The
  instinct is to write everything the facilitator would have said; the
  result overwhelms. The facilitator's commentary belongs in
  `ta_knowledge` files where the TA retrieves the right sentence at the
  right moment — not in the student's reading.
- **Every session index ends with "Getting help".** Session 1's lists the
  layers in order: the material, the automated course assistant, the
  checkpoint conversation, and the instructor, a person who sees what the
  assistant can't resolve. Say plainly which help is automated. Later
  sessions point back to it in two or three lines. Setup failures and
  "may I use this real task from my job?" go straight to the instructor.
- **Student-facing text says "instructor".** That is the platform's name
  for the human facilitator, and the route to them is the platform's own:
  "Stuck on this session?" on any session page, then "Send to your
  instructor" (first response within a day; calls are offered by the
  instructor from that thread, not booked by the student). Name that
  feature, not an email address. Facilitator documents keep "facilitator".
- **One document per reader, still.** DEC-011's split (participant steps
  vs facilitator runsheet) is what makes self-paced delivery possible at
  all; anything author- or facilitator-facing that leaks into a concept
  source is read by a student alone at 9pm, with nobody to tell them to
  skip it.

## Voice

Session 1's student index, prework, concept script and lab are the model
(revised 2026-10-10). The rules they follow:

- **Lead with what the student does.** Step tables with honest minutes;
  "Done when:" lines; "Next:" at the end of each part.
- **Make each argument once.** The concept track carries the why. The
  prework and the lab do not repeat it.
- **Define each thing in one place.** The toil inventory handout defines
  its columns; the exercises point to it.
- **No commentary on the material.** Cut lines that rate a step ("the
  load-bearing exercise", "the highest-value fifteen minutes"), praise the
  student, or announce what is coming.
- **Do not overstate.** "Frequency has nothing to do with judgeability"
  is false; "I do it every week is a reason to think you could check it,
  and it becomes a check once you can name what you'd look at" is the
  claim the course needs.
- **Write for the medium-free reader.** Scripts are also read as pages:
  no "you are listening", no "as I said a moment ago".

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

Both versions are authored together, and a test student proves the session
before the platform serves it (DEC-014).

1. **Write the session** — the `curriculum/` files of DEC-010/DEC-011,
   minus `PREWORK.md` — for a student working alone, with this document's
   rules in mind: a binary bar with named evidence, pass and near-miss
   exemplars with the corrective question in your words, submittable
   residue, separable why/how, and the voice above. The `README.md` stays
   yours and the facilitator's; the student's version of it is the index
   in step 2.

2. **Author the draft platform version alongside it**, into
   `platform/drafts/<NN>_<slug>/`: the rubric transcribed from
   `CHECKPOINT.md`, the listenable script, the recall prompts, the student
   index, the student prework, and a manifest fragment in the shape of one
   `module.yaml` `sessions:` entry — Contract v1.1, so `lab.parts`
   included, and `estimated_minutes.lab` the sum of the parts with the
   practice week in it. Do this while the material is still warm. The
   draft is not served and never appears in `module.yaml` — the mechanics
   are in [`platform/README.md`](../../platform/README.md), "Drafting a
   session before it is served".

3. **Have a test student work through it, and iterate.** Self-paced, with
   facilitator sessions as they need them. What the test changes — a
   reworded bar item, a re-timed part, a near-miss nobody anticipated — is
   re-derived into the draft. This step is also what earns the draft its
   exemplars: the near-misses you actually heard beat the ones you
   imagined.

4. **Promote, once a test student has completed it.** Move the draft's
   files to their served locations, add its manifest fragment to
   `sessions:` in `module.yaml` in progression order, run the validator,
   cut a `platform-YYYY-MM` tag, and tell the platform's instructor surface
   to ingest it. This validator run is the first that has seen the session
   — nothing under `platform/drafts/` is checked — so expect it to find a
   stale part anchor or a reworded handout header.

## Known gaps (check before relying on this section)

Current as of 2026-08-23; each should disappear, so verify before working
around it:

- `docs/trunk/FRICTION.md` is intended to feed the TA's friction corpus but
  the Module Contract has no manifest key for it yet, so the platform never
  fetches it. Friction still reaches the TA the long way: platform-side
  candidates the instructor accepts.
- ~~HTML comments in a listenable script are spoken by the voice~~ —
  resolved on the platform side (its audio pipeline now strips comments
  before TTS, verified 2026-08-23). The working rule stands on its own
  merits: nothing goes in a script you would not say aloud
  (`platform/README.md` records it).
