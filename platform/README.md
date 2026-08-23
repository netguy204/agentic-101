# `platform/` — this course, for a machine

<!-- Chunk: docs/chunks/platform_module_contract - What this directory is, and the rules for keeping it true -->
<!-- Chunk: docs/chunks/platform_lab_parts - The lab-as-parts rules: transcription, load-bearing headings, honest minutes -->
<!-- Chunk: docs/chunks/platform_dual_authoring - The drafts convention: staging a session's platform version until the room has proven it -->
<!-- Chunk: docs/chunks/platform_student_index - index/, the student's session index that concept.sources serves instead of README.md -->

Everything else in this repository is written for a person: a participant
reading prework on the train, a facilitator holding a runsheet in front of
twelve people. This directory is written for a program.

A self-paced delivery platform serves these sessions to students who never
sit in the room. It reads the concept material aloud, hands out the lab,
collects what the student made, and runs the checkpoint conversation a
facilitator runs in the last ten minutes. **It owns no course content.** It
fetches this repository at a git tag and reads the files below to find out
what the course is. That is the whole interface, and the schema it is written
against is Module Contract v1, which lives in the platform's own repository.

Nothing here replaces anything. Every file below is a derivative of prose
that already existed, and the prose is still the source. This README covers
the transcription — the mechanics of this directory. How to *write the
prose itself* so it transcribes well is the trunk's concern:
[`docs/trunk/PLATFORM_AUTHORING.md`](../docs/trunk/PLATFORM_AUTHORING.md).

## What is in here

| File | What it is |
|---|---|
| `module.yaml` | The manifest. The only file the platform knows the name of; everything else is found through it. Module identity, budgets, the setup gate, and per session: which files are concept, which are lab, which are the facilitator's, what a student submits, how long it takes, and the lab's **parts** — the sittings a student stops and resumes between. |
| `index/01_mental_models.md`, `index/02_meeting_the_harness.md` | Each session's index, for the student. What the session is for, what it costs in honest minutes, what they will do and what they hand in — written from the session's `README.md` and `PREWORK.md`. This is what `concept.sources` lists in place of `README.md`, which is a session's index for its author and its facilitator and is not served at all. |
| `rubrics/setup.yaml` | The gate before Session 1: `course-smoke-test` reported PASS. |
| `rubrics/01_mental_models.yaml`, `rubrics/02_meeting_the_harness.yaml` | Each session's `CHECKPOINT.md`, structured. Criteria, the evidence that satisfies each, pass exemplars, near-miss exemplars with the facilitator's corrective question, and — where the checkpoint names a fact a machine can see — a deterministic check. |
| `recall/*.yaml` | The question-and-answer beat that closes each audio segment. |
| `audio/*.md` | The concept tracks, written for the ear. |
| `pronunciation.yaml` | How the voice says pi, Ghostty, OpenRouter and the rest. |
| `drafts/<NN>_<slug>/` | A session's platform version, written alongside the session itself and staged until the room has proven it. Nothing in here is served — or read by anything at all — until it is promoted. See "Drafting a session before it is served". |

To check everything this directory serves before tagging, run the
platform's validator against this repository from a checkout of the
platform:

    pnpm contract:validate /path/to/agentic-101

It reports errors, which block a tag, and warnings, which mean an instructor
should look. It is the same code the platform runs at ingest, so a clean run
here is the answer and not a rehearsal.

## The rules

**`CHECKPOINT.md` is the source. The rubric is a transcription.** The rubric
is what a machine can apply, written from what a facilitator applies. It may
not say anything the checkpoint does not. Every criterion in the two session
rubrics carries a comment naming the sentence of the bar it comes from, and
every row of both near-miss tables is present with the facilitator's words
rather than a paraphrase — including, in Session 1, the row the checkpoint
prints in the near-miss table and then says to accept.

The consequence is the rule that matters: **a change to a session's bar or
its near-miss table is not finished until the rubric has been re-read.** That
is the reason this directory lives in this repository rather than in the
platform's — the two files land in the same review, and a rubric that has
quietly drifted from its checkpoint is a thing nobody would ever go looking
for.

**A lab is parts, and the parts are a transcription too.** Each session's
`lab.parts` in `module.yaml` names the sittings the lab is actually consumed
in: an id, a title, honest minutes, the one outcome the student has at the end
of it, and the `sources` — a lab document, usually narrowed to the heading the
part begins at. The room has a facilitator saying "ten more minutes, then
we'll swap"; a student alone at 9pm has this list instead, which is why
`docs/trunk/PLATFORM_AUTHORING.md` § "Design for the student who is alone"
asks for the structure and this is where it lands.

