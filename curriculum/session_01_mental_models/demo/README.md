# The Northwind Coffee demo

<!-- Chunk: docs/chunks/fluency_session_01 - Northwind Coffee demo working directory -->

Working directory for the Session 1 live demo (`../FACILITATOR_GUIDE.md`,
Beats 3 and 4). `FACILITATOR_GUIDE.md` is the authority on how to run it and
why; this directory is the material plus a reset command.

```bash
bash curriculum/session_01_mental_models/demo/start-demo.sh
```

That creates (or resets) `~/northwind-demo/` with a pristine
`headcount.csv` and prints the on-screen crib: the two Northwind facts, the
exact prompt, the check question, and both reveals. Run it again any time
to wipe the agent's output and start clean — rehearse as often as you like,
and reset once more right before the room walks in.

Pass a path to put the folder somewhere else:
`bash start-demo.sh /tmp/demo`.

## What's here

| File | What it is |
|---|---|
| `headcount.csv` | The demo file, byte-identical to the listing in `FACILITATOR_GUIDE.md`. Nine people, five spellings of Marketing, and two traps. |
| `start-demo.sh` | Creates/resets the working folder and prints the facilitator crib. |

**The live demo never runs in this repository.** The agent rewrites
`headcount.csv`, so the working copy lives outside the checkout and this
file stays pristine. If `git status` ever shows this CSV modified, you ran
the agent in the wrong folder.

## Why the file is shaped the way it is

Seven rows are mechanical noise — `Marketing`, `marketing`, `Mktg`,
`mktg.`, `MARKETING`, `Digital Mktg Team`. Any competent agent collapses
them correctly, and it should: that part is genuinely impressive and the
room needs to feel it before the turn.

Two rows are the point:

- **Grace — `Brand & Mktg`.** Folding Brand into Marketing is correct at
  almost every company in the world and wrong at Northwind, where Brand
  sits under Product. The file contains nothing that could tell the agent
  this. The output will be confident, well-explained, and wrong.
- **Hank and Ivy — `Field` and `Field Sales`.** The backup trap, for when
  the agent splits Brand out or asks about it. Agents commonly merge these
  two or map `Field` to Sales; both are wrong at Northwind, where "Field"
  is the retail store teams.

Having two independent traps is deliberate: the reveal is the hinge of the
whole session, and a demo that can only fail one way will eventually leave
you standing in front of a room with nothing to reveal. Check which trap
fired before you ask "how would you check this?" — you need to know which
name you're steering toward.

## Rehearse before you teach

Run it twice before the session. Not for confidence — to find out **which
trap fires today**. The model is nondeterministic and the version pinned
for your cohort may behave differently from the last one; the answer can
change between runs on the same machine. Two rehearsal runs tell you which
reveal to aim for and whether the mechanical part still lands as
impressive.

If a rehearsal produces something genuinely new — the agent asks a
clarifying question, refuses to guess, or invents a category — that is
worth capturing. Note it in `../FLOOR_TEST.md` and adapt: an agent that
*asks* about Brand instead of assuming is a better outcome for the world
and a worse demo, and you would rather discover that alone the night
before than live.
