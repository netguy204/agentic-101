# Session 2 facilitator guide — Meeting the harness

<!-- Chunk: docs/chunks/fluency_session_02 - Session 2 facilitator guide -->

**Length:** 90 minutes live. A 60-minute variant is marked in the timing
table.

**The one thing this session must achieve:** every participant has run an
agent on their own machine, seen it change a real file, checked the result
themselves, and put the folder back afterwards. Not "understands how" —
*has done*. This is the session that turns Session 1's argument into
something in their hands.

**What this session is:** the first hands-on one, and therefore the first one
where a broken laptop costs somebody something. Your first eight minutes are
about triage, not teaching. Read that section before anything else.

**What this session is not:** a terminal course or a memory test. Participants
keep the reference card beside them and use only the few entries needed to
navigate, recover local files, and move into and out of pi. Extra terminal
detail is comprehension burden competing with the actual subject: judgment.

---

## Before the room

- **Read** [`EXERCISES.md`](EXERCISES.md) end to end and
  [`DRY_RUN.md`](DRY_RUN.md) at least skimmed. The dry run records what the
  commands actually print, including the two places where `revert` asks a
  question people get wrong. You should not be meeting those live.
- **Run the whole session on your own machine**, from the written text, the
  day before. All five exercises, start to finish, in a folder you then
  delete. It takes about fifteen minutes because the agent steps are fast
  (ten to thirty seconds each in the dry run); what it buys you is having
  seen the exact prompts and the exact answers to `revert`'s questions with
  your own hands.
- **Print** [`handouts/terminal-card.md`](handouts/terminal-card.md), one per
  participant plus spares, and
  [`handouts/what-did-it-do.md`](handouts/what-did-it-do.md), **two** per
  participant — people fill in a second one during the practice week and
  having a spare in the bag makes that likelier.
- **Send the prework a week ahead** ([`PREWORK.md`](PREWORK.md)). Part 3 asks
  everyone to run `course-smoke-test` and reply with the result. **Those
  replies are the input to your triage plan** — chase the non-repliers two
  days out, because a non-reply is a failed setup far more often than it's a
  busy week.
- **Hold the remediation slots.** Anyone who reported `FAIL` in Session 1's
  prework should already have had one. Anyone who reports `FAIL` now needs
  one *before* today, not after. This session is the reason those slots exist.
- **Know the pins.** `setup/pins.env` says which pi version and which model
  the cohort runs. If somebody's smoke test says "pi is version X, but this
  course uses Y", that is a re-run of the setup guide's Step 3, not a mystery.

### Bring a spare laptop if you possibly can

One laptop with the environment installed, signed in on a spare key, sitting
at the back of the room. It converts your worst case — a participant who
cannot take part — into a shrug. It is the single highest-value thing you can
carry to this session.

---

## The first eight minutes: setup triage

Do this before you say anything about the session. It is not a warm-up; it is
the thing that decides whether the next eighty minutes work for everybody or
for most people.

**1. Everyone opens the course terminal and runs one command.** Say it, write
it on the board, and give it ninety seconds:

```
course-smoke-test
```

It takes about ten seconds and ends in one word. (It's the same check from
the setup guide; running it costs nothing and it is the only way to know the
truth rather than what people remember about last week.)

**2. Hands up for PASS.** Count. Write the number on the board next to the
number of people in the room, out loud and cheerfully. Aggregate only, never
individually — Session 1 established that tone and today is not the day to
break it.

**3. Everyone who isn't PASS gets a neighbour, now.** Not later, not after
you've had a look. Pair them physically: move a chair. Say it plainly:

> "If yours didn't come back PASS, put your hand up and I'll pair you with
> someone. Here's the rule for pairs, and it matters: **the person whose
> laptop it isn't does the typing.** You're not watching, you're driving. You
> will do every exercise today; you'll just do it on somebody else's machine."

