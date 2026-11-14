# Before Session 2

<!-- Chunk: docs/chunks/platform_cohort_prework - The self-paced student's prework; Session 2's only prework (DEC-014) -->

**Time:** about 15 minutes. You'll pick one row from your toil inventory
sheet, then check that the course software still works.

---

## 1. Pick your row (10 minutes)

**You'll need:** your
[toil inventory sheet](../../curriculum/session_01_mental_models/handouts/toil-inventory.md#the-sheet)
from Session 1.

Choose **one row** on your sheet. In the lab you'll point an agent at it. A
good row has three things going for it:

- It's marked **in**.
- It involves a list, a file or a set of records, something with rows or
  items in it for the agent to work on.
- It has a specific check in the *How I'd check* column. "I'd read it over"
  doesn't count yet.

Put a star next to it. Under it, write two rough sentences:

1. **What the messy version looks like.** Describe the material rather than
   the task. "A list of tickets where the priority is written four different
   ways" works. "Sorting my ticket queue" doesn't.
2. **What "done right" looks like.** Copy this from the *What "done right"
   looks like* column.

You'll only describe the shape of this work to the agent and ask it to
invent the rows, so leave out real names, figures and files.

If none of your rows fits, use one of the prepared options in
[Priya's sample tasks](../../curriculum/session_01_mental_models/handouts/canned-toil.md#for-session-2-neutral-synthetic-task-options)
instead.

---

## 2. Run two commands (5 minutes)

Open the course terminal. **Mac:** `Command + Space`, type `Ghostty`,
Enter. **Windows:** Start, type `Terminal`, Enter on **Windows Terminal**
(not "Git Bash").

Type this and press Enter:

```
course-update
```

It fetches any course fixes published since you set up. Most weeks it says
**Nothing to do.** If it tells you to close the window and open a new one,
do that.

Then type this and press Enter:

```
course-smoke-test
```

It prints a short list and ends with **PASS** or **FAIL**. PASS means
you're ready.

**If it says FAIL, or anything else goes wrong, stop there.** Don't
reinstall anything or try fixes from the internet. Copy everything the
window printed and send it to your instructor: choose "Stuck on this
session?", then "Send to your instructor". A FAIL means the setup
instructions need fixing, and that output shows your instructor what went
wrong.

**Next:** the audio.
