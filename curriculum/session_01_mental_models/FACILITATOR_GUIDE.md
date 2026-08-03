# Session 1 facilitator guide — Mental models & toil inventory

<!-- Chunk: docs/chunks/fluency_session_01 - Session 1 facilitator guide -->

**Length:** 90 minutes live. A 60-minute variant is marked in the timing
table.

**The one thing this session must achieve:** every participant leaves
believing the course is *for them*, holding a list of their own work with
an honest mark against each entry saying whether they could tell good from
bad. Everything else is in service of that.

**What this session is not:** a tool demonstration. Nobody installs
anything, nobody types a command, and the only agent in the room is on
your screen. That is deliberate — participants whose pre-course setup
failed take part in every minute of this session, and their setup gets
fixed before Session 2, which is the one that needs it.

---

## Before the room

- **Read** `docs/trunk/GOAL.md` (the problem statement and thesis) and
  `docs/trunk/SPEC.md` (Terminology). The vocabulary in this guide is
  quoted from SPEC.md deliberately; every later session builds on it, so
  use these words rather than synonyms you prefer.
- **Read** [`handouts/toil-inventory.md`](handouts/toil-inventory.md) and
  [`EXERCISES.md`](EXERCISES.md) properly. You will be filling in a live
  example on the board and you should not be reading the columns for the
  first time in front of people.
- **Print** the inventory sheet, one per participant plus spares, and the
  canned-toil sheet for anyone who asked for it in prework. Print them
  even for a remote cohort — say "print this or copy the four columns
  onto anything" in the joining email.
- **Send the prework a week ahead** — [`PREWORK.md`](PREWORK.md), by email,
  with no verbal preamble beyond "this is the prework". Part 3 asks people
  to reply with their setup status and whether they want the canned task
  set, so you need the replies in hand before the room; chase the
  non-repliers two days out, because a non-reply usually means a failed
  setup rather than a busy week.
- **Test the demo** (see Demo, below) on your own machine the day before,
  on the pinned model. It needs a working pi install on the *facilitator's*
  machine — not on anyone else's. If you don't have one, you install it the
  same way the participants did: follow `setup/README.md` end to end,
  including its smoke test. Do this a week out, not the night before.
- **Tally the prework replies**: who reported `PASS`, who reported `FAIL`,
  who didn't reply, who asked for the canned set.

### Setup status: collect it, don't solve it

Setup status is a fact you need and a problem you must not open in the
room. Keep a table:

| Participant | Setup status | Canned set? | Remediation slot booked |
|---|---|---|---|
| | PASS / FAIL / no reply / didn't attempt | | |

At the door — as people arrive, or in the first two minutes — confirm the
tally out loud in aggregate, never individually: *"About a third of you
had the setup work first time and a couple of you hit a wall. That's
completely normal and it does not affect today at all. If yours didn't
work, I'll grab you at the end for two minutes to book a slot."*

**The remediation route:** anyone with `FAIL`, no reply, or an unattempted
setup gets a 20–30 minute one-to-one **before Session 2**. Book it at the
end of this session, not during it. The setup guide (`setup/README.md`)
and its troubleshooting table are the script for that slot.

**Do not** attempt to fix a laptop during this session, and do not let a
participant open one to try. It costs the room fifteen minutes, it teaches
the person that the course is about fighting software, and it fixes
something nothing today depends on.

---

## Timing

| Start | Min | Beat | 60-min variant |
|---|---|---|---|
| 0:00 | 5 | Arrival, welcome, setup tally | 5 |
| 0:05 | 11 | **Cold open — why the moment matters** | 9 |
| 0:16 | 8 | Mental models: what an agent is, and how it differs from a chatbot | 5 |
| 0:24 | 6 | **Demo, beat 1** — the agent does something impressive | 4 |
| 0:30 | 8 | **Demo, beat 2** — "how would you check this?", then the reveal | 4 |
| 0:38 | 8 | Judgment vs expertise; the judgment boundary; the thought experiment | 6 |
| 0:46 | 5 | Break; hand out the sheets | — |
| 0:51 | 7 | Exercise 1 — brain dump | 5 |
| 0:58 | 12 | **Exercise 2 — the check column** | 10 |
| 1:10 | 8 | Exercise 3 — the skeptic pass | 5 |
| 1:18 | 2 | Wrap the block, count the rows | 1 |
| 1:20 | 7 | **Checkpoint round** | 4 |
| 1:27 | 3 | Practice assignment, close | 2 |

**Cutting rules, in the order you should cut.** Drop the break. Shorten
the cold open by cutting the "what changed" section but never the "why
you" section. Compress the demo to one beat plus the reveal. Run
exercise 3 as one facilitator-led round in front of the room instead of in
pairs. **Never cut exercise 2, and never cut the checkpoint round** —
between them they are the session's outcome and the evidence that it
landed. If you're at 1:15 with the exercises unfinished, run exercise 2 to
completion and hand the checkpoint to the practice assignment as
"send me your three entries by Friday", noting it in your session log.

