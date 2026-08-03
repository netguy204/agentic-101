# Session 1 checkpoint

<!-- Chunk: docs/chunks/fluency_session_01 - Session 1 observable checkpoint -->

The observable behavior that tells you Session 1's outcome landed
(`docs/trunk/SPEC.md`, Session Anatomy;
`docs/trunk/TESTING_PHILOSOPHY.md`, In-Session Checkpoints).

---

## The bar

**Every participant leaves the room with:**

1. A toil inventory containing **at least three entries**, each annotated
   with judgeability — in, out, or not sure — and
2. the ability to **say out loud, for one of their own tasks, why it sits
   inside or outside their judgment boundary**, naming the check they
   would use (or naming why no check is available to them).

Both halves are required. Three filled rows without the spoken articulation
is a filled-in form; the articulation without the rows is a nice
conversation. The session's outcome is the pair.

---

## How to observe it (7 minutes)

Run a round in the last ten minutes. One sentence each, going round the
room or down the participant list. Give them the frame and stick to it:

> "One task from your sheet. In or out. And the check — how you'd know if
> it was wrong."

That's it. Three sentences per person, twelve people, seven minutes. Do
not discuss, do not improve their answer, do not let it become a
conversation — say "good", note it, and move to the next person. If
something is worth picking up, pick it up with that person afterwards.

**For a large or remote cohort:** sample six spoken answers out loud and
collect the rest in writing — chat message, photo of the sheet, or a
one-line email that evening. Written counts. What doesn't count is
assuming.

**Record as you go.** You need this for Session 2 and again for Session 6:

| Participant | ≥3 annotated entries | Spoken articulation | Note |
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

The second one is a *better* answer than the first, and if you have time
for one piece of commentary in the whole round, that's the one to make:
knowing where your judgment runs out is the skill, and saying it in front
of the cohort is worth more than any confident **in**.

## What a near-miss sounds like, and what to say

| They say | What's missing | Say this |
|---|---|---|
| "It's in because I do it every week." | Frequency isn't judgeability. | "How often has nothing to do with it. If I handed you a finished one — how would you know it was wrong?" |
| "It's out because I couldn't do it myself." | Expertise confused with judgment. **The most common near-miss by far.** | "You don't need to be able to do it. Could you tell if it was wrong? … Then it's in." |
| "I'd just read it over and I'd know." | The check isn't concrete. | "Reading it for *what*? What's the thing you'd notice?" There is almost always a real answer one question down. |
| "It's in because the agent could definitely do it." | Judging the agent, not their own judgment. | "That's a question about the tool. Mine's about you: could *you* tell?" |
| "It's in, but I'd have to check every line." | Actually a fine answer — that's a real check. | Accept it, and flag it as interesting: "That's a genuine check, and it's an expensive one. Hold that thought — Session 4 is about exactly that." |

A near-miss corrected on the spot counts as a pass. The point is the
distinction, not the first attempt.

## Recovery: someone who can't produce one

Do this **privately, at the end**, never in front of the room. Someone who
can't articulate a boundary claim is usually not confused about the
concept — they're stuck on the sheet, and there are only three causes:

- **No entries yet** (blank-page freeze, or the work genuinely doesn't feel
  repetitive). Hand them [`handouts/canned-toil.md`](handouts/canned-toil.md)
  and do one row with them out loud, right there. Two minutes. Then ask
  them to do the daily pass in [`PRACTICE.md`](PRACTICE.md) and send you
  three entries by Friday.
- **Entries but no checks.** Ask "what would you actually look at?" on one
  entry until it's concrete. One worked example almost always unblocks the
  rest.
- **Everything marked out.** Usually the expertise/judgment confusion, and
  usually in a participant who's new to their role or is being modest.
  Walk one of their **out** entries back: "if I handed you this finished,
  would you spot a missing region?" Yes. Then it's in.

Book the Friday follow-up and actually check it. This is the cheapest
intervention in the whole course — a participant who reaches Session 6
without an inventory has no capstone to pick.

---

## If the checkpoint fails across the room

If more than about a third of the cohort can't produce a boundary claim,
the session didn't land, and that's a curriculum defect rather than a
cohort problem (`docs/trunk/TESTING_PHILOSOPHY.md`: a confused participant
is a bug report). Two obligations:

1. **Adjust Session 2.** Open it with a ten-minute inventory clinic —
   re-run exercise 2 on the entries people brought, using the live-worked
   example. Session 2's own material is short enough at the top to absorb
   it, and the inventory is a prerequisite for everything downstream.
2. **Log it.** Record what the answers sounded like in
   `docs/trunk/FRICTION.md` and in this session's
   [`FLOOR_TEST.md`](FLOOR_TEST.md) results log. The most likely causes,
   in order: the demo reveal didn't land (so the boundary stayed
   abstract), exercise 2 got squeezed for time, or the live-worked example
   was skipped. All three are fixable in the guide.

## What this checkpoint feeds

- **Session 2** uses each participant's inventory to pick their first
  delegation, so a participant arriving without one has nothing to point
  the agent at.
- **Session 6** gates capstone selection on the inventory, including the
  judgeability column — an entry marked **out** and correctly ruled out is
  treated as demonstrated skill, not a gap
  (`docs/trunk/DECISIONS.md`, DEC-005).
