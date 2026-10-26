# Session 1 facilitator guide — Mental models & toil inventory

<!-- Chunk: docs/chunks/fluency_session_01 - Session 1 facilitator guide -->

The student works through Session 1 alone on the platform (DEC-014). You
are their instructor: you answer what the automated help can't, and you
run live sessions, one to one or with a small group on a video call, when
a student needs one or you have scheduled one. Students see you as "your
instructor".

**The outcome:** the student has a list of their own repeating work, with
an honest mark against each row saying whether they could tell good work
from bad, and can explain that mark for one row. The bar is in
[`CHECKPOINT.md`](CHECKPOINT.md).

Nobody installs or types anything in this session. A student whose setup
failed can do all of it; their setup needs fixing before Session 2.

---

## What the student does

| Step | Time | Source |
|---|---|---|
| Prework: five things they did more than once last week | 10 min | `platform/prework/01_mental_models.md` |
| Concept track: four audio segments, each closed by a recall question | 15 min | `platform/audio/01_mental_models.md` |
| Fill the sheet, then the check column (exercises 1 and 2) | 25 min | [`EXERCISES.md`](EXERCISES.md) |
| The skeptic pass (exercise 3) | 12 min | [`EXERCISES.md`](EXERCISES.md) |
| The practice week: daily pass, check test, consolidation | 55 min over a week | [`PRACTICE.md`](PRACTICE.md) |
| Submit the sheet and one task, explained | — | The platform's checkpoint |

The sheet and its column definitions are
[`handouts/toil-inventory.md`](handouts/toil-inventory.md). A student who
can't use their own work uses
[`handouts/canned-toil.md`](handouts/canned-toil.md) for the whole session.

The platform checks the submission against the rubric. If the student's
answer is a near-miss, it asks the corrective question from
[`CHECKPOINT.md`](CHECKPOINT.md) and gives them a second try. After two
rounds, or when it isn't confident, it sends the case to you.

---

## Before your first student

- **Read** `docs/trunk/GOAL.md` and the Terminology section of
  `docs/trunk/SPEC.md`. Use SPEC's words for agent, judgment, expertise
  and judgment boundary; every later session builds on them.
- **Read** the handout, [`EXERCISES.md`](EXERCISES.md),
  [`EXERCISE_RUNSHEET.md`](EXERCISE_RUNSHEET.md) and
  [`CHECKPOINT.md`](CHECKPOINT.md).
- **Listen to the concept track** once, so you know what the student has
  heard.
- **Rehearse the Northwind demo** (below) if you will run live sessions.
  It needs a working pi install on your machine. If you don't have one,
  follow `setup/README.md` end to end, including the smoke test, a week
  ahead.

---

## Threads from students

Students reach you through "Stuck on this session?", then "Send to your
instructor". Escalations from the checkpoint arrive the same way. Reply in
the thread within a day.

What usually arrives in Session 1:

- **A checkpoint escalation.** The rubric's near-miss rows tell you what
  the student said and which question they have already been asked. Ask
  the next question down; the Recovery section of
  [`CHECKPOINT.md`](CHECKPOINT.md) lists the three usual causes and what to
  do for each.
- **"Can I use this task from my job?"** If the data or the task is
  confidential, they write the shape of the task and leave out the
  contents, or use the canned sheet. If their work can't be described even
  in outline, flag it now: Session 6 needs something real to point at.
- **A failed setup.** Nothing in Session 1 needs it. Offer a 20–30 minute
  call before they start Session 2, and work through `setup/README.md` and
  its troubleshooting table on that call.

If a thread would take more than three exchanges, offer a call.

---

## A live session

Offer one when a student is stuck on the check column, when their
checkpoint escalates twice, or as a scheduled group session. 30–45 minutes
on a video call, one student or a small group. The student has usually
heard the concept track, so the call does three things the platform can't:

1. **The Northwind demo, 10 minutes.** The student watches an agent give a
   confident, well-explained, wrong answer that only they can catch. The
   concept track describes this; the demo is the only place they see it.
2. **One row worked together, 5 minutes.** Take one of their rows, or
   Priya's Monday roll-up from the canned sheet, and fill in columns 3 and
   4 out loud. It sets how specific a check has to be.
3. **You as the skeptic, 10–15 minutes.** Run exercise 3 with you asking
   "How would you know if it was wrong?" until you believe the answer. A
   student who would rather not name the task can tell you only how they'd
   check it.

End with the checkpoint frame: "One task from your sheet. In or out. And
the check: how you'd know if it was wrong." A corrected near-miss counts.

**With a small group:** do the demo for everyone, then take each person in
turn for the skeptic pass while the others listen, or use breakout rooms of
two for four minutes each way. Ask for the checkpoint frame from each
person at the end, or have them submit it on the platform.

Don't fix a laptop during a Session 1 call. Book the setup call separately.

---

## The argument, if you have to make it live

The concept track makes the argument, and the student should hear it
before a call. If you need to restate it, keep the order:

1. **Software engineers have had leveraged judgment for forty years.** They
   could write a decision down once and have it applied thousands of times.
   Everyone else's judgment ran live, one call at a time.
