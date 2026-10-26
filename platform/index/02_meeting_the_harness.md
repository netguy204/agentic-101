# Session 2 — Meeting the harness

<!-- Chunk: docs/chunks/platform_student_index - The student's index for Session 2, written from its README and (then) PREWORK -->

In this session you run an agent on your own machine, watch it change a
file, and decide whether the result was right using the check you wrote in
Session 1. Before any agent runs, you learn to undo changes in your
practice folder.

You need the software you installed. The prework checks that it still
works.

## What you hand in

1. **Your session log.** pi, the agent you run, saves a record of every
   session on your machine: the tool calls themselves, not its summary.
   Nothing to do during the lab; `pi -r` finds it afterwards.
2. **Your what-did-it-do worksheet**, with box 3 naming the check you
   applied and what it told you.
3. **The output of `revert --list`.** `commit` and `revert` are commands
   you type, so they don't appear in the session log. This list shows that
   you undid something.
4. **The files from your practice folder**, including the one the agent
   changed.

You need all four to pass. The worksheet is the one that takes thought.

## Steps

| Step | Time | What you do |
|---|---|---|
| 1. Prework | 15 min | Pick one row from your inventory and run two commands. |
| 2. Concept track | 15 min | Four short segments. Listen or read; nothing to type. |
| 3. Find your way, then the safety net | 25 min | Open your practice folder in the terminal and the file browser. Save a checkpoint, delete a file, get it back. |
| 4. First delegation | 15 min | Ask the agent to make a messy practice file shaped like your task. |
| 5. Read what it did, then break it | 25 min | Have it fix the file, fill in the worksheet, then ruin the file on purpose and revert. |
| 6. Solo lap | 20 min, within 48 hours | The same loop alone: commit, delegate, check, commit. |
| 7. Two real ones | 15 min each | Two real tasks from your inventory, each checked. |
| 8. One worksheet | 10 min | A worksheet on whichever delegation went worst. Submit. |

Steps 6 to 8 spread across about a week. You can stop after any step and
pick up at the next one.

## Before you start: what gets sent

What you type, and any file the agent reads, is sent to a model provider so
the model can respond. In the lab you describe only the shape of your work
and ask the agent to invent the data. Don't put confidential names, figures
or files anywhere near it. If you would rather not describe your work at
all, the lab has prepared tasks.

Everything happens in one folder, `course-practice`, which your setup
created. `commit` and `revert` roll back ordinary file changes in that
folder. They don't unsend an email, recall anything sent to a model
provider, or undo anything outside the folder. The folder is not a
security boundary.

## Getting help

The same as Session 1: the material, then the automated course assistant,
then the checkpoint conversation, and your instructor at any point. To
reach your instructor, use "Stuck on this session?" on this page and
choose "Send to your instructor". Go straight to your instructor if the
course software won't work.

## Next

In Session 3 you write a one-page brief for one of your own tasks, and
learn to find the missing piece when a delegation goes wrong. It starts
from the worksheet you hand in here.
