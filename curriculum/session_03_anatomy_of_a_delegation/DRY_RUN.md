# Dry run — Session 3

<!-- Chunk: docs/chunks/fluency_session_03 - Session 3 exercise dry-run record -->

Per `docs/trunk/TESTING_PHILOSOPHY.md` (Exercise Dry-Runs): every runnable
step in [`EXERCISES.md`](EXERCISES.md) executed from its written
instructions, with agent steps run more than once because model behaviour
varies. **The dry run follows the text literally — if the runner has to
improvise, the text fails**, and where that happened it is recorded below
along with the fix.

**Run on:** 2026-08-22, macOS (Darwin 25.5.0), by the authoring agent,
against Priya's three briefs from
[`../session_01_mental_models/handouts/canned-toil.md`](../session_01_mental_models/handouts/canned-toil.md)
("For Session 3").

---

## What this run does and does not establish

Read this before trusting anything below it.

| | |
|---|---|
| **Established** | Exercise 3's loop runs from the written text: inputs made by the agent, `commit` before, the instruction sent word for word, `commit` after, `revert` back to *before run 1* by name, a second run, `commit` — and `revert --list` then shows exactly the four lines `EXERCISES.md` promises. All three Priya briefs made real calls to the prescribed model over OpenRouter and wrote real files. Brief A is right both times; Brief B, as first written, stalls; with the folder named it invents its own definition of "stale" and says so; revised, it chases the right items; Brief C is right both times with a checkpoint that couldn't tell. |
| **Not established** | Anything on Windows. Anything about the pi TUI's on-screen rendering (print mode was used). Whether a non-programmer can fill the brief in from the handout or find the box that failed — that is the floor test ([`FLOOR_TEST.md`](FLOOR_TEST.md)) and it has not happened. Exercises 1, 2 and 4 are paper-and-conversation and cannot be dry-run. |

### Deviations from a true participant environment

Four, all recorded rather than hidden:

1. **pi 0.84.2, not the pinned 0.83.0.** As in Session 2's dry run, the
   authoring machine's pi is newer than the pin and was not downgraded to
   run a dry run. `setup/install-pi.sh --skip-packages` configured the
   course model (`anthropic/claude-sonnet-5` via OpenRouter, thinking
   `medium`) for the throwaway home; the agent, tools and prompts are the
   participant's. **Re-running on the pinned version is a pre-cohort
   requirement** (`setup/PRE_COHORT_CHECKLIST.md`).
2. **A throwaway `HOME`, not the operator's.** `env/install.sh
   --skip-packages` and `setup/install-pi.sh --skip-packages
   --no-smoke-test` installed into a temporary home; the operator's real
   `~/.pi`, `~/.agentic-101` and `~/course-practice` were never written to.
   The key appears nowhere in this record. Three practice folders were
   used, one per brief, so each brief's `revert --list` is clean.
3. **`pi -p` (print mode) instead of the interactive TUI**, with stdin
   closed. The agent, tools, model and prompts are identical; what differs
   is that output is printed rather than drawn, and a scripted run cannot
   press `Ctrl+O` or `Escape`. **Escape was therefore not exercised** — it
   matters this time (see Brief B), and it is covered by the interactive
   TUI pass in `FLOOR_TEST.md`.
4. **`commit` and `revert` were answered by piping.** A scripted run cannot
   type at a prompt; answers were piped exactly as a participant types them
   (`2`, then `yes`). The first pass of this run set the environment's
   "assume defaults" switch for `commit` and accidentally made `revert`
   take *its* default — stop — so every "second run" in that pass ran on
   an already-processed folder. That was the runner's error, not the
   text's; the `revert`-to-before steps were re-done properly and only
   those results are reported. It is, incidentally, exactly what a
   participant who presses Enter at "which one?" will see: *Stopped.
   Nothing was changed.* — and the text already says to read the names.

---

## Exercise 3, Brief A — the Monday roll-up (a full brief)

**Inputs** (agent-made from the canned sentence): three tracker files, ten
items each, one date format, roughly a third of each file's items dated
within the past seven days. 22 s, one `write` per file. `commit` →
*before run 1*.

**Run 1** — 22 s. Tool calls, from the session file: `bash`, `read`,
`read`, `read`, `write`.

> **Finding.** The first tool call was `date`. The brief's Inputs box lists
> "today is the Monday" as a fact, and the instruction as first written
> didn't say it — the agent *served itself* the missing input by running a
> command. A fact it can look up is a fact it will look up; the Inputs box
> is for the facts it can't (what "stale" means, which two labels differ).
> The runsheet's Inputs stall line says this.

The agent said:

```
Today is 2026-08-22, so the window is 2026-08-15 through 2026-08-22. I wrote
`monday-summary.md` with the results:

- tracker-alpha.csv: 4 items
- tracker-beta.csv: 4 items
- tracker-gamma.csv: 3 items
```

**Checkpoint applied** (the brief's: count per group against the dates in
each tracker): 4 / 4 / 3 recent items in the files, by date. **Matched
exactly.** Two owners spot-checked against the trackers: present. `commit`
→ *after run 1*.

**`revert` to *before run 1*** (answered `2`, then `yes`):

```
Done. This folder is back to "before run 1".
Nothing was lost — every checkpoint you made is still in the list,
and this move is itself a checkpoint you can go back from.
```

`ls`: the three trackers only; `monday-summary.md` gone.

**Run 2** — 21 s, same instruction. Same counts, different wording, same
file. `commit` → *after run 2*. Then:

```
Your checkpoints, newest first:
   1) 0 seconds ago    after run 2
   2) 22 seconds ago   Back to: before run 1
   3) 13 minutes ago   after run 1
   4) 14 minutes ago   before run 1
```

> **This is the evidence shape `EXERCISES.md` promises** ("What you should
> see" in exercise 3), verified verbatim. The *Back to* line is the revert
> itself, listed as a checkpoint.

---

## Exercise 3, Brief B — chasing stale items (the under-specified one)

**Inputs** (agent-made): `tracker.csv`, fifteen items, one date format —
**dated May 2024**, because the canned sentence said "over the past five
weeks" and the agent, not having looked up today, picked a year. 12 s.

> **Defect found, and fixed.** The inputs sentence now says "find out
> today's real date first, and spread the dates over the five weeks before
> it." With the old sentence every item was two years stale and the brief's
> designed near-miss (what counts as stale) couldn't show.

**Run 1, as first written** — instruction: *"Read `tracker.csv`. For every
item that has gone stale, write a short, friendly chase message…"* — with
no folder named and no definition of stale.

**Stalled. Three times out of three** (300 s, 300 s, 150 s caps). The
session file shows one tool call each time:

```
bash: find / -iname "tracker.csv" 2>/dev/null
```

— a search of the entire disk for the file, which does not return in the
time a participant would wait.

> **Defect found, and fixed — and a teaching point kept.** Every Priya
> instruction now says "in this folder", and the brief handout's
> Instruction prompt says to name the file *and that it's in this folder*.
> The stall is *it didn't know something* — where the file is — arriving as
> a stall rather than a guess, and it is exactly what a real brief written
> in exercise 2 without the folder will do in the room. `EXERCISES.md`
> exercise 3 now tells participants what to do after a minute (Escape,
> `/quit`, read the one box), and the runsheet and facilitator guide carry
> it as an expected case. Escape itself was not exercised here (print
> mode); the interactive pass owns that.

**Run 1, with the folder named, "stale" still undefined** — two runs, 37 s
and 41 s. Tool calls: `bash cat tracker.csv`, `bash date`, a `bash`
python one-liner to compute staleness, `write`. Both runs chased four
items. Run 1's explanation:

```
How I judged "stale": the tracker has no explicit "today" date, so I used
the most recent last_updated in the file (2024-05-30) as a reference point,
then flagged items that are still active (not "Done") and haven't been
touched in roughly 2+ weeks.
```

Run 2 said the same with a table, and added: *"let me know if you'd like a
stricter/looser threshold (e.g., 7 days) and I'll adjust."*

> **This is the brief's designed near-miss, arriving on cue, twice.** Two
> missing facts (the threshold, today) → *it didn't know something*; and an
> unasked-for rule (skip every *Done* item) → *it decided something* — both
> in one run, both announced politely in the explanation, both invisible to
> a checkpoint that only checks "did it chase the stale ones" if you don't
> know what stale is. The runsheet's worked placements quote it.

**Run 2, revised** — the instruction plus *"Stale means no update in the
last 14 days; today is 2026-08-22."* — 26 s and 36 s across two runs
(`bash`, `write`). Chased the ten non-*Done* items (all two years old in
this inputs file), said so, and skipped *Done* items — still a decision
nobody asked for:

```
I skipped items marked Done (…) since there's nothing to chase — they're
already finished, even though their timestamps are also old.
```

> **Box 5 writes itself from this line.** A correct second run that still
> contains a decision the participant didn't make is the best possible
> set-up for exercise 4, and the facilitator guide's appendix says so.

`revert --list` after the proper sequence showed *after run 2 / Back to:
before run 1 / … / before run 1* as for Brief A.

---

## Exercise 3, Brief C — invoice reconciliation (the vague checkpoint)

**Inputs** (agent-made): eight contractors in `invoices.csv` and
`timesheets.csv`, five matching, three differing by 4, 6 and 3 hours, with
team notes explaining each. 16 s.

**Run 1** — 19 s; `bash`, `read`, `read`, `write`. **Run 2** (after
`revert` to before) — 17 s; `bash`, `write`. Both wrote `invoice-check.md`
with a table of all eight and flagged exactly the three whose hours differ
by more than one, each with the team note quoted and a reading of it
("invoice appears overstated" / "understated"). Run 1's explanation:

```
Flagged (difference > 1 hour):
- Chidi Okafor — billed 72 vs. recorded 68 (over-billed by 4) …
- Farid Hassan — billed 88 vs. recorded 82 (over-billed by 6) …
- Hector Ruiz — billed 60 vs. recorded 63 (under-billed by 3) …
The other 5 contractors matched exactly with no discrepancy.
```

Neither input file was modified (checked by `git status` via the
checkpoint list — *after run 1* recorded only `invoice-check.md`).

> **Correct both times — which is the point.** Brief C's checkpoint is "I'd
> look it over." A participant running it has a correct file and no way of
> knowing it is correct; in exercise 4 the question "what would I have
> failed to catch?" has an obvious first answer (a contractor missing from
> the comparison; a difference computed the wrong way round) and an easy
> second checkpoint (count the contractors; re-add one difference by hand).
> The runsheet sends early finishers here.

---

## Timings

| Step | Run 1 | Run 2 |
|---|---|---|
| Brief A — inputs (three files) | 22 s | — |
| Brief A — run | 22 s | 21 s |
| Brief B — inputs | 12 s | — |
| Brief B — as first written (no folder) | **stall, 300 s cap** | **stall, 300 s cap** (and a third at 150 s) |
| Brief B — folder named, stale undefined | 37 s | 41 s |
| Brief B — revised (stale + today) | 26 s | 36 s |
| Brief C — inputs (two files) | 16 s | — |
| Brief C — run | 19 s | 17 s |

Twenty to forty seconds per run. Exercise 3's twenty-four minutes is
therefore dominated by reading, comparing and writing the one-change
sentence, not by waiting — **except for a stall**, which is why the text
now says what to do after a minute.

---

## Corrections this run made to the text

1. Every Priya instruction says **"in this folder"**; the brief handout's
   Instruction prompt says to name the file and that it's in this folder;
   `EXERCISES.md` exercise 2 says the same (the stall).
2. Brief B's inputs sentence asks the agent to **find today's date first**
   (the 2024 dates).
3. `EXERCISES.md` exercise 3 gained **"If it sits for more than a minute"**
   (Escape, `/quit`, read the one box); the runsheet and the facilitator
   guide's failure table carry the same case with the dry-run cause.
4. The runsheet's worked placements quote Brief B's real explanation for
   *it didn't know something*, and add the stall as a second form of it.
5. The facilitator guide's appendix reports what the briefs actually did
   rather than what was planned.

## Status

| Step | Status |
|---|---|
| Exercise 1 — the round and the sort | **Not runnable** — conversation; floor test |
| Exercise 2 — writing the brief | **Not runnable** — paper; floor test |
| Exercise 3 — inputs, commit, run, commit, revert-to-before, run, commit | **Verified ×3 briefs**, each run at least twice; `revert --list` shape verified verbatim |
| Exercise 3 — the stall and Escape | Stall **reproduced ×3**; Escape **not exercised** (print mode) |
| Exercise 4 | **Not runnable** — paper; the material it needs (B's unasked decision, C's vague checkpoint) **verified present** |
| pi TUI keys (`/quit`, `Ctrl+O`, `Escape`) | **Not verified** — print mode only |
| Windows | **Not run** |
| Pinned pi version | **Not run** — 0.84.2 used; 0.83.0 pinned |

## Before this session is taught

1. **Re-run exercise 3 on the pinned pi** (`setup/pins.env`), or re-pin.
2. **Run it once through the real TUI** and press Escape on a stalled Brief
   B (remove "in this folder" to provoke it) — fifteen minutes — so the
   "after a minute" instruction has been done by hand.
3. **Run exercise 3 once on Windows**, Git Bash, including the
   `revert`-to-before move.
4. **Do the floor test** ([`FLOOR_TEST.md`](FLOOR_TEST.md)). Nothing here
   says whether a non-programmer can write a brief from the handout or find
   the box that failed; only that the briefs do what the text now claims.
