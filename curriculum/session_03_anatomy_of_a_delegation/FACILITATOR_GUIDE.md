# Session 3 facilitator guide — Anatomy of a delegation

<!-- Chunk: docs/chunks/fluency_session_03 - Session 3 facilitator guide -->

**Length:** 90 minutes live. A 60-minute variant is marked in the timing
table.

**The one thing this session must achieve:** every participant has written
down, on one page, what an agent needs to be told to do one of their own
tasks — inputs, instruction, outputs, checkpoints — run it, found the box
that let them down, changed it for a reason they can say, run it again, and
written down what their checks would still miss. Not "understands the four
parts" — *has a brief that ran twice*.

**What this session is:** the one where a delegation stops being a sentence
and becomes a structure. Session 2 proved the room can hand an agent work
and read what it did. Session 3 is about why the ones that went badly went
badly, and it opens on the room's own bad ones — which the practice week was
designed to produce, one per person.

**What this session is not:** a prompt-writing course. The word is *brief*;
the frame is a capable colleague who cannot see your screen and will not
ask. There are no techniques to memorise, only four boxes to fill and the
habit of changing one at a time. And it is not yet workflows: one task, one
delegation, anatomised. "What happens when it runs every week" is Session 4.

---

## Before the room

- **Read Session 2's checkpoint tally** — the table in
  [`../session_02_meeting_the_harness/CHECKPOINT.md`](../session_02_meeting_the_harness/CHECKPOINT.md)
  that you filled in at the end of Session 2. It tells you who never ran a
  delegation unaided, who read only the summary, and who had no real check.
  Those people need a neighbour from minute one today, because this session
  assumes everybody can run a delegation and read its tool calls. If more
  than a third of the room was a near-miss, see "If Session 2 didn't land"
  below — the opening changes.
- **Read** [`EXERCISES.md`](EXERCISES.md) (what participants follow) and
  [`EXERCISE_RUNSHEET.md`](EXERCISE_RUNSHEET.md) (what you run the block
  from) end to end, and [`DRY_RUN.md`](DRY_RUN.md) at least skimmed. The dry
  run records what Priya's three briefs actually did on the course model,
  including which one goes wrong and how.
- **Run exercise 3 yourself, the day before**, on a Priya brief, from the
  written text, in a folder you then delete. Fifteen minutes. The one new
  mechanical move today — `revert` back to *before run 1* so the second run
  starts from the same place — is the thing to have done with your own
  hands.
- **Run `course-update` on your own machine** the morning of. If it updates
  something, the room's will too, and you want to have seen the message.
- **Print** [`handouts/delegation-brief.md`](handouts/delegation-brief.md),
  **two** per participant — one for the room, one for the practice week —
  and Session 1's
  [`handouts/canned-toil.md`](../session_01_mental_models/handouts/canned-toil.md)
  for anyone on Priya's briefs (the "For Session 3" section is what they
  need, but print the whole sheet; the task descriptions are on page one).
- **Send the prework a week ahead** ([`PREWORK.md`](PREWORK.md)). It asks
  for three things to be brought: the worst-delegation worksheet, the
  inventory, and one sentence. Chase the worksheet two days out — a room
  where half the people have no sentence has no opening.
- **Know the pins.** `setup/pins.env` still names the pi version and model.
  `course-update` handles the version now; if someone's says it updated pi,
  that's expected, not a mystery.

### The spare laptop still earns its place

Same as Session 2: one machine with the environment installed and a spare
key, at the back. Exercise 3 is twenty-four minutes and a participant who
cannot run anything has no session.

---

## The first three minutes

No triage beat this time — `course-update` is the triage. Everyone opens
the course terminal, types it, and you ask for hands on *Nothing to do* (or
on "it updated and I've reopened the window"). Anyone whose terminal isn't
cooperating gets a neighbour now; the person without the laptop types.
Then start. The same rule as Session 2 holds: **do not debug a laptop during
the session.** Thirty seconds, a pairing, a slot afterwards.

---

## Timing

| Start | Min | Beat | 60-min variant |
|---|---|---|---|
| 0:00 | 3 | Arrival — `course-update`, pairs | 2 |
| 0:03 | 12 | **Exercise 1 — your worst one** (this is the cold open) | 8 |
| 0:15 | 8 | The anatomy — four parts, one definition | 6 |
| 0:23 | 12 | **Exercise 2 — write the brief** | 10 |
| 0:35 | 5 | Break | — |
| 0:40 | 24 | **Exercise 3 — run it, read it, fix it, run it again** | 16 |
| 1:04 | 10 | **Exercise 4 — what would I have failed to catch?** | 8 |
| 1:14 | 4 | The sentence to land, and next time | 2 |
| 1:18 | 8 | **Checkpoint round** | 6 |
| 1:26 | 4 | Practice assignment, close | 2 |

