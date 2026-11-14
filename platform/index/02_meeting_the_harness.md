# Session 2 — Meeting the harness

<!-- Chunk: docs/chunks/platform_student_index - The student's index for Session 2, written from its README and (then) PREWORK -->

Welcome back. This is the session where the course gets hands-on. You'll run
an agent on your own computer, watch it change a file, and decide whether
the result was right using the check you wrote in Session 1. Before any
agent runs, you'll learn to undo changes in your practice folder, so
everything after that is safe to try.

You'll need the software you installed. The prework checks that it still
works.

## What you'll submit

1. **Your session log.** pi, the agent you'll run, keeps a record of every
   session on your computer. It shows the steps the agent actually took,
   which is different from the summary it gives you. You don't need to do
   anything during the lab, because `pi -r` finds it afterwards.
2. **Your
   [what-did-it-do worksheet](../../curriculum/session_02_meeting_the_harness/handouts/what-did-it-do.md)**,
   with Box 3, *Was it reasonable, and how do I know?*, naming the check you
   applied and what it told you.
3. **The output of `revert --list`.** `commit` and `revert` are commands you
   type yourself, so they don't appear in the session log. This list shows
   that you undid something.
4. **The files from your practice folder,** including the one the agent
   changed.

You'll need all four to complete the session. The worksheet is the one that
takes some thought.

## Steps

| Step | Time | What you do |
|---|---|---|
| 1. [Prework](../prework/02_meeting_the_harness.md) | 15 min | Pick one row from your [toil inventory sheet](../../curriculum/session_01_mental_models/handouts/toil-inventory.md#the-sheet) and run two commands. |
| 2. The audio | 15 min | Four short parts. Listen, or read the same material if you prefer. There's nothing to type. |
| 3. Find your way, then build the safety net | 25 min | Open your practice folder in the terminal and in your file browser. Save a checkpoint, delete a file, and get it back. |
| 4. Your first delegation | 15 min | Ask the agent to make a messy practice file shaped like your task. |
| 5. Read what it did, then break it on purpose | 25 min | Have it fix the file and fill in your worksheet. Then ruin the file on purpose and revert. |
| 6. The solo lap | 20 min, within 48 hours | The same loop on your own: commit, delegate, check, commit. |
| 7. Two real ones | 15 min each | Two real tasks from your sheet, each one checked. |
| 8. One worksheet, on the worst one | 10 min | A worksheet on whichever delegation went worst. Then submit. |

Steps 6 to 8 are spread over about a week. You can stop after any step and
pick up at the next one.

## Before you start: what gets sent

What you type, and any file the agent reads, is sent to a model provider so
the model can respond. In the lab you'll describe only the shape of your
work and ask the agent to invent the data. Keep confidential names, figures
and files away from it. If you'd rather not describe your work at all, you
can use
[Priya's sample tasks](../../curriculum/session_01_mental_models/handouts/canned-toil.md#for-session-2-neutral-synthetic-task-options)
instead.

Everything happens in one folder, `course-practice`, which your setup
created. `commit` and `revert` roll back ordinary file changes in that
folder. They don't unsend an email, recall anything sent to a model
provider, or undo anything outside the folder. The folder is not a security
boundary.

## Getting help

Help works the same way as in Session 1. Start with the material, then the
course assistant, which is automated, then the checkpoint conversation. Your
instructor is there at any point. To reach them, choose "Stuck on this
session?" on this page, then "Send to your instructor". If the course
software won't work, go straight to your instructor.

## Next

In Session 3 you'll write a one-page brief for one of your own tasks, and
learn to find the missing piece when a delegation goes wrong. It starts from
the worksheet you submit here.
