# Session 2 exercise runsheet

<!-- Chunk: docs/chunks/fluency_session_02 - Session 2 in-session exercises -->
<!-- Chunk: docs/chunks/fluency_exercise_split - Exercise material split by reader: this file is for the facilitator -->

What to say, what to look for and what to do when an exercise goes wrong,
whether you are running it live with a student or answering a thread about
it. The student's steps are in [`EXERCISES.md`](EXERCISES.md); this file
doesn't repeat them.

Five exercises, about 65 minutes for a student working alone. Each one sets
up the next, so they run in order. If time is short in a live session,
shorten an exercise; don't skip one.

**Two paths (DEC-016).** Most students work on their agent page: the
agent's folder is "Your files", each tool call appears as a step (Read,
Wrote, Changed, Ran a command), and the undo is "Undo the last request" or
"Earlier versions". A student who runs pi on their own computer follows the
local box in each exercise and works on named files in
**`~/course-practice`**. Either way, the folder keeps changes visible and
recoverable; it isn't a security boundary.

A local student keeps [`handouts/terminal-card.md`](handouts/terminal-card.md)
open. Every student fills in [`handouts/what-did-it-do.md`](handouts/what-did-it-do.md)
in exercise 4, and works from the row they starred in the prework. A
student without a usable row picks one of the prepared tasks in the "For
Session 2" section of
[`../session_01_mental_models/handouts/canned-toil.md`](../session_01_mental_models/handouts/canned-toil.md).

**Tell the student at the start of a live session:** these exercises
change files in one practice folder, and by the end of exercise 2 they'll
know how to get ordinary changes back. That is file recovery; it doesn't
undo anything sent or done outside the folder. What they type, and any
file the agent reads, goes to the model provider.

**Local path, before exercise 1: `course-update`.** It installs any fix published
since setup. Most weeks it prints *Nothing to do*. If it says to close and
reopen the window, do that before exercise 1. With no internet it says so
and changes nothing; carry on.

---

## Exercise 1 — Where am I? (about 10 minutes)

**On the agent page.** The student finds the request box, "Your files",
"Earlier versions" and "Undo the last request", and asks the agent what's
in its folder without changing anything. They should see a Read step and
nothing else. Say: "Everything it makes or changes appears under Your
files, and every step it takes appears here as it works."

**Local path.** Opens the course terminal, moves to the practice folder,
and checks that the terminal and the file browser show the same folder.

**Say it like this.** "Three commands: `pwd` is *where am I*, `ls` is
*what's here*, `cd` is *go there*. And that window and this window are the
same folder. The terminal is the same files, reached by typing instead of
clicking."

**And this:** "Nothing happens until you press Enter. If you type
something and nothing happens, you probably didn't press Enter."

**Done when:** on the agent page, they know where those four things are;
locally, the terminal shows a path ending in `course-practice`, and a
file-browser window is open on the same folder.

**If the student is stuck (local path):**

| What you see | What it is | What to do |
|---|---|---|
| Nothing happened when they typed | They didn't press Enter | Press Enter. |
| `cd: …/course-practice: No such file or directory` | Setup didn't finish | Run `course-smoke-test` and send the instructor everything it prints. Don't try to fix it in the session. |
| A wall of red text | Almost always a typo | `cd ~`, then retype. Don't debug the typo. |

**Don't let them skip `open .` / `explorer .`.** Seeing the same folder in
both windows is what makes the terminal stop feeling like a separate,
dangerous computer.

**Common misfire.** Typing the `$` from the examples. The `$` is already on
screen; it means the terminal is ready.

---

## Exercise 2 — The safety net (about 15 minutes)

Nobody gives the agent real work until this exercise is done.

**On the agent page.** The student asks for `notes.txt`, undoes it with
"Undo the last request", asks again, asks the agent to delete it, then goes
back with "Earlier versions" to the version from the request that made it.
Say afterwards: "Undo the last request takes back the agent's last request.
Earlier versions takes every file back to any earlier point, and you can
come forward again. Neither recalls what was sent to the model provider."
Misfires: going back to the wrong entry (open the list again; nothing is
lost), and undoing a request that changed no file (nothing to undo).

**Local path.** pi has no general undo, so the student makes a file, saves
a checkpoint, deletes the file on purpose, and gets it back. The `revert`
answers (Enter, Enter, the number next to "before anything", `yes`) are the
table in the exercise's local box.

**In a live session, warn them before `revert`:** "It's going to ask four
questions, one at a time. The first starts with the word *Wait* and gives
three numbered choices. Press Enter. That's it being careful."

**Afterwards, say it like this.** "You deleted a file on purpose and got
it back. `commit` saves a snapshot of this folder. `revert` puts the
folder back to one. It can't recall a sent message, undo anything outside
this folder, or pull back what went to the model provider."

**Done when:** `notes.txt` is back with the student's line in it. This has
no substitute: a student who has only read that the undo works won't let
the agent do anything interesting in exercise 5.

**First misfire: not really deleting the file.** Deleting feels wasteful.
The exercise is getting it back, and skipping the deletion skips that.

**Second misfire: reading `revert`'s questions as an error.** The first
thing it says is "Wait —". It's asking, and Enter is the right answer.

**Third misfire, and it catches nearly everyone: typing `1`.** The
checkpoint they want is number **2**, because `revert` saved their deletion
as a new number 1 on the way past. Getting it wrong costs nothing: run
`revert` again and pick the other number. Say why, because the same thing
happens in exercise 5 with a longer list: **read the names, not the
numbers.**

