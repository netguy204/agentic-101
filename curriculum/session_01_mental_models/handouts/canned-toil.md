# Canned toil: Priya's week

<!-- Chunk: docs/chunks/fluency_session_01 - Fallback material for the Session 1 exercises -->

Use this sheet if you can't use your own work in today's exercises — your
work is confidential, you don't have your notes with you, or the blank page
just isn't cooperating. It costs you nothing: you'll do the same thinking
on someone else's tasks, and you can transfer the skill to your own list
during the week.

Priya is a **programme manager** at a company of about 600 people. She sits
between three delivery teams and the leadership group. She has been there
four years, so she knows the work and the people well. Below are eight
things she does over and over.

---

## Priya's recurring tasks

**1. The Monday status roll-up.** Every Monday morning she opens three
team trackers, pulls out anything whose status changed last week, and
writes a one-page summary for the leadership meeting. About 45 minutes.
She has read every one of these trackers weekly for four years.

**2. Chasing missing updates.** Roughly a dozen times a week, an item in a
tracker hasn't been touched in ten days. She messages the owner and asks
where it stands. Two minutes each, but they're scattered through the week
and they break her concentration.

**3. Reformatting the delivery deck.** The leadership deck has a fixed
template — logo, heading style, a red/amber/green table. She rebuilds it
monthly from whatever the teams sent her, which is never in the template.
About 90 minutes a month, almost all of it clicking.

**4. Summarising the retro notes.** After each team's retrospective she
gets a wall of raw notes and turns them into a short list of themes for
the leadership group. Monthly, about an hour. She was in most of the
retros, so she remembers what people actually meant.

**5. Reconciling the contractor invoices.** Contractors submit hours;
Priya checks each invoice against what the team said the contractor
worked on, and flags anything that doesn't line up. Monthly, two hours.
She knows the contractors and roughly what a normal month looks like for
each.

**6. Reviewing the data-processing clauses.** New supplier contracts pass
across her desk and she's asked to sanity-check the data-handling section
before it goes to legal. Quarterly, an hour. She is not a lawyer and has
never been trained on this; she was given the job because she's organised.

**7. Answering "when will X ship?"** Several times a week, someone asks
for a date on something. She checks the tracker, thinks about what she
knows about the team's current load, and gives an answer. Five minutes
each — but the thinking is the part she'd struggle to write down.

**8. Translating the engineering risk notes for leadership.** The teams
write technical risk notes; leadership wants them in business terms.
Monthly, 45 minutes. She can tell when a note has been mangled in
translation *if* the topic is one she's picked up over four years — which
covers most, but not all, of them.

---

## How to use this in the exercises

Work through Priya's eight tasks exactly as you would your own.

- **Brain dump** — the list is already made. Skip straight to copying them
  onto the inventory sheet.
- **The check column** — for each task, decide: could *Priya* tell whether
  the finished work was right, and how? You know as much about her job as
  the sheet says, and that's deliberate: for some entries the sheet
  genuinely doesn't tell you enough, and noticing that is the point.
- **The skeptic pass** — your partner asks "how would Priya know if it was
  wrong?" and you answer for her. If you can't, mark it **out** and say
  what she'd need to know to move it inside.

Three of these tasks are comfortably inside Priya's judgment boundary,
two are outside it, and the rest depend on things the sheet doesn't tell
you. There is no answer key: two people can defensibly disagree, and the
argument they have on the way is the exercise. The one answer that is
always wrong is "in, because she does it every week."

Sessions 2 and 3 each add a section below with ready-made material for
their exercises; use the one for the session you are in.

---

## For Session 2 — neutral synthetic task options

<!-- Chunk: docs/chunks/fluency_session_02 - Session 2 fallback delegation -->

If you cannot use your own inventory entry, choose **one** option below. Each
is made-up, task-shaped practice. You are not being asked to play a role or
pretend these records belong to you. Type the two prompts for your option,
then use its check in exercise 4.

### Option A — metadata cleanup

**Exercise 3:**

> Make a file called `sample.csv` with about 15 made-up content records. Use
> the columns title, owner, status, and review_date. Include inconsistent
> capitalization, several spellings for the same status, blank owners, and
> dates in different formats. Leave the mistakes in.

**Exercise 4:**

> Clean the metadata in `sample.csv`. Standardize capitalization, statuses,
> and date formats. Do not invent missing owners; mark them `REVIEW NEEDED`.
> Tell me what you changed and why.

**Check:** confirm the row count stayed the same, every original title remains,
status and date formats are consistent, and blank owners were flagged rather
than guessed.

### Option B — meeting follow-up

**Exercise 3:**

> Make a file called `sample.csv` with about 15 made-up meeting-note items.
> Use the columns note, possible_owner, possible_due_date, and category. Mix
> clear actions with decisions and open questions; leave some owners and dates
> uncertain. Use several date formats.

**Exercise 4:**

> Organize `sample.csv` into actions, decisions, and open questions.
> Standardize clear dates, but do not invent an owner, deadline, or decision.
> Mark uncertainty `REVIEW NEEDED`. Tell me what you changed and why.

**Check:** confirm no note disappeared, decisions were not turned into assigned
actions, and every uncertain owner or date remains visibly flagged for human
follow-up.

### Option C — onboarding coordination

**Exercise 3:**

