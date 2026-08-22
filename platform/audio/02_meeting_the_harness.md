# Session 2 — Meeting the harness

This is the concept track for session two, and it is the session where the
course becomes hands-on — which makes this recording a slightly odd object,
so let me be clear about what it is for. Nothing here asks you to type
anything. Every command, every screen and every step is on your lab card and
in the written material, waiting for you when you sit down. What is here is
the part that is worth having in your head before you get there: what a
terminal actually is, why you learn to undo things before you learn to do
them, and the one habit this session exists to build. Four segments, each
about four or five minutes, each closing with a question to answer out loud.

## Segment 1 — A window onto a folder

You are about to spend an hour in an app where you type instructions instead
of clicking them, and that app has a reputation. I want to dismantle the
reputation now, on a commute, rather than while you are sitting in front of
it with your heart rate up.

Here is the whole thing. A terminal is a window onto a folder. The same
folders you already see in Finder or File Explorer. The same files. The same
computer. You are just saying what you want in words instead of pointing at
it.

Everything the course asks you to type is something you already do by
clicking. Today, to find out which folder you are in, you read the title bar.
In a terminal you ask, and it tells you. Today, to see what is in a folder,
you look at the icons. In a terminal you ask for a list. Today, to go into a
folder, you double-click it. In a terminal you say go there.

Three ideas, and you already own all three. The words for them are on your
lab card and you are not expected to remember any of them, ever. Remembering
commands is not the skill this course teaches, and it is never the test.

There is one thing about the terminal that genuinely is different from
clicking, and it is the thing that unsettles people, so let me name it. It
does not look like it is doing anything. There is a cursor, and it blinks,
and nothing else moves. People read that as a machine waiting for them to get
something right.

It is not. The blinking cursor is not waiting for permission — it is waiting
for you. Nothing happens until you type something and press the enter key. It
never goes ahead on its own. It is not counting down. It does not care how
long you take, and it will sit there exactly as long as you need. If you type
something and nothing happens, you have almost certainly not pressed enter
yet, and that is by far the most common thing that goes wrong in this
session. It happens to everybody, it happens to me, and it means nothing
about you.

While I am handing out reassurances: this is the first session that needs the
software you installed before the course to actually work, and for some
people it will not. That is expected, it is planned for, and it is not
something you are supposed to solve alone at eleven at night. If your setup
is broken, say so and let it be fixed properly. People lose entire evenings
to this, having read something confident on the internet, and they arrive the
next morning with a worse problem than they started with. Do not be that
person. Nothing about a failed install says anything about whether you are
going to be good at this.

One more reassurance, and this one is a fact about the commands rather than a
sentiment. The three ideas I just described — where am I, what is here, go
there — only look. They cannot change anything, they cannot delete anything,
and you can run them as many times as you like. There is no version of them
that breaks something. So the first stretch of this session is genuinely
risk-free, and the exercise ends with the same folder open in both windows at
once: the terminal on one side, your ordinary file browser on the other,
showing you the same files. That is the moment it stops being a mystery, and
it is worth waiting for.

> Lab card: the three commands, what each one shows you, and how to get to
> your practice folder are on the terminal card. Keep it beside the laptop.

> Recall: what_is_a_terminal

## Segment 2 — Why you learn to undo first

Now the part of the session's design I actually want to argue for, because if
you understand why it is ordered this way you will get considerably more out
of it.

You may remember somebody in session one asking what happens if it deletes my
files, and being told they would get a real answer in session two. Here it
is.

The agent changes files, and it has no undo button. Not a small one, not a
hidden one — there is no general undo. That is a real property of the tool
and I am not going to soften it.

So before you let it near anything, you learn two commands. One saves a
snapshot of your practice folder exactly as it is right now. The other puts
the folder back to one of those snapshots. Save a state; go back to a saved
state. That is the entire mental model, and it is the same one you already
have for a photograph and an undo arrow.

You do not just hear about them. You use them, on purpose, before any agent
runs: you delete a file yourself, watch it be gone from your own file
browser, and get it back. Then, much later in the session, you deliberately
tell the agent to ruin a named file of yours, and you undo that too.

That ordering is not politeness. It is the load-bearing decision in the
session. Somebody who has only been told the safety net exists does not
believe it, and somebody who does not believe it does not experiment. They
give the agent cautious, hedged, tiny instructions, learn very little, and go
back to their normal week. Somebody who has deleted a file and got it back
has felt it, and they will try things. The practice week after this session
is where the habit either sets or does not, and it sets in the people who are
willing to break something.

There is one more property of the undo worth knowing before you meet it,
because it removes the last hesitation people have. Going back is itself
undoable. When you put the folder back to an earlier state, that is recorded
as a new saved state rather than erasing anything, so if you pick the wrong
one — and you will, at least once, because the list is newest first and
people count in the wrong direction — you simply do it again and pick the
other one. Nothing is destroyed quietly, either: if you have changed
something since your last snapshot, it stops and asks you about it before it
goes anywhere. Those two properties are the difference between a safety net
you use and a safety net you are frightened of.

Now the honest limits, because a safety net described loosely is worse than
no safety net at all. What these commands do is roll back ordinary changes to
files in your practice folder. That is genuinely useful and it covers what
you will do in this session. What they do not do: they do not unsend an
email. They do not reach outside that folder. They do not undo anything the
agent did in the wider world, and they do not pull back information that has
already been sent to a model provider, because the moment you type something
to the agent, it has been sent. The folder is a tidy desk, not a locked
cabinet — it keeps your work visible and recoverable, and it is not a
security boundary. Follow the written instructions rather than treating the
location as protection.

Two commands, one real limit, and a session that makes you use both before it
lets you do anything interesting.

