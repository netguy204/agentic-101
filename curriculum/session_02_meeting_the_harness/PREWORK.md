# Before Session 2

<!-- Chunk: docs/chunks/fluency_session_02 - Session 2 prework -->

**About 25 minutes.** Something to read, one decision to make, and one
command to run.

Session 2 is the first hands-on session — you'll be using the software you
installed before the course. **None of that happens in this prework.**
Nothing here asks you to learn anything technical, and if your setup isn't
working, part 3 tells you exactly what to do, which is not "fix it".

---

## 1. Read this (10 minutes)

### What a terminal is, and why we're using one

You're about to spend an hour in an app where you type instructions instead
of clicking them. It has a reputation, and it's worth dismantling that
reputation before the session rather than during it.

Here is the whole thing: **a terminal is a window onto a folder.** The same
folders you see in Finder or File Explorer, the same files, the same
computer. You just say what you want in words instead of pointing at it.

Everything the course asks you to type is something you already do by
clicking:

| What you want | Clicking | Typing |
|---|---|---|
| Which folder am I in? | Read the window's title | `pwd` |
| What's in here? | Look at the icons | `ls` |
| Go into that folder | Double-click it | `cd` |

That's enough to begin. Every command you need is on a reference card that
stays beside your laptop. You are not expected to memorise any of them.

> **The blinking cursor isn't waiting for permission — it's waiting for
> you.** Nothing happens until you type something and press Enter. It never
> goes ahead on its own, it isn't counting down, and it doesn't care how long
> you take. If you type something and nothing happens, you almost certainly
> forgot to press Enter. That is by far the most common thing that goes wrong
> and it happens to everybody.

The three commands above only *look*. They cannot change or delete anything,
ever. You can run them as often as you like.

### The thing you were promised in Session 1

You may remember someone asking "what if it deletes my files?" and the answer
being "you'll get a real one in Session 2". Here it is.

The agent changes files, and it has no undo button. So before we let it near
anything, you'll learn two commands:

- **`commit`** — save a snapshot of your practice folder exactly as it is now.
- **`revert`** — put the folder back to one of those snapshots.

In the session you will use them for real: you'll delete a file on purpose,
watch it be gone, and get it back. Then, later, you'll deliberately tell the
agent to ruin your work and undo that too. This proves a specific recovery
move: ordinary local file edits in the practice folder can be rolled back. It does not make everything an agent can
do safe, recover an email already sent, or protect information sent to a
model provider.

Today's exercises use one folder — `course-practice`, which your setup
created — to keep the local file work easy to see and recover. The folder is
not a security boundary, so follow the written prompts rather than treating
its location as protection.

### What the hour actually looks like

1. Find your way to the practice folder, and see it in the terminal and in
   your normal file browser at the same time.
2. Save a checkpoint. Delete something. Get it back.
3. Give an agent a piece of work and watch it do it.
4. Work out what it actually did, and decide whether it was any good — using
   the check you wrote on your own inventory sheet weeks ago.
5. Break something on purpose and undo it.

Step 4 is the session. The rest is getting you to a place where step 4 is
possible.

---

## 2. Pick the entry you'll use (10 minutes)

Get your **toil inventory** out. You've been growing it for a week; it should
have somewhere around 8–10 entries with the check column filled in.

Now choose **one entry** to bring to the session. You'll point an agent at it
during the session. A good one has three properties:

| | Why |
|---|---|
| **Marked `in`** — you could tell good work from bad | Everything on this course stays inside your judgment boundary, and today is no exception |
| **It involves a list, a file, or a set of records** — something with rows or items in it | The agent works on files, so a task with no "thing" in it has nothing to grip |
| **Column 4 says something specific** — a real check, not "I'd read it over" | You'll be applying that check for real, in the room |

Put a star next to it. Then, so you're not composing at the keyboard during
the session, write two rough sentences underneath:

1. **What the messy version looks like.** Not the task — the *material*.
   "A list of tickets where the priority is written four different ways",
   not "sorting my ticket queue". This is the sentence people find hardest
   in the room, which is why you're writing it now with your feet up.
2. **What "done right" looks like.** You already wrote this, in column 2.
   Copy it out.

> **The exercise uses invented data, but pi still talks to a model provider.**
> What you type, and any file pi reads, is sent to that provider so the model
> can respond. During the session you will describe only the general shape of the
> work and ask the agent to invent fifteen rows; do not include confidential
> names, facts, or files. There are prepared synthetic options if you would
> rather not describe your work at all.

**If your inventory is thin**, don't panic and don't pad it. One good entry
is all the session needs. Bring what you have and tell your facilitator.

---

## 3. Run two commands, and tell your facilitator (5 minutes)

The second is the same check you ran at the end of the setup guide. Both
take seconds.

Open the course terminal — **Mac:** `Command + Space`, type `Ghostty`, Enter.
**Windows:** Start, type `Terminal`, Enter on **Windows Terminal** (not "Git
Bash"). Then type this and press Enter:

```
course-update
```

It fetches any course fixes published since you set up — most weeks it
says **Nothing to do.** If it tells you to close the window and open a new
one, do that. Then type this and press Enter:

```
course-smoke-test
```

It prints a short list and ends in one word: **PASS** or **FAIL**.

**Reply to your facilitator with that word.** If it said FAIL, or if
something else happened, send a screenshot of the whole window as well.

> ### If it says FAIL — or anything else goes wrong — stop there.
>
> **Do not try to fix it.** Don't reinstall anything, don't follow
> instructions from elsewhere on the internet, and above all don't lose an
> evening to it. Send the screenshot and go and do something else.
>
> Setup problems are expected, they are quick to diagnose from a screenshot,
> and they are a bug in our instructions rather than in you. Your facilitator
> will either fix it with you in a short slot before the session or pair you
> with someone in the room. **Either way you will do every exercise in the
> session.** Nobody sits and watches.
>
> The one thing that genuinely costs you something is arriving having spent
> three hours fighting it alone.

---

## What to bring

- **Your toil inventory**, with one entry starred and the two rough
  sentences under it.
- **Your laptop and its charger.** An hour of this drains a battery.
- Nothing else. No preparation beyond this page, and no commands to
  memorise — use the reference card throughout the session.