**4. Then start, on time.** This is the hard part and it is not negotiable.

> **Do not debug a laptop during this session.** Not one. You get thirty
> seconds of looking at a screenshot and then it's a pairing and a slot in
> your calendar. A facilitator who spends fifteen minutes on one machine has
> traded eleven people's session for one person's, and the one person doesn't
> get fixed either — they get fixed properly in a twenty-minute slot
> afterwards, with `setup/README.md`'s troubleshooting table in front of you.

**Keep the tally**, because you need it for Session 3 and because a pattern
across the cohort is a bug report about the setup guide, not about the cohort:

| Participant | Smoke test today | Paired with | Slot booked | What it said |
|---|---|---|---|---|
| | PASS / FAIL / didn't run | | | |

Anything that fails today goes in `docs/trunk/FRICTION.md` with the exact
`[no]` line. Two participants hitting the same line is a defect in `setup/`.

---

## Timing

| Start | Min | Beat | 60-min variant |
|---|---|---|---|
| 0:00 | 8 | **Setup triage** — smoke test, tally, pairs | 6 |
| 0:08 | 4 | Cold open — what today is, and the promise about undo | 3 |
| 0:12 | 11 | **Exercise 1** — Where am I? | 8 |
| 0:23 | 14 | **Exercise 2 — the safety net** | 12 |
| 0:37 | 5 | Break | — |
| 0:42 | 6 | What pi is: the harness, the four tools, the work log | 4 |
| 0:48 | 14 | **Exercise 3** — your first delegation | 10 |
| 1:02 | 13 | **Exercise 4 — what did it actually do?** | 11 |
| 1:15 | 7 | **Exercise 5** — break it on purpose | 4 |
| 1:22 | 6 | **Checkpoint round** | 2 |
| 1:28 | 2 | Practice assignment, close | 2 |

**Cutting rules, in the order you should cut.** Drop the break. Run exercise
1 as a facilitator-led "everybody type this after me" instead of independent
work. Shorten the "what pi is" beat to the four tools and nothing else. Cut
exercise 3's file-browser look at `sample.csv` (they'll see it in exercise 4
anyway). Run exercise 5 as a demo on the projector with the room following
along on their own machines rather than at their own pace.

**Never cut exercise 2, never cut exercise 4, and never cut the checkpoint
round.** Exercise 2 is the session's licence to do anything at all; exercise
4 is its content; the checkpoint round is the evidence. If you are at 1:10
with exercise 4 unfinished, **drop exercise 5 entirely** and let the practice
assignment carry it — that is the designed sacrifice, and it is much better
than a rushed exercise 4. Say so out loud when you do it: "we're skipping the
fun destructive one; it's the first thing in your practice sheet and it takes
four minutes."

---

## Beat 1 — Cold open (4 min)

Short, and it does two jobs.

**1. Name the shift.** "Last time we didn't touch a computer, on purpose.
Today you'll use one for about an hour, and by the end of it every one of you
will have handed a piece of your own work to an agent and checked what it
did. That's the whole session."

**2. Make the promise, and make it concrete, because fear is the thing that
will actually slow this room down.** People who are nervous about breaking
something type slowly and stop asking for things.

> "In about twenty minutes you're going to delete a local practice file on
> purpose and get it back. Once you've done that yourself — not heard me say
> it, done it — you can experiment confidently with the bounded file tasks
> written for today. This recovery move does not cover disclosure, external
> actions, or work outside the checkpoint."

**Do not demo anything here.** The instinct to open with something impressive
is wrong for this session: they'll be running it themselves in twenty
minutes, and a demo now just makes the next twenty minutes feel like
preamble.

---

## Beat 2 — Exercise 1: Where am I? (11 min)

Run it from [`EXERCISES.md`](EXERCISES.md). Three things to hold in mind
while you circulate:

- **The blank-response problem is real.** When somebody types a command and
  gets nothing back, they think it failed. Say the reassurance from the
  exercise before they start, not after somebody's hand goes up.
