# Session 2 — Meeting the harness

<!-- Chunk: docs/chunks/platform_student_index - The student's index for Session 2, written from its README and PREWORK -->

This is the session where the course becomes hands-on. Session 1 needed
nothing but you and somewhere to write; this one needs the software you
installed to be working, and the first thing you do is check that it still
is.

**By the end you will have** run an agent on your own machine and watched
it change a real file at your instruction; said what it actually did by
reading the tools it used rather than repeating its summary; named the
specific thing you checked to decide whether the result was any good; and
used `revert` at least once to undo a mess on purpose.

## What it will cost you

| | |
|---|---|
| **The concept track** | About **25 minutes**. Four segments, listened to or read, with nothing to type. |
| **The lab** | About **125 minutes**, across several sittings. |

The lab figure includes the practice week. Working on your own there is no
"between sessions" to do practice in, so the laps that follow the main
block are simply the last sittings of the lab and are counted in the 125
minutes rather than added on top. Each sitting comes with its own honest
number and the one thing you should have at the end of it. The safety net
comes before the first delegation, and that order is not decoration —
nothing gets delegated until you have proved you can undo it.

## What you will do

**In the concept track**, four things: what a terminal actually is — a
window onto a folder you already know, where you say what you want instead
of pointing at it; why you learn to undo before you learn to delegate;
what it looks like when something *acts* rather than converses; and why
the paragraph an agent writes about its own work is not evidence that the
work was done. The mechanics stay at the desk; the track carries the
reasons.

**In the lab**, five steps and then the practice laps. You find your way
to your practice folder and see the same folder in the terminal and in
your normal file browser at once. You save a snapshot of it, delete
something on purpose, and get it back. You give an agent a piece of work
shaped like something from your own inventory, and watch it do it. Then —
this is the session, the rest is getting you here — you work out what it
actually did and decide whether it was any good, using the check you wrote
on your inventory sheet weeks ago. Last, you tell it to ruin a named file
and you undo that too.

The practice laps that follow are the same loop on your own work: one full
lap within a couple of days, then two real tasks, then one worksheet
filled in properly on whichever one went worst.

## Before you start

The prework is about 25 minutes: a short piece of reading, one decision,
and two commands.

The decision is which entry from your toil inventory you will bring. A
good one is marked *in*, involves a list or a file or a set of records —
something with rows in it for an agent to grip — and has a real check
written against it rather than "I'd read it over". Star it, and write two
rough sentences under it: what the messy version looks like, and what
"done right" looks like. That second one you already wrote, in column 2.
People find the first sentence hardest under time pressure, which is why
it is worth doing now with your feet up.

The two commands are in the course terminal. `course-update` fetches any
course fixes published since you set up — most weeks it says *Nothing to
do*; if it tells you to close the window and open a new one, do that.
Then `course-smoke-test`, which prints a short list and ends in one word:
**PASS** or **FAIL**.

If it says FAIL, or something else happens: **stop there, and do not try
to fix it.** Do not reinstall anything and do not follow instructions from
elsewhere on the internet, and above all do not lose an evening to it. Keep
what the window printed, all of it, and take it to the course's TA — a
setup problem is quick to diagnose from what it printed, and it is a bug in
our instructions rather than in you.

The prework was written for a room, so it also asks you to email a
facilitator that word. On your own there is nobody to send it to: the check
is for you, and PASS means go ahead.

> **The exercises use invented data, but the agent still talks to a model
> provider.** What you type, and any file the agent reads, is sent to that
> provider so the model can respond. Describe only the general shape of
> your work and ask the agent to invent the rows; do not put confidential
> names, facts or files anywhere near it. If you would rather not describe
> your work at all, there are prepared synthetic tasks that work just as
> well.

Everything today happens in one folder — `course-practice`, which your
setup created. That keeps the file changes easy to see and easy to
recover. It is not a security boundary, so follow the written prompts
rather than treating the folder's location as protection. What `commit`
and `revert` give you is real but specific: ordinary local file changes in
that folder can be rolled back. They do not un-send an email, recall
anything given to a model provider, or make everything an agent might do
safe.

## What you hand in

Four things, and each of them is a by-product of the lab rather than
homework on top of it.

1. **Your session log.** pi — the harness you will be running — keeps a
   record of every session as a file on your own machine: the tool calls
   themselves, rather than the summary it wrote about them. It does that
   automatically, so there is nothing to do during the lab to produce one,
   and `pi -r` is what finds it again afterwards.
2. **Your filled-in what-did-it-do worksheet**, including the box where
   you name the check you applied and what it told you.
3. **The output of `revert --list`.** `commit` and `revert` are commands
   *you* type rather than tools the agent calls, so using them leaves no
   trace in the session log at all. The checkpoint history that
   `revert --list` prints is the evidence that you undid something.
4. **The files from your practice folder** — the thing an agent changed on
   your own machine, which is the plainest form of the first outcome.

Three of them are facts anyone can read off a file. The worksheet is the
one where you say what happened in your own words — what the agent did,
and what you checked — and it is the one the session is really for.
Delegating plenty and never naming what you checked is learning to operate
software, which is not what this course is selling.

## What comes next

Session 3 takes it as given that you can run a delegation unaided and read
what it did, and teaches you to write down, on one page, exactly what an
agent needs to do one of your own tasks — and to find the missing piece
when a delegation goes wrong. The worksheet from your practice laps is
what opens it.
