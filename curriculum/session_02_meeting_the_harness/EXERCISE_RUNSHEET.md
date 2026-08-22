# Session 2 exercise runsheet

<!-- Chunk: docs/chunks/fluency_session_02 - Session 2 in-session exercises -->
<!-- Chunk: docs/chunks/fluency_exercise_split - Exercise material split by reader: this file is for the facilitator -->

The facilitator's running order for the exercise block. Participants work
from [`EXERCISES.md`](EXERCISES.md); this file never restates a step — it
says what to say, what to watch for, and what to do when it goes wrong.
Where it mentions an exercise or a step, the text is in `EXERCISES.md`.

Five exercises, 59 minutes of the session, in a fixed order. Each one is a
prerequisite for the next, so they are not a menu — if you run short, cut
*within* an exercise rather than dropping one.

Every written exercise targets named files in **`~/course-practice`**, the
folder the setup guide made. This keeps the work visible and locally
recoverable; it does not make the folder a security boundary.

Participants work from
[`handouts/terminal-card.md`](handouts/terminal-card.md) (the commands, on
one printable page) and fill in
[`handouts/what-did-it-do.md`](handouts/what-did-it-do.md) during exercise 4
— print both (see [`FACILITATOR_GUIDE.md`](FACILITATOR_GUIDE.md), "Before
the room"). They also need their toil inventory from Session 1
([`../session_01_mental_models/handouts/toil-inventory.md`](../session_01_mental_models/handouts/toil-inventory.md));
anyone without a usable entry chooses a neutral synthetic task from the
Session 2 section of
[`../session_01_mental_models/handouts/canned-toil.md`](../session_01_mental_models/handouts/canned-toil.md).

**Before starting, say this out loud:** today's written tasks edit local files
in one practice folder, and by the end of the second exercise you will know
how to recover ordinary changes to those files. This is local file recovery,
not a security boundary or permission to take external actions. Also state
that what participants type and any file pi reads is sent to the model
provider. Say both before anyone touches a keyboard.

---

## Exercise 1 — Where am I? (11 minutes)

**What participants do.** Open the course terminal and find their way to the
practice folder, checking at each step that the terminal and the file browser
agree about where they are. Steps: `EXERCISES.md`, exercise 1.

**Say it like this.** "Three commands, and they are the only three you need
to never be lost: `pwd` is *where am I*, `ls` is *what's here*, `cd` is *go
there*. That's it. Everything else today, the agent does for you. And notice
what just happened with `open .` — that window and this window are the same
folder. The terminal isn't a different computer. It's the same files, reached
by typing instead of clicking."

**Then the reassurance, and don't skip it:** "The cursor blinking at you is
not waiting for permission and it is not judging you. It's waiting. Nothing
happens until you press Enter. If you type something and nothing happens, you
almost certainly forgot to press Enter — that is the most common thing in
this room today, and it happens to everybody."

**Observable output.** Every participant's terminal shows a path ending in
`course-practice`, and they have a file-browser window open on the same
folder.

**If someone stalls.** Three causes, in order of likelihood:

| What you see | What it is | Fix |
|---|---|---|
| Nothing happened when they typed | They didn't press Enter | Point at the Enter key. Don't explain. |
| `bash: cd: /Users/…/course-practice: No such file or directory` | Setup didn't finish | Pair them (see the triage plan in [`FACILITATOR_GUIDE.md`](FACILITATOR_GUIDE.md)); don't fix it now |
| A wall of red text | Almost always a typo | `cd ~` to get home, then retype. Never debug the typo — retype it. |

**Fallback.** A participant with no working terminal pairs with a neighbour
and drives — they type, the neighbour's laptop runs it. Pairs run every
exercise today at full value; the person without the laptop should be the one
holding the keyboard.

**Most common misfire.** Typing the `$` from the examples. Say once, up
front: "the `$` is already on your screen; it's the terminal saying it's
ready. You never type it."

---

## Exercise 2 — The safety net (14 minutes)

The most important fourteen minutes of the session. **Nobody runs an agent
until this exercise is finished by everyone in the room**, including the
pairs. pi has no general undo button; this is recovery for ordinary local
file changes in the checkpointed folder.

**What participants do.** Make a file, save a checkpoint, destroy the file on
purpose, and get it back. Steps: `EXERCISES.md`, exercise 2 — the `revert`
answers (Enter, Enter, `2`, `yes`) are the table at step 6.

**Say it like this — and say the last two sentences slowly.** "You just
deleted a local file on purpose and got it back. That lets us recover the
ordinary file edits in today's bounded exercises. `commit` means *save a
snapshot of this folder as it is right now*. `revert` means *put this folder
back to one of those snapshots*. It cannot recall a sent message, undo an
external action, or protect data sent to the model provider."

**Work the first `commit` on the projector before they start.** Two minutes.
Run it on your own machine, out loud, so the room has seen the questions
before they meet them. The `commit` walkthrough asks things nobody has been
asked by a computer before ("This folder is not saving checkpoints yet —
turn them on?") and the first encounter should not be alone.

**Observable output.** Every participant has run `revert` and watched a file
they deleted reappear. This is the one thing in the session with no
substitute — a participant who has only *heard* that revert works will not
let the agent do anything interesting in exercise 5.

**Most common misfire.** Skipping step 5 because deleting the file feels
wasteful. Push: "delete it properly. The exercise is the getting it back, and
you don't get the feeling from watching someone else." Nobody who skipped the
deletion trusts the net afterwards.

**The second misfire.** Reading `revert`'s questions as an error message.
Anything unexpected on a terminal reads as failure to a new user, and the
first thing `revert` says is the word "Wait —". Say up front: "`revert` is
going to ask you four questions, one at a time. The first starts with the
word *wait* and gives you three numbered choices — just press Enter. That's
it being careful, not it going wrong."

**The third misfire, and it catches nearly everyone: typing `1`.** The
checkpoint they want is number **2**, because `revert` saved their deletion
as a new number 1 on the way past (the answer is in the table at
`EXERCISES.md`, exercise 2, step 6). Getting it wrong costs nothing — run
`revert` again and pick the other number — but say the reason out loud when
it happens, because the same shape recurs in exercise 5 with a longer list:
**read the names, not the numbers.**

**If `revert` says there are no checkpoints.** Their `commit` didn't
complete — usually they answered `no` to the first question. Run `commit`
again, answer `yes`, then carry on. Costs thirty seconds.

**Fallback.** Pairs do this exercise twice in the same practice folder, once
each: after the first person restores `notes.txt`, the second person changes
or deletes it in the file browser and then runs `commit` and `revert` using
the reference card. It is worth the extra minutes: both people need to use
the recovery move themselves. The facilitator confirms pi is closed before
they return to the terminal prompt.

---

## Exercise 3 — Your first delegation (14 minutes)

By now the room has heard what an agent is (Session 1) and what pi's four
tools are (the beat before this one). This is where they see it.

**What participants do.** Start pi in the practice folder and ask it to build
the material the next exercise works on — a messy file shaped like the input
to one of their own toil entries. Steps: `EXERCISES.md`, exercise 3 — the
prompt they send is at step 2.

**Say it like this.** "Notice what you just did and did not do. You did not
open a spreadsheet. You did not type fifteen rows. You described what you
wanted in the same words you'd use with a colleague, and something went and
made it. That's the whole shape of the thing. The rest of this course is
about pointing it at work that matters and knowing whether it did it right."

**Say this too, before anyone asks:** "What you typed was sent to the model
provider, and pi would also send the contents of any file it reads. We did
not give it your work data: you described only the general shape and it
invented plausible rows. Everything in the practice file is made up."

**Observable output.** A file exists in `~/course-practice` that the
participant did not create by hand, and there is a checkpoint of it.

**Most common misfire.** A prompt describing the *task* instead of the
*material*: "sort my ticket queue". They get an empty file or a lecture. Ask:
"what would the file look like *before* you fixed it? Describe that." Column
1 of their sheet almost always has the answer already.

**The second misfire.** Waiting silently and assuming it's broken. Agents
pause. Say it up front: "there will be a few seconds where nothing moves.
That's normal. Escape stops it if you ever want to, but give it a minute
first."

**If the agent asks a question instead of doing it.** Answer it in the box
and press Enter. Say to the room: "that's a good sign — it knew it didn't
know. It won't always do that, and Session 2's whole second half is about
what happens when it doesn't."

**Fallback.** Participants choose one neutral synthetic option — metadata
cleanup, meeting follow-up, or onboarding coordination — and use its
ready-made prompt in
[`../session_01_mental_models/handouts/canned-toil.md`](../session_01_mental_models/handouts/canned-toil.md)
(section: "For Session 2"). Same exercise, timing, and artifact.

**Fallback for a pair.** One laptop, two turns: the person whose laptop it
isn't goes first and uses their own toil entry.

---

## Exercise 4 — What did it actually do? (13 minutes)

**The core exercise of the session.** Everything before it prepared the
room for this. Give it the full thirteen minutes; take them from exercise 3
if you have to.

**What participants do.** Delegate the real task, then reconstruct what
happened from the evidence rather than from the agent's summary — and decide
whether it was reasonable. Steps: `EXERCISES.md`, exercise 4 — the prompt is
at step 2, the three worksheet boxes at step 4.

**Say it like this, and it is the sentence the session exists for.** "The
agent wrote you a paragraph explaining what it did. That paragraph is the
least reliable thing on your screen — not because it lies, but because it's
describing its intentions, and you care about its effects. The tool calls are
what it *did*. The file is what *happened*. Read those two, in that order,
and then use your own check. That habit is the difference between using one
of these things and being used by one."

**Point back at Session 1 explicitly.** Hold up the inventory sheet. "Column
2 became the instruction. Column 4 became the check. You wrote both of those
before you'd ever seen this software, and they worked. That's what we meant
by the judgment being the scarce part."

**Observable output.** Every participant has a filled-in worksheet whose
third box names a specific thing they looked at and what it told them. "It
looked fine" is not a filled-in box.

**Most common misfire, and it's near-universal:** reading the agent's summary
and treating that as the check. They'll write "it said it standardized the
department names" in box 3. Ask the question that fixes it every time:
*"That's what it told you. What did you look at?"*

**The second misfire.** Box 1 filled in from memory rather than from
scrolling back. The tell is a box that says "it fixed the file" — that's a
summary, not a tool call. Have them scroll up; the boxes on screen are
labelled.

**When the agent got it wrong — and in some of the room it will.** This is
the best thing that can happen and you should treat it as a prize, out loud:
"Who's got one where it did something you didn't want? … Good. Come on, tell
us what it did." Then: what did they look at that told them? That's the
answer to box 3, and it's a better answer than anyone whose run went
perfectly. Give it thirty seconds of the room's attention.

**Fallback.** Participants apply the concrete check printed under the
synthetic task option they chose. They answer from the file evidence, not for
a fictional person.

**If someone finishes early.** Ask them the harder question: "what would you
have failed to catch?" That's exercise 4 of Session 3, arriving early, and
it's a good use of a fast participant.

---

## Exercise 5 — Break it on purpose (7 minutes)

**What participants do.** Deliberately tell the agent to ruin their work, watch
it comply, and put it back. Steps: `EXERCISES.md`, exercise 5 — the prompt
is at step 2 and must be sent exactly as written.

**Say it like this.** "You recovered a deliberately damaged local file in
about forty seconds. You know this recovery move works because you did it.
It does not undo messages, disclosures, or other external actions, so later
work still needs authorization, appropriate delegation, and human approval.
Be ambitious inside those bounds."

**Observable output.** Every participant's `ls` shows `sample.csv` and no
`disaster.csv`, after having shown the opposite a minute earlier.

**Why this prompt and not "delete everything".** The checkpoints live in a
hidden folder inside `~/course-practice`. A prompt broad enough to delete
*everything* can delete those too, and then there is nothing to revert to —
which would teach precisely the wrong lesson in the most memorable possible
way. This prompt names the file it ruins. **Don't let the room improvise a
more dramatic one**, and if someone asks, tell them exactly this; it's a real
answer and it's the beginning of Session 4.

**Most common misfire.** Reverting to the wrong checkpoint — usually "the
messy sample" instead of "cleaned up" — and losing exercise 4's work. Not a
disaster: `revert` is itself undoable, so run it again and pick the other
number. Worth saying out loud when it happens, because "I reverted too far
and reverted back" is a genuinely useful thing to have seen.

**If the agent refuses or asks whether you're sure.** It happens. Tell it
yes, or say "do it anyway". If it still won't, tell the room what just
happened — *"it declined to destroy my work, which is lovely and which you
must not rely on"* — and delete `sample.csv` in the file browser instead. The
exercise is the revert, and the revert works either way.

---

## Wrapping the block (1 minute)

Before the checkpoint round, one question to the room, hands up: **who has a
`sample.csv` in their folder right now with sensible data in it?** That's the
session's outcome in one show of hands, and it tells you who to catch at the
end — see [`CHECKPOINT.md`](CHECKPOINT.md).
