# Session 2 — Meeting the harness

This is Session 2 of Agentic 101. It has four parts. Each one ends with a
question. Answer it yourself, out loud if you can, before you hear the model
answer. Nothing here asks you to type anything. Every step is in the lab,
where you'll need it.

## Segment 1 — The agent's folder

In this session you work with an agent for the first time. You'll do it on
your agent page, which comes with the course and needs nothing installed.

The agent has a folder of its own. Everything it makes or changes lives
there, and you can see the whole folder on the page, listed under Your
files. When you ask the agent for something, it works inside that folder
and nowhere else. So the folder is where you look to see what it did.

The page shows you the work as it happens. Each time the agent does
something, a step appears, labelled with what it did. It read a file. It
wrote a file. It changed part of a file. It ran a command. You'll get to
know these four in the lab.

The page also waits for you. Nothing happens until you send a request, and
the agent stops when it has finished what you asked. If it's taking a
while, you'll see a Stop button, and you can use it.

Your first exercise is simply finding your way round the page. You'll ask
the agent what's in its folder and tell it not to change anything. You'll
see it look and nothing else.

Some students run the agent on their own computer instead, in a terminal.
If that's you, the lab gives you the same exercises with terminal steps,
and a card with every command on it. Either way, the ideas in this audio
are the same.

> Lab card: where the request box, Your files and the list of earlier
> versions are on your agent page, and the terminal card if you run the
> agent on your own computer.

> Recall: what_is_a_terminal

## Segment 2 — Why you learn to undo first

An agent changes files. So before you let it near anything that matters,
you learn how to put things back.

Your agent page gives you two ways. Undo the last request takes back
whatever the agent changed in answer to your most recent request. Earlier
versions is a list of points you can go back to, usually named after the
request each one came from. Going back puts every file as it was then. If
you run the agent on your own computer, the same two ideas are two
commands: commit saves a snapshot of your folder, and revert puts the
folder back to one.

You use them before the agent does any real work. You'll ask it to make a
small file, undo that, and then get the file back from the list of earlier
versions. Later in the session you'll tell the agent to ruin a file on
purpose, and you'll put that right too.

The order matters. Someone who has only been told the safety net exists
doesn't believe it, and someone who doesn't believe it doesn't experiment.
They give the agent small, cautious instructions and learn very little.
Someone who has seen a file come back will try things. The practice week
depends on that.

Going back can itself be undone. Going back to an earlier version loses
nothing, and you can come forward again from the same list. If you pick the
wrong one, pick again. Read the names in the list rather than counting.

Know the limits before you rely on it. Undoing puts files in the agent's
folder back. It doesn't unsend an email, and it doesn't reach anything
outside that folder. It can't pull back anything already sent to the model
provider, because whatever you type to the agent is sent as soon as you
send it. Undo keeps your work recoverable. It doesn't make it private.

> Lab card: Undo the last request and Earlier versions on your agent page,
> or commit and revert on the terminal card, with the exercise steps.

> Recall: why_the_safety_net_comes_first

## Segment 3 — Watching something act

Session 1 said that a chatbot produces text about the work, and an agent
does the work. In this session you see that happen.

You give the agent a piece of work in plain English. Instead of a
paragraph, steps appear on the screen, one after another. Each step is one
thing it did: it read a file, wrote a file, changed one, or ran a command.
These steps are called tool calls. They're the nearest thing you get to a
receipt.

Expect few of them. Two steps is a normal run. A single write is a whole
file created, correctly formatted, in a few seconds. A short list does not
mean it did nothing, or that you missed something. The work is in the
file.

Sometimes the steps show it doing something you wouldn't have done. It
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

Three things from your toil inventory sheet go in: the row you starred, one
sentence on what the messy version looks like, and the second column, what
done right looks like. You wrote that column before you had seen this
software.

> Lab card: the two delegation prompts, and the prepared alternative if you
> would rather not describe your own work, are in the exercise steps.

> Recall: what_tool_calls_are

## Segment 4 — The three questions

When the agent finishes, it writes a paragraph about what it did. The
paragraph is fluent and confident, and it describes what the agent
intended. The steps show what it did. The file shows the result. Read the
steps and the file.

After every delegation, ask three questions in this order.

First: what did it do? Scroll back through the steps and name each one in
your own words. It wrote the file. It ran a command to rename it. Note
anything that surprises you.

Second: what changed in the folder? Open the actual file and look at it. Check whether anything else in the folder changed.

Third: was that reasonable, and how do I know? This is the question the
session is for. You already wrote the answer, in the How I'd check column
of your toil inventory sheet: the number you would re-add or the name you would recognise. Apply
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
