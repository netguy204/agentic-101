# Session 1 — Mental models & toil inventory

<!-- Chunk: docs/chunks/fluency_session_01 - Session 1 index -->

**Arc 1 — Fluency, session 1 of 5. 90 minutes live.**

The opening session of the course. No software, no terminal, no harness —
Session 2 owns all of that. This session recruits the audience, gives them
the two distinctions the rest of the course depends on, and gets them
started on the list of their own work that everything downstream is built
from.

**Outcome:** every participant leaves with a toil inventory of at least
three entries, each marked with whether they could evaluate the output,
and can say out loud why one of their own tasks sits inside or outside
their judgment boundary.

---

## The artifacts

| File | For | Read it when |
|---|---|---|
| [`platform/prework/01_mental_models.md`](../../platform/prework/01_mental_models.md) | Participant | Before the session. This session has no `PREWORK.md`; the platform prework is the only version (DEC-014) |
| [`FACILITATOR_GUIDE.md`](FACILITATOR_GUIDE.md) | Facilitator | **Start here.** Read fully before the first teach |
| [`EXERCISES.md`](EXERCISES.md) | Participant | The 27-minute exercise block, step by step |
| [`EXERCISE_RUNSHEET.md`](EXERCISE_RUNSHEET.md) | Facilitator | Running the exercise block: timing, cues, misfires, fallbacks |
| [`PRACTICE.md`](PRACTICE.md) | Participant | Handed out at the close |
| [`CHECKPOINT.md`](CHECKPOINT.md) | Facilitator | The last ten minutes, and afterwards |
| [`FLOOR_TEST.md`](FLOOR_TEST.md) | Author | Before the session is taught the first time |
| [`handouts/toil-inventory.md`](handouts/toil-inventory.md) | Participant | Printed, one per person — **used by every later session** |
| [`handouts/canned-toil.md`](handouts/canned-toil.md) | Participant | Printed, for anyone who can't use their real work |

A facilitator running this for the first time reads the facilitator guide
end to end, then the inventory sheet, then the exercises — both
[`EXERCISES.md`](EXERCISES.md) and [`EXERCISE_RUNSHEET.md`](EXERCISE_RUNSHEET.md).
Twenty minutes,
and it is the difference between running this session and reading it out.

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
4. **The toil inventory.** Participants start the list they will mine for
   their capstone, annotating each entry with whether they could evaluate
   the result.

The demo exists to make point 3 an experience rather than a claim: the
room is given domain knowledge the agent can't have, the agent produces a
confident answer that's wrong in exactly that spot, and the room catches
it. Any capability shown in this session is followed immediately by "how
would you check this?" (DEC-005, Consequences).

---

## Constraints on edits

- **No harness hands-on.** The session must work end to end for a
  participant whose pre-course setup failed; their remediation is routed
  to before Session 2. The `commit`/`revert` safety net gets one sentence
  in the FAQ if asked, and is taught in Session 2.
- **No assumed programming or terminal knowledge**, anywhere, including
  the handouts (DEC-004).
- **Exercises run on the participant's own work**, with the canned persona
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
