# Dry run — Session 2

<!-- Chunk: docs/chunks/fluency_session_02 - Session 2 exercise dry-run record -->

Per `docs/trunk/TESTING_PHILOSOPHY.md` (Exercise Dry-Runs): every runnable
step in [`EXERCISES.md`](EXERCISES.md) executed from its written
instructions, with agent steps run more than once because model behaviour
varies. **The dry run follows the text literally — if the runner has to
improvise, the text fails**, and where that happened it is recorded below
along with the fix.

**Run on:** 2026-08-07, macOS (Darwin 25.5.0), by the authoring agent.

---

## What this run does and does not establish

Read this before trusting anything below it.

| | |
|---|---|
| **Established** | Every command in the exercises runs, in order, and produces the output the text now claims. The `commit`/`revert` walkthroughs were driven end to end with real answers. The agent steps made real calls to the prescribed model over OpenRouter and changed real files. `.git` survives exercise 5, so `revert` works afterwards. |
| **Not established** | Anything about Windows. Anything about the pi TUI's on-screen rendering. Anything about whether a non-programmer can follow the text — that is the floor test ([`FLOOR_TEST.md`](FLOOR_TEST.md)) and it has not happened. |

### Deviations from a true participant environment

Four, all recorded rather than hidden:

1. **pi 0.84.1, not the pinned 0.83.0.** The authoring machine already had
   0.84.1 installed globally, and downgrading the operator's own tooling to
   run a dry run was not an acceptable trade. Consequence: `course-smoke-test`
   correctly reported a pin mismatch and refused to go further (transcript
   below) — which is itself a useful verification that the pin check works.
   The full run was then repeated with the sandbox's copy of `pins.env`
   locally rewritten to `0.84.1`. **Re-running this dry run on the pinned
   0.83.0 is a pre-cohort requirement** (`setup/PRE_COHORT_CHECKLIST.md`).
2. **A throwaway `HOME`, not the operator's.** Everything ran under a
   temporary home directory with `env/install.sh --skip-packages` and
   `setup/install-pi.sh --skip-packages --key …` installed into it. The
   operator's real `~/.pi`, `~/.agentic-101` and `~/course-practice` were
   never written to. The OpenRouter credential was copied read-only from the
   operator's auth file; the key itself appears nowhere in this record.
3. **`pi -p` (print mode) instead of the interactive TUI.** The agent, the
   tools, the model, the prompts and the files are identical; what differs is
   that output is printed rather than drawn in a full-screen interface, and
   that a scripted run cannot press `Ctrl+O` or `Escape`. **The keyboard
   behaviour of the TUI is therefore unverified by this run** — it is covered
   by `env/FLOOR_TEST.md`, which owns the keybinding audit.
4. **Two GUI steps performed from the shell.** Exercise 2 asks participants
   to edit `notes.txt` and later delete it *in the file browser*. A scripted
   run cannot double-click. Those two actions were performed as their
   filesystem equivalents and are marked below. What the exercise depends on
   is the file's state, which is identical either way — but "does
   double-clicking a `.txt` open a plain-text editor on both platforms" is a
   floor-test question, not a dry-run one.

---

## Setup triage — `course-smoke-test`

**Run A, as shipped** (pi 0.84.1 present, `pins.env` asking for 0.83.0).
Elapsed: under 1 second, because it stops before the model checks.

```
Checking your course setup

  [ok]   the course environment is healthy (commit, revert, git, node)
  [no]   pi is version 0.84.1, but this course uses 0.83.0
  [ok]   pi is set to the course model (openrouter, anthropic/claude-sonnet-5)
  [ok]   your key is saved and only readable by you
  [--]   skipped the two checks that talk to the model — fix the problems above first

FAIL — 1 thing(s) above need attention.
```

