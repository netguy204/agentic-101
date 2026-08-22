# Session 3 exercise runsheet

<!-- Chunk: docs/chunks/fluency_session_03 - Session 3 in-session exercises (facilitator) -->

The facilitator's running order for the exercise block. Participants work
from [`EXERCISES.md`](EXERCISES.md); this file never restates a step — it
says what to say, what to watch for, and what to do when it goes wrong.
Where it mentions an exercise or a step, the text is in `EXERCISES.md`.

Four exercises, 58 minutes of the session, in a fixed order. Exercise 1 is
the opening of the session (there is no separate cold open — the round *is*
the open), exercise 3 is the long one, and exercise 4 is the payload. Cut
*within* exercise 3 if you run short; never drop exercise 1 or 4.

Participants work on one printed
[`handouts/delegation-brief.md`](handouts/delegation-brief.md) each (print
two per person — the second is for the practice week), with Session 2's
terminal card beside them and their practice-week worksheet and toil
inventory in hand. Anyone without a usable entry uses Priya's briefs in the
"For Session 3" section of
[`../session_01_mental_models/handouts/canned-toil.md`](../session_01_mental_models/handouts/canned-toil.md)
— print that too.

**Before anything — `course-update`.** Run it on the projector first, then
have everyone run it. Most weeks it prints *Nothing to do* in a few
seconds; if it says to close and reopen the window, wait for the room to do
that. If the room has no internet it says so in one line and changes
nothing — carry on. Hands up for "Nothing to do"; anyone whose terminal
won't cooperate gets a neighbour now, not later, and the person without the
laptop types.

**Before starting, say this out loud:** today's tasks, like Session 2's,
edit made-up files in one practice folder, and `commit`/`revert` recover
those edits — local file recovery, not a security boundary or permission to
act outside the folder. What participants type and any file pi reads is sent
to the model provider, so real confidential material stays out of the
folder and the brief describes its *shape*.

---

## Exercise 1 — Your worst one (12 minutes)

**What participants do.** Each says one sentence about the practice-week
delegation that went worst; you sort the sentences live into three reasons;
they write their reason on their worksheet. Steps: `EXERCISES.md`,
exercise 1.

**Before the round, write the three reasons on the board and leave them
there all session:**

> **It didn't know something.** · **It decided something.** · **I couldn't
> tell.**

**Say it like this.** "Everybody brought one that went badly. That's the
best material this course has ever had in a room, and we're going to use it
before I teach you anything. One sentence each: what you asked for, what
went wrong. I'm going to put a mark under one of these three every time,
and by the end you'll see why there are only three."

**Run the round fast.** Twelve people, a sentence each, a tally mark each —
under eight minutes. Do not discuss, do not fix, do not let anyone explain.
After each sentence, name the bucket out loud in four words ("that's *it
decided something*") and move on. If you can't place one, ask one question
— "what would you have needed to know to catch it?" — and place it on the
answer.

**Worked placements, from the dry run and Session 2:**

| They say | Bucket | Why |
|---|---|---|
| "It merged *Complete* into *Done* and they're different where I work." | It decided something | A choice it made and announced; the instruction didn't forbid it. |
| "It chased items that weren't stale — it guessed what stale meant." | It didn't know something | A missing fact (the threshold, today's date). In the dry run it picked its own — "roughly two weeks, measured from the newest date in the file" — and said so. |
| "It just sat there. I waited five minutes." | It didn't know something | Usually where the file is: the dry run saw a whole-disk search for a file named without a folder. A stall, not a guess. |
| "It looked fine, and then my colleague found two rows were gone." | I couldn't tell | No checkpoint that would have counted the rows. |
| "It asked me three questions and I gave up." | It didn't know something | The questions *were* the missing inputs. |
| "It did it perfectly but I have no idea if the numbers are right." | I couldn't tell — or out of bounds | Ask: could *anyone* in your role check it? If not, out of bounds, and that's a pass. |

**The fourth bucket.** Some sentences are "the task was outside what I
could judge, and I noticed." Write **out of bounds** to one side and put the
mark there. Say, the first time it happens: "that one's a pass — you found
the edge of your boundary in a practice folder instead of in front of a
customer."