**Cutting rules, in the order you should cut.** Drop the break. Shorten the
anatomy beat to the definition and the four words on the board. In exercise
3, cut the *second* run's reading to "apply your checkpoint and commit" —
the change-one-box sentence must still be written. Run the checkpoint round
as six spoken answers plus photographs of the rest.

**Never cut exercise 1, never cut exercise 4, and never cut the change-one-
box step.** Exercise 1 is the session's argument (the tally on the board is
the anatomy, discovered rather than announced); exercise 4 is its payload;
the one-change sentence is its evidence. If you are at 1:00 with the first
runs still coming back, **let the second run be the practice week's job** —
say so out loud: "your second run is the first thing on your practice sheet;
write the change now, run it at home" — and go straight to exercise 4 with
the brief as revised. A session that ends with a revised brief and a filled
box 5 has landed, even if the second run happens Tuesday.

---

## Beat 1 — Exercise 1 is the cold open (12 min)

There is no preamble. Say one thing, then start the round:

> "Everybody brought one that went badly. That is the best material this
> course has ever had in a room, and we're going to use it before I teach
> you anything. One sentence each: what you asked for, what went wrong."

Run it from [`EXERCISE_RUNSHEET.md`](EXERCISE_RUNSHEET.md), exercise 1 —
the three reasons on the board, a tally mark per sentence, named out loud
in four words each, fast. The runsheet has worked placements for the
sentences you'll actually hear.

**Why this is the open and not a warm-up.** If you explain the three reasons
first, people classify themselves and the round teaches nothing. If you run
the round first, the tally on the board *is* the anatomy, and the next beat
only has to name what everyone has just watched happen twelve times.

**Hold the fourth bucket ready.** "It was outside what I could judge and I
noticed" is a pass. Say so the first time it comes up, because the person
saying it half-expects to be told they did it wrong.

---

## Beat 2 — The anatomy (8 min)

Point at the tally. Then the definition, quoted from `docs/trunk/SPEC.md` so
Sessions 4–5 build on the same words:

> A **delegation** is handing a task to an agent with enough structure that
> it completes without step-by-step supervision.

> "*Enough structure.* Look at the board: every one of those marks is a
> piece of structure that wasn't there. There are four pieces. Two of them
> you already wrote, weeks ago, on your inventory."

Write the four under the three reasons, and draw the arrows:

