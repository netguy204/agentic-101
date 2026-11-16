# Session 2 exercises

<!-- Chunk: docs/chunks/fluency_session_02 - Session 2 in-session exercises -->
<!-- Chunk: docs/chunks/fluency_exercise_split - Exercise material split by reader: this file is for the participant -->
<!-- Chunk: docs/chunks/platform_solo_labs - Followable by a student with no room; the contract before the work -->

By the end of these five exercises you'll have a `sample.csv` that an agent
made and then fixed, and that you checked yourself. You'll have a filled-in
[what-did-it-do worksheet](handouts/what-did-it-do.md). And you'll have undone
the agent's work at least once, to bring back a file that was ruined on
purpose.

You'll work with your agent, the agent page that comes with the course. It
runs on the course's computer, so there's nothing to install. Its own folder
of files is listed under **Your files** on the agent page.

Do the exercises in order, because each one sets up the next. What you type,
and any file the agent reads, is sent to the model provider. The files
you'll work with today are made up.

Each exercise ends with what usually goes wrong and what to do about it.
Have a look there before you assume you've broken something.

**If you run pi on your own computer:** you'll do the same exercises in the
course terminal, in your practice folder `~/course-practice`, and the boxes
marked like this one give your steps. Keep the
[terminal card](handouts/terminal-card.md) open; it lists every command.
Before exercise 1, type `course-update` and press Enter. Most weeks it says
*Nothing to do.* If it tells you to close the window and open a new one, do
that first.

---

## Exercise 1 — Where am I?

**You'll need:** your agent page open.

1. Find the request box. That's where you type what you want, then choose
   **Send**.
2. Find **Your files**. It's the agent's folder, and right now it's nearly
   empty. Everything the agent makes or changes today will appear here.
3. Find **Earlier versions** and **Undo the last request**. You'll use them in
   the next exercise.
4. Type this in the request box and choose **Send**:

   > What files are in your folder? Don't change anything.

5. Watch the page while it works. Each step the agent takes appears as it
   happens, labelled with what it did: **Read**, **Wrote**, **Changed** or
   **Ran a command**. This time you should see it look, and nothing else.

**Done when:** you've seen the agent answer, and you know where **Your
files**, **Earlier versions** and **Undo the last request** are.

**If it goes wrong:**

- **Nothing seems to happen.** Give it half a minute. While it's working
  you'll see **Stop**.
- **It changed something anyway.** Choose **Undo the last request**. You've
  just done the next exercise early.

**If you run pi on your own computer:**

1. Open the course terminal. **Mac:** `Command + Space`, type `Ghostty`,
   Enter. **Windows:** Start, type `Terminal`, Enter on **Windows
   Terminal**, not "Git Bash" or "Command Prompt".
