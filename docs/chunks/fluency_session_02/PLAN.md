# Implementation Plan

## Approach

Author `curriculum/session_02_meeting_the_harness/` as eight files — the six
required by `curriculum/README.md` (DEC-010) plus `FLOOR_TEST.md` and
`DRY_RUN.md` — in the register established by
`curriculum/session_01_mental_models/`: plain language, second person,
minute-level timing, tables for anything enumerable, honest about what has
not been verified.

The session's design problem is ordering, not content. Four things have to
happen in 90 minutes, and only one order works:

1. **Terminal survival** — the participant must be able to get to
   `~/course-practice` and know they are there before anything else is
   possible.
2. **The safety net** — `commit` and `revert`, proved by hand (the
   participant deletes a file themselves and gets it back) *before* an agent
   is allowed near the folder. DEC-006: pi has no undo. Session 1's
   PRACTICE.md has already promised these arrive here.
3. **First delegation** — pi in the practice folder, on material derived
   from the participant's own toil entry.
4. **Reading and judging what it did** — tool calls, then the file on disk,
   then the recurring question: *was this reasonable, and how do I know?*
   (DEC-005.)

Two design choices carry most of the weight and are worth stating plainly:

**The agent creates its own practice material.** `~/course-practice` is
empty after setup — `course-smoke-test` deletes its scratch folder on the way
out. Rather than ask a room of non-programmers to hand-author a file (macOS
Finder has no "new text file"; teaching `>` redirection is out of scope and
`pi-learning-paths.md` Stage 0 explicitly flags it as destructive-looking),
the first delegation is a two-parter: *make me a messy file that looks like
my real input*, then *clean it up*. This produces exercise material shaped
like the participant's own toil without any confidential data leaving the
building, and it gives the room two agent runs instead of one — which is the
honest way to teach nondeterminism.

**The safety net is proved before the agent exists**, using the one
destructive act every participant already knows how to perform: deleting a
file in Finder or File Explorer. One `touch` gives the folder something to
save; the file browser gives them the fear; `revert` removes it. The
agent-driven mess (exercise 5) then re-uses a muscle they already have rather
than introducing `revert` at the moment they are most alarmed.

Everything happens in `~/course-practice` on the managed environment
(DEC-007/DEC-008: Ghostty running bash on macOS, Windows Terminal + Git Bash
on Windows) with the prescribed model (DEC-006/DEC-009). No provider or model
choice appears anywhere in the material.

### Testing

Per `docs/trunk/TESTING_PHILOSOPHY.md`:

- **Exercise dry-run** (`DRY_RUN.md`) — every runnable step executed from its
  written instructions on this machine, in a throwaway `HOME` and a throwaway
  pi config directory. The operator's `~/.pi` and `~/course-practice` are
  never touched. Agent steps run at least twice. Limits recorded honestly:
  Windows is untested, and this machine's pi is not the pinned version.
- **Floor test** (`FLOOR_TEST.md`) — protocol and observer watch-fors
  authored; the human run is an operator follow-up and does not block
  completion (the chunk GOAL says so).
- No automated suite: the deliverable is prose. `ve validate` is the gate.

## Sequence

### Step 1: Plan and checkpoint

This file, committed before any authoring, so a dropped connection costs one
step rather than the session.

### Step 2: `EXERCISES.md` — the runnable spine

Five exercises with per-exercise fallbacks (SPEC.md, Guarantees: no dead
ends), written first because the dry run executes them and everything else
refers to them.

1. **Where am I?** (12 min) — open the course terminal, `pwd`, `ls`,
   `cd ~/course-practice`, `pwd`, `ls`; then `open .` / `explorer .` to see
   the same folder in the file browser. Outcome: the participant can say
   where they are and point at it in two places.
2. **The safety net** (15 min) — `touch notes.txt`, edit it in the file
   browser, `commit`; delete it in the file browser; `revert`; watch it come
   back. Outcome: every participant has restored a file they deleted on
   purpose.
3. **First delegation** (15 min) — `pi`, one plain sentence asking for a
   messy sample file shaped like their toil entry; watch the tool calls;
   `/quit`; `commit`. Outcome: a file on disk the agent made, and a
   checkpoint of it.
