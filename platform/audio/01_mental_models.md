# Session 1 — Mental models and the toil inventory

Welcome to Agentic 101. This is the concept track for session one, and it is
meant to be listened to. You do not need a screen, a keyboard, or a free
hand. There are four segments, each about four or five minutes, and each one
ends with a question you answer out loud before I give you my version of the
answer. Nothing in this session asks you to install anything or type
anything — session one is a conversation, and if the software you were sent
before the course did not work, you will not miss a minute of this. When
something does need your hands, I will say so, and it will be waiting for you
on your lab card.

## Segment 1 — Why now, and why you

I want to start with an argument rather than a definition, because if the
argument does not land, the definitions will not be worth having.

Start with something true about you. You know your job deeply. You know the
edge cases. You know the tedious reports, and the workarounds you have built
in spreadsheets over the years, and the reason the numbers in that one column
are always wrong in March. Nobody wrote that down anywhere. It is not in a
process document. It lives in you, and until quite recently there was no way
for it to be anywhere else. That knowledge is about to become a new kind of
leverage, and the rest of this segment is the argument for why.

For about forty years, one profession has had a structural advantage that
had nothing to do with being smarter than anybody else. A software engineer
could take a decision — when this happens, do that; this input is suspicious;
this case needs a human — write it down once, and have it govern thousands of
executions afterwards, without them in the room. Their judgment compounded.

Everybody else's judgment ran live. Yours has run one meeting at a time, one
review at a time, one document at a time. You have made thousands of good
calls, and each of them applied exactly once. Not because your judgment was
worth less. Because there was no way to encode it that did not require
learning to program, and learning to program was a career, not an afternoon.

That is what has changed. Agentic tools let judgment expressed in plain
language govern automated work. Take an instruction like: flag anything from
a customer who has mentioned cancelling, because retention is what we are
protecting this quarter. That is not a program. That is a sentence you could
say to a new colleague. It is now also a thing you can write down once and
have applied every time, by something that does the typing for you. No code,
no ticket to the technology team, no waiting.

Which means the scarce input has moved. It used to be the keystrokes —
somebody who could build the thing. Now the keystrokes are cheap, and the
scarce input is knowing what is worth building, and whether the result is
right. That is exactly what you have, and exactly what these tools do not.

So this course is not about catching up to programmers. You will not write
any code on it. It is about the thing that is now in short supply: your
judgment, and how to spend it where it buys the most.

Now the hard edge, stated honestly, because you will meet it either way and I
would rather you met it here.

You can safely hand over work you could not do yourself. That is normal. You
do it every time you hire a contractor or brief a designer, and nobody thinks
twice about it. What you cannot safely hand over is work whose result you
could not evaluate. An agent will produce a confident, fluent,
professional-looking answer to almost anything you ask it. If you are not
able to tell a good one from a bad one, you will not find out that it was
wrong. You will find out later, from somebody else, expensively.

Being able to do the work, and being able to judge the work, are two
different abilities. Only one of them is the limit. This session is about
finding where yours runs out — and that turns out to be a genuinely useful
thing to know about yourself, quite apart from any of this.

Hold on to that distinction. Everything in the next three segments is built
on it, and if you take one idea away from the whole course, this is the one I
would pick.

> Recall: judgment_is_the_scarce_input

## Segment 2 — What an agent actually is

Now some furniture. Two words, and the difference between them.

You have almost certainly used a chatbot. You type a question, it types an
answer, and the answer arrives as text in the window. Whatever you do with
that text afterwards, you do. You copy it into a document. You retype the
useful half. You paste it into an email and fix the tone. The work of moving
the answer into the world is yours, every time, and it is often most of the
work.

An agent is the same underlying model with two things added: it can take
actions, and it can take a sequence of them without asking you between each
one. It can read a file on your computer. It can write one. It can run a
command. It can look at what came back and decide what to do next. So when
you ask an agent to tidy up a list of supplier names, it does not describe
how you might tidy them. It opens the file, changes it, and saves it. The
file on your computer is different afterwards.