---

## Beat 1 — Cold open: why the moment matters (11 min)

Open with the argument, not with definitions. The participants have been
told, by every other piece of AI material they've seen, that they are
behind. This eleven minutes exists to tell them the opposite, and it has
to land before they will invest in anything else.

**Say these three things. In this order.**

**1. One profession has had leveraged judgment for forty years, and it
wasn't because they were smarter.** A software engineer could take a
decision — *this input is suspicious; this case needs a human* — write it
down once, and have it govern thousands of executions without them in the
room. Their judgment compounded. Everyone else's ran live: one meeting,
one review, one document at a time. Thousands of good calls, each applied
exactly once.

**2. That gap existed for a boring structural reason, and it just
closed.** The only way to encode a decision was code, and learning to code
was a career rather than an afternoon. Agentic tools take instructions in
plain language. "Flag anything from a customer who's mentioned cancelling,
because retention is what we're protecting this quarter" is now a thing
you write down once and have applied every time.

**3. So the scarce input has moved, and you already own it.** It used to
be the keystrokes. Now the keystrokes are cheap, and what's scarce is
knowing what's worth doing and whether the result is right. That is
exactly the thing you have and exactly the thing the tool doesn't. *"The
agent does the typing; you supply the judgment."*

**Land it personally.** Ask the room, and take three or four answers
aloud: *"What's the thing you'd have automated years ago if you'd had a
programmer sitting next to you?"* Write the answers on the board and leave
them up — you will point back at them during the exercises, and a couple
of them will end up as capstones in Session 6.

**Two framings to avoid, hard.**

- **Threat framing.** No "AI is coming for these jobs", no "adapt or be
  left behind", not even as a joke. The argument is that their judgment
  becomes more valuable, not that they're at risk. Anyone who hears threat
  spends the rest of the session defending themselves instead of listing
  their work.
- **Hype framing.** No "this changes everything", no breathless demo
  language, no numbers you can't source. This audience has been sold to
  before and it has made them appropriately suspicious. Understated and
  specific beats enthusiastic every time — and the demo in twenty minutes
  is going to show the agent being *wrong*, which only works if you
  haven't spent the cold open promising magic.

---

## Beat 2 — Mental models: agent vs chatbot (8 min)

Now the definitions, and only now. Two of them, both quoted from SPEC.md
Terminology so that Sessions 2–6 can build on the same words.

> An **agent** is an LLM running in a harness with the ability to take
> actions — read and write files, run commands, call tools — not just
> converse.

The distinction that matters to this room is not technical:

| A chatbot | An agent |
|---|---|
| Converses. Produces text for you to use. | Acts. Reads and changes real files and systems. |
| You are the hands: you copy, paste, and apply. | It has hands of its own. |
| One exchange at a time. | Multiple steps, chained, without asking between each one. |
| Wrong answer costs you the time to notice. | Wrong action has already changed something. |

**The analogy that works** (adapt to your room, keep the shape): a chatbot
is a very well-read colleague on the phone. An agent is a colleague you
handed your laptop to. The advice may be identical. The consequences of it
being wrong are not.

Two more terms, said once and left to settle — the exercises are where
they get real:

> **Judgment** is the ability to discern a reasonable result from an
> unreasonable one *in a given domain* — to *evaluate* work without
> necessarily being able to produce it. **Expertise** is the ability to
> produce the work yourself.

"In a given domain" is doing real work in that sentence — judgment isn't a
personality trait you have or lack, it's something you have *here* and
don't have *there*. Say it; the exercises depend on people believing it.

Then the sentence this whole course hangs on. Put it on a slide, say it
slowly, and don't explain it yet — the demo is the explanation:

> **Delegation can substitute for expertise. Nothing substitutes for
> judgment.**

---

## Beats 3 and 4 — The demo, in two halves (6 min + 8 min)

The demo is not a capability showcase. It is the argument for the judgment
boundary, delivered as an experience rather than a claim, and it only
works if you run both halves. If you are short of time, cut the first half
down — never run it without the second.

### Setting up: give the room the domain knowledge first

This is the trick that makes it work. Sixty seconds before you touch the
keyboard, make the room the domain expert:

> "For the next ten minutes you all work at Northwind Coffee. Two things
> you know about Northwind that nobody outside would: **Brand isn't part
> of Marketing here.** Brand sits under Product — it's a long-running org
> quirk everyone internally knows about. And **'Field' means the retail
> store teams**, not sales. Everyone got that? You are now the only people
> in the room who know how this company is organised."

