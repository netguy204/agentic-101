# Session 2 checkpoint

<!-- Chunk: docs/chunks/fluency_session_02 - Session 2 observable checkpoint -->

The observable behavior that tells you Session 2's outcome landed
(`docs/trunk/SPEC.md`, Session Anatomy;
`docs/trunk/TESTING_PHILOSOPHY.md`, In-Session Checkpoints).

---

## The bar

**Every student submits evidence of having:**

1. **Run at least one delegation** in `~/course-practice` — an agent changed
   a real file on their own machine at their instruction.
2. **Said what the agent did by reading its tool calls**, not by repeating
   its summary. "It wrote the file" is a pass. "It cleaned up my statuses" is
   not — that's the paragraph talking.
3. **Named what they checked** to decide whether the result was reasonable,
   and what that check told them. Specific. "The row count was still fifteen
   and I read the status column" passes; "it looked fine" does not.
4. **Used `revert` at least once** to recover an ordinary local file change
   they or the agent made on purpose. This demonstrates local recovery, not
   broader safety.

All four. The first and fourth are facts you can see; the second and third
are the ones you have to hear or read, and they are the ones the session is
for.
Three delegations without item 3 is a person who has learned to operate
software, which is not what this course is selling.

---

## How it is observed

**On the platform.** The student submits four things: the pi session log
(item 1), the what-did-it-do worksheet (box 1 is item 2, box 3 is item 3),
the output of `revert --list` (item 4), and the files from the practice
folder. Items 1 and 4 are checked mechanically; items 2 and 3 are judged
against the examples below. A near-miss gets the corrective question from
the table below and a second try. After two rounds, or when the judge
isn't confident, the case goes to the instructor.

**In a live session.** Ask for it at the end, in one frame:

> "What you asked for. What tools it used. What you checked. And say the
> words 'I used revert' if you did."

Don't improve their answer before they give it. If it's a near-miss, ask
the corrective question once. With a small group, take one answer from
each person, or have them submit on the platform.

**Record it.** Session 3 starts from this:

| Student | Ran a delegation | Read the tool calls | Named a real check | Used revert | Note |
|---|---|---|---|---|---|
| | yes / no | yes / no | yes / vague / no | yes / no | |

---

## What a pass sounds like

> "I asked it for a list of purchase orders with the supplier names spelled
> inconsistently. It used **write** once. Then I asked it to fix them, and it
> used **write** again — it never re-read the file, which I noticed. I
> checked that there were still fifteen rows and that the two suppliers I
> know by name were still there. They were. And yes, I reverted — it renamed
> my file and I put it back."

> "Mine merged two statuses that mean different things where I work. I only
> caught it because it said so in its explanation, and I know our board.
> Nothing I checked mechanically would have found it. And I reverted twice —
> the first time I picked the wrong checkpoint."

**The second one is the better answer.** If you comment on one thing,
comment on that: they caught something a row count couldn't, using
knowledge only they had, and said that their mechanical checks wouldn't
have found it. That is Session 1's judgment boundary, on their own work.

## What a near-miss sounds like, and what to say

| They say | What's missing | Say this |
|---|---|---|
| "It standardised all my statuses and tidied the dates." | That's the summary, not the tool calls. **The most common near-miss by far.** | "That's what it told you. What did the boxes say, and what did you look at?" |
| "It looked fine." | No check. | "Fine how? What's the first thing your eye went to?" There is nearly always a real answer one question down. |
| "I checked it against what it said it did." | Circular — the summary checking the summary. | "So you checked the paragraph against the paragraph. What's in the file?" |
| "It used all four tools." | Guessing from the handout rather than reading the screen. | "Scroll up. How many boxes are actually there?" Usually one or two. |
| "I didn't need to revert, mine went fine." | Item 4 missing. | "Not a debate — do it now, it takes thirty seconds. `commit`, delete a file in your file browser, `revert`. Then send me `revert --list` again. You cannot finish this session without having done it once." |
| "It only used one tool, so I don't think it really did anything." | Reading a short list as a failure. | "One `write` is a whole file created. Short lists are normal — what changed in the folder?" |

A near-miss corrected on the spot counts as a pass. The point is the habit,
not the first attempt.

---

## Recovery: someone who can't produce one

These are the cases the platform sends to the instructor. Handle them in
the thread, or offer a call. There are four usual causes:

- **Never got a delegation to run** (setup failed, or they got stuck in
  exercise 1). Offer a setup call, then run one delegation with them
  typing and sharing their screen. Session 3 assumes they have done it.
- **Ran it but read only the summary.** Go back through their session
  with them (`pi -r` finds it) and point at the boxes. One walk-through
  usually fixes this; they haven't yet seen the boxes as separate from the
  prose.
- **No check, because the task was outside their judgment boundary.** They
  picked a row marked `out`, or one whose column 4 was always vague. Say
  that this is a good diagnosis, and pick a different row with them for
  the practice week.
- **Didn't use `revert`.** Thirty seconds: `commit`, delete a file in the
  file browser, `revert`, then send `revert --list`. A student who hasn't
  done it won't experiment during the practice week.

Note who needed which. Two students with the same cause is a defect in the
material.

---

## If test students keep failing it

If a test student can't name a real check without a person, or several
students escalate for the same reason, the session didn't land. That's a
curriculum defect (`docs/trunk/TESTING_PHILOSOPHY.md`: a confused
participant is a bug report). Two obligations:

1. **Help the student before Session 3.** On a call, go back through
   their session (`pi -r`) and their worksheet: "what did yours actually
   do?" Session 3 is about writing instructions an agent can follow, and
   it's no use to someone who can't yet tell what the agent did.
2. **Log it** in `docs/trunk/FRICTION.md` and in this session's
   [`FLOOR_TEST.md`](FLOOR_TEST.md), with what their answers said. Likely
   causes: setup problems ate the time for exercise 4; the "boxes versus
   paragraph" point didn't come through in the concept track or the
   exercise text; or exercise 3's file was too trivial to have anything to
   check.

If the student *did* check and found nothing wrong, the checkpoint hasn't
failed; the model behaved. Question one of the agent's judgment calls with
them, and note it in the floor-test log: a student who never sees a wrong
answer reaches Session 6 trusting the agent too much.

## What this checkpoint feeds

- **Session 3** assumes every student can run a delegation unaided and
  read what it did. It teaches decomposition on top of that; someone who
  can't yet see the tool calls has nothing to decompose *against*.
- **The practice week** is where the habit sets. The table above tells you
  whom to check in with mid-week.
- **Session 6** gates capstones on the student's judgment boundary. The
  people who said "I couldn't check that one" today are, as in Session 1,
  demonstrating the skill rather than falling short of it
  (`docs/trunk/DECISIONS.md`, DEC-005).