That is the whole distinction, and it is bigger than it sounds. A chatbot
produces text about the work. An agent does the work. One leaves you with
something to read; the other leaves you with something that has happened.

Two consequences follow, and they set up everything you will do next week.

The first is that an agent has to work somewhere. It acts on real files in a
real folder on your own machine, which means the question of which folder is
suddenly a question worth asking. In this course everything happens in one
practice folder that was made for you, so that the changes are easy to see
and easy to undo. That folder is not a security wall. It is a tidy desk.

The second consequence is the one this whole course turns on. Because the
agent acts rather than describes, its own account of what it did is not
evidence. It will write you a paragraph — a nice paragraph, in confident
prose, explaining what it has done and why. That paragraph is a description
of its intentions. The file is what happened. Those two things usually agree,
and when they do not, it is the paragraph that is wrong, and the paragraph is
the thing you were most likely to have read.

I am not asking you to distrust it. I am asking you to notice that there are
two different objects here, and that only one of them is the work. Next
session you will watch this happen on your own machine, in your own folder,
and it is a great deal more vivid when the file is yours.

One more thing, briefly, because people ask. An agent is not a person, and it
is not a colleague. It has no stake in the outcome, it does not know what
your company is like, and it will not come and tell you that the request
seemed odd. It is closer to an extremely fast, extremely literal contractor
who has never worked in your industry and has no way of asking around.

Which is worth holding on to, because it makes the failure mode predictable
rather than mysterious. A contractor like that does not fail by producing
obvious rubbish. They fail by producing something entirely reasonable that is
wrong in the one place only somebody from inside your organisation would
know to look. That is not a flaw to be fixed in a later version. It is a
straightforward consequence of the thing not being you, and it is the reason
that a rule runs through this whole course: every time you see what one of
these tools can do, the very next question is how you would check it. Not
eventually. Immediately, in the same breath, every time.

> Recall: agent_versus_chatbot

## Segment 3 — Judgment, expertise, and the boundary between them

Here is the part that makes this course different from every other course
about these tools.

Take a piece of work you do regularly and ask a question that has nothing at
all to do with software. If somebody handed me this work finished, could I
tell whether it was right?

Not: could I do it. Could I tell. Those are different questions, and almost
everybody runs them together the first time they are asked.

You do not need to be able to audit a set of accounts to notice that a total
is missing a region you know always reports late. You do not need to write
contracts to spot that a payment term has changed. That is judgment operating
well beyond your expertise, and it is the ordinary case, not the clever one.

And the reverse is true, and more uncomfortable. You might be perfectly able
to do a piece of work and still be unable to check it quickly enough for
checking to mean anything. If verifying the result takes as long as doing it
yourself, you have not delegated anything. You have just added a step.

The space where you can evaluate a result is your judgment boundary. Tasks
inside it are candidates for handing over. Tasks outside it are not — and I
want to be careful about why, because the reason is not the obvious one. It
is not that the tool cannot do them. Very often it can, and it will produce
something fluent and confident and entirely plausible. The reason is that you
could not catch it when it got them wrong. A confident, well-written review
of clauses you cannot evaluate is worse than no review at all, because now
there is a document that looks like diligence.

Say that back to yourself, because it inverts the way most people think about
risk. The dangerous task is not the hard one. The dangerous task is the one
where wrong looks exactly like right, to you.

Here is the shape of it, and it is worth picturing, because it is going to
happen to you at some point. A piece of work comes back. It is well
formatted. The totals add up. Every mechanical check you could think of
passes. And it is still wrong, in one specific place, for a reason that
depends on something about your organisation that was never written down
anywhere the tool could have read it — a region that always reports late, a
customer who is technically two customers, a status that means something
different on your team than it does anywhere else. Only somebody who knows
the place catches it. If that somebody is you, this is a good day. If nobody
in the loop is that person, the document goes out.

