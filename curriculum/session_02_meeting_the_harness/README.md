# Session 2 — Meeting the harness

<!-- Chunk: docs/chunks/fluency_session_02 - Session 2 index -->

**Arc 1 — Fluency, session 2 of 5. 90 minutes live.**

The session where the course becomes hands-on. Session 1 was deliberately
conceptual so that a broken setup cost nothing; this is the one that needs
the environment to work, and the first eight minutes are about making sure it
does for everybody in the room.

**Outcome:** every participant has run an agent on their own machine, watched
it change a real file, said what it did by reading its tool calls rather than
its prose, named the specific thing they checked, and used `revert` to undo a
mess on purpose.

---

## The artifacts

| File | For | Read it when |
|---|---|---|
| [`PREWORK.md`](PREWORK.md) | Participant | Sent a week before the session |
| [`FACILITATOR_GUIDE.md`](FACILITATOR_GUIDE.md) | Facilitator | **Start here.** Read fully before the first teach |
| [`EXERCISES.md`](EXERCISES.md) | Facilitator, participant | The 59-minute exercise block |
| [`PRACTICE.md`](PRACTICE.md) | Participant | Handed out at the close |
| [`CHECKPOINT.md`](CHECKPOINT.md) | Facilitator | The last ten minutes, and afterwards |
| [`DRY_RUN.md`](DRY_RUN.md) | Facilitator, author | Before the first teach — what the commands really print, and what is still untested |
| [`FLOOR_TEST.md`](FLOOR_TEST.md) | Author | Before the session is taught the first time |
| [`handouts/terminal-card.md`](handouts/terminal-card.md) | Participant | Printed, one per person — a no-memorisation reference for terminal, pi, and local recovery |
| [`handouts/what-did-it-do.md`](handouts/what-did-it-do.md) | Participant | Printed, **two** per person — one for the room, one for the practice week |

A facilitator running this for the first time reads the facilitator guide end
to end, then runs the five exercises on their own machine from
[`EXERCISES.md`](EXERCISES.md), then skims [`DRY_RUN.md`](DRY_RUN.md). About
forty minutes, and unlike Session 1 it is not optional — this session has
commands in it, and a facilitator who has not typed them will be reading
`revert`'s questions for the first time in front of twelve people.

---

## The teaching spine

The order is the design. Each step is a prerequisite for the next, and an
edit that reorders them is a change to the session's argument rather than its
emphasis.

1. **Terminal survival, and no more.** What a prompt is, where you are
   (`pwd`), what's here (`ls`), how to move (`cd`), and that nothing happens
   until Enter. Framed as a map onto the file browser people already know,
   and closed by having the same folder open in both windows at once. The
   reference card stays beside the laptop; remembering commands is never the
   test, and technical detail must not compete with the actual subject.
2. **Local file recovery, before the first delegation.** `commit` and
   `revert`, taught first and proved by hand: participants delete a file
   themselves and get it back. These commands recover ordinary changes in
   the practice folder; they do not provide confidentiality, authorization,
   or approval for external actions. Because pi has no general undo, this
   ordering is essential — and Session 1's practice assignment has already
   promised these commands arrive here.
3. **First delegations.** Two of them: one that asks the agent to build
   practice material shaped like the participant's own toil, and one that
   does the real task on it. The point is not that the agent succeeds. It is
   that the participant watches an agent *act* rather than converse — the
   distinction Session 1 drew in the abstract, made concrete in their own
   folder.
4. **Reading what it actually did, and judging it.** The session's payload
   and its checkpoint. Tool calls, then the file, then the recurring
   question: *was this reasonable, and how do I know?* Every demonstration
   of what the agent can do is paired with how a participant would check it.

Then, last, the participant tells the agent to ruin a named local file and
recovers it. That exercise is the session's emotional argument: local file
recovery is not a reassurance, it is a move they have now used twice.

---

## Constraints on edits

- **`commit` and `revert` come before the first delegation.** Not negotiable.
  An edit that moves the safety net later inverts the dependency the whole
  session rests on, and breaks a promise Session 1 has already made.
- **Every written task targets `~/course-practice`.** This keeps local file
  changes visible and recoverable; it is folder discipline, not a security
  boundary.
- **One prescribed model, no choice.** Everyone uses the same course setup so
  that "you should see something like this" is true across the room. Comparing
  model providers is outside this session; adapting pi arrives in Session 5.
- **No assumed terminal or programming knowledge**, anywhere, including the
  prework. This session *teaches* the terminal; it may not lean on it.
- **Exercises are outcome-checked, never output-checked.** "A file exists
  with fifteen rows and you verified it" survives a model change; "the agent
  will say X" does not (`docs/trunk/TESTING_PHILOSOPHY.md`).
- **The destructive prompt in exercise 5 stays bounded to a named file.** An
  unbounded one can destroy the checkpoints, which teaches the opposite of
  the lesson. The reason is written into the exercise so nobody helpfully
  makes it more dramatic.
- **Nondeterminism is taught, not hidden.** An agent doing something
  surprising in front of the room is the best thing that can happen, and the
  facilitator guide says so in those words.

## What this session takes, and what it hands on

| From Session 1 | Used as |
|---|---|
| The toil inventory | The source of the delegation. Column 2 becomes the instruction; column 4 becomes the check. |
| `handouts/canned-toil.md` | The fallback, extended in place with a "For Session 2" section rather than forked |
| The judgment boundary | The reason exercise 4's third box is the session's outcome |

| To later sessions | |
|---|---|
| 3 | Every participant can run a delegation unaided and read what it did — Session 3 teaches decomposition on top of that. The worksheets from the practice week open it. |
| 4 | Bounding what an agent can touch, first met as "why exercise 5's prompt names its file" |
| 5 | pi as a thing that can be adapted, first met as a thing with four tools |
| 6 | The habit that makes a capstone checkable: checkpoint, delegate, check, checkpoint |
