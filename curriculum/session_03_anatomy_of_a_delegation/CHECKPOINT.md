# Session 3 checkpoint

<!-- Chunk: docs/chunks/fluency_session_03 - Session 3 observable checkpoint -->

The observable behavior that tells you Session 3's outcome landed
(`docs/trunk/SPEC.md`, Session Anatomy;
`docs/trunk/TESTING_PHILOSOPHY.md`, In-Session Checkpoints).

---

## The bar

**Every participant leaves the room having:**

1. **Written a delegation brief** for one of their own inventory entries
   (or a Priya brief) — all four boxes filled: inputs, instruction, outputs,
   checkpoints.
2. **Run it twice**, with one change to the brief between the runs. On disk
   this is `revert --list` showing *before run 1*, *after run 1*, the *Back
   to* line, and *after run 2*. (On a paired laptop counts, as long as they
   were the one whose brief was revised and typed.)
3. **Named the box they changed and why** — in one sentence, written at the
   bottom of the brief. "I added the fact that stale means ten days, because
   it guessed" passes; "I made it clearer" does not.
4. **Written what their checkpoints would have failed to catch** — box 5 —
   and either added a checkpoint that would catch it or written **out**
   beside the task.

All four. The first and second are facts you can see; the third and fourth
are the ones you have to hear, and they are what the session is for. A
brief that ran twice without a named change is a person who has learned to
operate the loop, which is the means and not the end.

**If the second run had to be left for the practice week** (the cutting
rules allow it), items 3 and 4 still apply to the brief *as revised*, and
the tally notes it. Item 2 is then checked on Wednesday by email.

---

## How to observe it (8 minutes)

Run a round in the last twelve minutes. Three short sentences each, going
round the room or down the participant list. Give them the frame and hold
it:

> "Which box you changed, and why. What your check would still miss."

Twelve people, eight minutes. Do not discuss, do not improve their answer,
do not let it become a conversation — say "good", note it, move on. If
something is worth picking up, pick it up with that person at the end.

**For a large or remote cohort:** take six spoken answers and collect the
rest as photographs of the brief, posted in chat. The brief is built to be
the written form of this round — the bottom sentence is item 3, box 5 is
item 4 — so a filled-in brief is genuine evidence. What doesn't count is
assuming.

**Record as you go.** Session 4's opening is planned from this table —
Session 4 opens with the briefs, and you need to know whose ran twice:

| Participant | Brief written | Ran twice | Named the change | Named the miss | Out? | Note |
|---|---|---|---|---|---|---|
| | yes / Priya / no | yes / once — 2nd run in practice / no | yes / vague / no | yes / vague / no | out / check added | |

---

## What a pass sounds like

> "Inputs. I'd told it to chase the stale items and never said what stale
> meant, so it picked ten days and chased four people who were fine. I added
> 'stale means no update in fourteen days' and it chased the right two. What
> it still wouldn't catch: an item whose owner has left — it would chase a
> name that isn't here any more. I added a check: read the owner column
> against the team list."

> "Checkpoints, actually — the run was fine both times. My check was 'count
> the rows', and I realised that would never catch it swapping two people's
> figures. I can't think of a check for that I could actually do on a Monday
> without redoing the whole thing, so I've written *out*. It was a
> forty-minute job; I'll keep doing it by hand."

**The second one is the better answer**, and if you have time for one piece
of commentary in the whole round, make it that one: a task they could run
twice, cleanly, and still correctly decided not to delegate — because they
named the failure no check of theirs would catch. That is Session 1's
judgment boundary, found by experiment, on their own work. Say so.

## What a near-miss sounds like, and what to say

