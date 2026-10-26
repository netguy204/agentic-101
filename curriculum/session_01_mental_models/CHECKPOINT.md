# Session 1 checkpoint

<!-- Chunk: docs/chunks/fluency_session_01 - Session 1 observable checkpoint -->

The observable behavior that tells you Session 1's outcome landed
(`docs/trunk/SPEC.md`, Session Anatomy;
`docs/trunk/TESTING_PHILOSOPHY.md`, In-Session Checkpoints).

---

## The bar

**Every student submits:**

1. A toil inventory containing **at least three entries**, each annotated
   with judgeability — in, out, or not sure — and
2. an explanation, **for one of their own tasks, of why it sits inside or
   outside their judgment boundary**, naming the check they would use (or
   naming why no check is available to them). Typed or as a voice note on
   the platform; spoken, in a live session.

Both halves are required. Three filled rows without the explanation is a
filled-in form; the explanation without the rows is a nice conversation.
The session's outcome is the pair.

---

## How it is observed

**On the platform.** The student submits the sheet and the explanation.
The sheet's row and column checks are mechanical; the explanation is judged
against the examples below. A near-miss gets the corrective question from
the table below and a second try. After two rounds, or when the judge isn't
confident, the case goes to the instructor.

**In a live session.** Ask for it at the end, in one frame:

> "One task from your sheet. In or out. And the check — how you'd know if
> it was wrong."

Don't improve their answer before they give it. If it's a near-miss, ask
the corrective question once. With a small group, take one answer from
each person, or have them submit on the platform.

**Record it.** Session 2 picks a task from this sheet, and Session 6 picks
the final project from it:

| Student | ≥3 annotated entries | Explanation | Note |
|---|---|---|---|
| | yes / no | pass / near-miss / no | |

---

## What a pass sounds like

> "The Monday roll-up. It's **in** — I'd add up the four regional totals
> myself and check the summary matches, and I'd notice if a region that
> always reports late had a suspiciously round number."

> "The contract clauses. **Out.** I can spot a changed payment term but I
> could not tell you whether a re-worded liability clause is normal, and
> it'd read fine to me either way."

The second one is the better answer. If you comment on one thing, comment
on that: knowing where your judgment runs out is the skill, and saying it
plainly is worth more than any confident **in**.

## What a near-miss sounds like, and what to say

| They say | What's missing | Say this |
|---|---|---|
| "It's in because I do it every week." | Frequency isn't judgeability. | "Doing it often helps. If I handed you a finished one, how would you know it was wrong?" |
| "It's out because I couldn't do it myself." | Expertise confused with judgment. **The most common near-miss by far.** | "You don't need to be able to do it. Could you tell if it was wrong? … Then it's in." |
| "I'd just read it over and I'd know." | The check isn't concrete. | "Reading it for *what*? What's the thing you'd notice?" There is almost always a real answer one question down. |
| "It's in because the agent could definitely do it." | Judging the agent, not their own judgment. | "That's a question about the tool. Mine's about you: could *you* tell?" |
| "It's in, but I'd have to check every line." | Actually a fine answer — that's a real check. | Accept it, and flag it as interesting: "That's a genuine check, and it's an expensive one. Hold that thought — Session 4 is about exactly that." |

A near-miss corrected on the spot counts as a pass. The point is the
distinction, not the first attempt.

## Recovery: someone who can't produce one

These are the cases the platform sends to the instructor. Handle them in
the thread, or offer a call. A student who can't explain a boundary is
usually stuck on the sheet, for one of three reasons:

- **No entries yet** (blank-page freeze, or the work doesn't feel
  repetitive). Point them at [`handouts/canned-toil.md`](handouts/canned-toil.md)
  and work one row with them, in the thread or on a call. Then ask them to
  do the daily pass in [`PRACTICE.md`](PRACTICE.md) and submit three
  entries by the end of the week.
- **Entries but no checks.** Ask "what would you actually look at?" on one
  entry until it's concrete. One worked example almost always unblocks the
  rest.
- **Everything marked out.** Usually the expertise/judgment confusion,
  often in a student who's new to their role or being modest. Walk one
  **out** entry back: "if I handed you this finished, would you spot a
  missing region?" Yes. Then it's in.

Follow up when you said you would. A student who reaches Session 6 without
an inventory has no final project to pick.

---

## If test students keep failing it

If a test student can't produce a boundary claim without a person, or
several students escalate for the same reason, the session didn't land.
That's a curriculum defect (`docs/trunk/TESTING_PHILOSOPHY.md`: a confused
participant is a bug report). Two obligations:

1. **Help the student before Session 2.** Re-run exercise 2 with them on
   a call, on the rows they have, working one row together first.
2. **Log it** in `docs/trunk/FRICTION.md` and in this session's
   [`FLOOR_TEST.md`](FLOOR_TEST.md) results log, with what their answers
   said. Likely causes: the concept track's boundary argument stayed
   abstract, the handout's filled-in rows didn't show how specific a check
   has to be, or the exercise text let "I can't do it" stand for "I can't
   check it".

## What this checkpoint feeds

- **Session 2** uses the student's inventory to pick their first
  delegation, so a student arriving without one has nothing to point the
  agent at.
- **Session 6** gates capstone selection on the inventory, including the
  judgeability column — an entry marked **out** and correctly ruled out is
  treated as demonstrated skill, not a gap
  (`docs/trunk/DECISIONS.md`, DEC-005).
