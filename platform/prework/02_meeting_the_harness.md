# Before Session 2

<!-- Chunk: docs/chunks/platform_cohort_prework - The self-paced student's prework; Session 2's only prework (DEC-014) -->

**Time:** 15 minutes. Pick one row from your inventory, then check that
the course software still works.

---

## 1. Pick your row (10 minutes)

Choose **one row** from your toil inventory. You will point an agent at it
in the lab. A good row:

- is marked **in**;
- involves a list, a file or a set of records, something with rows or
  items in it for the agent to work on;
- has a specific check in column 4. "I'd read it over" is not one.

Star it. Under it, write two rough sentences:

1. **What the messy version looks like.** Describe the material, not the
   task: "a list of tickets where the priority is written four different
   ways", not "sorting my ticket queue".
2. **What "done right" looks like.** Copy column 2.

You will only describe the shape of this work to the agent and ask it to
invent the rows. Leave out real names, figures and files.

If your inventory has no row like this, use one of the prepared tasks in
[`canned-toil.md`](../../curriculum/session_01_mental_models/handouts/canned-toil.md)
(section "For Session 2").

---

## 2. Run two commands (5 minutes)

Open the course terminal. **Mac:** `Command + Space`, type `Ghostty`,
Enter. **Windows:** Start, type `Terminal`, Enter on **Windows Terminal**
(not "Git Bash").

Type this and press Enter:

```
course-update
```

It fetches any course fixes published since you set up. Most weeks it
says **Nothing to do.** If it tells you to close the window and open a new
one, do that.

Then type this and press Enter:

```
course-smoke-test
```

It prints a short list and ends with **PASS** or **FAIL**. PASS means you
are ready.

**If it says FAIL, or anything else goes wrong, stop.** Don't reinstall
anything or follow fixes from the internet. Copy everything the window
printed and send it to your instructor ("Stuck on this session?", then
"Send to your instructor"). This is a problem with the setup instructions,
and it is quick to diagnose from that output.

**Next:** the concept track.
