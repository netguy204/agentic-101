# Session 2 exercises

<!-- Chunk: docs/chunks/fluency_session_02 - Session 2 in-session exercises -->
<!-- Chunk: docs/chunks/fluency_exercise_split - Exercise material split by reader: this file is for the participant -->

Five exercises, in a fixed order — each one sets up the next. Everything
you do today happens in **`~/course-practice`**, the folder your setup
made, and exercise 2 teaches you how to undo ordinary changes to the files
in it. That is local file recovery, not a security boundary.

You'll need:

- [`handouts/terminal-card.md`](handouts/terminal-card.md) — the commands,
  on one printable page.
- [`handouts/what-did-it-do.md`](handouts/what-did-it-do.md) — you fill it
  in during exercise 4.
- Your toil inventory from Session 1
  ([`../session_01_mental_models/handouts/toil-inventory.md`](../session_01_mental_models/handouts/toil-inventory.md)).
  No usable entry? Choose a neutral synthetic task from the Session 2
  section of
  [`../session_01_mental_models/handouts/canned-toil.md`](../session_01_mental_models/handouts/canned-toil.md)
  — same exercises, same timing, same result.

What you type, and any file pi reads, is sent to the model provider.
Today's files are made up, so nothing in them can't leave the building.

Stuck at any point? Say so — you'll be paired. A pair runs every exercise
at full value; the person without the laptop holds the keyboard.

---

## Exercise 1 — Where am I?

Open the course terminal and find your way to the practice folder, checking
at each step that the terminal and the file browser agree about where you
are.

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

**What you should see:** your terminal shows a path ending in
`course-practice`, and a file-browser window is open on the same folder.

Three commands, and they are the only three you need to never be lost:
`pwd` is *where am I*, `ls` is *what's here*, `cd` is *go there*. Everything
else today, the agent does for you. And notice what happened with `open .`
— that window and this window are the same folder. The terminal isn't a
different computer. It's the same files, reached by typing instead of
clicking.

Two things worth knowing before you start. The cursor blinking at you is
not waiting for permission and it is not judging you — it's waiting.
Nothing happens until you press Enter; if you type something and nothing
happens, you almost certainly forgot to press Enter, and it happens to
everybody. And the `$` in the examples is already on your screen — it's the
terminal saying it's ready. You never type it.

**If it goes wrong:**

| What you see | What to do |
|---|---|
| Nothing happened when you typed | Press Enter. |
| `bash: cd: /Users/…/course-practice: No such file or directory` | Your setup didn't finish. Put your hand up — you'll be paired; it isn't fixed live. |
| A wall of red text | Almost always a typo. Type `cd ~` to get home, then retype the command. Don't try to fix the typo — retype it. |

---

## Exercise 2 — The safety net

Nobody runs an agent until everyone in the room has finished this
exercise, pairs included. pi has no general undo button; this is how you
recover ordinary changes to the files in this folder.

Make a file, save a checkpoint, destroy the file on purpose, and get it
back.

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
   delete it. In the terminal, `ls` — only `README.txt` is left. Don't skip
   this because deleting the file feels wasteful — the exercise is the
   getting it back, and you don't get the feeling from watching someone
   else.
6. Type `revert` and press Enter. It asks **four questions**, one at a time —
   the first offers three numbered choices, and it is the only one with a
   menu. The first thing it says is the word "Wait —": that's it being
   careful, not it going wrong. Here is exactly what to do with each:

   | It asks | You do | Because |
   |---|---|---|
   | "Wait — 1 thing in this folder has changed since your last checkpoint… Type 1, 2 or 3." | Press **Enter** (takes option 1, *save them as a checkpoint now*) | It saves your deletion first, so even the deletion is undoable |
   | "What should we call this checkpoint?" | Press **Enter** (takes the date) | This checkpoint is scaffolding; it doesn't need a name |
   | "Which one should this folder go back to?" | Type **`2`**, Enter | The list is newest first, and it just added one — **"before anything" is number 2** |
   | "Go back to this checkpoint?" | Type **`yes`**, Enter | |

7. `ls`. `notes.txt` is back. Open it in the file browser — your line is
   still in it.

**What you should see:** `notes.txt` back in the folder with your line in
it. You just deleted a local file on purpose and got it back.

`commit` means *save a snapshot of this folder as it is right now*.
`revert` means *put this folder back to one of those snapshots*. It cannot
recall a sent message, undo an external action, or protect data sent to the
model provider.

Two things that catch people:

- **Typing `1` at "Which one should this folder go back to?"** The
  checkpoint you want is number **2**, because `revert` saved your deletion
  as a new number 1 on the way past. Getting it wrong costs nothing — run
  `revert` again and pick the other number — but the rule matters, because
  the list gets longer in exercise 5: **read the names, not the numbers.**
- **`revert` says there are no checkpoints.** Your `commit` didn't complete
  — usually because you answered `no` to the first question. Run `commit`
  again, answer `yes`, then carry on. Thirty seconds.

**In a pair?** Do this exercise twice in the same practice folder, once
each: after the first person restores `notes.txt`, the second person
changes or deletes it in the file browser and then runs `commit` and
`revert` from the reference card. Both of you need to have used the
recovery move yourselves.

---

## Exercise 3 — Your first delegation

Start pi in the practice folder and ask it to build the material the next
exercise works on — a messy file shaped like the input to one of your own
toil entries.

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

**What you should see:** a file in `~/course-practice` that you did not
create by hand, and a checkpoint of it.

Notice what you just did and did not do. You did not open a spreadsheet.
You did not type fifteen rows. You described what you wanted in the same
words you'd use with a colleague, and something went and made it.

What you typed was sent to the model provider, and pi would also send the
contents of any file it reads. You did not give it your work data: you
described only the general shape and it invented plausible rows.
Everything in the practice file is made up.

Three things worth knowing:

- **Describe the *material*, not the task.** "Sort my ticket queue" gets
  you an empty file or a lecture. What would the file look like *before*
  you fixed it? Describe that — column 1 of your sheet almost always has
  the answer already.
- **There will be a few seconds where nothing moves.** That's normal.
  Agents pause. Escape stops it if you ever want to, but give it a minute
  first.
- **If the agent asks a question instead of doing it,** answer it in the box
  and press Enter. That's a good sign — it knew it didn't know.

**No usable inventory entry?** Choose one neutral synthetic option —
metadata cleanup, meeting follow-up, or onboarding coordination — and use
its ready-made prompt in
[`../session_01_mental_models/handouts/canned-toil.md`](../session_01_mental_models/handouts/canned-toil.md)
(section: "For Session 2"). Same exercise, same timing, same artifact.

**In a pair?** One laptop, two turns: the person whose laptop it isn't goes
first and uses their own toil entry.

---

## Exercise 4 — What did it actually do?

The core exercise of the session. Delegate the real task, then reconstruct
what happened from the evidence rather than from the agent's summary — and
decide whether it was reasonable.

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

**What you should see:** a filled-in worksheet whose third box names a
specific thing you looked at and what it told you. "It looked fine" is not
a filled-in box.

The agent wrote you a paragraph explaining what it did. That paragraph is
the least reliable thing on your screen — not because it lies, but because
it's describing its intentions, and you care about its effects. The tool
calls are what it *did*. The file is what *happened*. Read those two, in
that order, and then use your own check.

Column 2 of your inventory became the instruction. Column 4 became the
check. You wrote both of those before you'd ever seen this software.

Two things that catch people:

- **Box 3 filled in from the agent's summary.** "It said it standardized
  the department names" is what it told you. What did you *look at*?
- **Box 1 filled in from memory.** "It fixed the file" is a summary, not a
  tool call. Scroll up — the boxes on screen are labelled.

**If it did something you didn't want** — good. That's the most useful run
in the room. What did you look at that told you? That's your box 3, and
it's a better answer than anyone whose run went perfectly.

**Synthetic task?** Apply the concrete check printed under the option you
chose, answering from the file evidence — not for a fictional person.

**Finished early?** The harder question: what would you have *failed* to
catch?

---

## Exercise 5 — Break it on purpose

Deliberately tell the agent to ruin your work, watch it comply, and put it
back.

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

**What you should see:** `ls` shows `sample.csv` and no `disaster.csv`,
after having shown the opposite a minute earlier.

Why exactly that prompt: it names the file it ruins. A prompt broad enough
to "delete everything" could delete the checkpoints too, and then there is
nothing to revert to. Don't improvise a more dramatic one.

Two things that catch people:

- **Reverting to the wrong checkpoint** — usually "the messy sample"
  instead of "cleaned up" — and losing exercise 4's work. Not a disaster:
  `revert` is itself undoable, so run it again and pick the other number.
- **The agent refuses, or asks whether you're sure.** It happens. Tell it
  yes, or say "do it anyway". If it still won't, delete `sample.csv` in the
  file browser instead. The exercise is the revert, and the revert works
  either way — and an agent that declines to destroy your work is lovely
  and must not be relied on.

---

## Wrapping up

One question, hands up: do you have a `sample.csv` in your folder right
now with sensible data in it? That is the session's outcome in one show of
hands.