- **The two-window moment is the point of the exercise**, not the commands.
  Do not let anyone skip `open .` / `explorer .`. Someone who has seen their
  terminal and their Finder showing the same folder has stopped believing the
  terminal is a separate, dangerous computer, and that belief is worth more
  than the three commands.
- **Circulate for typos, and retype rather than diagnose.** A new user
  reading a bash error learns nothing except that they're bad at this. "Let's
  just do that line again" is faster and kinder every single time.

---

## Beat 3 — Exercise 2: the safety net (14 min)

The most important beat in the session. Two things to do differently here
from every other exercise:

**Work the first `commit` on the projector first.** Two minutes, out loud, on
your machine. `commit` asks a question no computer has ever asked these
people ("This folder is not saving checkpoints yet — turn them on?"), and the
first encounter with it should not be alone. Show the whole flow: the
question, the list of what changed, the naming prompt.

**Then do not move on until everyone has done it.** Including the pairs.
Including the person who is quietly behind. Ask for hands: "who has seen
`notes.txt` come back?" If it isn't everyone, wait — you have the time,
because exercise 5 is the designated sacrifice.

### The two places people get stuck, both scripted

| | What happens | What you say |
|---|---|---|
| **`revert` opens with "Wait —"** | Reads as an error. People stop. | Warn them before they start: "revert is going to ask you four questions, one at a time. The first starts with the word *wait* and gives you three numbered choices — just press Enter. That's it being careful." |
| **They type `1` for the checkpoint** | Goes back to the wrong place, because `revert` saved their deletion as the new number 1 | Not a problem — `revert` is undoable, so run it again with the other number. Then say the rule out loud, because it recurs in exercise 5 with a longer list: **read the names, not the numbers.** |

### The sentence to land before the break

> "`commit` saves a snapshot of this folder. `revert` puts ordinary local
> file changes back. You have now used both. Everything after the break is
> you letting something else edit the practice files — and you know how to
> recover those edits. They do not undo disclosure or an external action."

---

## Beat 4 — What pi is (6 min)

Now, and only now, the mechanics. Keep it to six minutes; it's the least
durable content in the session and the most tempting to expand.

Two terms, quoted from `docs/trunk/SPEC.md` so Sessions 3–5 build on the same
words:

> A **harness** is the software environment in which an agent runs — its
> tools, configuration, prompts, and extensions. Ours is pi.
>
> An **agent** is an LLM running in a harness with the ability to take
> actions — read and write files, run commands, call tools — not just
> converse.

Then the thing that actually matters today, which is what a tool call is. The
coworker analogy carries it:

> "Think of it as a colleague you're messaging who can act through four
> tools: **read** a file, **write** a file, **edit** part of a file, or **run
> a command**. Every box that appears on your screen shows it using one of
> those tools. That scroll of boxes is its work log."

Write the four tool names on the board and leave them there — participants
refer to them in exercise 4.

Then the sentence this session's second half turns on. Say it now, and say it
again in exercise 4:

> **The boxes are what it did. The paragraph at the end is what it says it
> did. When you want to know what happened, read the boxes and then look at
> the file.**

Last, thirty seconds of connective tissue back to Session 1: "Remember the
distinction we drew — a chatbot converses, an agent acts. The boxes are the
acting. That's the whole difference, and you're about to watch it happen on
your own disk."

---

## Beat 5 — Exercise 3: the first delegation (14 min)

The mechanical risk here is the prompt, not the software. Two moves:

**Work one prompt on the board before they type.** Take a volunteer's
inventory entry, out loud, and fill in the two gaps together. Ninety seconds.
The gaps are "what your data looks like" and "the mess in it", and people
reliably fill the first with a *task* rather than a *thing* — "sort my ticket
queue" instead of "a list of tickets with the priorities written four
different ways". One worked example fixes it for the room.