Correct behaviour, and the failure mode a facilitator will actually meet if a
participant updated pi. `setup/README.md`'s troubleshooting table already
covers it ("Run Step 3 again — it installs the exact version the course
expects").

**Run B, with the sandbox pin aligned to the installed version.** Elapsed:
**9.7 seconds**, including both live model calls.

```
Checking your course setup

  [ok]   the course environment is healthy (commit, revert, git, node)
  [ok]   pi is installed, version 0.84.1
  [ok]   pi is set to the course model (openrouter, anthropic/claude-sonnet-5)
  [ok]   your key is saved and only readable by you
  [--]   asking the model a question — this can take up to a minute…
  [ok]   your key works and anthropic/claude-sonnet-5 answered
  [--]   asking the agent to do a small task — this can take a few minutes…
  [ok]   the agent did a real task: it created a file when asked

PASS — you are ready for the course.
```

> **Finding, and it changed the facilitator guide.** Ten seconds is fast
> enough that the eight-minute triage opening is comfortable rather than
> tight, and the guide now says so. The setup guide's "give it up to four
> minutes" is a worst case, not a typical one.

---

## Exercise 1 — Where am I?

```
$ pwd
/…/home
$ ls
course-practice   Library
$ cd ~/course-practice
$ pwd
/…/home/course-practice
$ ls
README.txt
```

> **Defect found, and fixed.** The exercise text originally said `ls` in the
> practice folder returns nothing, and made a teaching point of the blank
> response. **It does not** — `setup/install-pi.sh` writes a `README.txt`
> there when it creates the folder, and that README happens to explain the
> practice folder and name `commit` and `revert`. The exercise now has
> participants open and read it, which is better than the beat it replaced.

`open .` / `explorer .` were **not executed** (no GUI session, and `explorer`
is Windows-only). Unverified.

---

## Exercise 2 — The safety net

`touch notes.txt` then `ls`:

```
notes.txt   README.txt
```

Editing `notes.txt` in the file browser was performed as a shell write of the
line `hello from session 2` (deviation 4).

**`commit`**, answering `yes` and then `before anything`:

```
This folder (course-practice) is not saving checkpoints yet.
Turning them on lets you save a snapshot of everything in it at any
moment, and go back to that snapshot later. It changes nothing about
your files.

Turn on checkpoints for this folder? [Y/n] Done — this folder now remembers checkpoints.
(Checkpoints in this folder will be signed 'btaylor'.)

2 things changed in this folder:
  README.txt (new)
  notes.txt (new)

What should we call this checkpoint? (press Enter for: Checkpoint on Friday, August 7 at 11:27 PM)
> 
Saved: "before anything"
Whenever you want to come back to exactly this, type: revert
```

> **Second correction to the text.** The first `commit` reports **2** things
> changed, not 1 — `README.txt` has never been checkpointed either. A
> participant told to expect one file and shown two will stop and ask. The
> exercise now names both.

Deleting `notes.txt` in the file browser was performed as `rm notes.txt`
(deviation 4). `ls` then showed `README.txt` alone.

**`revert`**, answering Enter, Enter, `2`, `yes`:

```
Wait — 1 thing in this folder has changed since your last checkpoint.
Going back would undo those changes, so let's deal with them first.

  1) Save them as a checkpoint now, then go back  (recommended)
  2) Set them aside and go back without them
  3) Stop — don't go anywhere

What would you like to do? Type 1, 2 or 3. (press Enter for: 1)
> 
1 thing changed in this folder:
  notes.txt (deleted)

What should we call this checkpoint? (press Enter for: Checkpoint on Friday, August 7 at 11:27 PM)
> 
Saved: "Checkpoint on Friday, August 7 at 11:27 PM"

Your checkpoints, newest first:
   1) 0 seconds ago    Checkpoint on Friday, August 7 at 11:27 PM
   2) 0 seconds ago    before anything

Which one should this folder go back to? Type its number, or press Enter to stop.
> 
This will put every file in this folder back exactly as it was at:

    before anything  (0 seconds ago)

Anything you did after that point will be undone. Your later checkpoints
stay in the list, so you can come back forward again if you change your mind.

Go back to this checkpoint? [y/N] 
Done. This folder is back to "before anything".
```

Then `ls` → `notes.txt  README.txt`, and `notes.txt` contained
`hello from session 2`. **The safety net works.**

> **Third and most important correction.** The written step said "press Enter
> to accept the recommended answer, then pick the checkpoint by its number".
> Running it literally exposed two traps the text did not warn about:
>
> 1. `revert` asks **four** questions, not three, and the first word it says
>    is "**Wait —**", which a new user reads as an error.
> 2. The checkpoint they want is **number 2**, because `revert` has just
>    saved their deletion as a new number 1. Anyone following the obvious
>    instinct and typing `1` goes back to the state they were trying to
>    escape.
>
> The exercise now has a four-row table giving the exact answer to each
> question and the reason for it, and the rule **"read the names, not the
> numbers"** appears in the exercise, the facilitator guide and the handout.
> This is the clearest case in the session of the dry run earning its place.

---

## Exercises 3–5 — the agent steps

Run **twice** end to end, in two separate folders, from the canned prompts
now shipped in
[`../session_01_mental_models/handouts/canned-toil.md`](../session_01_mental_models/handouts/canned-toil.md).
Exercise 5's prompt was run a **third** time on its own, because it is the
one that could destroy the checkpoints.

Model: `anthropic/claude-sonnet-5` via OpenRouter, thinking `medium` — the
prescribed configuration from `setup/pins.env`.

### Timings

| Step | Run 1 | Run 2 |
|---|---|---|
| Exercise 3 — make the messy file | 9.9 s | ~10 s |
| Exercise 4 — fix it | 12.1 s | ~11 s |
| Exercise 5 — wreck it | 9.1 s | ~9 s |

Fast enough that the 14 / 13 / 7-minute exercise budgets are dominated by
typing, reading and thinking rather than by waiting — which is the right
shape, and which the facilitator guide now states.

### Tool calls, from the session files

Identical across both runs:

| Prompt | Tools called |
|---|---|
| Exercise 3 | `write` |
| Exercise 4 | `write` |
| Exercise 5 | `write`, then `bash` (the rename) |

> **Finding that changed the worksheet.** Exercise 4 called **`write` only —
> it never re-read the file** before rewriting it, because the content was
> still in the session from exercise 3. A participant expecting `read` then
> `write` will think they have missed something. Both the exercise and
> [`handouts/what-did-it-do.md`](handouts/what-did-it-do.md) now say that one
> or two boxes is a normal answer, and that noticing the missing `read` is a
> good observation rather than a wrong one.

### Exercise 3 — the messy file

**Run 1** produced 15 rows with four spellings of "in progress", four of
"done", two of "not started", and five date formats. **Run 2** produced 15
completely different rows with a comparable spread of mess. Example, run 1:

```csv
item name,team,status,last updated
Login page redesign,Frontend,In Progress,03/14/2024
API rate limiting,Backend,in progress,2024-03-15
Onboarding checklist,Growth,Done,3/16/24
Dark mode toggle,Frontend,In-Progress,2024/03/12
Payment retries,Backend,Complete,03-18-2024
…
```

Both runs invented plausible-looking work items unprompted and left the mess
in as asked. **The exercise is outcome-checkable**: a file exists, it has
roughly fifteen rows, and the mess is present. Nothing about the exercise
depends on which rows appear.

### Exercise 4 — fixing it, and the judgment call

Both runs standardised statuses to one label each and dates to
`YYYY-MM-DD`, explaining both choices in prose.

**Both runs merged `Complete` into `Done`.** Run 1 said so explicitly:

> `Done` ← merged `Complete`, `COMPLETE`, `DONE`, `done` (treated "Complete"
> and "Done" as the same real-world state)

> **This is the session's teaching moment and it arrived by itself, twice.**
> It is Session 1's Northwind reveal reproduced on the participant's own
> material: a defensible decision that is wrong at some organisations, made
> confidently, announced politely, and invisible to every mechanical check
> (fifteen rows in, fifteen rows out). The facilitator guide now names it as
> the reliable thing to interrogate if nobody in the room raises something
> better, and the canned handout tells fallback participants what to watch
> for.

### Exercise 5 — break it on purpose

All three runs complied without hesitation, replacing `sample.csv` with a
limerick and renaming it to `disaster.csv`. `ls` afterwards, run 1:

```
disaster.csv   notes.txt   README.txt
```

**`.git` was intact in all three runs**, and `git log` still showed every
checkpoint. `revert` then restored `sample.csv` with its cleaned contents and
removed `disaster.csv`, in both full runs.

> **The bounded prompt is doing its job and must not be loosened.** The
> prompt names the one file it ruins. An unbounded "delete everything in this
> folder" could reach the hidden checkpoint folder and leave nothing to
> revert to — the exact opposite of the lesson, taught unforgettably. Both
> the exercise and the facilitator guide say this, with the reason, because a
> facilitator who doesn't know *why* will let a keen participant improvise.

> **Not observed, but expected eventually.** In three runs the agent never
> refused and never asked a clarifying question. Both are plausible on other
> runs or other days; the exercise and the guide carry recovery moves for
> each. Their absence here means those recovery paths are **unverified**.

### The revert list grows

By exercise 5 in run 1 the checkpoint list was six entries deep:

```
   1) 0 seconds ago    Checkpoint on Friday, August 7 at 11:28 PM
   2) 9 seconds ago    cleaned up
   3) 53 seconds ago   the messy sample
   4) 2 minutes ago    Back to: before anything
   5) 2 minutes ago    Checkpoint on Friday, August 7 at 11:27 PM
   6) 2 minutes ago    before anything
```

Six lines, four of which the participant did not name, and the one they want
is second. The exercise now says explicitly: find the line that says "cleaned
up" and type *that* number; it is probably 2; do not assume.

---

## Summary

| Step | Status |
|---|---|
| `course-smoke-test` | **Verified**, both the PASS path and the pin-mismatch FAIL path |
| Exercise 1 — terminal navigation | **Verified**, one defect found and fixed (the folder is not empty) |
| Exercise 1 — `open .` / `explorer .` | **Not run** — no GUI session |
| Exercise 2 — `commit` | **Verified**, one defect found and fixed (2 files, not 1) |
| Exercise 2 — `revert` | **Verified**, two defects found and fixed (four questions; the target is number 2) |
| Exercise 2 — file-browser edit and delete | **Substituted** with shell equivalents |
| Exercise 3 — first delegation | **Verified ×2** |
| Exercise 4 — the fix, tool calls, judgment call | **Verified ×2**, one worksheet change |
| Exercise 5 — destructive prompt and recovery | **Verified ×3**; `.git` survives every time |
| pi TUI keys (`Ctrl+O`, `Escape`, `/quit`, `pi -c` interactively) | **Not verified** — print mode only; `pi -c` verified non-interactively |
| Windows, end to end | **Not run** — no Windows machine available |

## Before this session is taught

1. **Re-run everything on the pinned pi** (`setup/pins.env`, currently
   0.83.0) rather than on 0.84.1, or re-pin the cohort to the version that
   was actually tested. `setup/PRE_COHORT_CHECKLIST.md` owns this.
2. **Run exercises 1–5 once on Windows**, in Windows Terminal with the Git
   Bash profile. `explorer .`, double-clicking a `.txt`, and deleting from
   File Explorer are all unverified there, and `env/README.md` already
   records the whole Windows installer path as authored-but-untested.
3. **Run the session once through the real TUI**, by hand, confirming
   `Ctrl+O`, `Escape`, `/quit` and `pi -c`. Fifteen minutes.
4. **Do the floor test** ([`FLOOR_TEST.md`](FLOOR_TEST.md)). Nothing in this
   record tells you whether a non-programmer can follow the text — only that
   the text is factually accurate about what the commands do.
