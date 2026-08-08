---
decision: APPROVE
summary: "All nine success criteria are satisfied; the dry run is a genuine execution that found and fixed three defects in the exercise text, and the remaining gaps (Windows, TUI keys, the human floor test) are recorded as pending rather than claimed."
operator_review: null  # DO NOT SET - reserved for operator curation good | bad | feedback: "<message>"
---

## Criteria Assessment

### Criterion 1: All six required files exist per `curriculum/README.md`, plus `FLOOR_TEST.md` and `DRY_RUN.md`; content conforms to SPEC.md's Session Anatomy

- **Status**: satisfied
- **Evidence**: `curriculum/session_02_meeting_the_harness/` contains
  `README.md`, `PREWORK.md`, `FACILITATOR_GUIDE.md`, `EXERCISES.md`,
  `PRACTICE.md`, `CHECKPOINT.md`, `FLOOR_TEST.md`, `DRY_RUN.md`, plus
  `handouts/terminal-card.md` and `handouts/what-did-it-do.md`. Against
  SPEC.md's Session Anatomy: the facilitator guide carries timing, talking
  points, two live-demo scripts (the projector `commit` walkthrough and the
  board-worked exercise-3 prompt), an eleven-row failure table and recovery
  moves; prework is ≤30 min; exercises operate on the participant's own toil
  with a per-exercise fallback; practice is ≤90 min; the checkpoint is an
  observable behavior. `ve validate` passes and all 0 internal links are
  broken (checked programmatically across `curriculum/`).

### Criterion 2: PREWORK is completable in ≤30 minutes with no terminal knowledge, and works for a participant whose setup is still broken

- **Status**: satisfied
- **Evidence**: `PREWORK.md` claims 25 minutes across three parts (10 read,
  10 pick an inventory entry, 5 run one command). It teaches rather than
  assumes: the GUI→terminal mapping is presented as a three-row table to
  *read*, and part 3 spells out how to open the course terminal on each
  platform rather than assuming it. It does not require a working pi — part
  3 asks for the smoke-test *result*, PASS or FAIL, and the boxed instruction
  is explicitly "stop there, do not try to fix it", with the promise that a
  failed setup still means doing every exercise (paired). One judgment call
  worth an operator eye: part 3 does require *opening* the terminal, which
  `setup/README.md` Step 2 already taught and which this page re-teaches
  inline. Anyone who cannot get that far reports it, which is the intended
  signal.

### Criterion 3: PRACTICE fits ≤90 minutes and displaces existing toil rather than adding homework, in Session 1's register