There is a third answer, by the way, and you are allowed to use it. Not sure.
That means: I think I could tell, but I would be guessing about how. Not sure
is an honest answer and a useful one. What it is not is a place to park
everything uncomfortable — the way out of it is to try to name the check, and
the attempt usually resolves it in one direction or the other.

Now, here is the thing nobody expects when they start this course. The tasks
you rule out are the most valuable findings you will produce. They are the
ones that would have hurt. Later in this course, ruling a task out because
you could not check it counts as demonstrated skill, not as a gap. Knowing
where your judgment runs out, and saying it out loud, is worth more than any
confident yes.

You will hear me come back to this in every session. Session two asks you
what you checked. Session three asks what your checks would still have
missed. The last session decides what you build on the strength of it. It is
the spine of the whole thing, and it is why the first thing I am going to ask
you to make is a list.

> Recall: judgment_not_expertise

## Segment 4 — The list you are going to keep

Somewhere in your week there is work you do again and again. Not the
interesting part of your job — the part around it. Pulling four regional
numbers into one summary every Monday morning. Reading a folder of supplier
renewals looking for anything that changed. Rewriting the same update for
three different audiences. Chasing people for the thing they promised on
Thursday. You know exactly which ones I mean, because you thought of two of
them before I finished the sentence.

Write them down. We call the list a toil inventory, and it is the single most
useful thing you will make on this course. Everything later points back at
it: the task you hand to an agent next session comes off this list, and so
does the project you finish the course with.

Three things make an entry worth writing. The first is that you actually did
it, recently. Not something you think you ought to automate one day — the
list is a record, not a wish. The second is that it is specific enough to
picture. Reporting is not an entry. Pasting last week's ticket counts into
the operations deck is an entry, because I can see it happening. The third is
that you can say what done right looks like, in one sentence, before anybody
mentions software. One table, one row per region, the totals matching what
each region reported, and no region silently missing. If you cannot write
that sentence, you have found something more interesting than a candidate for
automation. You have found a piece of work whose definition of done nobody
has ever written down.

Then two more things about each entry, and these are the ones that make the
list worth keeping rather than just worth writing.

For each entry, mark whether you could evaluate the result. In, out, or not
sure. In means I could look at the finished work and tell whether it is
right. Out means I could not; it would look fine to me either way. Not sure
means I think I could, but I would be guessing about how.

And then the one that does the real work: how you would check. This is the
proof of the mark you just made. Name the specific thing you would look at. A
number you would re-add. A name you would recognise. A rule you would apply.
A person who would complain. If you can write that sentence, the entry really
is in. If what you write is that you would just read it over and see, then
that is a not sure wearing a disguise. Go back and make it concrete, or mark
it honestly and move on.

Two things do not belong on the list, and both of them are tempting. The
first is work you have never actually done and could not describe — you
cannot judge it, so it cannot be evaluated for delegation, and putting it
down just makes the list longer. The second is frequency used as a substitute
for judgeability. It is in because I do it every week. That is not an answer
to the question, and it is the single most common wrong answer there is. How
often you do something has nothing at all to do with whether you could tell
it had been done wrong. Those are the two most common ways a sheet ends up
full and useless.

And one thing that does belong, which people leave off out of a kind of
embarrassment: the uncomfortable entries. The ones you would have to mark
out. Those teach you more than the confident ones, and by the end of this
course an entry you ruled out because you could not check it is treated as a
demonstration of skill rather than a shortfall. Put them on the list.

Two entries with a real check on them are worth more than ten with vague
ones. Three is the floor, not the goal, and the floor is what you need before
the next session. Keep the list somewhere you will actually keep it — printed
on your desk, a note on your phone, a document, the back of a notebook. Paper
is genuinely fine. What matters is that it is within reach during your
working week, because the best entries get written down in the ten seconds
after you catch yourself doing something for the fifth time.

> Lab card: the four-column sheet is on your lab card, with two filled-in
> rows to copy the shape from, and a set of prepared example tasks if your
> own work is confidential or the page stays blank.

> Recall: what_makes_a_good_entry
