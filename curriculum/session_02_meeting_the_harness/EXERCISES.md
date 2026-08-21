# Session 2 exercises

<!-- Chunk: docs/chunks/fluency_session_02 - Session 2 in-session exercises -->

Five exercises, 59 minutes of the session, in a fixed order. Each one is a
prerequisite for the next, so they are not a menu — if you run short, cut
*within* an exercise rather than dropping one.

Every written exercise targets named files in **`~/course-practice`**, the
folder the setup guide made. This keeps the work visible and locally
recoverable; it does not make the folder a security boundary.

Participants work from
[`handouts/terminal-card.md`](handouts/terminal-card.md) (the commands, on
one printable page) and fill in
[`handouts/what-did-it-do.md`](handouts/what-did-it-do.md) during exercise 4.
They also need their toil inventory from Session 1
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
agree about where they are.

1. Open the course terminal. **Mac:** `Command + Space`, type `Ghostty`,
   Enter. **Windows:** Start, type `Terminal`, Enter on **Windows Terminal**
   — not "Git Bash", not "Command Prompt".
2. Type `pwd` and press Enter. *("Print working directory" — where am I?)*
3. Type `ls` and press Enter. *(What's in here?)*
4. Type `cd ~/course-practice` and press Enter. *(Go there.)*
5. Type `pwd` again. The line now ends in `course-practice`.
6. Type `ls` again. One thing comes back: `README.txt`. Your setup put it
   there.
7. Open the same folder in the file browser: **Mac:** `open .` — **Windows:**
   `explorer .` (the `.` means "here"). Put the two windows side by side.
   Double-click `README.txt` and read it — it is four short paragraphs and it
   says exactly what the next two exercises are about.

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
purpose, and get it back.

1. Check you're in the right place: `pwd`. It must end in `course-practice`.
2. Type `touch notes.txt` and press Enter. *(Make a new empty file.)*
   Nothing prints. Type `ls` — now `notes.txt` is there. Look at the file
   browser window: it's there too.
3. In the **file browser**, double-click `notes.txt`. It opens in your normal
   text editor. Type a line — anything, "hello from session 2" is fine. Save
   it and close it.
4. Back in the terminal, type `commit` and press Enter. It asks two
   questions, in plain English. Answer the first `yes` — *turn on checkpoints
   for this folder*. It then lists **2 things changed: `README.txt` (new)
   and `notes.txt` (new)**, because neither has ever been saved before, and
   asks what to call the checkpoint. Type **`before anything`** and press
   Enter.
5. **Now delete the file.** In the file browser, delete `notes.txt`. Really
   delete it. In the terminal, `ls` — only `README.txt` is left.
6. Type `revert` and press Enter. It asks **four** things, in this order, and
   here is exactly what to do with each:

   | It asks | You do | Because |
   |---|---|---|
   | "2 things have changed since your last checkpoint… 1, 2 or 3?" | Press **Enter** (takes option 1) | It saves your deletion first, so even the deletion is undoable |
   | "What should we call this checkpoint?" | Press **Enter** (takes the date) | This checkpoint is scaffolding; it doesn't need a name |
   | "Which one should this folder go back to?" | Type **`2`**, Enter | The list is newest first, and it just added one — **"before anything" is number 2** |
   | "Go back to this checkpoint?" | Type **`yes`**, Enter | |

7. `ls`. `notes.txt` is back. Open it in the file browser — your line is
   still in it.

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
going to ask you four things and one of them starts with the word *wait*.
That's it being careful, not it going wrong."

**The third misfire, and it catches nearly everyone: typing `1`.** The
checkpoint they want is number **2**, because `revert` saved their deletion
as a new number 1 on the way past. Getting it wrong costs nothing — run
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
to one of their own toil entries.

1. In the terminal, in `~/course-practice`, type `pi` and press Enter. Wait
   for it to open. There is a box at the bottom; that's where you type.
2. Look at the entry you picked on your inventory sheet. Fill in the two gaps
   in this sentence and send it (type it, press Enter):

   > Make a file called `sample.csv` in this folder with about 15 rows of
   > made-up data that looks like **[what you work on — column 1 of your
   > sheet]**. Include the mistakes I usually have to fix: **[the mess]**.
   > Leave the mistakes in — I want the messy version.

3. **Watch.** Boxes appear as it works: those are tool calls — the agent
   reaching for one of its four tools and reporting back. Don't read them
   closely yet; just notice that things are *happening* rather than being
   *said*. `Ctrl+O` collapses and expands them if the screen gets busy. The
   whole thing usually takes ten to thirty seconds.
4. When it stops, look at the file browser window. `sample.csv` is there. Open
   it. **A real file, in your own folder, that you did not type.**
5. Leave pi: type `/quit` and press Enter.
6. Type `commit`. Name this checkpoint **"the messy sample"**.

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
whether it was reasonable.

1. Come back to your session: type `pi -c` and press Enter. *(Continue where
   you left off — it remembers.)*
2. Send the task itself. Column 2 of your inventory sheet — "what done right
   looks like" — is the instruction; you already wrote it, weeks ago, for a
   different reason:

   > Now fix the mistakes in `sample.csv`. Done right looks like: **[column 2
   > of your sheet]**. Tell me what you changed and why.

3. When it finishes, `/quit`, then `commit` and name it **"cleaned up"**.
4. Now fill in [`handouts/what-did-it-do.md`](handouts/what-did-it-do.md).
   Three boxes, and the order matters:
   - **What tools did it use?** Scroll back through the session and list them
     in order, in your own words: "it wrote the file." Not what it *said* it
     did — what the boxes show it did. Expect this to be shorter than people
     assume: one or two boxes is a normal answer, and noticing that it never
     re-read the file before rewriting it is a *good* observation, not a
     wrong one.
   - **What changed in the folder?** Open `sample.csv` in the file browser and
     look at the actual file. Not the summary in the terminal. The file.
   - **Was it reasonable, and how do I know?** Column 4 of your inventory
     sheet — "how I'd check" — is the answer to the second half. Apply the
     check you wrote in Session 1 and write down what it told you.

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
it comply, and put it back.

1. `pi -c` again.
2. Send this — exactly this, no improvising, and it is deliberately absurd:

   > Replace everything in `sample.csv` with a limerick about spreadsheets,
   > then rename the file to `disaster.csv`.

3. `/quit`. Then `ls` — `sample.csv` is gone and there's a `disaster.csv`
   where your work used to be. Open it in the file browser if you want the
   full effect. (The work log normally shows one box replacing the file and
   another renaming it. You do not need to know the command inside the second
   box.)
4. Type `revert`. Answer as you did in exercise 2 — Enter, Enter, then the
   number, then `yes`. **The list is longer now**, five or six checkpoints
   deep. Find the line that says **"cleaned up"** and type *that* number. It
   is probably 2. Do not assume.
5. `ls`. `sample.csv` is back, `disaster.csv` is gone, and the file has your
   cleaned-up data in it. Check the file browser to be sure — the point is
   checking, not being told.

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