Two consequences worth knowing before you edit an exercise. First, the same
rule as the rubrics: **a part may not say anything its exercise does not**, so
re-timing or re-splitting an exercise is not finished until its part has been
re-read. Second, **the headings are load-bearing**: a part's `#anchor` is
matched against the real headings of the file, so renaming
`## Exercise 2 — The check column` breaks it. Unlike a reworded handout
header, this one fails loudly at validation rather than silently in front of a
student.

The minutes are the promise. Every session's `estimated_minutes.lab` is the
sum of its parts and includes the practice week, because a student with no
cohort has no "between sessions" — the practice laps are simply the last
sittings of the lab. Parts are pacing and never a gate: the platform certifies
against what the student submits, so somebody who ignores the parts entirely
is signed off exactly the same way.

**Deterministic checks quote handout text, exactly.** Three of Session 1's
criteria are decided by reading the participant's inventory sheet, and they
name its table heading and its column headers as `handouts/toil-inventory.md`
prints them — including the question mark on "In or out of my judgment
boundary?". Reword a header and the criterion does not error. It fails every
student, silently, until somebody notices. If you edit a handout that a
rubric reads, grep this directory for the old wording. The rubrics say which
headings they depend on, in comments, next to the checks that depend on them.

**The facilitator's documents are the TA's, not the student's.** Each session
lists `FACILITATOR_GUIDE.md`, `EXERCISE_RUNSHEET.md`, `FLOOR_TEST.md` and
`DRY_RUN.md` under `ta_knowledge`: the platform's virtual TA may read and
cite them, and a student never sees them. `CHECKPOINT.md` is deliberately
*not* in that list. It is the source the rubrics were written from, and
handing it to the TA as well would hand a student the answers to their own
checkpoint.

**The audio carries the why; the lab card carries the how.** A concept track
is listened to on a commute, so a table, a code block or a command line in
one is an error and the validator treats it as such. Anything a listener
would have to look at goes out to a `> Lab card:` line, said once and moved
on from. This bites hardest in Session 2, which is a hands-on session: the
terminal card and the mechanics of `commit` and `revert` stay at the desk,
while *why* the safety net is taught before the first delegation is exactly
the sort of thing that survives a commute.

**Segments are three to six minutes, and each closes with its recall
prompt.** Roughly 450 to 900 words. The validator warns outside that; aim for
the middle, and read one aloud before you believe it.

**The files under `audio/` carry no backreference comment, and that is
deliberate.** Everything in a script that is not a `> Recall:` or
`> Lab card:` line is speech. The platform's audio pipeline now strips HTML
comments before TTS (verified 2026-08-23), so a stray comment is no longer
spoken — but the discipline stays, because the validator's
unspeakable-content check still only looks for tables, code fences and
command lines: nothing goes in a script that you would not say to a
listener. The scripts' attribution is the row in the table above.

## Drafting a session before it is served

A session's platform version is written at the same time as the session
itself and staged here until the room has proven it — that is DEC-013, and
`docs/trunk/PLATFORM_AUTHORING.md` § "A new session, in order" is the
author's four steps. This section is the mechanics of the staging.

A draft lives in `drafts/<NN>_<slug>/`, under the prefix and slug the
session will be served as, and holds everything the served session needs:

| In the draft | Promoted to |
|---|---|
| `rubric.yaml` | `rubrics/<NN>_<slug>.yaml` |
| `audio.md` | `audio/<NN>_<slug>.md` |
| `recall.yaml` | `recall/<NN>_<slug>.yaml` |
| `index.md` | the student-facing concept index, in its served location (`index/<NN>_<slug>.md`) |
| `session.yaml` | one entry under `sessions:` in `module.yaml` |

`session.yaml` is a manifest fragment: a single `sessions:` entry written in
the shape `module.yaml` wants it, at the contract's current revision (v1.1,
the one that added the lab's parts). So: the concept sources and listenable
script, the lab sources and handouts, `lab.parts` with its two to six
sittings each anchored at the heading it begins at, the artifacts a student
submits, `ta_knowledge`, the rubric path the session will have after
promotion, and `estimated_minutes.lab` equal to the sum of the parts with
the practice week inside it. Written that way, promotion is a paste rather
than a translation.