2. Type `pwd` *(where am I?)*, then `ls` *(what's here?)*, pressing Enter
   after each.
3. Type `cd ~/course-practice` *(go there)*, then `pwd` again. The line now
   ends in `course-practice`, and `ls` shows `README.txt`.
4. Open the same folder in your file browser: `open .` on a Mac,
   `explorer .` on Windows. Put the two windows side by side.

You're done when the terminal shows a path ending in `course-practice` and a
file-browser window is open on the same folder. If
`cd ~/course-practice` says *No such file or directory*, your setup didn't
finish: run `course-smoke-test` and send everything it prints to your
instructor.

---

## Exercise 2 — The safety net

**You'll need:** your agent page, with **Your files** in view.

Do this before you give the agent any real work. Learning to undo comes
first, so everything after it is safe to try.

1. Send this:

   > Make a file called `notes.txt` with one line in it: hello from
   > session 2.

   You'll see **Wrote**, and `notes.txt` appears under **Your files**. Open
   it and read the line.
2. Choose **Undo the last request**. `notes.txt` disappears from **Your
   files**. The agent's change is gone.
3. Send the same request again, so `notes.txt` is back.
4. Send this:

   > Delete `notes.txt`.

   It's gone again.
5. Open **Earlier versions**. Each entry is a point you can go back to,
   usually named after the request it came from. Find the one from the
   request that made `notes.txt` and go back to it. "Going back puts every
   file as it was then."
6. Check **Your files**. `notes.txt` is back, with your line in it.

**Undo the last request** takes back the agent's most recent request.
**Earlier versions** takes every file back to any earlier point, and you can
come forward again from the same list. Neither can recall something already
sent to the model provider, or undo anything the agent did outside its
folder.

**Done when:** `notes.txt` is back under **Your files** with your line in it,
and you got it back with **Earlier versions**.

**If it goes wrong:**

- **You went back to the wrong version.** Open **Earlier versions** again and
  pick another one. Going back doesn't lose the later versions. **Read the
  names in the list rather than counting down it.**
- **Undo didn't seem to change anything.** It only undoes the agent's last
  request. If that request didn't change a file, there was nothing to undo.

**If you run pi on your own computer:** your safety net is `commit` and
`revert`, which you type in the terminal. pi itself has no general undo.

1. In `~/course-practice`, type `touch notes.txt` to make an empty file. Open
   it from the file browser, type a line, save and close it.
2. Type `commit`. Answer the first question `yes` (turn on checkpoints for
   this folder). Name the checkpoint **`before anything`**.
3. Delete `notes.txt` in the file browser.
4. Type `revert` and answer its four questions:

   | It asks | You do |
   |---|---|
   | "Wait — 1 thing in this folder has changed since your last checkpoint…" | Press **Enter** (save them as a checkpoint now) |
   | "What should we call this checkpoint?" | Press **Enter** |
   | "Which one should this folder go back to?" | Type the number next to **"before anything"** (probably **2**), Enter |
   | "Go back to this checkpoint?" | Type **`yes`**, Enter |

5. Type `ls`. `notes.txt` is back, with your line in it.

If `revert` says there are no checkpoints, your `commit` didn't finish. Run
`commit` again and answer `yes`. The list is newest first and grows as you
go, so read the names, not the numbers.

**Working with your instructor or a partner?** Each of you does this
exercise once, on your own agent page or in your own folder.

---

## Exercise 3 — Your first delegation

**You'll need:** the row you starred on your
[toil inventory sheet](../session_01_mental_models/handouts/toil-inventory.md#the-sheet)
in the [prework](../../platform/prework/02_meeting_the_harness.md#1-pick-your-row-10-minutes),
with the two sentences you wrote under it.

You'll ask the agent to make a messy file shaped like the input to your
starred row. Exercise 4 works on it.

1. Fill in the two gaps and send it. For the first gap, use your row's *The
   task, and how often* column. For the second, use the "messy version"
   sentence you wrote in the prework.

   > Make a file called `sample.csv` in this folder with about 15 rows of
   > made-up data that looks like **[what you work on — column 1 of your
   > sheet]**. Include the mistakes I usually have to fix: **[the mess]**.
   > Leave the mistakes in — I want the messy version.

2. Watch the steps appear as it works. Each one is the agent using one of
   its tools: **Read**, **Wrote**, **Changed** or **Ran a command**. You'll
   read them properly in exercise 4. It usually takes ten to thirty seconds.
3. When it stops, open `sample.csv` from **Your files**.

You described the shape of your work and the agent invented the rows, so
nothing real was sent. The request you just sent is now an entry in
**Earlier versions**, so you can always come back to this messy sample.

**Done when:** `sample.csv` is under **Your files**, and you didn't type it.

**If it goes wrong:**

- **The file is empty, or it explains instead of doing.** Describe the
  material rather than the task. "Sort my ticket queue" doesn't work.
  Describe what the file looks like before you fix it. The *The task, and
  how often* column on your sheet usually says.
- **Nothing moves for a few seconds.** That's normal. Wait a minute before
  choosing **Stop**.
- **It asks you a question.** Answer it in the request box and choose
  **Send**.

**Using one of Priya's sample tasks?** Use the ready-made prompt for the
option you chose in
[Priya's sample tasks](../session_01_mental_models/handouts/canned-toil.md#for-session-2-neutral-synthetic-task-options).

**If you run pi on your own computer:** in `~/course-practice`, type `pi`
and send the same request in the box at the bottom. Steps appear as boxes
(`Ctrl+O` collapses and expands them). When it stops, open `sample.csv` from
the file browser, type `/quit`, then `commit` and name the checkpoint
**"the messy sample"**.

---

## Exercise 4 — What did it actually do?

**You'll need:** a blank
[what-did-it-do worksheet](handouts/what-did-it-do.md), and your starred row
on your
[toil inventory sheet](../session_01_mental_models/handouts/toil-inventory.md#the-sheet).

You'll hand over the real task, then work out what happened from the steps
the agent took and from the file itself, and decide whether it was right.

1. Send the task. Your row's *What "done right" looks like* column is the
   instruction:

   > Now fix the mistakes in `sample.csv`. Done right looks like: **[column 2
   > of your sheet]**. Tell me what you changed and why.

2. Fill in your worksheet, in order:
   - **[Box 1 — What tools did it use?](handouts/what-did-it-do.md#box-1-what-tools-did-it-use)**
     Scroll back through the steps on the agent page and list them, in
     order, in your own words: "it wrote the file." One or two steps is
     normal. Noticing that it rewrote the file without reading it first is a
     good observation.
   - **[Box 2 — What changed in the folder?](handouts/what-did-it-do.md#box-2-what-changed-in-the-folder)**
     Open `sample.csv` from **Your files** and look at the file itself.
   - **[Box 3 — Was it reasonable, and how do I know?](handouts/what-did-it-do.md#box-3-was-it-reasonable-and-how-do-i-know)**
     Apply the check in your row's *How I'd check* column. Write what you
     looked at and what it told you.

The agent's closing paragraph describes what it meant to do. Fill in the
boxes from the steps it took and the file.

**Done when:** Box 3 names a specific thing you looked at and what it told
you. "It looked fine" doesn't count yet.

**If it goes wrong:**

- **Box 3 repeats the agent's summary.** "It said it standardised the
  department names" is what it told you. What did you look at?
- **Box 1 says "it fixed the file".** That's a summary. Scroll up, and
  you'll see each step on the page is labelled with what it did.
- **It did something you didn't want.** Write down what you looked at that
  showed you. That makes a good Box 3.

**Using one of Priya's sample tasks?** Apply the **Check** printed under
the option you chose in
[Priya's sample tasks](../session_01_mental_models/handouts/canned-toil.md#for-session-2-neutral-synthetic-task-options).

**Finished early?** Write down what your check would have missed.

**If you run pi on your own computer:** type `pi -c` *(continue the last
conversation)* and send the same request. When it finishes, type `/quit`,
then `commit`, and name it **"cleaned up"**. Scroll back through pi's boxes
for Box 1, and open `sample.csv` from the file browser for Box 2.

---

## Exercise 5 — Break it on purpose

**You'll need:** the cleaned-up `sample.csv` from exercise 4.

You'll tell the agent to ruin your work, then put it back.

1. Send exactly this:

   > Replace everything in `sample.csv` with a limerick about spreadsheets,
   > then rename the file to `disaster.csv`.

2. Check **Your files**. `sample.csv` is gone and `disaster.csv` is there.
   Open it if you like.
3. Open **Earlier versions** and find the entry from your exercise 4 request,
   the one that fixed the mistakes. Go back to it.
4. Check **Your files**. `sample.csv` is back with your cleaned-up data, and
   `disaster.csv` is gone.

Use this exact prompt. It names the one file to ruin, so nothing else is
touched.

**Done when:** **Your files** shows `sample.csv` and no `disaster.csv`, and
the file has your cleaned-up data.

**If it goes wrong:**

- **You went back to the messy sample.** Open **Earlier versions** again and
  pick the entry from the cleanup request.
- **The agent refuses or asks if you're sure.** Tell it yes, or "do it
  anyway".

**If you run pi on your own computer:** type `pi -c`, send the same prompt,
then `/quit` and `ls`. Type `revert` and answer as in exercise 2: Enter,
Enter, the number next to **"cleaned up"** (probably 2, but check the
name), then `yes`. Type `ls` again: `sample.csv` is back and `disaster.csv`
is gone. Use this exact prompt, because a broader one could delete your
checkpoints too.

---

## Wrapping up

Look at **Your files**, or `~/course-practice` if you run pi on your own
computer. There's a `sample.csv` with sensible data in it that you didn't
type. Nice work. That's the whole loop: delegate, check, and undo when you
need to.

**Next:** the [solo lap](PRACTICE.md#1-the-solo-lap-20-minutes-within-48-hours),
within 48 hours.
