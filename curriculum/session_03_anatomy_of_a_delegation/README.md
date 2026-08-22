# Session 3 — Anatomy of a delegation

<!-- Chunk: docs/chunks/fluency_session_03 - Session 3 index -->

**Arc 1 — Fluency, session 3 of 5. 90 minutes live.**

The session where a delegation stops being a sentence and becomes a
structure. Session 2 proved the room can hand an agent work and read what it
did; this one opens on the delegations that went badly in the practice week
— one per person, by design — and teaches why they went badly and how to
write down what an agent needs so that they don't.

**Outcome:** every participant has written a one-page delegation brief for
one of their own tasks — inputs, instruction, outputs, checkpoints — run it,
found the box that let them down, changed it for a reason they can say, run
it again, and written down what their checks would still miss.

---

## The artifacts

| File | For | Read it when |
|---|---|---|
| [`PREWORK.md`](PREWORK.md) | Participant | Sent a week before the session |
| [`FACILITATOR_GUIDE.md`](FACILITATOR_GUIDE.md) | Facilitator | **Start here.** Read fully before the first teach |
| [`EXERCISES.md`](EXERCISES.md) | Participant | The 58-minute exercise block, step by step |
| [`EXERCISE_RUNSHEET.md`](EXERCISE_RUNSHEET.md) | Facilitator | Running the exercise block: timing, cues, misfires, fallbacks |
| [`PRACTICE.md`](PRACTICE.md) | Participant | Handed out at the close |
| [`CHECKPOINT.md`](CHECKPOINT.md) | Facilitator | The last twelve minutes, and afterwards |
| [`DRY_RUN.md`](DRY_RUN.md) | Facilitator, author | Before the first teach — what Priya's briefs really did on the course model, and what is still untested |
| [`FLOOR_TEST.md`](FLOOR_TEST.md) | Author | Before the session is taught the first time |
| [`handouts/delegation-brief.md`](handouts/delegation-brief.md) | Participant | Printed, **two** per person — one for the room, one for the practice week. **Used by Sessions 4 and 6.** |

A facilitator running this for the first time reads the facilitator guide
end to end, then runs exercise 3 on their own machine from
[`EXERCISES.md`](EXERCISES.md) with [`EXERCISE_RUNSHEET.md`](EXERCISE_RUNSHEET.md)
beside it, on one of Priya's briefs, then skims [`DRY_RUN.md`](DRY_RUN.md).
About thirty minutes. The one new mechanical move — `revert` back to *before
run 1* so the second run starts from the same place — is the thing to have
done with your own hands.

---

## The teaching spine

The order is the design. Each step is a prerequisite for the next, and an
edit that reorders them is a change to the session's argument rather than
its emphasis.

1. **The near-misses first, sorted live.** One sentence per person about
   the practice-week delegation that went worst, sorted on the board into
   three reasons — *it didn't know something*, *it decided something*, *I
   couldn't tell* — with a fourth, *out of bounds*, that counts as a pass.
   The tally is the anatomy, discovered before it is named.
2. **The anatomy, named from their examples.** A delegation is "handing a
   task to an agent with enough structure that it completes without
   step-by-step supervision" (SPEC.md); enough structure is four boxes —
   inputs, instruction, outputs, checkpoints — and each reason on the board
   is a missing box. Two of the four are already on the inventory (columns
   2 and 4).
3. **Write it, run it, change one box, run it again.** The brief for one
   real entry; the Session 2 loop twice with `revert` back to *before*
   between; one change for a reason written in a sentence. The canned
   fallback is Priya's briefs, one of which is built to go wrong.
4. **What would I have failed to catch?** The last box, and the decision it
   forces: add the checkpoint that would catch it, or write *out* — the
   judgment boundary found by experiment, which Session 6 treats as the
   skill.

Then the sentence to land: enough structure is these four boxes, and the
move when it goes wrong is find the box, change it once, run again. Next
time: what happens when the same brief has to run every week.

---

## Constraints on edits

- **The round comes before the explanation.** Explaining the three reasons
  first lets people classify themselves and the tally teaches nothing.
- **One box, one change, between the two runs.** The session's evidence is
  a sentence naming the box and the reason; three changes and a guess is
  not evidence.
- **Exercise 4 is the payload and is never cut.** The cutting rules let the
  second run become the practice week's; they never let box 5 go unfilled.
- **The brief is owned here and extended in place.** Sessions 4 and 6 edit
  `handouts/delegation-brief.md` in this directory and say so in their own
  READMEs; they do not fork a copy (`curriculum/README.md`, cross-session
  rules). Its four boxes are not renamed or renumbered.
- **No prompt-engineering vocabulary.** The frame is a colleague who cannot
  see your screen; the technique is four boxes and the runs.
- **Real-task use goes through Session 2's four-question gate**, linked from
  `PRACTICE.md` rather than restated. In the room, files are made up or
  describe only the shape of the work.
- **Nondeterminism is taught, not hidden.** The agent getting it right
  despite a bad brief is the expected hard case and the guide scripts it;
  the agent doing something surprising is still the best thing that can
  happen.
- **`course-update` opens the session** (DEC-012) — prework part 4 and the
  first paragraph of `EXERCISES.md`.

## What this session takes, and what it hands on

| From earlier sessions | Used as |
|---|---|
| The toil inventory (Session 1) | Column 2 is the brief's instruction; column 4 is its checkpoints. The entry briefed gets a star. |
| The judgment boundary (Session 1) | Exercise 4's *out* — found by experiment this time |
| The loop — `commit` → delegate → check → `commit` (Session 2) | Run twice, with `revert` back to *before* between |
| `handouts/what-did-it-do.md` (Session 2) | The worst-delegation worksheet that opens the session |
| `handouts/canned-toil.md` (Session 1) | The fallback, extended in place with "For Session 3" — Priya's briefs |

| To later sessions | |
|---|---|
| 4 | Every participant owns a brief that has run twice with one named change. Session 4 turns it into a workflow — the same four boxes, repeated, with the checkpoints where they buy the most — and opens with the briefs. |
| 5 | The brief's Instruction box is the first thing participants will want to stop retyping — the case for a prompt template, met before it's taught. |
| 6 | The capstone design is a brief; entries with a strong checkpoints box are picked first, and *out* entries are ruled out on purpose. |
