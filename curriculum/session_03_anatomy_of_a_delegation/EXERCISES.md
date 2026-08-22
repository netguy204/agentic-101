# Session 3 exercises

<!-- Chunk: docs/chunks/fluency_session_03 - Session 3 in-session exercises (participant) -->

Four exercises, in a fixed order — each one sets up the next. You'll spend
the session on **one** task from your toil inventory: you'll write down, on
one page, what an agent needs to be told to do it; run it; work out which
part of the page let you down; fix that part; and run it again. Everything
happens in **`~/course-practice`**, with `commit` and `revert` around it
exactly as in Session 2.

You'll need:

- Your **worst delegation from the practice week** — the
  `what-did-it-do.md` worksheet you filled in, and your one sentence about
  it.
- Your **toil inventory**, with ticks against the entries you delegated.
- A blank **delegation brief** —
  [`handouts/delegation-brief.md`](handouts/delegation-brief.md), printed.
  You'll fill it in during exercise 2.
- The terminal card from Session 2
  ([`../session_02_meeting_the_harness/handouts/terminal-card.md`](../session_02_meeting_the_harness/handouts/terminal-card.md))
  beside your laptop, as before.
- No usable entry of your own? Use one of **Priya's briefs** in the
  "For Session 3" section of
  [`../session_01_mental_models/handouts/canned-toil.md`](../session_01_mental_models/handouts/canned-toil.md)
  — same exercises, same timing, same result.

What you type, and any file pi reads, is sent to the model provider. As in
Session 2, today's files are made up or describe only the shape of your
work; nothing confidential goes in the folder.

Stuck at any point? Say so — you'll be paired. A pair runs every exercise at
full value; the person without the laptop holds the keyboard.

**Before exercise 1:** in the course terminal, type `course-update` and
press Enter. It fetches any course fixes published since you set up — most
weeks it says *Nothing to do.* If it tells you to close the window and open
a new one, do that before going on.

---

## Exercise 1 — Your worst one

Everybody brought a delegation that went badly. The room goes round once,
one sentence each, and sorts them.

1. Have your worksheet and your sentence in front of you.
2. When it's your turn, say the sentence: what you asked for, and what went
   wrong. One sentence. Don't explain it; don't defend it.
3. As the others go, listen for which of three things happened. Nearly every
   bad delegation is one of them:
   - **It didn't know something.** It needed a file, a fact, a date, a rule
     — and it wasn't there, so it guessed.
   - **It decided something.** It made a choice you didn't ask it to make —
     merged two things that mean different things to you, picked a format,
     filled a gap — and only sometimes mentioned it.
   - **I couldn't tell.** It might have been fine. You had no way of
     knowing, because there was nothing you could actually check.
4. When yours has been said, write which of the three it was at the top of
   your worksheet. If it was genuinely none of them — the task was outside
   what you could judge, and you noticed — write **out of bounds**. That is
   a pass, not a miss.

**What you should see:** one of the three reasons (or *out of bounds*)
written at the top of your worksheet, in your handwriting.

---

## Exercise 2 — Write the brief

A **delegation** is a task handed over with enough structure that it
completes without you standing over it. "Enough structure" is four things,
and the brief has a box for each.

1. **Choose the task.** The entry your worst delegation came from, if it's
   marked **in** and passes Session 2's four questions (you can check it,
   you're allowed to, it isn't a consequential decision, nothing leaves the
   folder without a person approving it). Otherwise another **in** entry
   that passes. Otherwise one of Priya's briefs. Write the entry's name at
   the top of the brief.
2. **Inputs — what must it be able to see?** Name the files it needs, and
   the facts it needs that aren't written down anywhere. Be literal: if the
   file isn't in `~/course-practice` yet, that's fine — you'll make a
   made-up version in exercise 3, so describe its shape here. If your real
   file is confidential, describe the shape and let the agent invent one,
   exactly as in Session 2.
3. **Instruction — what does done right look like?** Copy column 2 of your
   inventory, then make it one sentence the agent can act on: name the
   file and say it's in this folder, name the result, say what it must not
   touch. This is the sentence
   you will type, so write it the way you'd say it.
4. **Outputs — what does done produce, and where?** A file name. A place.
   A shape ("the same rows, tidied"; "a new file called…").
5. **Checkpoints — where will you look, and what for?** Column 4 of your
   inventory, as a step: *I will open ___ and look at ___.* Two is better
   than one. If what you wrote is "I'll read it over", ask yourself what
   you'd be reading *for*, and write that.
6. Leave box 5 and the sentence at the bottom blank. They come later.

**What you should see:** four boxes filled in, none of them saying "see
above", and an instruction you could read aloud in one breath.