| Reason on the board | The missing box |
|---|---|
| It didn't know something | **Inputs** — what it must be able to see: files, and facts that aren't written anywhere |
| It decided something | **Instruction** — what done right looks like, said precisely enough that the decisions you care about are made by you (and **Checkpoints**, to catch the ones you didn't think to name) |
| I couldn't tell | **Checkpoints** — where you'll look and what for, as a step, not a hope |
| *(always)* | **Outputs** — what done produces and where; if you can't name it, you can't check it |

Then the frame that carries the rest of the session:

> "Think of it as briefing a capable colleague who cannot see your screen,
> doesn't know your company, and will not ask. Anything you leave out, they
> guess — politely, confidently, and sometimes wrong. The brief is what you'd
> write for them."

And the inventory, held up:

> "Column 2 is your instruction. Column 4 is your checkpoints. You wrote both
> before you'd seen this software. Today you add the two boxes that were
> missing, and you find out by running it which one you needed."

**Do not teach techniques here.** No "be specific", no "give examples". The
four boxes are the whole technique; the runs are the teacher.

---

## Beat 3 — Exercise 2: write the brief (12 min)

Run it from the runsheet. Two things to do yourself:

**Brief Priya's Monday roll-up on the board first.** Two minutes, four
boxes, out loud — the runsheet has the words. Doing one together sets the
standard for how concrete a box should be, exactly as working one check
column live did in Session 1.

**Circulate for the two misfires** the runsheet names: column 2 pasted in
as the instruction with no file and no result; and "I'll read it over" in
checkpoints. Both have one-question fixes.

---

## Beat 4 — Exercise 3: run it, read it, fix it, run it again (24 min)

The long beat. Three moves:

**Show the `revert`-to-before move on the projector before anyone types.**
One minute. `revert --list` with *before run 1* and *after run 1* on it;
then "we go back to *before*, by name, and run again from the same place."
It is the only new mechanical thing today and the room should see it once
before doing it.

**Say the what-you-type rule before step 4.** "The Instruction box, word for
word, plus any Inputs fact that isn't in a file. Nothing else." People add
preamble; the preamble is what hides whether the brief was enough.

**Then get out of the way and circulate for the three misfires** in the
runsheet — changing several boxes at once; the agent getting it right
despite a bad brief (send them to Checkpoints: "would you have *known*?");
and the brief that says "don't make any decisions." Each has its sentence.

**The sentence that makes the beat work**, said after the first runs come
back and again before the second:

> "Something let you down and it was one of four boxes — not the agent, a
> box. Find it. Change it once. Say why. Run again. That loop is the whole
> skill."

---

## Beat 5 — Exercise 4: what would I have failed to catch? (10 min)

The payload. Run it from the runsheet; the sentence to say is there and it
is the sentence the session exists for. Two things to hold:

**"Out" is a pass.** Someone who writes *out* beside a task they have just
run twice has found their judgment boundary in a practice folder. Say so
to the room when it happens; it is Session 1's lesson arriving in their
own hands, and it is what Session 6 will gate the capstone on.

**"Out" is not an escape.** The test is "could *anyone* in your role check
this?" If yes, it's a missing checkpoint. The runsheet has the words.

---

## Beat 6 — The sentence to land, and next time (4 min)

> "A delegation is a task with enough structure that it completes without
> you. You now know what enough is: what it must see, what done looks like,
> what done produces, where you'll look. And you know the move when it goes
> wrong — find the box, change it once, run again. Next time we ask the
> question this one raises: what happens when the same brief has to run
> every week, and how do you spend your checking where it buys the most?
> That's a workflow, and it's Session 4."

Say *workflow* once, as a word for next time. Don't define it.

---

## Beat 7 — Checkpoint round (8 min)

Run it as [`CHECKPOINT.md`](CHECKPOINT.md) describes. One frame, three
sentences per person, no discussion:

> "Which box you changed, and why. What your check would still miss."

Twelve people, eight minutes. Note the answers as you go; the table in
[`CHECKPOINT.md`](CHECKPOINT.md) is what Session 4 is planned from — Session
4 opens with the briefs, and you need to know whose ran twice.

---

## Beat 8 — Close (4 min)

Hand out [`PRACTICE.md`](PRACTICE.md) and say two sentences: the first thing
on it is running the brief on the real task — the same loop, on the real
thing — and the second run, revised, is the thing to bring next time. Then
the sentence that keeps the course honest: "this replaces something you were
going to do by hand anyway. If it feels like homework, you picked the wrong
entry."

Then catch, individually and quietly: anyone whose brief never ran twice,
anyone with an empty box 5, anyone who wrote *out* and looked unhappy about
it. Recovery moves are in [`CHECKPOINT.md`](CHECKPOINT.md).

---

## If Session 2 didn't land

Session 2's checkpoint obligates a different opening if more than about a
third of the room couldn't name a real check: fifteen minutes on "what did
yours actually do", with the practice-week sessions still on people's
laptops (`pi -r` lists them; pick the one from the worst delegation), walking
the tool-call boxes and the file together before any sentence is said. Take
the time from exercise 3's second run (let it be the practice week's), not
from exercise 1 or 4. Someone who cannot yet see what the agent did has
nothing to write a brief *against*.

---

## Anticipated failure points and recovery moves