4. **What did it actually do?** (12 min) — second delegation: the real task
   from their inventory entry. Then the worksheet: which tools, what changed
   on disk, what did you check, was it reasonable.
5. **Break it on purpose** (7 min) — a bounded destructive prompt, then
   `revert`. Outcome: every participant has used `revert` on a mess an agent
   made.

### Step 3: Dry-run the runnable steps

Throwaway `HOME`; `env/install.sh --skip-packages` into it (the pattern
`env/tests/test-install.sh` already uses); `PI_CODING_AGENT_DIR` pointed at a
sandbox config carrying only the OpenRouter credential and the prescribed
model. Record verbatim output for every command in `DRY_RUN.md`, with at
least two runs of each agent step.

### Step 4: Revise `EXERCISES.md` against what actually happened

The dry run is not a formality. Any place the text made the runner improvise
is a defect in the text (TESTING_PHILOSOPHY.md).

### Step 5: Handouts

- `handouts/terminal-card.md` — the GUI→terminal concept map (mined from
  `pi-learning-paths.md` Stage 0), the six commands the course uses, the pi
  keys, and the recovery moves. One printable card.
- `handouts/what-did-it-do.md` — the three-box worksheet exercise 4 fills in.
  This is the session's checkpoint evidence.

### Step 6: Extend Session 1's handouts in place

Per `curriculum/README.md` (cross-session rules) and the chunk GOAL: no forks.

- `session_01_mental_models/handouts/canned-toil.md` — a "For Session 2"
  section giving canned-set participants a file-shaped task and the two
  exact prompts.
- `session_01_mental_models/handouts/toil-inventory.md` — the usage table
  gains a Session 2 row.

### Step 7: `FACILITATOR_GUIDE.md`

Setup-triage opening; minute-level timing table for 90 minutes with a
60-minute variant and cutting rules; per-beat talking points; the failure
table (agent surprises the room, a key dies mid-session, a terminal won't
open, someone's `revert` finds no checkpoints); FAQ; the framing that an
agent doing something unexpected is a verification lesson, not a broken demo.

### Step 8: `PREWORK.md`, `PRACTICE.md`, `CHECKPOINT.md`, `README.md`

Prework ≤30 min, completable with a broken setup and no terminal knowledge.
Practice ≤90 min with a time-budget table and an "if the week gets away from
you" floor, displacing real toil rather than adding homework. Checkpoint
states the four observable behaviors from the chunk GOAL.

### Step 9: `FLOOR_TEST.md` and `DRY_RUN.md` finalized

### Step 10: Settle the indexes

`curriculum/README.md`'s session table and SPEC.md's Curriculum Structure
entry for Session 2, mirroring how Session 1 is recorded.

### Step 11: Review, `ve validate`, complete

## Dependencies

- `fluency_session_01` (ACTIVE) — the register, the toil inventory, the
  canned fallback, and the promise that `commit`/`revert` arrive here.
- `onboarding_terminal_env` (ACTIVE) — `commit`, `revert`, the managed
  terminal.
- `onboarding_setup_guide` (ACTIVE) — pi, the pins, `course-smoke-test`,
  `~/course-practice`.

## Risks and Open Questions

- **The destructive prompt in exercise 5 must not be able to destroy the
  checkpoints.** An unbounded "delete everything in this folder" could reach
  `.git` and make `revert` impossible — the exact opposite of the lesson. The
  prompt is bounded to named files; the dry run verifies `.git` survives.
- **`revert` after an uncommitted change is a four-answer walkthrough**, not
  one keystroke. The facilitator guide has to script the exact answers, which
  means the dry run has to capture them verbatim.
- **This machine runs pi 0.84.1; the cohort pin is 0.83.0** (`setup/pins.env`)
  and the course environment is not installed here. Both get recorded as
  dry-run limits rather than papered over.
- **Nondeterminism is the subject, not a nuisance.** Exercises are
  outcome-checked ("a file exists and you verified it"), never
  output-checked.
- **Windows is unverifiable here.** No Windows machine; recorded as such,
  consistent with `env/README.md`.

## Deviations