**Then say the reassurance about their data before anyone asks it**, because
somebody in the room is worried and won't say so:

> "What you type and any file pi reads is sent to our model provider so it
> can respond. Today, do not give it your work data: describe only the general
> shape — 'a list of tickets with inconsistent priorities' — and let it
> invent fifteen rows. Synthetic data lets us practise the process without
> sending the real records."

**While they work**, circulate for the two failure shapes, both in
[`EXERCISES.md`](EXERCISES.md): a prompt that describes the task instead of
the material, and someone sitting silently through a ten-second pause
convinced it has frozen.

**Make them look at the file in the file browser.** Not the terminal. The
moment that lands is a real file, in a real folder, that they did not type.
Some people need to be told to go and look.

---

## Beat 6 — Exercise 4: what did it actually do? (13 min)

The session's content. Everything before it was getting the room to a place
where this beat is possible.

**Set it up with the sentence, slowly:**

> "It's about to write you a paragraph explaining what it did. That paragraph
> is the least reliable thing on your screen — not because it lies, but
> because it's describing its intentions and you care about its effects. The
> boxes are what it did. The file is what happened. Read those two first, in
> that order, and *then* use your own check."

**Point at Session 1 explicitly, holding up the inventory sheet.** This is
the payoff for six weeks of that sheet and it will not land unless you say it
out loud:

> "Look at what you're doing. Column 2 of your sheet — what 'done right'
> looks like — you just used as the instruction. Column 4 — how you'd check —
> is about to be the check. You wrote both of those weeks ago, before you'd
> seen any of this software, and they worked unchanged. That's what we meant
> when we said the judgment was the scarce part and the typing was cheap."

**Hunt for a wrong answer, out loud, and treat it as a prize.** Somewhere in
the room the agent will have made a judgment call the participant disagrees
with. Ask for it: *"Who's got one where it did something you didn't want?
Good — tell us."*

> **The one that shows up most reliably** is two labels that mean the same
> thing to the agent and different things at the participant's company. In
> both dry runs on the canned task, the agent folded `Complete` into `Done`
> and said so plainly in its explanation. At most companies that's right. At
> some, "complete" means signed off and "done" means the work stopped, and
> merging them silently destroys a distinction somebody relies on. It is
> Session 1's Northwind reveal, arriving by itself, on the participant's own
> material. If nobody in the room raises something like it, raise it
> yourself: read the agent's explanation aloud and ask "who's at a place
> where those two words mean different things?"

**Then the question that fixes the near-universal misfire.** People will
write "it said it standardised the statuses" in box 3. Every time:

> **"That's what it told you. What did you *look at*?"**

**Observable output before you move on:** every worksheet has something
specific in box 3. Walk the room and check — this is the one you are
collecting evidence on, and "looks fine" is a blank box.

---

## Beat 7 — Exercise 5: break it on purpose (7 min)

Loosen up. This one is meant to be funny, and the laugh is doing real work —
it's the sound of a room that has stopped being frightened of the tool.

Run it exactly as written and hold two lines:

**Don't let anyone improvise a bigger disaster.** Someone will suggest
"delete everything". The answer is a real one and worth giving:

> "The checkpoints live in a hidden folder inside this one. A prompt broad
> enough to delete everything can delete those too, and then there's nothing
> to go back to. Which is why the prompt names the file it ruins. Bounding
> what you let it touch is a real skill and it's most of Session 4."

**Then the closing frame**, which is the sentence people leave with:

> "You have now recovered a deliberately damaged local file in about forty
> seconds. That is strong evidence for this specific recovery move, not a
> promise about every action an agent could take. Be ambitious within clear
> bounds, and keep human approval between draft work and external action."

**If the agent refuses.** It happens, and it's a gift: *"It declined to
destroy my work, which is lovely and which you must not rely on — it is not a
safety feature, it's a mood."* Then delete `sample.csv` in the file browser
instead and revert from there. The exercise is the revert.