- **Status**: satisfied
- **Evidence**: `PRACTICE.md` opens with "About 60 minutes… Cap it at 90",
  carries a four-row time-budget table summing to 60 with the slack named,
  and closes with "If the week gets away from you" reducing the assignment to
  the 20-minute solo lap. Displacement is structural rather than asserted:
  part 2 is two delegations on tasks "when the task next comes round in your
  actual week… do it this way instead of the way you normally would". It also
  matches Session 1's habit of making the uncomfortable answer legitimate —
  "if the task turns out to be a bad fit, that is a result, not a failure" —
  and carries an optional-depth item (DEC-004's pressure valve) that
  deliberately produces a failure the participant learns from.

### Criterion 4: `commit` and `revert` are taught before the first delegation, and the exercises prove the safety net by having participants deliberately let the agent make a mess and then `revert` it

- **Status**: satisfied
- **Evidence**: Exercise ordering in `EXERCISES.md` is 1 terminal, **2 the
  safety net**, 3 first delegation, 4 read and judge, 5 break it on purpose.
  Exercise 2 opens "Nobody runs an agent until this exercise is finished by
  everyone in the room", and proves the net by hand — the participant deletes
  `notes.txt` themselves and restores it — before an agent exists. Exercise 5
  then does it with the agent: a bounded destructive prompt, `ls` showing the
  damage, `revert`, `ls` showing recovery. Both were executed in `DRY_RUN.md`
  and both worked. The "prove by demonstration, not reassurance" requirement
  is met twice, and the facilitator guide names exercise 5 as the designated
  sacrifice if time runs out — correctly, since exercise 2 already satisfies
  the criterion on its own.

### Criterion 5: Every exercise operates on the participant's own toil where possible, with a canned fallback (Session 1's `handouts/canned-toil.md` reused or extended, not forked)

- **Status**: satisfied
- **Evidence**: Exercises 3 and 4 are built from the participant's starred
  inventory entry — column 1 becomes the material description, column 2
  becomes the instruction, column 4 becomes the check. Exercises 1, 2 and 5
  are mechanics with no toil content to attach. Every exercise has a named
  fallback, and the canned path extends Session 1's handout **in place**:
  `session_01_mental_models/handouts/canned-toil.md` gains a "For Session 2"
  section with Priya's two ready-made prompts and her concrete check. No
  parallel copy was created. `handouts/toil-inventory.md` likewise gains one
  row in its usage table rather than a new column, respecting DEC-010's
  four-column contract.

### Criterion 6: The checkpoint is observable and stated in `CHECKPOINT.md`

- **Status**: satisfied
- **Evidence**: `CHECKPOINT.md`'s bar is the four required behaviors verbatim
  — ran at least one delegation in `~/course-practice`; said what the agent
  did by reading tool calls rather than prose; named what they checked; used
  `revert` at least once — with "All four" stated explicitly. It is
  observable: a six-minute round with a fixed four-sentence frame, a
  recording table, two worked examples of a pass, a six-row near-miss table
  with the correcting question for each, and four private recovery moves
  keyed to cause. It also distinguishes a failed checkpoint from a run where
  the model simply behaved, which is the honest reading of a nondeterministic
  exercise.

### Criterion 7: `DRY_RUN.md` records an actual execution on this machine, including at least two runs of any agent step, with honest limits

- **Status**: satisfied
- **Evidence**: `DRY_RUN.md` records a real execution on 2026-08-07 against
  the prescribed model (`anthropic/claude-sonnet-5` via OpenRouter) in a
  throwaway `HOME`, with verbatim transcripts of `course-smoke-test`,
  `commit` and `revert`. Agent steps ran twice end to end and exercise 5 ran
  a third time. It earned its place: it found three defects the text had
  wrong (the practice folder is not empty — `install-pi.sh` leaves a
  `README.txt`; the first `commit` reports two files not one; `revert` asks
  four questions and the wanted checkpoint is number 2, not 1) and one
  worksheet change (exercise 4 calls `write` only, never `read`), all of
  which were fixed in the material. Limits are stated plainly rather than
  implied: four numbered deviations from a true participant environment
  (unpinned pi 0.84.1, fake HOME, print mode instead of the TUI, two GUI
  steps performed from the shell), a summary table marking each step
  verified / substituted / not run, and four named pre-teach requirements.
  Windows is recorded as not run, consistent with `env/README.md`.

### Criterion 8: The facilitator guide is sufficient for a non-author, with minute-level timing for 90 minutes, the setup-triage opening, and recovery moves for the anticipated failures

- **Status**: satisfied
- **Evidence**: `FACILITATOR_GUIDE.md` opens with "The first eight minutes:
  setup triage" — run `course-smoke-test`, count PASS aloud in aggregate,
  pair every non-PASS immediately with the driver rule, start on time, and a
  boxed prohibition on debugging a laptop in the room, plus a tally table
  routing repeat failures to `docs/trunk/FRICTION.md`. Timing is an
  eleven-row minute-level table summing to 90 with a 60-minute variant
  column and ordered cutting rules that name exercise 5 as the sacrifice and
  protect exercises 2 and 4 and the checkpoint round. All three named
  failures have recovery moves (lines 411–413): the agent surprising the room
  (framed as the best possible outcome, with the reason), a key failing
  mid-session, and a terminal that won't open. Eight further failure modes
  are covered, along with a seven-question FAQ and an appendix stating what a
  normal run looks like, drawn from the dry run.

### Criterion 9: `curriculum/README.md`'s session table and SPEC.md's Curriculum Structure entry for Session 2 are updated to settled, mirroring Session 1

- **Status**: satisfied
- **Evidence**: `curriculum/README.md`'s session table gains the Session 2
  row; its `DRY_RUN.md` bullet and cross-session handout rule are extended to
  reflect what Session 2 actually did. `docs/trunk/SPEC.md`'s Curriculum
  Structure entry 2 is rewritten in the same "(settled — path)" form as entry
  1, with the ordering rationale and the 90-minute duration, and the DRAFT
  checkbox now reads "Sessions 1 and 2 are settled… Sessions 3–8 remain
  draft".

## Notes for the operator

Not blocking, but worth knowing:

- **The dry run ran on pi 0.84.1 against a 0.83.0 pin.** Downgrading the
  operator's own global pi was not an acceptable side effect of a dry run.
  Re-running on the pinned version (or re-pinning to a tested version) is
  listed first in `DRY_RUN.md`'s pre-teach list and belongs on
  `setup/PRE_COHORT_CHECKLIST.md`.
- **Three things remain genuinely unverified** and are logged as PENDING in
  `FLOOR_TEST.md` rather than glossed: the human floor test, a Windows pass,
  and one pass through the real interactive TUI. The human floor test was
  named in the chunk GOAL as non-blocking.
- **`env/bin/revert`'s list ordering is a latent usability defect**, not a
  documentation one. After it saves a participant's uncommitted change, the
  checkpoint they want is number 2 and the obvious instinct is `1`. The
  material now warns about it in three places, but if the floor test shows a
  tester still typing `1`, the right fix is in the command rather than in the
  prose. `FLOOR_TEST.md` watch-for 3 says so.
