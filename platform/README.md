# `platform/` — this course, for a machine

<!-- Chunk: docs/chunks/platform_module_contract - What this directory is, and the rules for keeping it true -->

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
| `module.yaml` | The manifest. The only file the platform knows the name of; everything else is found through it. Module identity, budgets, the setup gate, and per session: which files are concept, which are lab, which are the facilitator's, what a student submits, and how long it takes. |
| `rubrics/setup.yaml` | The gate before Session 1: `course-smoke-test` reported PASS. |
| `rubrics/01_mental_models.yaml`, `rubrics/02_meeting_the_harness.yaml` | Each session's `CHECKPOINT.md`, structured. Criteria, the evidence that satisfies each, pass exemplars, near-miss exemplars with the facilitator's corrective question, and — where the checkpoint names a fact a machine can see — a deterministic check. |
| `recall/*.yaml` | The question-and-answer beat that closes each audio segment. |
| `audio/*.md` | The concept tracks, written for the ear. |
| `pronunciation.yaml` | How the voice says pi, Ghostty, OpenRouter and the rest. |

To check the whole directory before tagging, run the platform's validator
against this repository from a checkout of the platform:

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

**The two files under `audio/` carry no backreference comment, and that is
deliberate.** Everything in a script that is not a `> Recall:` or
`> Lab card:` line is speech, and that includes an HTML comment: anything
before the first `## Segment` heading is the track's spoken introduction, so a
`<!-- Chunk: … -->` line at the top would be read out by the voice. The
validator does not currently catch this — its unspeakable-content check looks
for tables, code fences and command lines. Until it does, the rule is manual:
nothing goes in a script that you would not say to a listener. Their
attribution is the row in the table above.

## Adding a session

1. Write the session first, as a session — the seven files of DEC-010 and
   DEC-011. This directory describes a session; it does not define one.
2. Add it to `sessions:` in `module.yaml`, in progression order. The numeric
   prefixes have to agree with the list order.
3. Write the rubric from `CHECKPOINT.md`, working through the bar item by
   item. Ask of each: can a machine see this, or does somebody have to hear
   it? The checkpoints tend to answer that themselves — Session 2's says
   outright which of its four items are facts you can see and which are the
   ones you have to hear.
4. Write the script, then the recall prompts, in that order. A prompt has to
   ask about what its segment actually said.
5. Run the validator. Read the warnings; they are not noise.

## What is not here yet

Sessions 3 to 6. Session 3 exists in `curriculum/` with a complete
checkpoint; the rest are unwritten. The manifest describes what the platform
serves, so a session appears here when it is ready to be served, not when it
is planned — a session named without a rubric is a locked door with a sign on
it.