2. **The reason was structural, and it has gone.** Encoding a decision
   meant writing code. Agentic tools take instructions in plain language.
3. **So the bottleneck has moved to knowing what's worth automating and
   what good looks like.** The student has that. The tool doesn't. "The
   agent does the typing; you supply the judgment."

Two framings to keep out:

- **Threat.** No "AI is coming for these jobs" or "adapt or be left
  behind", even as a joke. A student who hears threat defends themselves
  and stops listing their work.
- **Hype.** No "this changes everything" and no numbers you can't source.
  This audience has been sold to before. The demo shows the agent being
  wrong, which only works if you haven't promised magic.

### The terms, quoted from SPEC.md

> An **agent** is an LLM running in a harness with the ability to take
> actions — read and write files, run commands, call tools — not just
> converse.

> **Judgment** is the ability to discern a reasonable result from an
> unreasonable one *in a given domain* — to *evaluate* work without
> necessarily being able to produce it. **Expertise** is the ability to
> produce the work yourself.

> Your **judgment boundary** is the edge of the space where you can
> evaluate outcomes. Tasks inside it are candidates for delegation. Tasks
> outside it are not — regardless of how capable the agent is.

> **Delegation can substitute for expertise. Nothing substitutes for
> judgment.**

"In a given domain" matters: a person has judgment about some tasks and
not others. Priya can judge a status roll-up cold and can't judge a
liability clause.

A chatbot is a well-read colleague on the phone. An agent is a colleague
you handed your laptop to. The advice may be identical; the consequences
of it being wrong are not.

---

## The Northwind demo

Run both halves. The first shows the agent doing good work; the second
shows that only the student could catch where it went wrong. Never run the
first half without the second.

`demo/start-demo.sh` creates a clean working folder and prints a crib
(see [`demo/README.md`](demo/README.md)).

### Set up: give the student the domain knowledge

Before you touch the keyboard, say:

> "For the next ten minutes you work at Northwind Coffee. Two things you
> know about Northwind that nobody outside would: **Brand isn't part of
> Marketing here.** Brand sits under Product; it's a long-running org
> quirk everyone internally knows about. And **'Field' means the retail
> store teams**, not sales."

Keep those two facts visible, in the chat or on a shared slide.

### The file

`demo/headcount.csv`:

```csv
name,department
Alice,Marketing
Bob,marketing
Carol,Mktg
Dave,mktg.
Eve,MARKETING
Frank,Digital Mktg Team
Grace,Brand & Mktg
Hank,Field
Ivy,Field Sales
```

### First half: the agent does the work

Share your screen, run the agent in the demo folder, and send exactly:

> `headcount.csv` has department names written inconsistently.
> Standardize them to one clean name per department, and tell me what you
> chose and why.