| What goes wrong | What you do |
|---|---|
| **Half the room has no worst-delegation worksheet.** | Run the round anyway on whoever has one; people without one sort along with you and meet their near-miss in exercise 3 (give them Priya's Brief B — it is built to go wrong). Then chase the practice week harder before Session 4 and log it in `docs/trunk/FRICTION.md` — a room that didn't do the practice is a finding about `PRACTICE.md`, not about the room. |
| **The agent gets it right despite a bad brief**, for a third of the room. | Expected; the dry run saw it. Send them to Checkpoints: "would you have *known* if it hadn't?" They add the check that would have caught the thing they most expected and run again. A clean second run with a better check is a pass. Never let "nothing let me down" stand. |
| **The agent does something surprising in front of the room.** | Same as Session 2 and still true: **the best thing that can happen**. Show it, ask "which box would have stopped that?", and watch the room answer. |
| **Somebody's worst delegation was outside their judgment boundary** — an `out` entry, or a vague column 4. | A *good* diagnosis; say so. They brief a different `in` entry in exercise 2, and their exercise-1 sentence goes under *out of bounds* on the board. |
| **`revert` in step 9 goes to the wrong checkpoint.** | Undoable — `revert` again, read the names. Same rule as Session 2; say it once to the room. |
| **A first run takes more than a minute and someone thinks it's frozen.** | Twenty to thirty seconds is normal. More than a minute with nothing new is a stall, and the dry run saw the cause: a brief that named a file without saying where sent the agent searching the whole disk. Escape, `/quit`, read the one box; the change is "in this folder". Say it to the room the first time — it's *it didn't know something*, as a stall. |
| **A participant changes three boxes at once.** | "One box. The second run tells you about the next one." If they already ran it, have them name the one that mattered most and write only that in the sentence. |
| **Somebody writes "out" to get out of the work.** | "Out means nobody with your knowledge could check it. Is that true?" If not, it's a missing checkpoint — help them write one. |
| **A Windows participant sees a git warning after `commit`.** | Environments from 1.0.1 silence it; `course-update` at the start of today should have delivered that. If it still shows, it's harmless — "look for the green *Saved* line" — and they re-run Step 1 of the setup guide after the session. |
| **A technical participant wants to talk about prompt engineering.** | "The four boxes *are* the technique, and the runs are the teacher. Techniques that don't survive the second run aren't techniques." Give them box 5 on the Priya brief they didn't choose, and move on. |
| **The room is remote-only.** | The round works unchanged (chat or voice, one sentence each; you keep the tally on a shared screen). One volunteer screen-shares the `revert`-to-before move. Pairs are breakout rooms with the driver dictating. Budget three extra minutes overall and take them from exercise 2. |
| **You are fifteen minutes late at the break.** | Apply the cutting rules. Let the second run be the practice week's before you compress exercise 4. |

---

## FAQ — questions you will be asked

**"Isn't this just prompt engineering?"** It's the part of it that survives
contact with the work. The four boxes aren't tricks for talking to a model;
they're what any delegation needs — to a person or an agent — and the
reason we write them down is that the agent won't ask for the one you left
out. You're not learning to phrase things; you're learning what you owe the
person doing the task.

**"What if the agent asks me a question instead of doing it?"** Answer it —
and notice that the question was a missing input. That's box 1 telling you
it was incomplete. Next run, the answer goes in the brief.

**"Can I reuse a brief at work tomorrow?"** That is exactly what the
practice week is. Same gate as Session 2's practice sheet: you can check it,
you're allowed to, it isn't a consequential decision, and a person approves
anything before it leaves the folder. A good brief doesn't change the gate;
it makes the checkpoint box the place where the gate's first question gets
answered.

**"My second run was worse. Did I do it wrong?"** No — you learned
something the first run couldn't teach you. Say which box you changed and
what happened; that's still the checkpoint. Then change it back, or change a
different one, in the practice week.

**"Why only one box at a time?"** Because otherwise you never find out which
one mattered. It feels slow and it is faster: one change and a run is two
minutes; three changes and a guess is a week of not knowing.

**"What do I do with the brief after today?"** Keep it. The practice week
runs it on the real task; Session 4 turns it into the first step of a
workflow; Session 6 asks for one as your capstone design. It's the second
document on this course that outlives the session it started in — the
inventory is the first.

---

## Appendix — what a normal run looks like

From [`DRY_RUN.md`](DRY_RUN.md), so you know what "normal" is before you're
standing in front of people. Priya's three briefs, on the course model
(`anthropic/claude-sonnet-5` over OpenRouter), from the written text:

| Brief | What happened |
|---|---|
| **A — Monday roll-up** | ~20 seconds, both runs. Ran a shell command to find today's date (the brief's fact, self-served), read the three trackers, wrote `monday-summary.md` grouped by file with per-file counts 4 / 4 / 3 — which matched the dates in the trackers exactly. The "right" run: what a full brief looks like when it works. |
| **B — chasing stale items**, as first written (no folder, no threshold) | **Stalled, three times out of three.** The single tool call was a search of the whole disk for `tracker.csv`; it never returned. That finding put "in this folder" into every Priya instruction — and it is what a real brief written without the folder will do in the room. Escape, `/quit`, read the one box. |
| **B — with the folder named, "stale" still undefined** | ~40 seconds. Read the file, ran `date`, then **chose its own reference date and its own threshold** ("roughly 14 days, measured from the newest date in the file, since there's no live today"), skipped every *Done* item without being asked, chased four, and said all of this in its explanation. *It didn't know something* and *it decided something*, in one run, on cue. |
| **B — revised** (stale = 14 days; today stated) | ~26 seconds. Chased the right items, still skipped *Done* ones — and said so. Box 5 writes itself: the decision nobody asked for. |
| **C — invoice reconciliation** | ~18 seconds, both runs. Read both files, flagged the three contractors whose hours differed by more than one (4, 6 and 3 hours), explained each using the team note. Correct both times — and that is the point: its checkpoint says "I'd look it over", so the participant has no way of knowing it was correct. |

Row contents differed between runs; the outcomes did not. **Outcome-checked,
not output-checked** (`docs/trunk/TESTING_PHILOSOPHY.md`) is worth having
felt before you promise a room what they're about to see — and so is the
stall, which looks like a broken tool and is a missing input.