> Make a file called `sample.csv` with about 15 made-up onboarding tasks. Use
> the columns task, responsible_team, target_day, and status. Include duplicate
> tasks, inconsistent team and status labels, different day formats, and a few
> blank assignments. Leave the mistakes in.

**Exercise 4:**

> Clean `sample.csv` for coordination. Standardize team names, statuses, and
> target-day formats. Flag possible duplicates and blank assignments for
> review; do not silently delete, combine, or assign them. Tell me what you
> changed and why.

**Check:** confirm all original rows remain, possible duplicates and blank
assignments are visible, and the agent did not make staffing or access
decisions.

**Exercise 5** is the same for everybody — use the prompt in
[`../../session_02_meeting_the_harness/EXERCISES.md`](../../session_02_meeting_the_harness/EXERCISES.md).

---

## For Session 3 — Priya's briefs

<!-- Chunk: docs/chunks/fluency_session_03 - Session 3 fallback: pre-written delegation briefs, one deliberately under-specified -->

If you cannot use your own inventory entry, choose **one** brief below and
copy it onto a blank delegation brief
([`../../session_03_anatomy_of_a_delegation/handouts/delegation-brief.md`](../../session_03_anatomy_of_a_delegation/handouts/delegation-brief.md)).
Each is made-up, task-shaped practice on Priya's work: you first ask the
agent to invent the input files, then run the brief exactly as written, read
what happened, and fix the box that let you down. One of the three is
missing something. Finding out which, by running it, is the exercise — so
don't look for it first.

### Brief A — the Monday roll-up (task 1)

**Inputs, step 1 — make them.** In `~/course-practice`, in pi, send:

> Make three files in this folder called `tracker-alpha.csv`, `tracker-beta.csv`
> and `tracker-gamma.csv`, each with about 10 made-up work items and the columns
> item, owner, status, last_updated. In each file make about a third of the
> items have a last_updated date in the past seven days and the rest older.
> Use one date format throughout. Leave everything else tidy.

Then `/quit`, then `commit` named **before run 1**.

| Box | Write this |
|---|---|
| **Inputs** | Files: the three tracker files. Facts: "last week" means the seven days before today; today is the Monday this is being run. |
| **Instruction** | "Read `tracker-alpha.csv`, `tracker-beta.csv` and `tracker-gamma.csv` in this folder. Write a file called `monday-summary.md` listing every item whose last_updated date is in the seven days before today, grouped by file, one line each with item, owner and status. Don't include anything older. Tell me how many items you listed from each file." |
| **Outputs** | `monday-summary.md`, in the same folder. |
| **Checkpoints** | Open `monday-summary.md`. Count the items per group and compare with the dates in each tracker — every recent item present, no old one included. Spot-check two owners' names against the trackers. |

### Brief B — chasing missing updates (task 2)

**Inputs, step 1 — make them.** In pi, send:

> Make a file called `tracker.csv` in this folder with about 15 made-up work
> items and the columns item, owner, status, last_updated. Find out today's
> real date first, and spread the last_updated dates over the five weeks
> before it. Use one date format throughout.

Then `/quit`, then `commit` named **before run 1**.

| Box | Write this |
|---|---|
| **Inputs** | Files: `tracker.csv`. |
| **Instruction** | "Read `tracker.csv` in this folder. For every item that has gone stale, write a short, friendly chase message to its owner asking where it stands, into a file called `chasers.md` — one message per item, with the item name in the first line. Tell me which items you chased and why." |
| **Outputs** | `chasers.md`, in the same folder. |
| **Checkpoints** | Open `chasers.md`. Check that every item it chased really is stale, and that no stale item is missing. Read one message and check it names the right owner. |

### Brief C — reconciling the contractor invoices (task 5)

**Inputs, step 1 — make them.** In pi, send:

> Make two files in this folder. `invoices.csv`: about 8 made-up contractor invoices for
> last month with the columns contractor, hours_billed, rate, total.
> `timesheets.csv`: the same contractors with the columns contractor,
> hours_recorded, team_note. Make most hours match between the two files and
> two or three differ by a few hours. Use the same contractor names in both.

Then `/quit`, then `commit` named **before run 1**.

| Box | Write this |
|---|---|
| **Inputs** | Files: `invoices.csv`, `timesheets.csv`. Facts: a difference of up to one hour is normal rounding; more than that needs a question. |
| **Instruction** | "Compare `invoices.csv` against `timesheets.csv` in this folder, by contractor. Write a file called `invoice-check.md` that lists every contractor, the hours billed and the hours recorded, and flags any whose hours differ by more than one. Don't change either input file. Tell me what you flagged and why." |
| **Outputs** | `invoice-check.md`, in the same folder. |
| **Checkpoints** | I'd look it over. |

**In exercise 4**, Brief C is the one to think hardest about.

There is no answer key for which brief is missing what. Two people can run
the same brief and meet different surprises — the model is not perfectly
repeatable — and the argument about what the box should have said is the
exercise.

---

## Transferring it back to your own work

Before Session 2, do the same pass on your real tasks. You don't have to
show the sheet to anyone — the check column is written for you, not for
the room, and a private inventory is a perfectly good inventory. If your
work genuinely can't be discussed even in outline, tell your facilitator
early; the capstone in Session 6 needs *something* real to point at, and
finding a shareable-enough corner of your work is easier with six weeks'
notice than with one.