**Observable output.** A tally on the board with marks under at least two of
the three reasons, and every worksheet in the room with a reason written at
the top.

**If someone stalls.** They didn't do the practice, or all three of theirs
went fine. Either way: "Pick the one where it made a decision you hadn't
asked for. There'll be one." If there genuinely isn't, they sit this round
out and sort along with you — they'll meet their near-miss in exercise 3.

**Fallback.** A participant with no delegation from the week at all gets
Priya's Brief B in exercise 2 — it is built to go wrong in the first run,
so they will have a sentence by exercise 4.

**Most common misfire.** Turning the sentence into a story. Hold the frame:
"one sentence — what you asked, what went wrong. Good. Next." The round's
value is its speed and the tally, not any one story.

**The second misfire — yours.** Teaching the three reasons *before* the
round so people classify themselves. Don't. Say the three words, run the
round, and let the tally do the teaching; the anatomy beat afterwards is
where you explain.

---

## Exercise 2 — Write the brief (12 minutes)

**What participants do.** Fill in the four boxes of a delegation brief for
one real inventory entry (or a Priya brief). Steps: `EXERCISES.md`,
exercise 2.

**Work one live before they start.** Two minutes, on the board, with the
brief's four boxes drawn up: Priya's Monday roll-up (canned-toil task 1,
Brief A). Fill Inputs ("three tracker files — and the fact that 'last week'
means the seven days before Monday"), Instruction (read it aloud from the
canned sheet), Outputs ("`monday-summary.md`"), Checkpoints ("open it,
count per group against the dates in each tracker, spot-check two owners").
Then point at the board: "this is what a colleague who can't see your
screen needs. Everything else they'll guess."

**Say it like this.** "Two of these boxes you've already written — column 2
is your instruction, column 4 is your checkpoints. You wrote them weeks ago
and they worked in Session 2. The two new boxes are the ones that were
missing when it went wrong: what it had to be able to *see*, and what
*done* actually produces. Write all four. If one of them says 'see above',
it isn't written."

**Observable output.** Every brief has four boxes filled; the Instruction
box reads as one sentence someone could type.

**If someone stalls.** Nearly always on Inputs — "it just needs the file".
Ask: "and what do you know about this task that the file doesn't say?" The
answer is the missing fact (what counts as late, which two labels differ,
what today is). Write that in.

**Fallback.** Priya's briefs are copied word for word — including the one
that's wrong. Don't let a canned-set participant fix it in exercise 2; the
fix is exercise 3's job.

**Most common misfire.** Column 2 copied verbatim as the Instruction with
no file name and no result — "clean up the tracker". Ask: "which file? what
does clean mean, in one sentence?" The instruction must name the file and
the result.

**The second misfire.** Checkpoints that say "I'll read it over." Same fix
as Session 1: "what would you be reading *for*?" — and write that.

---

## Exercise 3 — Run it, read it, fix it, run it again (24 minutes)

**What participants do.** Get the inputs into the folder, `commit`, run the
instruction, read boxes → file → checkpoint, `commit`, find the box that
let them down, change it once for a named reason, `revert` to before,
run again, `commit`. Steps: `EXERCISES.md`, exercise 3 — the revert-to-
before move is step 9 and the change is step 8.

**Work the `revert`-to-before move on the projector before they start.**
One minute. Show `revert --list` with *before run 1* and *after run 1* on
it, and say: "the second run has to start from the same place as the first,
so we go *back* to before run 1 — by name — and run again. That's what the
checkpoints are for." This is the one new mechanical move today and the
room should see it before doing it.

**Say this before they type step 4:** "What you send is the Instruction box
— word for word — plus any fact from Inputs that isn't in a file. Nothing
else. No preamble, no 'please', no extra explanation. If it needs more than
that, that's what you'll find out."

**Say it like this, after the first runs come back.** "Something let you
down, and it was one of four boxes. Not the agent — a box. Find the box.
Change it once. Say why. Then run it again and see if you were right. That
loop — brief, run, read, change one thing, run — is the whole skill, and
you'll do it every week for the rest of the course."

**Observable output.** `revert --list` on every machine shows the four
named checkpoints (after run 2 / Back to / after run 1 / before run 1), and
every brief has a sentence in "Which box let me down, and what I changed."

**Most common misfire.** Changing two or three boxes at once. Hold the
line: "one box. If it's still wrong, the second run tells you about the
next one. Change three things and you'll never know which one mattered."

**The second misfire.** The agent gets it right despite a bad brief. This
is the hardest case to teach from, and it will happen to a third of the
room. Do not let them write "nothing let me down." Send them to the
Checkpoints box: "it worked — would you have *known* if it hadn't? Add the
check that would have caught the thing you most expected to go wrong, and
run again." A second clean run with a better check is a pass.

**The third misfire.** Reading "it decided something" as the agent's fault
and writing a brief that says "don't make any decisions." Say it to the
room: "it will always make small calls. The brief's job is to name the ones
that matter to you — 'treat Done and Complete as different' — and the
checkpoints' job is to catch the ones you didn't think to name."

**If `revert` in step 9 goes to the wrong checkpoint** — usually *after
run 1* instead of *before run 1* — it's undoable: `revert` again, read the
names. Same rule as Session 2.

**If the first run takes more than a minute.** Twenty to thirty seconds is
normal for the Priya briefs on the course model (dry run). A genuine stall
happened three times out of three in the dry run when a brief named
`tracker.csv` without saying where it was: the agent's one tool call was a
search of the whole disk for the file, which never returns. After a minute:
Escape, `/quit`, read the one box — "it went looking for the file" — and
that is *it didn't know something* as a stall rather than a guess. The
change is "in this folder" in the instruction. Priya's briefs now say it;
real briefs written in exercise 2 may not.

**Fallback.** Pairs: one laptop, two briefs, one run each, then swap whose
brief is revised for the second run. Both people must have changed a box
and said why. A canned-set participant on Brief B will find the missing
input (what "stale" means) in the first run; on Brief C the first run is
usually fine and the trouble is in exercise 4.

**Remote delivery.** Screen-share from one volunteer for the
`revert`-to-before move; pairs are breakout rooms of two with the driver
dictating.

---

## Exercise 4 — What would I have failed to catch? (10 minutes)

**What participants do.** Name one failure their checkpoints would not
detect; add a second checkpoint that would, or rule the task **out**.
Steps: `EXERCISES.md`, exercise 4.

**Say it like this, and it is the sentence the session exists for.** "Your
checkpoints caught what you told them to catch. Now name the thing they
*wouldn't*. If you can think of a check for it — write it in, you now have a
better brief than you walked in with. If you can't — write *out* next to
the task. That isn't failure. That's the judgment boundary from Session 1,
found by you, for two runs in a practice folder instead of once a week for
real. In Session 6 that word counts as the skill."

**Point back at the board.** The tally under *it decided something* is
where most of these live: "the decisions you didn't ask it to make are the
ones your checkpoints don't look for. Which one would hurt you?"

**Observable output.** Box 5 filled on every brief; box 4 has a second line
or the word **out** sits beside the task.

**Most common misfire.** Writing something the checkpoints *would* catch
("it might lose a row" when the checkpoint counts rows). Ask: "your check
counts rows. What's wrong that keeps the count the same?" The answer is
nearly always a swapped or merged value.

**The second misfire.** Writing **out** as an escape from the work. It
isn't; the question is "could *anyone* in your role check this?" If yes,
it's a missing checkpoint, not an out. Say: "out means nobody with your
knowledge could tell. Is that true here?"

**If someone finishes early.** "Write box 5 for the Priya brief you didn't
choose." Brief C's checkpoint is "I'd look it over" — it's the one to think
hardest about, and a fast participant will enjoy taking it apart.

**Fallback.** Canned-set participants answer for the brief they ran. Brief
C exists for this exercise: its checkpoint is vague on purpose.

---

## Wrapping the block (2 minutes)

Before the checkpoint round, one question to the room, hands up: **who has a
brief that ran twice and can say in one sentence why the second run was
better?** That's the session's outcome in one show of hands — and the
sentence is what the round asks for. See [`CHECKPOINT.md`](CHECKPOINT.md).