---

## Beat 8 — Checkpoint round (6 min)

Run it as [`CHECKPOINT.md`](CHECKPOINT.md) describes. One frame, four
sentences per person, no discussion:

> "What you asked for. What tools it used. What you checked. And whether
> you've used `revert`."

Twelve people, six minutes, and you must not let it become a conversation.
Note the answers as you go; the table in [`CHECKPOINT.md`](CHECKPOINT.md) is
what Session 3 is planned from.

---

## Beat 9 — Close (2 min)

Hand out [`PRACTICE.md`](PRACTICE.md) and say two sentences about it: the
first exercise on it is the same loop they just ran, alone, within 48 hours,
and it takes twenty minutes. Then: "the two after that are on real work you
were going to do by hand anyway. That's the point — this replaces something,
it doesn't add something."

Then catch, individually and quietly: anyone who was paired, anyone whose
box 3 stayed empty, anyone who didn't get through exercise 4. Recovery moves
are in [`CHECKPOINT.md`](CHECKPOINT.md).

---

## Anticipated failure points and recovery moves

| What goes wrong | What you do |
|---|---|
| **A third of the room fails the smoke test.** | Pair aggressively and start on time — the session works at full value in pairs. Then treat it as a defect in `setup/`, not as bad luck: collect the exact `[no]` lines, log them in `docs/trunk/FRICTION.md`, and re-run the pre-cohort checklist before the next cohort. |
| **One participant's key stops working mid-session** (`could not reach the model`). | Pair them immediately with a neighbour; they lose ninety seconds. Do not attempt to re-issue a key in the room. Note it and fix it after — a mid-session key failure is usually a spend limit, which is an operator problem with a thirty-second fix outside the room. |
| **Somebody's terminal won't open at all.** | Spare laptop if you brought one, pairing if you didn't. Do not troubleshoot Ghostty or Windows Terminal live; the setup guide's troubleshooting table exists and the remediation slot is where it gets used. |
| **The agent does something surprising in front of the room.** | **This is the best thing that can happen and you must treat it that way, visibly.** Stop, show it on the projector, and ask the room "how would you have caught that?" Nondeterminism isn't a broken demo — it is the reason the whole course teaches checking. A facilitator who looks embarrassed here teaches the room that surprises are failures, which is exactly wrong. |
| **The agent produces a perfect result for everybody and nobody has anything to catch.** | Read the agent's own explanation aloud and interrogate a judgment call in it (`Complete` / `Done` is the reliable one). Every run makes calls it doesn't flag as calls. There is always something. |
| **Somebody reverts to the wrong checkpoint and loses exercise 4's work.** | Run `revert` again and pick the right one — reverting is itself a checkpoint. Say it to the room when it happens; "I went back too far and came forward again" is a genuinely valuable thing for people to have witnessed. |
| **A Windows participant sees `warning: in the working copy of 'README.txt', LF will be replaced by CRLF…` after `commit`.** | Harmless — it is git remarking on line endings, and the green `Saved:` line below it means the checkpoint worked. Say "ignore the word *warning*; look for the green *Saved* line" and move on. Environments installed at version 1.0.1 or later silence it (`commit` turns line-ending conversion off for the practice folder); a participant who set up earlier can re-run the pi installer after the session. |
| **A participant's `commit` never happened**, so `revert` says there are no checkpoints. | They answered `no` to the first question. `commit`, answer `yes`, carry on. Thirty seconds. |
| **Somebody runs pi outside `~/course-practice`.** | Catch it with `pwd` before they send anything. If they've already made a mess somewhere else: it's their own folder, nothing was deleted (the exercises only ever create), and `cd ~/course-practice` fixes the rest. Worth saying calmly and moving on — the folder discipline is a habit, not a security boundary. |
| **A technical participant races ahead** — asks about models, git, other harnesses, or starts installing things. | Give them the optional item in [`PRACTICE.md`](PRACTICE.md) and name where their question lands: models and provider choice are settled for the cohort and not up for redesign (`DECISIONS.md`, DEC-006); harness adaptation is Session 5. Do not let the session become a conversation between the two of you. |
| **The room is remote-only.** | Everything works, with three adjustments. Ask for screen-shares during exercise 2 from two volunteers, so the room sees the `commit` and `revert` walkthroughs on somebody else's machine as well as yours. "Pairing" becomes a breakout room of two with the unpaired person driving by dictating. Budget three extra minutes overall and take them from exercise 1. |
| **You are fifteen minutes late at the break.** | Apply the cutting rules. Drop exercise 5 before you compress exercise 4. |