| They say | What's missing | Say this |
|---|---|---|
| "I made the instruction clearer." | Not a box, not a reason. **The most common near-miss.** | "Clearer how? What did the first run do that the second didn't?" |
| "I changed the inputs and the instruction and the checks." | Three changes; no way to know which mattered. | "Which one mattered most? That's your sentence. The other two go on the practice sheet, one at a time." |
| "Nothing let me down — it was fine both times." | No change named. | "Then what did you add to your checkpoints? … Would you have *known* if it hadn't been fine?" If they didn't add a check, they do it now, at the table. |
| "It would fail if it lost a row." (and their checkpoint counts rows) | Box 5 names something the checks already catch. | "Your check counts rows. What's wrong that keeps the count the same?" |
| "I wrote *out* because it's too hard." | *Out* as an exit, not a finding. | "Could anyone in your role check it? If yes, what would they look at — that's your second checkpoint, not an out." |
| "I don't think it needs a second check." | Box 5 empty. | "Name the one thing you'd be most embarrassed to have missed. That's the box." There is always one. |

A near-miss corrected on the spot counts as a pass. The point is the habit,
not the first attempt.

---

## Recovery: someone who can't produce one

Do this **privately, at the end**. There are only four causes and each has a
two-minute fix:

- **No real entry to brief** (thin inventory, or everything confidential).
  They should have been on a Priya brief from exercise 2; if they weren't,
  give them Brief B now and have them run it once at home, revised after
  — the practice sheet's first item covers it. Book a few minutes before
  Session 4 to hear the sentence.
- **The brief never ran twice** (the first run was slow, or they got stuck
  on the `revert`-to-before move). Sit with them, do the `revert` together,
  and let the second run be the practice week's — *with the change already
  written*. The change is the checkpoint; the second run is its test.
- **Can't name a miss.** Ask the embarrassment question ("what would you
  least want to have missed?"). If there is genuinely nothing — rare — their
  checkpoints are complete and that is a pass; write "none found" in box 5
  and move on. If there is something and they can't think of a check, *out*
  is the honest answer and a pass.
- **Changed everything at once.** Have them pick the one change that
  mattered and write only that; the others go on the practice sheet, one
  per run.

Note who needed which. Two people with the same cause is a defect in the
material.

---

## If the checkpoint fails across the room

If more than about a third of the cohort can't name a box and a reason, the
session didn't land, and that is a curriculum defect rather than a cohort
problem (`docs/trunk/TESTING_PHILOSOPHY.md`: a confused participant is a
bug report). Two obligations:

1. **Adjust Session 4.** Open it by re-running the briefs rather than with
   new material: ten minutes on "run your brief once more, change one box,
   say why", before anything about workflows. Session 4 turns a brief into
   a repeatable workflow, and that is worthless to someone who doesn't yet
   own a brief that works.
2. **Log it.** Record what the answers sounded like in
   `docs/trunk/FRICTION.md` and in this session's
   [`FLOOR_TEST.md`](FLOOR_TEST.md). The likely causes, in order: the round
   in exercise 1 was allowed to become discussion and ate exercise 3; the
   "one box, one change" rule was said once instead of three times; or the
   briefs were written so vaguely in exercise 2 that the first run had
   nothing specific to fail against.

A different failure shape, worth separating: if most people's first run was
*fine* and they struggled to find a box, that is not a failed checkpoint —
it is a run where the model behaved. The checkpoints box is the move
("would you have known?"), and box 5 is where that cohort learns the
lesson instead. Note it in the floor-test log; a cohort that never sees a
bad first run arrives at Session 4 over-trusting their briefs.

## What this checkpoint feeds

- **Session 4** assumes every participant owns a brief that has run twice
  and can say why the second run was better. It turns that brief into a
  workflow — the same four boxes, repeated, with the checkpoints where they
  buy the most. The table above tells you whose brief to open the session
  with.
- **The practice week** is where the brief meets the real task. The table
  tells you who to email on Wednesday: anyone whose second run was deferred,
  and anyone who wrote *out* — to check they picked a different entry for
  the week.
- **Session 6** gates capstones on the participant's judgment boundary and
  on the strength of the checkpoints box. The people who wrote *out* today
  are, as in Sessions 1 and 2, demonstrating the skill rather than falling
  short of it (`docs/trunk/DECISIONS.md`, DEC-005).
