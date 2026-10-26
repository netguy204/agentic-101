# Session 2 exercises

<!-- Chunk: docs/chunks/fluency_session_02 - Session 2 in-session exercises -->
<!-- Chunk: docs/chunks/fluency_exercise_split - Exercise material split by reader: this file is for the participant -->
<!-- Chunk: docs/chunks/platform_solo_labs - Followable by a student with no room; the contract before the work -->

**What you'll have at the end.** A `sample.csv` in `~/course-practice`
that an agent made and then fixed, and that you checked yourself. A
filled-in `what-did-it-do.md`. And `revert` used at least once, by you, to
bring back work that was destroyed on purpose.

Do the five exercises in order; each sets up the next. Everything happens
in **`~/course-practice`**, the folder your setup made.

Keep these open:

- [`handouts/terminal-card.md`](handouts/terminal-card.md): every command,
  on one page.
- [`handouts/what-did-it-do.md`](handouts/what-did-it-do.md): you fill it
  in during exercise 4.
- Your toil inventory, with the row you starred in the prework. No usable
  row? Use one of the prepared tasks in the "For Session 2" section of
  [`../session_01_mental_models/handouts/canned-toil.md`](../session_01_mental_models/handouts/canned-toil.md).

What you type, and any file pi reads, is sent to the model provider.
Today's files are made up.

Each exercise ends with what usually goes wrong and what to do. Read that
before you assume you've broken something.

**Before exercise 1:** in the course terminal, type `course-update` and
press Enter. Most weeks it says *Nothing to do.* If it tells you to close
the window and open a new one, do that first.

---

## Exercise 1 — Where am I?

1. Open the course terminal. **Mac:** `Command + Space`, type `Ghostty`,
   Enter. **Windows:** Start, type `Terminal`, Enter on **Windows
   Terminal**, not "Git Bash" or "Command Prompt".