**If `revert` says there are no checkpoints.** The `commit` didn't finish,
usually because the first question was answered `no`. Run `commit` again,
answer `yes`, carry on.

**Two people, one practice folder.** Each does the exercise once. After
the first person restores `notes.txt`, the second changes or deletes it
and runs `commit` and `revert` themselves. Both need to have done it.

---

## Exercise 3 — Your first delegation (about 15 minutes)

**What the student does.** Asks the agent (on the agent page, or pi in
the practice folder) to make a messy file shaped like the input to their
starred row. Exercise 4
works on that file. The prompt is at step 2.

**In a live session, work the prompt with them before they send it.** The
gaps are "what your data looks like" and "the mess in it". People fill the
first with a task when it needs a thing: "a list of tickets with the
priorities written four different ways", not "sort my ticket queue".

**Afterwards, say it like this.** "You didn't open a spreadsheet or type
fifteen rows. You described what you wanted, and it made it. The rest of
the course is about pointing it at work that matters and knowing whether
it got it right."

**And this:** "What you typed went to the model provider, and so would any
file the agent reads. You described only the shape of your work, so
everything in the file is made up."

**Done when:** `sample.csv` is in the folder and the student didn't type it
(locally, there's also a checkpoint named "the messy sample"). Have them
open it, from "Your files" or the file browser; seeing a real file they
didn't make is the point.

**First misfire: describing the task instead of the material.** They get
an empty file or an explanation. Ask: "What does the file look like
*before* you fix it?" Column 1 of the sheet usually says.

**Second misfire: thinking it has frozen.** Agents pause. Wait a minute
before choosing "Stop" (or pressing Escape in pi).

**If the agent asks a question.** Answer it in the request box and send it. It
knew it didn't know; it won't always.

**Prepared task.** The student uses the ready-made prompt for the option
they chose in the canned sheet's "For Session 2" section. Same exercise,
same time.

---

## Exercise 4 — What did it actually do? (about 15 minutes)

The session's content. In a live session, give it the time and take it
from exercise 3 if you have to.

**What the student does.** Delegates the real task, then works out what
happened from the tool calls and the file, and decides whether it was
right. The prompt is at step 2; the worksheet boxes are at step 4.

**Say it like this.** "The agent wrote you a paragraph explaining what it
did. That paragraph describes what it meant to do; you care about what it
did. The tool calls are what it did. The file is what happened. Read those
two, in that order, then use your own check."

**Point back at Session 1.** "Column 2 of your sheet became the
instruction. Column 4 became the check. You wrote both before you'd seen
this software."

**Done when:** box 3 names a specific thing the student looked at and what
it told them. "It looked fine" is an empty box.

**First misfire, and nearly everyone makes it: the summary as the check.**
Box 3 says "it said it standardised the department names". Ask: *"That's
what it told you. What did you look at?"*

**Second misfire: box 1 from memory.** A box 1 that says "it fixed the
file" is a summary. Have them scroll up; each step on screen is labelled
with what it did (Read, Wrote, Changed, Ran a command; locally, the pi
tool names read, write, edit, bash). One or two boxes is normal, and noticing it rewrote the
file without reading it first is a good observation.

**When the agent got it wrong.** A good result. Ask what they looked at
that showed them. That's box 3, and it's a better answer than a run that
went perfectly.

**When nothing went wrong.** Read the agent's explanation with them and
question one judgment call in it. In the dry runs it merged `Complete`
into `Done` both times, which loses a distinction at some companies.

**Prepared task.** The student applies the check printed under their
option, from the file evidence.

**Finished early?** Ask: "What would your check have missed?" That
question opens Session 3.

---

## Exercise 5 — Break it on purpose (about 8 minutes, plus 2 to wrap)

**What the student does.** Tells the agent to ruin `sample.csv`, watches
it comply, and goes back to the cleaned-up version: on the agent page, the
"Earlier versions" entry from the exercise 4 request; locally, `revert` to
"cleaned up". The prompt is sent exactly as written.

**Afterwards, say it like this.** "You got back a deliberately ruined file
in under a minute, and you know it works because you did it. It doesn't
undo messages, data sent out, or anything outside the folder, so real work
still needs authorization, the right task, and a person approving anything
external."

**Done when:** the folder shows `sample.csv` and no `disaster.csv`, and the
file has the cleaned-up data.

**Why this prompt and not "delete everything".** Locally, the checkpoints
live in a hidden folder inside `~/course-practice`. A prompt broad enough to delete
everything can delete those too, and then there's nothing to revert to.
This prompt names the file it ruins. Don't let a student make it more
dramatic; if they ask, tell them why. Bounding what an agent can touch is
Session 4.

**Common misfire: going back to the messy sample.** Exercise 4's work
seems lost. On the agent page, open "Earlier versions" again and pick the
entry from the cleanup request; locally, run `revert` again and pick
"cleaned up". Going back can itself be undone.

**If the agent refuses or asks if they're sure.** Tell it yes, or "do it
anyway". Locally, if it still won't, delete `sample.csv` in the file
browser and revert from there. The exercise is the undo. Don't present the refusal
as a safety feature.

---

## Wrapping up

The student opens "Your files" (or `~/course-practice`) and finds a
`sample.csv` with sensible data they didn't type. That's the session's outcome. A student
who can't get there is a case for the Recovery section of
[`CHECKPOINT.md`](CHECKPOINT.md).