Narrate the reasoning in plain language ("it's reading the file… it's
decided how to group them… it's writing the file back"). Don't explain
tool calls or the terminal; that is Session 2. Show the result. It will be
good: five spellings of Marketing collapsed correctly, each ambiguous call
explained.

### Second half: "how would you check this?"

Before you say whether it's right, ask:

> **"How would you check this?"**

Expect: count the rows; list the distinct values; look for a name you
recognise; check nobody was dropped; read the explanation. Praise the row
count and the distinct-values list; they are real, cheap checks. Then:
*"All of those pass on this file. Is it right?"*

Wait for **Grace.** `Brand & Mktg` has been folded into Marketing, which
is right almost everywhere and wrong at Northwind. Nothing in the file
said so. Then say:

> "It wasn't a bad answer. It was the best answer available to anyone who
> didn't know this company. The only thing that caught it was you knowing
> something the agent couldn't. That's your judgment, and it's why you
> have to be in the loop. The row count and the value list both passed.
> Mechanical checks catch mechanical errors. They don't catch this."

If the student doesn't get there, go down the file name by name until they
say Grace. Don't tell them.

**Backup row.** If the agent handles Grace correctly (it may split Brand
out or ask about it), use **Hank and Ivy**: agents often fold `Field` and
`Field Sales` together or map `Field` to Sales, both wrong at Northwind.
Check which trap fired before you ask the question.

### The other direction

Straight after, as a thought experiment:

> "Now imagine I ask the same agent to review the data-protection clause
> in a supplier contract. It will produce something fluent and confident.
> Could you tell me whether it was right? … That's the other side of the
> same line. Northwind's file, you caught it. The contract, you wouldn't
> have."

---

## Anticipated failure points and recovery moves

| What goes wrong | What to do |
|---|---|
| **The student marks a task *out* because they couldn't do it themselves.** The checkpoint's most common near-miss. | Ask: "If someone handed you a finished one, would you know if it was wrong?" If yes, it's *in*. Doing the work and judging it are different abilities; only judging limits what can be delegated. |
| **The student marks a task *in* because they do it often.** | Doing it often suggests they could check it. Ask them to name what they would look at; that goes in column 4. |
| **The check column says "I'd read it over".** | That's *not sure* until it's concrete. Ask: "Reading it for what?" There is usually a real answer one question down: the regions are all there, the total matches. |
| **Everything is marked *out*.** | Usually the can't-do / can't-check confusion, often in someone new to their role. Take one *out* row and ask whether they would spot a specific error in it, such as a missing region. If yes, it's *in*. |
| **The student says they have no repeating work.** | Ask what they did before lunch, and what they'll do again next Tuesday. If it's still true, have them list work their team does repeatedly. If the page stays blank, they copy a row or two from the canned sheet and come back to their own. |
| **The student can't use their own work** (confidential, or new in the job). | The canned sheet ([`handouts/canned-toil.md`](handouts/canned-toil.md)) produces the same result for the whole session. For a row that doesn't say enough to decide, *not sure* with "I'd need to know …" is a correct answer. Flag it to the instructor early if they'll need the canned set beyond Session 1. |
| **The skeptic pass changes nothing.** | Expect at least one row to change. Ask "how would you know if it was wrong?" of the answer itself, again, until the answer is specific enough to bet on or the student finds they couldn't tell. "I couldn't tell" is a good result. |
| **The student argues the thesis**: "this is just autocomplete", "we tried AI, it hallucinated". | Agree: "Yes. That's why the course spends its time on how to check it." Their skepticism is what the course builds on. Don't argue model capability. |
| **The student races ahead** to tools, models, or automating the sheet. | Point them at the optional page in [`PRACTICE.md`](PRACTICE.md) and say the tools start in Session 2. |
| **The student's setup failed.** | Nothing in Session 1 needs it. In a call, don't try to fix it; book a separate 20–30 minute setup call before Session 2. |
| **(Live) The demo won't run**: no network, model errors, install broken. | One 30-second attempt, then read the transcript in the appendix aloud and run the second half as written. The reveal works from paper. Log it in `docs/trunk/FRICTION.md`. |
| **(Live) The agent gets Grace right.** | Use Hank and Ivy. Know which trap fired before you ask the question. |
| **(Live) The agent asks a clarifying question.** | Point it out: "It knew it didn't know. It won't always do that." Answer wrongly but plausibly ("yes, fold Brand into Marketing"), let it carry on, and run the reveal. |
| **(Live) The agent does something baffling**: rewrites the whole file, writes a script, drops a column. | "Obviously wrong is easy to catch. The dangerous one is what we were about to see." Then read the appendix transcript for the reveal. |

---

## FAQ — questions you will be asked

**"Is this going to take my job?"** No. Look at which half of the work the
demo relied on: the typing was free, and knowing that Brand isn't in
Marketing was everything. Work that is purely mechanical is getting
cheaper, which is why this course finds the judgment in your work and
points it somewhere useful.

**"What if it deletes my files?"** Session 2 answers this properly. The
course gives you two commands: `commit` saves a snapshot of your practice
folder and `revert` puts it back, so ordinary file changes there can be
undone. Nothing today needs them.

**"Why aren't we using the software in this session?"** The tool is the
easy part. Choosing what to point it at is the hard part, and it stays true
when the tools change. A failed setup also costs nothing here.

**"Can I put confidential work on the sheet?"** Your sheet is private
unless you share it. If you work with a partner or your instructor,
describe the shape and leave out the contents: "a monthly reconciliation"
is enough to ask how you'd check it. If your work can't be discussed even
in outline, tell your instructor now; Session 6 needs something real to
point at.

**"What if I mark something wrong?"** It doesn't matter yet. You'll revise
the sheet every week, and Session 6 re-checks every row before anything is
built.

**"Which AI is it?"** The pinned model in `setup/pins.env`. The course
pins one model so everyone sees the same thing.

**"Do I have to be good at the job to do this?"** You have to know the
work well enough to tell a right result from a wrong one. Rows you can't
judge are marked *out*, and finding them counts as skill.

---

## Appendix — demo transcript for reading aloud

Use this when the demo can't run. Read the prompt, then the agent's reply,
then run the second half as written.

> **You:** `headcount.csv` has department names written inconsistently.
> Standardize them to one clean name per department, and tell me what you
> chose and why.
>
> **Agent:** *(reads `headcount.csv`, then rewrites it)*
>
> I standardized the department column to two values, **Marketing** and
> **Sales**. Here's what I did and why:
>
> - `Marketing`, `marketing`, `Mktg`, `mktg.`, `MARKETING` — five
>   spellings of the same department. Standardized to **Marketing**.
> - `Digital Mktg Team` — a team within marketing rather than a separate
>   department. Standardized to **Marketing**.
> - `Brand & Mktg` — brand work typically sits within marketing, so I
>   folded this into **Marketing** as well.
> - `Field`, `Field Sales` — both refer to the field sales organisation.
>   Standardized to **Sales**.
>
> All nine rows are preserved and every name is unchanged. Let me know if
> Brand should be tracked separately — some organisations do split it out.

After the reveal, point at the last line: it flagged the exact thing it got
wrong, in a sentence most people skim past. Sometimes the agent tells you
where to look. You still have to know the answer.