> Lab card: the two commands, the questions the undo command asks you, and
> what to do if it says there are no checkpoints yet — all on the terminal
> card, with the exercise steps.

> Recall: why_the_safety_net_comes_first

## Segment 3 — Watching something act

Session one drew a distinction in the abstract: a chatbot produces text about
the work, and an agent does the work. This session is where you watch that
happen in your own folder, and I want to prepare you for what it actually
looks like, because it is stranger and more ordinary than people expect.

You will give it a piece of work in plain English. It will think for a
moment. And then, instead of a paragraph, you will see a series of small
boxes appear on the screen, one after another. Each box is one thing it did.
It read a file. It wrote a file. It ran a command to list what is in the
folder. Those boxes are called tool calls, and they are the closest thing you
will ever get to a receipt.

Two things about them surprise everybody the first time.

The first is how few there are. People expect a torrent and get two boxes. A
single write is a whole file created, from nothing, correctly formatted, in
about four seconds. A short list is not a sign that it did not really do
anything, and it is not a sign you missed something. It is what competence
looks like from the outside: the work is in the file, not in the number of
steps it took.

The second surprise is more interesting, and it is the one to listen for. The
boxes sometimes do not do what you would have done. It might rewrite a file
without ever having read it. It might rename something you did not mention.
It might take a completely reasonable route you would not have chosen. None
of that is failure — it is the thing you are here to learn to see. An agent
doing something surprising in front of you is the best thing that can happen
in this session, because it is the only way to learn that it is a thing that
can happen.

You will do this twice, deliberately. The first delegation asks it to build
you some practice material shaped like your own toil — a list of records with
exactly the kind of mess you deal with. The second does the real task on that
material. The point is not that it succeeds. It very often will, and that is
almost beside the point. The point is that you watched something act rather
than converse, on your own machine, in a folder you can see in your ordinary
file browser at the same time.

A word about what you actually send it, because this is the point at which
that stops being abstract. What you type goes to a model provider so the
model can answer, and so does any file it reads. That is how the thing works;
it is not a setting you can turn off. So in this session you describe the
shape of your work rather than its contents — a list of tickets where the
priority is written four different ways — and you ask the agent to invent
fifteen rows of it. Real shape, invented data. No client names, no actual
figures, no confidential file. If you would rather not describe your work at
all, there is a prepared alternative that works just as well and is not a
consolation prize.

And you will be using your own work, which is what makes it land. The entry
you starred on your inventory sheet, the messy version you described in a
sentence, and the definition of done you wrote weeks ago before you had ever
seen this software — all three go in. That last one matters more than it
looks, and the next segment is about why.

> Lab card: the two delegation prompts, and the prepared alternative if you
> would rather not describe your own work, are in the exercise steps.

> Recall: what_tool_calls_are

## Segment 4 — The paragraph is not the evidence

This is the segment that is the session. Everything else has been getting you
to a place where this is possible.

When the agent finishes, it writes you a paragraph explaining what it did.
It is a good paragraph. It is fluent, it is confident, it is organised, and
it will tell you that it standardised your statuses and tidied up the dates.
And here is the problem: that paragraph is the thing you are most likely to
read, and it is the thing least able to tell you what happened. It describes
intentions. The boxes describe actions. The file is the result. Three
different objects, and only two of them are evidence.

So the session gives you three questions, in a fixed order, because the order
is the skill.

First: what did it do? Answer that by scrolling back through the boxes and
naming them in your own words. It wrote the file. It ran a command to rename
it. Not what it said it did — what the boxes show. And notice anything
surprising while you are there.

Second: what changed in the folder? Open the actual file, in your ordinary
file browser, not the summary in the terminal. Look at it. See whether
anything else in the folder moved.

Third, and this is the one the whole course is about: was that reasonable,
and how do I know? Not was it plausible. Not did it look tidy. How do I know.

And you already have the answer to that, which is the quiet trick of this
whole course. The check column on your inventory sheet — the number you would
re-add, the name you would recognise, the rule you would apply — you wrote
that before you had ever seen this software, when you were thinking about
your work rather than about a tool. Now you apply it, for real, to something
a machine made. That is the entire method, and it is why session one spent an
hour on a list.

There are four honest answers to what your check told you, and I want you to
hear the fourth one properly. Fine, it did what I would have done. Fine, but
it made a judgment call I should know about. Wrong, and my check caught it.
Or: I could not tell.

I could not tell is the most valuable answer on the page. It is not a
failure, and it is not you being slow. It means the task, framed the way you
framed it, sits outside your judgment boundary — which is exactly the finding
session one was training you to make, arriving now in your own hands, on your
own work. Write down what you would need to know in order to check it. That
sentence is worth more than a successful delegation.

And then one question to carry away, which you do not have to answer today
but do have to keep asking. Not what did it get wrong. What could it have got
wrong in a way my check would not have found?

That question is the one that separates this course from a tutorial, so sit
with it for a second. Counting the rows is a real check and it catches a
whole class of failure — things going missing. It catches nothing at all
about two people's figures being swapped, because the count is the same
either way. Every check has a shape, and the shape has a hole in it, and
knowing where your hole is worth more than any amount of confidence about
what the tool can do.

Last thing, and it is about what a good session looks like. If the agent does
something surprising in front of you, that is not the session going wrong. It
is the best thing that can happen, and it is very hard to arrange
deliberately. And if everything goes smoothly and your check finds nothing —
that is fine too, but do not read it as proof. It is one run in which the
model behaved. The habit is what you are building here, not the result, and
the habit is what makes the difference in six weeks' time.

> Lab card: the three-box worksheet is on your lab card. Fill one in after
> each delegation — one for the room, one for the practice week.

> Recall: the_three_questions
