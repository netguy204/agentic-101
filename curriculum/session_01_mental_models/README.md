# Session 1 — Mental models & toil inventory

<!-- Chunk: docs/chunks/fluency_session_01 - Session 1 index -->

**Arc 1 — Fluency, session 1 of 5.** About an hour of prework, concept and lab,
then a practice week (the lab parts in `platform/module.yaml` have the steps).
Delivered self-paced on the platform, with an instructor reachable and
optional live sessions (DEC-014).

The opening session of the course. No software, no terminal, no harness;
Session 2 owns all of that. This session makes the case that the course is
for the student, gives them the two distinctions the rest of the course
depends on, and starts the list of their own work that everything
downstream is built from.

**Outcome:** every student submits a toil inventory of at least three
entries, each marked with whether they could evaluate the output, and
explains why one of their own tasks sits inside or outside their judgment
boundary.

---

## The artifacts

| File | For | Read it when |
|---|---|---|
| [`platform/prework/01_mental_models.md`](../../platform/prework/01_mental_models.md) | Student | Before the concept track. This session has no `PREWORK.md`; the platform prework is the only version (DEC-014) |
| [`FACILITATOR_GUIDE.md`](FACILITATOR_GUIDE.md) | Instructor | **Start here.** Before your first student |
| [`EXERCISES.md`](EXERCISES.md) | Student | The three exercises, step by step |
| [`EXERCISE_RUNSHEET.md`](EXERCISE_RUNSHEET.md) | Instructor | Running an exercise live, or answering a thread about it: cues, misfires, fallbacks |
| [`PRACTICE.md`](PRACTICE.md) | Student | The practice week, after the exercises |
| [`CHECKPOINT.md`](CHECKPOINT.md) | Instructor, author | The bar; the source of the platform rubric |
| [`FLOOR_TEST.md`](FLOOR_TEST.md) | Author | The test-student protocol and its results |
| [`handouts/toil-inventory.md`](handouts/toil-inventory.md) | Student | The sheet and its column definitions. **Used by every later session** |
| [`handouts/canned-toil.md`](handouts/canned-toil.md) | Student | For anyone who can't use their real work |
| [`demo/`](demo/README.md) | Instructor | The Northwind demo, for live sessions |

An instructor new to this session reads the facilitator guide, then the
inventory sheet, then [`EXERCISES.md`](EXERCISES.md) and
[`EXERCISE_RUNSHEET.md`](EXERCISE_RUNSHEET.md). About twenty minutes.

---

## The teaching spine

The session delivers the curriculum thesis (`docs/trunk/GOAL.md`;
DEC-005) in a fixed order. The order is load-bearing — an edit that
reorders these is a change to the session's argument, not a change of
emphasis.

1. **Why the moment matters, first.** The session opens with the leverage
   argument, not with definitions: judgment encoded once, governing
   unbounded work, is what software engineers have had for forty years and
   what plain-language agentic tooling now offers everyone else. This
   comes first because it tells a skeptical operations manager that the
   course is *for them*. Definitions land better once people believe that.
2. **Mental models.** What an agent is and isn't; how acting on files and
   systems over multiple steps differs from conversing.
3. **Judgment vs expertise, and the judgment boundary.** Judgment is the
   ability to evaluate; expertise is the ability to produce. Delegation
   substitutes for expertise; nothing substitutes for judgment. Delegating
   outside your judgment boundary is the cardinal risk, because
   plausible-but-wrong output passes unchallenged.
4. **The toil inventory.** Students start the list they will mine for
   their capstone, annotating each entry with whether they could evaluate
   the result.

In a live session, the Northwind demo makes point 3 an experience: the
student is given domain knowledge the agent can't have, the agent produces
a confident answer that's wrong in exactly that spot, and the student
catches it. The concept track makes the same point in words. Any
capability shown in this session is followed immediately by "how would you
check this?" (DEC-005, Consequences).

---

## Constraints on edits

- **No harness hands-on.** The session must work end to end for a
  student whose setup failed; their setup gets fixed before Session 2. The `commit`/`revert` safety net gets one sentence
  in the FAQ if asked, and is taught in Session 2.
- **No assumed programming or terminal knowledge**, anywhere, including
  the handouts (DEC-004).
- **Exercises run on the student's own work**, with the canned persona
  as a full-quality fallback rather than a consolation prize.
- **Terminology is quoted from `docs/trunk/SPEC.md`**, not paraphrased.
  Sessions 2–6 build on these words.
- **The inventory's four columns are a cross-session contract** (DEC-010).
  Later sessions may add a column; they may not rename or renumber these.

## What downstream sessions take from here

| Session | Takes |
|---|---|
| 2 | The inventory, to pick a first delegation from |
| 3–5 | Individual entries as exercise material |
| 6 | The whole inventory, as the capstone selection gate — including the entries correctly ruled out |