Have those two facts visible on the board for the rest of the demo.

### The file

Create `headcount.csv` in a scratch folder before the session:

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

### Beat 1 — the agent does the work (6 min)

Share your screen, run the agent in that folder, and send exactly this:

> `headcount.csv` has department names written inconsistently.
> Standardize them to one clean name per department, and tell me what you
> chose and why.

Narrate what scrolls past, in plain language, without teaching any
mechanics: *"It's reading the file… it's decided how to group them… now
it's writing the file back."* Do not explain tool calls, the terminal, or
anything on screen that isn't the reasoning. Somebody will ask what an
app or a command is; say "Session 2, I promise" and move on.

Then show the result. It will be genuinely good: the five spellings of
Marketing collapsed correctly, an explanation of each ambiguous call
written in confident, professional prose. Let that land. Let someone say
"that's quite impressive." It is.

### Beat 2 — "how would you check this?" (8 min)

Now, before you say anything about whether it's right:

> **"How would you check this?"**

Take answers and write them on the board. You will get some or all of:
count the rows before and after; list the distinct department values and
see if the list makes sense; look for a name you recognise; check nobody
got dropped; read the explanation and see if the reasoning holds.

Praise the row count and the distinct-values list — they are real checks,
they are cheap, and they generalise. Then push once: *"All of those pass.
Every one of them passes on this file. Is it right?"*

Wait. Someone will get there: **Grace.** `Brand & Mktg` has been folded
into Marketing, which is correct at almost every company on earth and
wrong at Northwind. The agent had no way to know. Nothing in the file said
so. The output is confident, well-explained, and wrong in a way that no
mechanical check catches — only someone who knows the company catches it.

**Say the conclusion explicitly, because this is the moment the session
turns:**

> "It wasn't a bad answer. It was the best answer available to anyone who
> didn't know this company. The only thing that caught it was you knowing
> something the agent couldn't. That's your judgment, and it's the whole
> reason you're the one who has to be in the loop. Notice also that the
> checks we listed on the board — the row count, the value list — all
> passed. Mechanical checks catch mechanical errors. They don't catch
> this."

**If the room doesn't get there**, walk down the file name by name until
someone says Grace. Don't tell them; the value of the beat is that they
caught it.

**Backup ambiguous row.** If the agent handles Grace correctly — it
happens; the model may split Brand out or ask about it — use **Hank and
Ivy** instead. Agents commonly fold `Field` and `Field Sales` together, or
map `Field` to Sales, both wrong at Northwind. Same reveal, same
conclusion. Have the second one ready every time so you're never left
without a reveal.

### The other direction: outside your boundary (part of beat 5)

Immediately after the reveal, flip it. This one is a thought experiment,
not a live demo — it's faster and it makes the point harder:

> "Now imagine I ask the same agent to review the data-protection clause
> in a supplier contract and tell me whether anything's unusual. It will
> produce something fluent, structured, and confident. Hands up who could
> tell me whether it was right." *(No hands, or one lawyer.)* "That's the
> other side of the same line. Same tool, same quality of output — the
> difference is entirely in us. Northwind's file, we caught it. The
> contract, we wouldn't have, and we'd have shipped it."

---

## Beat 5 — Judgment vs expertise and the boundary (8 min)

Name what just happened, using the terms from beat 2.

> Your **judgment boundary** is the edge of the space where you can
> evaluate outcomes. Tasks inside it are candidates for delegation. Tasks
> outside it are not — regardless of how capable the agent is.

Three points, briefly, then get to the sheets:

1. **Expertise is not the limit.** You can safely hand over work you
   couldn't do yourself. You do it constantly — you brief designers, hire
   contractors, sign off on things you couldn't have built. That's normal
   and it's fine.
2. **Judgment is the limit.** What you cannot safely hand over is work
   whose result you couldn't evaluate. Not because the agent is unreliable,
   but because you would never find out. You'd find out later, from
   someone else, expensively.
3. **The boundary is personal and it's specific.** It's not "I'm technical"
   or "I'm not." Priya can judge a status roll-up cold and can't judge a
   liability clause, and both facts are about the task, not about her.

**Anticipate the objection here**, because someone always raises it: *"So
I can only automate things I already understand? That's limiting."* The
answer is yes, and it is the point — plus the boundary moves. Learning
enough about a domain to *evaluate* it is a fraction of the work of
learning to *produce* it, and that's the cheapest expansion of leverage
available to anyone. Say it as an invitation, not a rule.

Then hand out the sheets and read the four columns aloud once, pointing at
the check column: *"This one is the one that matters. Everything else on
the sheet is context for this one."*

---

## Anticipated failure points and recovery moves

