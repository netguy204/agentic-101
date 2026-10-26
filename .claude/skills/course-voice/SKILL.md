---
name: course-voice
description: The agentic-101 course voice — tight, direct, actionable for a self-paced student. Use when writing or revising any session material in this repo (platform index, prework, audio script, recall, exercises, practice, handouts, checkpoint, facilitator guide, runsheet, floor test, setup guide, welcome email), or when asked to give a session a "voice pass".
---

# Course voice

The student works alone on the platform, with an instructor reachable
through it (DEC-014). Write so that student can act on every paragraph
without asking anyone. The reference is Session 1 and Session 2 as revised
in October 2026: `platform/index/01_mental_models.md`,
`platform/prework/01_mental_models.md`, `platform/audio/01_mental_models.md`,
and `curriculum/session_01_mental_models/`. Read them before writing.

Also apply the `plain-writing` skill. This skill adds what is specific to
course material.

## Before you edit

1. Read `docs/trunk/PLATFORM_AUTHORING.md` and `platform/README.md`.
2. List the frozen strings for the session, and keep them exact:
   - every heading `platform/module.yaml` anchors to (`lab.parts[].sources`,
     `facilitator` sources). Changing one means changing module.yaml in the
     same edit.
   - every heading, column name or phrase a rubric in `platform/rubrics/`
     quotes, and the checkpoint questions and correctives the rubric mirrors.
   - `> Recall: <id>` and `> Lab card:` lines in the audio script, and the
     ids in `platform/recall/`.
   - commands, version pins and sample terminal output (setup and Session 2+).
3. Back up each file to the scratchpad before rewriting it.

## The rules

**Lead with what the student does.** Each document opens with what they
will have at the end. Steps are numbered. Each exercise ends with a
**Done when:** line naming a thing they can see. Each part ends with
**Next:**.

> Before: "This is the first session of the course, and it is a
> conversation rather than a piece of software. You installed something to
> get here and you ran a check that said PASS; today you can forget both."
>
> After: "**What you hand in.** Your toil inventory with at least three
> rows, all four columns filled…"

**Give honest minutes.** The index has a steps table with a time per step.
The times agree with `module.yaml` (`estimated_minutes`, part `minutes`) and
the runsheet. If you change one, change all three.

**Make each argument once.** The audio script carries the why. The prework
and the lab say what to do and point back. If a paragraph in the lab
explains why the exercise matters, cut it.

**Define each thing in one place.** A handout defines its columns; the
exercises, practice and index point to it. When you find the same
definition in two files, keep the one in the handout.

**No commentary on the material.** Cut lines that rate a step ("the
load-bearing exercise", "the highest-value fifteen minutes"), reassure
("nothing in this list is your fault", "it looks severe and it is not"),
praise the student, or announce what is coming.

**Do not overstate.** Every claim has to survive a skeptical reader.

> Before: "Do not mark a task in because you do it every week. That is
> the most common mistake on the sheet."
>
> After: "'I do it every week' is a reason to think you could check it. It
> becomes a check once you can name what you'd look at."

Drop "most common", "always", "never" unless something in the repo
supports it.

**Talk to an adult who is new to this.** Explain a term once, plainly, the
first time it matters. Don't soften instructions or guess at the
student's feelings ("your heart rate up", "don't worry").

**Keep the numbers consistent.** Row counts, part counts, minimum
submissions: state the requirement the rubric enforces, in the same words,
wherever it appears.

## By document

| Document | Shape |
|---|---|
| Platform index | What you hand in; steps table with minutes; Getting help; Next. |
| Prework | Only what must be done before the session, with its time. No essay. |
| Audio script | Short intro, then segments of 300–450 words, each ending with its `> Recall:` line. No tables, no code, no reference to the medium ("this recording", "on your commute", "as I said a moment ago"); scripts are also read as pages. |
| Recall yaml | Question and model answer the script supports. Change an answer only if the script no longer supports it. |
| Exercises | "What you'll have at the end", then numbered steps, **Done when:**, and a "Working with your instructor or a partner?" note where pairing helps. |
| Practice | A table of when, how long, what; each part with **Done when:**; "If the week gets away from you" with the minimum. |
| Handout | The single definition of its format, with one filled-in example per case. |
| Facilitator guide, runsheet, floor test | Written for an instructor who answers threads and runs optional one-on-one or small-group video calls. Keep failure points, FAQ answers and correctives; they are fed to the course assistant, so each row must read correctly when quoted to a student alone. No room, floor, breakout tables or room timings. |
| Setup and welcome email | Each step: the line to paste, then what the screen shows. Keep sample output word for word with the scripts. |

## Words to use

- The person who helps is **your instructor** in student-facing text.
- The help route is **"Stuck on this session?"**, then **"Send to your
  instructor"**. First response within a day. Say plainly which help is
  automated (the course assistant) and that a person is always available.
- Call the learner **the student**, in every document.

## Checks before you finish

1. Grep the files you touched for the tics: `, not `, `rather than`,
   `worth noting`, `the room`, `this recording`, `facilitator` (in
   student-facing text), `most common`.
   An instruction such as "read the names, not the numbers" can stay;
   an argument with an objection the reader didn't raise goes.
2. Read each first sentence alone. It should say what the reader does or
   gets.
3. Check every frozen string from "Before you edit" is unchanged.
4. Grep for references to anything you deleted or renamed.
5. Run `uvx --from vibe-engineer ve validate` and, from
   `../learning-platform`, `pnpm contract:validate
   /Users/btaylor/Projects/agentic-101`. Short-segment warnings are
   accepted; read every other warning.
6. Record decisions that change how the course is delivered in
   `docs/trunk/DECISIONS.md` as an Amended note; it is append-only.

## Working with the operator

Rewrite one sample first (the index and the prework, or one audio
segment) and show it before doing the rest of a session. Report word
counts before and after, frozen strings checked, and the judgment calls
you made, so the operator can review the calls without rereading every
file.
