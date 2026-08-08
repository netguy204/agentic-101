# Session 2 checkpoint

<!-- Chunk: docs/chunks/fluency_session_02 - Session 2 observable checkpoint -->

The observable behavior that tells you Session 2's outcome landed
(`docs/trunk/SPEC.md`, Session Anatomy;
`docs/trunk/TESTING_PHILOSOPHY.md`, In-Session Checkpoints).

---

## The bar

**Every participant leaves the room having:**

1. **Run at least one delegation** in `~/course-practice` — an agent changed
   a real file on a real disk at their instruction. (On a paired laptop
   counts, as long as they were the one typing.)
2. **Said what the agent did by reading its tool calls**, not by repeating
   its summary. "It wrote the file" is a pass. "It cleaned up my statuses" is
   not — that's the paragraph talking.
3. **Named what they checked** to decide whether the result was reasonable,
   and what that check told them. Specific. "The row count was still fifteen
   and I read the status column" passes; "it looked fine" does not.
4. **Used `revert` at least once**, on something they or the agent broke on
   purpose.

All four. The first and fourth are facts you can see; the second and third
are the ones you have to hear, and they are the ones the session is for.
Three delegations without item 3 is a person who has learned to operate
software, which is not what this course is selling.

---

## How to observe it (6 minutes)

Run a round in the last ten minutes. Four short sentences each, going round
the room or down the participant list. Give them the frame and hold it:

> "What you asked for. What tools it used. What you checked. And say the
> words 'I used revert' if you did."

Twelve people, six minutes. Do not discuss, do not improve their answer, do
not let it become a conversation — say "good", note it, move on. If something
is worth picking up, pick it up with that person at the end.

**For a large or remote cohort:** take six spoken answers and collect the
rest as photographs of the worksheet, posted in chat. The worksheet is built
to be the written form of this round — box 1 is item 2, box 3 is item 3 — so
a filled-in sheet is genuine evidence. What doesn't count is assuming.

**Record as you go.** Session 3's opening is planned from this table:

| Participant | Ran a delegation | Read the tool calls | Named a real check | Used revert | Note |
|---|---|---|---|---|---|
| | yes / paired / no | yes / no | yes / vague / no | yes / no | |

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

**The second one is the better answer**, and if you have time for one piece
of commentary in the whole round, make it that one: they caught something a
row count couldn't catch, using knowledge only they had, and they said out
loud that their mechanical checks wouldn't have found it. That is Session 1's
judgment boundary, arriving in their own hands, on their own work. Say so.

## What a near-miss sounds like, and what to say

| They say | What's missing | Say this |
|---|---|---|
| "It standardised all my statuses and tidied the dates." | That's the summary, not the tool calls. **The most common near-miss by far.** | "That's what it told you. What did the boxes say, and what did you look at?" |
| "It looked fine." | No check. | "Fine how? What's the first thing your eye went to?" There is nearly always a real answer one question down. |
| "I checked it against what it said it did." | Circular — the summary checking the summary. | "So you checked the paragraph against the paragraph. What's in the file?" |
| "It used all four tools." | Guessing from the handout rather than reading the screen. | "Scroll up. How many boxes are actually there?" Usually one or two. |
| "I didn't need to revert, mine went fine." | Item 4 missing. | Not a debate — get them to do it, now, in thirty seconds. `commit`, delete a file in the file browser, `revert`. They cannot leave without having done it. |
| "It only used one tool, so I don't think it really did anything." | Reading a short list as a failure. | "One `write` is a whole file created. Short lists are normal — what changed on disk?" |

A near-miss corrected on the spot counts as a pass. The point is the habit,
not the first attempt.

---

## Recovery: someone who can't produce one

Do this **privately, at the end**. There are only four causes and each has a
two-minute fix:

- **Never got a delegation to run** (setup failed and pairing didn't happen,
  or they got stuck in exercise 1). Sit with them, run one delegation on your
  laptop with them typing, and book the setup slot. Do not let them leave
  without having done it once — Session 3 assumes it.
- **Ran it but read only the summary.** Scroll back through their own session
  with them and point at the boxes. One walk-through fixes this permanently;
  it is a perceptual problem, not a conceptual one.
- **No check, because the task was outside their judgment boundary** — they
  picked an entry marked `out`, or one whose column 4 was always vague. This
  is a *good* diagnosis and should be named as one. Pick a different entry
  with them for the practice week.
- **Didn't use `revert`.** Thirty seconds, right there. This is the one with
  no substitute and no excuse; a participant who hasn't felt it will not
  experiment during the practice week, and the practice week is where the
  habit forms.

Note who needed which. Two people with the same cause is a defect in the
material.

---

## If the checkpoint fails across the room

If more than about a third of the cohort can't name a real check, the session
didn't land, and that is a curriculum defect rather than a cohort problem
(`docs/trunk/TESTING_PHILOSOPHY.md`: a confused participant is a bug report).
Two obligations:

1. **Adjust Session 3.** Open it with the worksheets rather than with new
   material — fifteen minutes on "what did yours actually do", using the
   sessions still sitting on people's laptops (`pi -r` finds them). Session 3
   is about writing instructions that survive contact with an agent, and it
   is worthless to someone who can't yet tell what the agent did.
2. **Log it.** Record what the answers sounded like in
   `docs/trunk/FRICTION.md` and in this session's
   [`FLOOR_TEST.md`](FLOOR_TEST.md). The likely causes, in order: triage ran
   long and ate exercise 4; the "boxes versus paragraph" sentence was said
   once instead of three times; or exercise 3's prompts produced material so
   trivial that there was nothing to check.

A different failure shape, worth separating: if most people *did* check but
nobody found anything wrong, that is not a failed checkpoint — it is a run
where the model behaved. Interrogate one agent explanation out loud instead,
and note it in the floor-test log, because a cohort that never sees a wrong
answer arrives at Session 6 over-trusting.

## What this checkpoint feeds

- **Session 3** assumes every participant can run a delegation unaided and
  read what it did. It teaches decomposition on top of that; someone who
  can't yet see the tool calls has nothing to decompose *against*.
- **The practice week** is where the checkpoint's habit either sets or
  doesn't. The table above tells you who to email on Wednesday.
- **Session 6** gates capstones on the participant's judgment boundary. The
  people who said "I couldn't check that one" today are, as in Session 1,
  demonstrating the skill rather than falling short of it
  (`docs/trunk/DECISIONS.md`, DEC-005).