**Using a Priya brief?** Copy the four boxes from the canned sheet onto your
brief word for word. Don't improve them yet — one of them is missing
something, and finding out which by running it is the exercise.

---

## Exercise 3 — Run it, read it, fix it, run it again

The loop from Session 2 — `commit` → delegate → check → `commit` — run
twice, with one change to the brief in between.

1. In the course terminal: `cd ~/course-practice`, then `pwd`. It must end
   in `course-practice`.
2. **Get the inputs into the folder.** If your Inputs box names a file that
   isn't there yet, type `pi`, and ask for a made-up version of it — the
   same shape of sentence as Session 2: *"Make a file called `<name>` with
   about 15 rows of made-up data that looks like [your Inputs box]. Include
   the mistakes I usually have to fix. Leave the mistakes in."* (Priya's
   briefs give you this sentence ready-made.) When it stops, `/quit`. If
   the file is already there — `sample.csv` from Session 2, say — skip
   this step.
3. Type `commit` and name the checkpoint **before run 1**. (If it says
   nothing has changed since your last checkpoint, that's fine — the last
   one is your "before".)
4. Type `pi`. Send **the Instruction box, word for word** — plus any fact
   from your Inputs box that isn't in a file, added to the end of the
   sentence. Nothing else. Watch the boxes appear. When it stops, `/quit`.
5. **Read it, in this order.** The tool-call boxes — what did it do? The
   file, in the file browser — what changed? Then apply your Checkpoints
   box, literally: open what you said you'd open, look for what you said
   you'd look for.
6. `commit`, named **after run 1**.
7. **Compare, box by box.** Four questions, and one of them will have a
   bad answer:
   - *Inputs:* did it have what it needed, or did it guess at something?
   - *Instruction:* did it do what you meant, or what you said?
   - *Outputs:* is the thing where you said it would be, shaped how you
     said?
   - *Checkpoints:* did your check catch anything — and could it have?
8. **Change one box.** The one that let you down. Write the change, and
   write *why* in one sentence in the last section of the brief ("Which box
   let me down, and what I changed"). One box, one change. If two things
   went wrong, fix the bigger one; the second run will tell you about the
   other.
9. `revert`, and go back to **before run 1** — read the names, not the
   numbers. This puts the folder back exactly as it was before the first
   run, so the second run starts from the same place.
10. `pi` again. Send the revised instruction (and any input you added). Watch.
    `/quit`.
11. Read it the same way: boxes, file, checkpoints. `commit`, named **after
    run 2**.

**What you should see:** `revert --list` shows, newest first, *after run 2*,
the *Back to* line from step 9, *after run 1*, and *before run 1*; and a
sentence at the bottom of your brief naming the box you changed and why.

**If the first run was perfect** — it happens — your change in step 8 is to
the Checkpoints box anyway: add the check that would have caught the thing
you most expected to go wrong. Then run again. A second run that is *also*
fine, with a better check, is a pass.

**If the agent asks you a question instead of doing it,** answer it in the
box and press Enter — then, when you get to step 7, notice that what it
asked for was a missing input.

**If it sits for more than a minute with nothing new appearing,** press
Escape, then `/quit`, and read the boxes anyway. In the dry run, a brief
that named a file without saying where it was sent the agent searching the
whole computer for it. That is *it didn't know something*, arriving as a
stall instead of a guess — the missing input is where the file is, and
"in this folder" is the change.

**In a pair?** One laptop, two briefs, one run each — then swap whose brief
is revised and run second. Both of you need to have changed a box for a
reason you can say.

---

## Exercise 4 — What would I have failed to catch?

The last box, and the question that decides whether this task is one you
should be delegating at all.

1. Look at your Checkpoints box, and at what actually happened in the two
   runs.
2. Name one thing that could go wrong with this task that your checkpoints
   would **not** catch. Think about the second reason from exercise 1 — *it
   decided something*: two labels it might merge that mean different things
   to you; a number that could be plausible and wrong; something that could
   be missing without you noticing its absence. Write it in box 5.
3. Then do one of two things:
   - **Add a checkpoint that would catch it** — a second line in box 4, as
     concrete as the first. *I will open ___ and look at ___.*
   - **Or write "out" beside the task.** If you can't think of a check you
     could actually do, this task sits outside your judgment boundary for
     now, and you've just found that out for the price of two runs in a
     practice folder instead of once a week for real. That is a result, and
     in Session 6 it counts as the skill, not a shortfall.

**What you should see:** box 5 filled in, and either a second checkpoint in
box 4 or the word **out** beside the task.

---

## Wrapping up

One question, hands up: **who has a brief that ran twice, and can say in one
sentence why the second run was better?** That sentence — the one at the
bottom of your brief — is what you'll be asked for in the checkpoint round.