---

## FAQ — questions you will be asked

**"What if it does something to my other files?"** Today's written prompts
name files in `~/course-practice`, which keeps the exercise bounded and its
local changes recoverable. The folder is not a hard security boundary: pi
may run with the same access you have, and there are no universal confirmation
pop-ups. Use only the bounded prompts today; Session 4 develops stronger
scoping and approval habits.

**"Is my work being sent somewhere?"** Yes, and it's worth being precise
rather than reassuring. What you type and what it reads goes to the model
provider to produce a response. That's why today's exercises use invented
data that merely *looks* like your work. Before you point this at anything
real, that's a conversation with whoever owns the data — and knowing to have
that conversation is part of the judgment we keep talking about.

**"Which AI is this?"** The model in `setup/pins.env`, the same one for
everybody, which is why "you should see something like this" is a sentence I
can say at all. Model choice is deliberately not yours this term. Don't get
drawn further; harness adaptation is Session 5 and it doesn't extend to
picking your own provider.

**"Why can't I just use the chat one in my browser?"** You can, and for a lot
of things you should. The difference is the boxes: the browser one gives you
text to copy, this one changed a file. That's the distinction from Session 1,
and it's the reason today needed a safety net and a chat window doesn't.

**"Do I have to use the terminal forever?"** No, and it's a fair question. The
terminal is where this particular harness lives; the skill you're learning —
what to delegate, how to check it — moves to whatever comes next. That's the
whole reason we spend one session on the terminal and five on judgment.

**"What if I forget what to type?"** Look at the reference card. Using it is
the intended workflow and a successful floor-test behaviour; nothing on it
is meant to be memorised.

**"Can I use this on my actual work tomorrow?"** Only after the four-part
gate in the practice sheet: you can evaluate it, you are authorized to send
the data and delegate the task, the delegation is appropriate and not a
consequential decision, and a person reviews it before anything external
happens. A checkpoint adds local recovery; it does not replace those gates.

---

## Appendix — what a normal run looks like

From [`DRY_RUN.md`](DRY_RUN.md), so you know what "normal" is before you're
standing in front of people. Two full passes on the canned task, on the
prescribed model:

| Step | What happened, both times |
|---|---|
| `course-smoke-test` | ~10 seconds, PASS |
| Exercise 3 (make the messy file) | One `write` tool call, ~10 seconds, 15 rows with the requested mess |
| Exercise 4 (fix it) | One `write` tool call, ~12 seconds. **Both times it merged `Complete` into `Done` and said so.** Both times it standardised dates to `YYYY-MM-DD` and explained why. |
| Exercise 5 (wreck it) | A `write` and then a `bash` (the rename), ~9 seconds. Complied both times. `.git` untouched, so `revert` worked. |
| `revert` | Restored `sample.csv`, removed `disaster.csv`, both times |

The row contents differed completely between the two runs — different item
names, different teams, different spread of mess. **The outcomes were
identical and the output was not.** That is what "outcome-checked, not
output-checked" means (`docs/trunk/TESTING_PHILOSOPHY.md`), and it is worth
having felt before you promise a room what they're about to see.
