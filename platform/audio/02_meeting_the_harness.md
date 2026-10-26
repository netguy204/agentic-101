# Session 2 — Meeting the harness

This is the concept track for Session 2 of Agentic 101. It has four
segments. Each one ends with a question: answer it yourself, out loud if
you can, before the model answer. Nothing here asks you to type anything.
Every command and every step is in the lab, where you will need it.

## Segment 1 — A window onto a folder

In this session you work in an app where you type instructions instead of
clicking them. That app is a terminal.

A terminal is a window onto a folder. They are the same folders you see in
Finder or File Explorer, the same files, on the same computer. You say what
you want in words instead of pointing at it.

Everything the course asks you to type is something you already do by
clicking. In Finder or File Explorer, the folder's name is at the top of
the window, so you can see which folder you are in. In a terminal you ask,
and it tells you. In Finder or File Explorer, you see what is in a folder
by looking at its icons. In a terminal you ask for a list. In Finder or
File Explorer, you go into a folder by double-clicking it. In a terminal
you say go there.

Those three ideas are where am I, what is here, and go there. The words
for them are on your terminal card. You do not need to remember them. The
course never tests whether you know a command.

The terminal does one thing that clicking does not. It shows a blinking
cursor and nothing else moves. Many people read that as the machine
waiting for them to get something right. It is waiting for you to type and
press Enter. Nothing happens before that. It never goes ahead on its own
and it does not care how long you take. If you type something and nothing
happens, you have probably not pressed Enter. That is the most common
problem in this session, and it happens to everyone.

The three commands for where am I, what is here and go there only look.
They cannot change or delete anything, and you can run them as often as
you like. The first exercise ends with the same folder open twice: the
terminal on one side, your ordinary file browser on the other, showing the
same files.

This is the first session that needs the software you installed. If it
does not work, stop and tell your instructor. Do not reinstall anything
or follow fixes from the internet. A failed install is a problem with the
setup instructions, and it is quick to diagnose from what the window
printed.

> Lab card: the three commands, what each one shows you, and how to get to
> your practice folder are on the terminal card. Keep it beside the laptop.

> Lab card: one thing to do before the first exercise, and the exercise steps
> open with it — a single word that fetches any course fixes published since
> you set up. It takes seconds, most weeks it says there is nothing to do,
> and it is on the terminal card with the rest.

> Recall: what_is_a_terminal

## Segment 2 — Why you learn to undo first

An agent changes files, and it has no general undo. So before you let one
near anything, you learn two commands. The first, commit, saves a snapshot
of your practice folder exactly as it is now. The second, revert, puts the
folder back to one of those snapshots. Save a state; go back to a saved
state.

You use them before any agent runs. You delete a file yourself, see that
it is gone from your file browser, and get it back. Later in the session
you tell the agent to ruin a named file, and you undo that too.

The order matters. Someone who has only been told the safety net exists
does not believe it, and someone who does not believe it does not
experiment. They give the agent small, cautious instructions and learn
very little. Someone who has deleted a file and got it back will try
things. The practice week depends on that.

Two properties of revert make it safe to use. First, going back can itself
be undone. When you put the folder back, revert records that as a new
snapshot and erases nothing. If you pick the wrong snapshot, run revert
again and pick the other one. The list is newest first, and most people
pick the wrong one at least once, so read the names, not the numbers.
Second, if you have changed something since your last snapshot, revert
stops and offers to save it before it goes anywhere.

Know the limits before you rely on it. Revert rolls back ordinary changes
to files in your practice folder. It does not unsend an email. It does not
reach outside that folder. It does not undo anything the agent did
elsewhere. It cannot pull back anything already sent to a model provider:
whatever you type to the agent is sent as soon as you send it. The
practice folder keeps your work visible and recoverable. It is not a
security boundary, so follow the written steps and do not rely on the
folder to protect anything.

> Lab card: the two commands, the questions the undo command asks you, and
> what to do if it says there are no checkpoints yet — all on the terminal
> card, with the exercise steps.

> Recall: why_the_safety_net_comes_first

## Segment 3 — Watching something act

Session 1 said that a chatbot produces text about the work, and an agent
does the work. In this session you see that happen in your own folder.

You give the agent a piece of work in plain English. Instead of a
paragraph, small boxes appear on the screen, one after another. Each box
is one thing it did: it read a file, wrote a file, or ran a command. These
boxes are called tool calls. They are the nearest thing you get to a
receipt.

Expect few of them. Two boxes is a normal run. A single write is a whole
file created, correctly formatted, in a few seconds. A short list does not
mean it did nothing, or that you missed something. The work is in the
file.

Sometimes the boxes show it doing something you would not have done. It
might rewrite a file without reading it first, or rename something you did
not mention. Noticing that is the skill this session teaches, so when it
happens, write it down.

You delegate twice. First you ask the agent to make a practice file shaped
like one of your own tasks: a list of records with the mistakes you
usually fix. Then you ask it to do the task on that file.

What you type goes to a model provider so the model can answer, and so
does any file the agent reads. You cannot turn that off. So you describe
the shape of your work, for example a list of tickets where the priority
is written four different ways, and ask the agent to invent fifteen rows
of it. No client names, no real figures, no confidential files. If you
would rather not describe your work at all, the lab has prepared tasks
that work the same way.

Three things from your inventory sheet go in: the row you starred, one
sentence on what the messy version looks like, and column 2, what done
right looks like. You wrote column 2 before you had seen this software.

> Lab card: the two delegation prompts, and the prepared alternative if you
> would rather not describe your own work, are in the exercise steps.

> Recall: what_tool_calls_are

## Segment 4 — The three questions

When the agent finishes, it writes a paragraph about what it did. The
paragraph is fluent and confident, and it describes what the agent
intended. The boxes show what it did. The file shows the result. Read the
boxes and the file.

After every delegation, ask three questions in this order.

First: what did it do? Scroll back through the boxes and name each one in
your own words. It wrote the file. It ran a command to rename it. Note
anything that surprises you.

Second: what changed in the folder? Open the actual file in your file
browser and look at it. Check whether anything else in the folder changed.

Third: was that reasonable, and how do I know? This is the question the
session is for. You already wrote the answer: column 4 of your inventory
sheet, the number you would re-add or the name you would recognise. Apply
that check to what the agent made.

Your check gives one of four answers. Fine: it did what I would have done.
Fine, but it made a judgment call I should know about. Wrong, and my check
caught it. Or: I could not tell.

If you could not tell, the task as you framed it is outside your judgment
boundary. Session 1 taught you to find exactly that. Write down what you
would need to know to check it.

Then keep asking one more question: what could it have got wrong that my
check would not find? Counting rows catches missing rows. It catches
nothing if two people's figures were swapped, because the count is the
same. Every check misses something. Know what yours misses.

If the agent does something surprising, write down what it did and how you
noticed. If everything goes smoothly and your check finds nothing, that is
one run in which it behaved. It does not prove the next run will.

> Lab card: the three-box worksheet is on your lab card. Fill one in after
> the delegation in the lab, and one more in the practice week.

> Recall: the_three_questions