**A drafted session is never listed in `module.yaml`.** The manifest
describes what the platform serves, so naming a session there before its
files are in place costs a student a door that does not open and buys the
author nothing. The listing is the entire difference between a draft and a
served session; keep it that way and the state is never ambiguous.

**Nothing in a draft is read by anything.** `module.yaml` is the only file
the platform knows the name of, and everything else in this directory is
found *through* it — no glob, no convention, no directory scan. A file under
`platform/` that no manifest entry points at is invisible to the validator
and to ingest, which is the same code. So `drafts/` needs no exemption and
no ignore rule on the platform side, and the reason is worth holding on to:
the manifest is the only thing that makes a file real. (Verified rather than
assumed — the validator was run against a drafts directory full of
deliberately invalid files and reported the same clean result as without it:
`docs/chunks/platform_dual_authoring/PLAN.md` § Step 1.)

The flip side is that a draft is unverified by construction. Its part
anchors are never matched against the exercises' real headings, its rubric
is never schema-checked, its script is never read for the tables and code
blocks a listener cannot hear. All of that happens at promotion, which is
why promotion is not a formality.

**Promotion**, once the room has run the session:

1. Move the draft's files to their served locations, per the table above,
   and remove the empty draft directory.
2. Add `session.yaml`'s entry to `sessions:` in `module.yaml`, in
   progression order. The numeric prefixes have to agree with the list
   order.
3. Run the validator. This is the first time anything has read this
   session, so read every error and every warning — a part `sources` anchor
   broken by a heading the floor test reworded surfaces here and nowhere
   earlier.
4. Cut the `platform-YYYY-MM` tag and tell the platform's instructor
   surface to ingest it.

No step in that list is authoring. If promotion turns into writing, the
draft was not finished; finish it in `drafts/` and promote again, because a
session that is half-written in `module.yaml` is a session being served.

## Adding a session

These steps produce a *draft* — `drafts/<NN>_<slug>/`, written alongside the
session and promoted after the room has run it, per the section above. The
transcription work is the same either way; only its destination waits.

1. Write the session first, as a session — the seven files of DEC-010 and
   DEC-011. This directory describes a session; it does not define one.
2. Frame `session.yaml`, the manifest fragment — the entry the session will
   have under `sessions:` once it is promoted, and not a line in
   `module.yaml` before then. Which files are concept, which are the lab,
   which are the facilitator's, what the student submits. Steps 3 to 5 fill
   in what it points at.
3. Write the rubric from `CHECKPOINT.md`, working through the bar item by
   item. Ask of each: can a machine see this, or does somebody have to hear
   it? The checkpoints tend to answer that themselves — Session 2's says
   outright which of its four items are facts you can see and which are the
   ones you have to hear.
4. Split the lab into `parts`, from the structure the exercises already
   have — one per exercise, or per practice lap, grouping the ones the
   runsheet runs back to back. Two to six of them; minutes from the
   runsheet's block timings and `PRACTICE.md`'s time budget; each with the
   one outcome the student has at the end of it. Set
   `estimated_minutes.lab` to the sum.
5. Write the script, then the recall prompts, in that order. A prompt has to
   ask about what its segment actually said.
6. Write the student's index, from the session's `README.md` and
   `PREWORK.md` — one page in the course's voice, addressed to the student:
   the outcome, what they will do, the minutes the fragment now promises,
   and what they hand in. It goes in `concept.sources` and the `README.md`
   does not, so this is the step that decides what a student reads first.
7. Stop there, and wait for the room. Promotion (above) is what runs the
   validator, and since nothing in a draft is read by anything, that run is
   the first thing to check this session at all. Read its warnings; they
   are not noise.

## What is not here yet

Sessions 3 to 6. Session 3 exists in `curriculum/` with a complete
checkpoint; the rest are unwritten. The manifest describes what the platform
serves, so a session appears **in `module.yaml`** when it is ready to be
served, not when it is planned — a session named without a rubric is a
locked door with a sign on it.

`drafts/` is outside that rule rather than a hole in it. A draft may be as
complete as a served session and is still not here in the sense that
matters, because nothing names it to a student: no manifest entry, no door,
no sign to read. The one-step-at-a-time framing governs `module.yaml`
alone. So before concluding that a session has no platform version, look in
`drafts/` — it may be finished and waiting on a floor test.