| What goes wrong | What you do |
|---|---|
| **The demo won't run** — no network, model errors, install broken. | Don't debug in front of the room; you get one 30-second attempt. Switch to the transcript in the appendix, read it aloud, and run beat 2 identically. The reveal is what matters, and it works read from paper. Then log it as friction (`docs/trunk/FRICTION.md`). |
| **The demo gets Grace right.** | Use Hank/Ivy (above). Always know your second row before you start. |
| **The agent asks a clarifying question instead of deciding.** | This is a gift — say so. *"Look what it did: it knew it didn't know. It won't always do that, and that's exactly the problem — sometimes it just decides."* Answer the question wrongly-but-plausibly ("yes, fold Brand into Marketing"), let it proceed, and run the reveal as planned. |
| **The demo produces something baffling** — reformats the whole file, writes a script, drops a column. | Use it. *"That's the other failure mode, and it's the friendly one: obviously wrong is easy to catch. The dangerous one is what we were about to see."* Then read the transcript for the intended reveal. |
| **A participant argues the thesis** — "this is just autocomplete", "we tried AI, it hallucinated". | Agree, out loud and without hedging: *"Yes. That's exactly why we spent ten minutes on how to check it rather than on how clever it is."* Their skepticism is the asset the course is built on; recruit it, don't defend against it. Then move on — don't litigate model capability in Session 1. |
| **A participant says they have no recurring toil.** | Almost always a definition problem. Ask what they did before lunch, then what they'll do again next Tuesday. If it's genuinely true (rare — usually a very senior participant), have them do the exercises on work their *team* does repeatedly; the inventory is still valid and the capstone can be one of those. |
| **Silence in the room during the exercises.** | Expected for the first two minutes; people are thinking. If it persists past three, work a second live example on the board — silence is usually "I don't know what a good answer looks like", and one more worked row fixes it. |
| **Someone opens a laptop to fix their setup.** | Close it, kindly and immediately. *"Nothing today needs it, and I'd rather have you in the room. Grab me at the end and we'll book fifteen minutes."* |
| **A technical participant races ahead** and starts asking about tools, models, or automating the inventory itself. | Give them the optional-depth item from [`PRACTICE.md`](PRACTICE.md) — write one entry's check column as a brief for a new hire — and park the tooling questions to Session 2 explicitly. Do not let the session become a conversation between you and them. |
| **The room is remote-only.** | Breakout rooms of two for exercise 3, four minutes, then announce the swap in broadcast rather than re-rooming. Ask for cameras on during the checkpoint round only. Watch the chat during exercise 2 — the "wait, does frequency count?" questions arrive there rather than aloud. |
| **You are running fifteen minutes late at the break.** | Apply the cutting rules from the timing table. Protect exercise 2 and the checkpoint. |

---

## FAQ — questions you will be asked

**"Is this going to take my job?"** No — and notice which half of the work
the demo relied on. The typing was free. The knowledge that Brand isn't in
Marketing was the whole ballgame, and it was yours. The honest version:
work that's *purely* mechanical is getting cheaper, which is why we spend
this course finding the judgment in your work and pointing it somewhere
useful.

**"What if it deletes my files?"** It's a fair worry and you'll get a real
answer in Session 2. Short version: the course environment gives you two
commands — `commit` saves a snapshot of your work, `revert` puts it back —
so anything an agent does is undoable. You don't need to know anything
about them today. *(Don't teach these. One sentence and move on;
`onboarding_terminal_env` owns them and Session 2 teaches them.)*

**"Why aren't we using the software today?"** Two reasons. Some of you
have setups that didn't work and I'm not spending your first session
watching other people install things. And the tool is the easy part —
picking what to point it at is the hard part, and it's the part that's
still true when the tool changes.

**"Can I put confidential work on the sheet?"** Your sheet is yours;
nobody reads it. For the pair exercise, describe the shape and not the
contents — "a monthly reconciliation" tells your partner everything they
need to skepticise you. If your work genuinely can't be discussed even in
outline, tell me today, because Session 6 needs something real to point
at and that's easier to solve with six weeks' notice.

**"What if I mark something wrong?"** You will, and it doesn't matter
today. The sheet is a working document — you'll revise entries every week,
and Session 6 re-checks every one of them before anything gets built.

**"Which AI is it?"** Give the pinned model name from `setup/pins.env` and
one sentence: the course pins one model so everyone sees the same thing.
Don't be drawn into model comparisons in Session 1.

---

## Appendix — demo transcript for reading aloud

Use this when the live demo can't run. Read the participant's prompt, then
the agent's reply, then run beat 2 exactly as scripted. The reveal
survives being read from paper because the reveal is about the room's
knowledge, not the machine's behaviour.

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

That closing line is worth pointing at after the reveal: it flagged the
exact thing it got wrong, politely, in a sentence most people skim past.
Sometimes the agent tells you where to look. You still have to be the one
who knows the answer.

