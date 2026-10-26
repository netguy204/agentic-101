# The Northwind Coffee demo

<!-- Chunk: docs/chunks/fluency_session_01 - Northwind Coffee demo working directory -->

Working directory for the Session 1 demo, which you run in live sessions
(`../FACILITATOR_GUIDE.md`, "The Northwind demo"). The guide says how to
run it; this directory holds the file and a reset command.

```bash
bash curriculum/session_01_mental_models/demo/start-demo.sh
```

That creates or resets `~/northwind-demo/` with a clean `headcount.csv`
and prints a crib: the two Northwind facts, the exact prompt, the check
question and both reveals. Run it again to wipe the agent's output; reset
once more right before the call.

Pass a path to put the folder somewhere else:
`bash start-demo.sh /tmp/demo`.

## What's here

| File | What it is |
|---|---|
| `headcount.csv` | The demo file, byte-identical to the listing in `FACILITATOR_GUIDE.md`. Nine people, five spellings of Marketing, and two traps. |
| `start-demo.sh` | Creates or resets the working folder and prints the crib. |

**Never run the demo in this repository.** The agent rewrites
`headcount.csv`, so the working copy lives outside the checkout. If
`git status` shows this CSV modified, you ran the agent in the wrong
folder.

## Why the file is shaped this way

Seven rows are mechanical noise: `Marketing`, `marketing`, `Mktg`,
`mktg.`, `MARKETING`, `Digital Mktg Team`. Any competent agent collapses
them correctly, and the student should see that it does good work before
the reveal.

Two rows are the point:

- **Grace — `Brand & Mktg`.** Folding Brand into Marketing is correct
  almost everywhere and wrong at Northwind, where Brand sits under Product.
  Nothing in the file could tell the agent this.
- **Hank and Ivy — `Field` and `Field Sales`.** The backup trap, for when
  the agent splits Brand out or asks about it. Agents often merge these
  two or map `Field` to Sales; both are wrong at Northwind, where "Field"
  is the retail store teams.

Two traps mean there is almost always something to reveal. Check which
one fired before you ask "how would you check this?"

## Rehearse

Run it twice before a live session, to find out which trap fires today.
The model is nondeterministic, and the pinned version may behave
differently from the last one.

If a rehearsal produces something new (the agent asks a clarifying
question, refuses to guess, or invents a category), note it in
`../FLOOR_TEST.md` and adapt. An agent that asks about Brand is a better
outcome and a worse demo, and you want to find that out before the call.