2. Type `pwd` and press Enter. *(Where am I?)*
3. Type `ls` and press Enter. *(What's here?)*
4. Type `cd ~/course-practice` and press Enter. *(Go there.)*
5. Type `pwd` again. The line now ends in `course-practice`.
6. Type `ls` again. One file comes back: `README.txt`.
7. Open the same folder in your file browser. **Mac:** `open .`
   **Windows:** `explorer .` (the `.` means "here"). Put the two windows
   side by side. Double-click `README.txt` and read it.

The `$` in the examples is already on your screen. Don't type it.

**Done when:** the terminal shows a path ending in `course-practice`, and a
file-browser window is open on the same folder.

**If it goes wrong:**

| What you see | What to do |
|---|---|
| Nothing happened when you typed | Press Enter. |
| `cd: …/course-practice: No such file or directory` | Your setup didn't finish. Run `course-smoke-test` and send everything it prints to your instructor. Don't try to fix it. |
| A wall of red text | Usually a typo. Type `cd ~`, then type the command again. |

---

## Exercise 2 — The safety net

Do this before you run an agent. pi has no general undo; this is how you
recover changes to files in this folder.

1. Type `pwd`. It must end in `course-practice`.
2. Type `touch notes.txt` and press Enter. *(Make an empty file.)* Nothing
   prints. Type `ls`: `notes.txt` is there, and in the file browser too.
3. In the file browser, double-click `notes.txt`. Type a line, such as
   "hello from session 2". Save and close it.
4. In the terminal, type `commit` and press Enter. Answer the first
   question `yes` (turn on checkpoints for this folder). It lists **2
   things changed: `README.txt` (new) and `notes.txt` (new)** and asks for
   a name. Type **`before anything`** and press Enter.
5. In the file browser, delete `notes.txt`. In the terminal, type `ls`:
   only `README.txt` is left. Really delete it; getting it back is the
   exercise.
6. Type `revert` and press Enter. It asks four questions, one at a time.
   It opens with "Wait —"; that is normal.

   | It asks | You do | Because |
   |---|---|---|
   | "Wait — 1 thing in this folder has changed since your last checkpoint… Type 1, 2 or 3." | Press **Enter** (option 1, *save them as a checkpoint now*) | It saves your deletion first, so the deletion can be undone too |
   | "What should we call this checkpoint?" | Press **Enter** (uses the date) | This checkpoint doesn't need a name |
   | "Which one should this folder go back to?" | Type **`2`**, Enter | The list is newest first and it just added one, so **"before anything" is number 2** |
   | "Go back to this checkpoint?" | Type **`yes`**, Enter | |

7. Type `ls`. `notes.txt` is back. Open it: your line is still there.

`commit` saves a snapshot of this folder. `revert` puts the folder back to
a snapshot. Neither can recall a sent message, undo anything outside this
folder, or pull back data sent to the model provider.

**Done when:** `notes.txt` is back in the folder with your line in it.

**If it goes wrong:**

- **You typed `1` at "Which one should this folder go back to?"** Run
  `revert` again and pick the other number. The list gets longer in
  exercise 5, so **read the names, not the numbers.**
- **`revert` says there are no checkpoints.** Your `commit` didn't finish,
  usually because you answered `no` to the first question. Run `commit`
  again, answer `yes`, then carry on.

**Working with your instructor or a partner?** If you share a practice
folder, each of you does this exercise once. After the first person
restores `notes.txt`, the second changes or deletes it and runs `commit`
and `revert`.

---

## Exercise 3 — Your first delegation

Ask the agent to make a messy file shaped like the input to your starred
row. Exercise 4 works on it.

1. In the terminal, in `~/course-practice`, type `pi` and press Enter.
   Wait for it to open. Type into the box at the bottom.
2. Fill in the two gaps and send it (type it, press Enter):

   > Make a file called `sample.csv` in this folder with about 15 rows of
   > made-up data that looks like **[what you work on — column 1 of your
   > sheet]**. Include the mistakes I usually have to fix: **[the mess]**.
   > Leave the mistakes in — I want the messy version.

3. Watch. Boxes appear as it works. Each one is a tool call: the agent
   using one of its four tools. You'll read them in exercise 4. `Ctrl+O`
   collapses and expands them. It usually takes ten to thirty seconds.
4. When it stops, open `sample.csv` from the file browser.
5. Type `/quit` and press Enter to leave pi.
6. Type `commit`. Name the checkpoint **"the messy sample"**.

You described the shape of your work and pi invented the rows, so nothing
real was sent.

**Done when:** `sample.csv` is in the folder, you didn't type it, and
there is a checkpoint named "the messy sample".

**If it goes wrong:**

- **The file is empty, or it explains instead of doing.** Describe the
  material, not the task. "Sort my ticket queue" doesn't work; describe
  what the file looks like before you fix it. Column 1 of your sheet
  usually says.
- **Nothing moves for a few seconds.** Normal. Wait a minute before
  pressing Escape to stop it.
- **It asks you a question.** Answer it in the box and press Enter.

**Using a prepared task?** Use the ready-made prompt for the option you
chose in
[`../session_01_mental_models/handouts/canned-toil.md`](../session_01_mental_models/handouts/canned-toil.md)
(section "For Session 2").

**Working with your instructor or a partner?** If you share one laptop,
the person whose laptop it isn't goes first, with their own row.

---

## Exercise 4 — What did it actually do?

Delegate the task, then work out what happened from the tool calls and
the file, and decide whether it was right.

1. Type `pi -c` and press Enter. *(Continue the last conversation.)*
2. Send the task. Column 2 of your sheet is the instruction:

   > Now fix the mistakes in `sample.csv`. Done right looks like: **[column 2
   > of your sheet]**. Tell me what you changed and why.

3. When it finishes, type `/quit`, then `commit`, and name it **"cleaned
   up"**.
4. Fill in [`handouts/what-did-it-do.md`](handouts/what-did-it-do.md), in
   order:
   - **Box 1, what tools did it use?** Scroll back and list the boxes, in
     order, in your own words: "it wrote the file." One or two boxes is
     normal. Noting that it rewrote the file without reading it first is a
     good observation.
   - **Box 2, what changed in the folder?** Open `sample.csv` in the file
     browser and look at the file itself.
   - **Box 3, was it reasonable, and how do I know?** Apply the check in
     column 4 of your sheet. Write what you looked at and what it told
     you.

The agent's closing paragraph describes what it meant to do. Fill in the
boxes from the tool calls and the file.

**Done when:** box 3 names a specific thing you looked at and what it told
you. "It looked fine" doesn't count.

**If it goes wrong:**

- **Box 3 repeats the agent's summary.** "It said it standardised the
  department names" is what it told you. What did you look at?
- **Box 1 says "it fixed the file".** That's a summary. Scroll up; each
  box on screen is labelled with its tool.
- **It did something you didn't want.** Write down what you looked at
  that showed you. That is a good box 3.

**Using a prepared task?** Apply the check printed under the option you
chose.

**Finished early?** Write down what your check would have missed.

---

## Exercise 5 — Break it on purpose

Tell the agent to ruin your work, then put it back.

1. Type `pi -c` and press Enter.
2. Send exactly this:

   > Replace everything in `sample.csv` with a limerick about spreadsheets,
   > then rename the file to `disaster.csv`.

3. Type `/quit`, then `ls`. `sample.csv` is gone and `disaster.csv` is
   there. Open it if you like.
4. Type `revert`. Answer as in exercise 2: Enter, Enter, the number, then
   `yes`. The list is longer now. Find the line that says **"cleaned up"**
   and type that number. It is probably 2; check.
5. Type `ls`. `sample.csv` is back and `disaster.csv` is gone. Open
   `sample.csv` in the file browser and check it has your cleaned-up data.

Use this exact prompt. It names the one file to ruin. A broader prompt
could delete the checkpoints too, and then there would be nothing to
revert to.

**Done when:** `ls` shows `sample.csv` and no `disaster.csv`, and the file
has your cleaned-up data.

**If it goes wrong:**

- **You reverted to "the messy sample".** Run `revert` again and pick
  "cleaned up".
- **The agent refuses or asks if you're sure.** Tell it yes, or "do it
  anyway". If it still won't, delete `sample.csv` in the file browser
  instead, then revert.

---

## Wrapping up

Open `~/course-practice`. You should see a `sample.csv` with sensible data
in it that you did not type.

**Next:** the solo lap in [`PRACTICE.md`](PRACTICE.md), within 48 hours.
