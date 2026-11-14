---
name: course-voice
description: How to write and revise agentic-101 session material — the frozen strings, the shape of each document, and the checks — with instructor-voice as the voice. Use when writing or revising any session material in this repo (platform index, prework, audio script, recall, exercises, practice, handouts, checkpoint, facilitator guide, runsheet, floor test, setup guide, welcome email), or when asked to give a session a "voice pass".
---

# Course voice

The student works alone on the platform, with an instructor reachable
through it (DEC-014). Write so that student can act on every paragraph
without asking anyone.

**The voice for anything a student reads or hears is the `instructor-voice`
skill** (`~/.claude/skills/instructor-voice/SKILL.md`, adopted 2026-11-14).
Load it first. This skill adds what is specific to this course: what must not
change, the shape of each document, and the checks. Instructor-facing files
(facilitator guide, runsheet, floor test, dry run) follow `plain-writing`.

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

**Give honest minutes.** The session page shows each lab part's `minutes`
from `module.yaml`. They agree with `estimated_minutes` and the runsheet. If
you change one, change all three.

**Make each argument once.** The audio script carries the why. The prework
and the lab say what to do and point back. If a paragraph in the lab
explains why the exercise matters, cut it.

**Every reference can be found from where it's made.** A student must be
able to open anything the text names, right there, and know what it is.
The platform starts each lab part at its anchored heading, so nothing above
that heading reaches the student inside the part.

- Give each thing one ordinary name and use it everywhere: "your toil
  inventory sheet", "Priya's sample tasks", "the terminal card", "the
  what-did-it-do worksheet", "the prework".
- Link it at the point of use with a relative link, with a `#section`
  anchor when the text means one section (anchors use the platform's slug:
  lowercase, punctuation dropped, spaces to hyphens).
- Open every exercise and practice section that uses something with a
  **You'll need:** line that names and links it.
- Name columns and boxes by their headings, not only by number.
- Run the link check (Checks, below) before finishing.

**Define each thing in one place.** A handout defines its columns; the
exercises and practice point to it. When you find the same
definition in two files, keep the one in the handout.

**No commentary on the material.** Cut lines that rate a step ("the
load-bearing exercise", "the highest-value fifteen minutes") or announce
what is coming. Warmth and reassurance follow `instructor-voice`: where a
student would actually feel it, once.

**Do not overstate.** Every claim has to survive a skeptical reader.

> Before: "Do not mark a task in because you do it every week. That is
> the most common mistake on the sheet."
>
> After: "'I do it every week' is a reason to think you could check it. It
> becomes a check once you can name what you'd look at."

Drop "most common", "always", "never" unless something in the repo
supports it.

**Talk to an adult who is new to this.** Explain a term once, plainly, the
first time it matters.

**Keep the numbers consistent.** Row counts, part counts, minimum
submissions: state the requirement the rubric enforces, in the same words,
wherever it appears.

## By document

| Document | Shape |
|---|---|
| Session intro (`platform/intro/`) | A few sentences, under 120 words: a welcome and what the session is about. The session page shows the steps, submission and help, so don't repeat them. |
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
- Call the learner **the student** in instructor-facing documents; in
  student-facing text, talk to them as "you".
- Ordinary names for the parts: "the audio" (not "concept track"),
  "submit" (not "hand in"), "your lab".

## Checks before you finish

1. Run `instructor-voice`'s checks on student-facing text: read it aloud,
   test each reassurance, and search for house terms, ` — ` and `;`, and
   words about the system's insides.
2. Grep for `the room`, `this recording`, `concept track`, `hand in`,
   `facilitator` (in student-facing text), `most common`.
3. Check every frozen string from "Before you edit" is unchanged.
   Then check every relative link and `#anchor` in the student files
   resolves: each link must name a file the module serves, and each anchor
   a heading in it.
4. Grep for references to anything you deleted or renamed.
5. Run `uvx --from vibe-engineer ve validate` and, from
   `../learning-platform`, `pnpm contract:validate
   /Users/btaylor/Projects/agentic-101`. Short-segment warnings are
   accepted; read every other warning.
6. Record decisions that change how the course is delivered in
   `docs/trunk/DECISIONS.md` as an Amended note; it is append-only.

## Working with the operator

Rewrite one sample first (the intro and the prework, or one audio
segment) and show it before doing the rest of a session. Report word
counts before and after, frozen strings checked, and the judgment calls
you made, so the operator can review the calls without rereading every
file.
