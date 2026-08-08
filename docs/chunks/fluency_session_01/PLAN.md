# Implementation Plan

## Approach

Session 1 is a documentation deliverable, not software: seven Markdown
files under `curriculum/session_01_mental_models/` plus a `curriculum/`
index that fixes the per-session convention every later session follows.
There is nothing to execute, so verification is human — a floor test
protocol authored alongside the material (TESTING_PHILOSOPHY.md, Floor
Testing) and a checkpoint the facilitator observes live.

Four structural choices shape everything below.

**The session is 90 minutes with a 60-minute compressed variant.** SPEC.md
fixes prework (≤30 min) and practice (≤90 min) but not the live session.
90 minutes is the shortest slot that fits the required teaching order —
cold open, mental models, judgment boundary, and a *worked* inventory
exercise — without the exercise becoming a homework hand-wave. The
compressed variant exists because the first thing a facilitator loses is
time, and an unplanned cut lands on the exercise, which is the only part
that produces the checkpoint.

**Every concept beat is followed by a beat that tests it.** DEC-005's
consequence — "capability showcases, where used, are always paired with
'how would you check this?'" — is implemented literally: the guide's demo
is scripted in two beats, and beat two reveals that the impressive output
contains a defensible-but-wrong judgment call only a domain owner could
catch. The demo is the argument for the judgment boundary, not a break
from it.

**The inventory sheet is four columns on paper.** It has to be fillable by
someone whose setup failed, in a room, with a pen, and it has to survive
until Session 6's capstone gate. Its load-bearing column is not the task —
it is *how I'd check*, because an entry whose owner cannot name a check is
the definition of an entry outside the judgment boundary. That column
converts the abstract thesis into a filled-in cell, which is what makes
the checkpoint observable rather than a vibe.

**Voice comes from `pi-learning-paths.md`, not from scratch.** Its "Why
this guide, why you" opening, its GUI-analogy tables, and its
"before → after" framing are the operator's own register for this
audience. Session 1's cold open and prework reuse its phrasing where the
content overlaps (the leverage argument, the tags.csv moment, "the agent
does the typing; you supply the judgment"), so a participant who later
reads the learning path hears one voice rather than two.

### Decisions this plan makes

**`curriculum/<NN>_<slug>/` with fixed uppercase filenames.** Sessions are
addressed by number first (`session_01_mental_models`) so directory
listing order equals teaching order, and each session carries the same six
filenames — `README.md`, `PREWORK.md`, `FACILITATOR_GUIDE.md`,
`EXERCISES.md`, `PRACTICE.md`, `CHECKPOINT.md` — one per Session Anatomy
element plus an index. Participant-facing printables go in `handouts/`.
Fixed names mean a facilitator learns the layout once, and a later chunk
can reference `curriculum/session_04_workflow_design/EXERCISES.md` before
it exists. This settles the last DRAFT item in SPEC.md's Repository
Layout, and is recorded as **DEC-010** together with the inventory format,
because both are cross-session contracts later chunks must not silently
redesign.

**The toil inventory is owned by Session 1 and versioned as a handout.**
`handouts/toil-inventory.md` is the blank sheet; its four columns (task
and frequency, what "done right" looks like, in or out of the judgment
boundary, how I'd check) are the format Sessions 2–6 extend and Session 6
gates on.
Later sessions add columns at their own cost; they may not renumber or
rename these four.

**Floor-test protocol lives in the session directory, results log inline.**
`FLOOR_TEST.md` mirrors `env/FLOOR_TEST.md`: preconditions, verbatim
tasks, what the observer records, and a results log whose human sections
start as `PENDING`. TESTING_PHILOSOPHY.md asks for per-session results
"alongside the session material"; this is that.

**Session 1 mentions `commit`/`revert` only in a facilitator FAQ answer.**
The safety net exists and a participant may ask about it; the terminal is
Session 2's to teach. The guide gives a one-sentence answer and moves on.

## Subsystem Considerations

No subsystems exist in `docs/subsystems/`. This chunk establishes a
convention (the session directory layout) that a subsystem may later
document once three or more sessions exist and the pattern is real rather
than asserted.

## Sequence

### Step 1: `curriculum/README.md`

The convention document: the directory naming rule, the six required
filenames with a one-line description each, the `handouts/` rule, where
floor-test results live, and the instruction that a session chunk creates
all six even if one is thin. Links to SPEC.md Session Anatomy as the
authority for *what* each file must contain.

### Step 2: `curriculum/session_01_mental_models/handouts/toil-inventory.md`

The blank sheet plus one worked example row and a half-page of "what makes
a good entry". Printable as-is; usable as a file. Written before the
exercises, because the exercises are instructions for filling it in and
must not drift from it. States that later sessions extend this sheet.

### Step 3: `curriculum/session_01_mental_models/handouts/canned-toil.md`

The no-dead-ends fallback (SPEC.md, Guarantees): a persona — a program
manager at a mid-size company — with eight recurring tasks, deliberately
spanning clearly-inside, clearly-outside, and genuinely-ambiguous
judgeability, with enough context that a participant can reason about
checks without knowing the persona's job. Used by anyone who can't use
real work (confidentiality, no notes, blank-page freeze).

### Step 4: `curriculum/session_01_mental_models/PREWORK.md`

≤30 minutes, three parts: read the leverage argument (~10 min, written
here in the operator's voice rather than linked, so prework is
self-contained); list five things you did more than once last week (~10
min, deliberately rough — the session refines it); report your setup
status in one line (~2 min). Explicitly tells a participant whose setup
failed to report it and stop, not to debug alone. Names what to bring.

### Step 5: `curriculum/session_01_mental_models/EXERCISES.md`

Three exercises with per-exercise fallbacks and timing:

1. **Brain dump (7 min)** — recurring tasks onto the sheet, quantity over
   quality. Fallback: canned persona.
2. **The check column (12 min)** — for each entry, write how you'd know
   the output was right. Fallback: canned persona; facilitator prompt
   sequence for participants who write "I'd just know".
3. **The skeptic pass (8 min, pairs)** — partner asks "how would you know
   if it was wrong?" until the answer is concrete or the participant
   concedes they couldn't tell. Concession is the *success* case and the
   text says so. Fallback: facilitator plays the skeptic for a solo
   participant or a remote odd-one-out.

Each exercise states its observable output so the facilitator can see
completion from the room, and each names the misfire it produces most
often.

### Step 6: `curriculum/session_01_mental_models/FACILITATOR_GUIDE.md`

The largest artifact; written in two passes to keep each write small.

*Pass A — running the room:* who this session is for and the one thing it
must achieve; the 90-minute timing table with the 60-minute cut marked;
setup-status collection at the door (who reached PASS, who didn't, the
remediation route to before Session 2) with a tally table; the cold open
talking points, including the three sentences that must be said and the
two framings to avoid (threat framing, "AI will do your job" framing);
mental models (agent vs chatbot) and judgment vs expertise, using SPEC.md
Terminology verbatim and flagged as such so later sessions inherit it.

*Pass B — demo, failure, recovery:* the two-beat demo script with the exact
input file, the prompt, what the agent will plausibly do, and the planted
judgment call; the "how would you check this?" solicitation and the
reveal; the outside-your-boundary thought experiment; then the anticipated
failure points table (demo fails to run, demo produces a *correct* answer
and the reveal evaporates, a participant argues the thesis, a participant
has no recurring toil, the room is silent, remote-only logistics, a
technical participant races ahead) each with a recovery move; the FAQ
including the `commit`/`revert` answer and "why aren't we using the tool
today"; a pre-recorded transcript appendix for a demo that can't run live.

### Step 7: `curriculum/session_01_mental_models/PRACTICE.md`

≤90 minutes across a week, observation-shaped: a 5-minute end-of-day pass
(×4 = 20 min), one 20-minute weekend consolidation, and a 15-minute
"check test" on two `not sure` entries — observe what you actually looked
at to know the work was right, and write that down. Budget table sums to
55 minutes with the remainder reserved for setup remediation if needed.
Optional depth (DEC-004's pressure valve): write one entry's check column
as a brief for a new hire. Target state named explicitly: 8–10 entries by
Session 2.

### Step 8: `curriculum/session_01_mental_models/CHECKPOINT.md`

The observable behavior, verbatim from the chunk GOAL: ≥3 entries each
annotated with judgeability, and one articulated boundary claim per
participant. Adds the facilitator's discrimination guide — what a pass
sounds like, what a near-miss sounds like ("it's inside because I do it
every week" — frequency is not judgeability), the recovery move when a
participant can't produce one, how to run the round in 8 minutes for
twelve people, and what a failed checkpoint obligates in Session 2
(TESTING_PHILOSOPHY.md: checkpoints failing mid-cohort adjust later
sessions).

### Step 9: `curriculum/session_01_mental_models/FLOOR_TEST.md`

Protocol and results log per Step-1 convention and `env/FLOOR_TEST.md`'s
shape. Verbatim tasks: complete the prework cold and timed; fill the sheet
from the exercise text alone with no facilitator; be the skeptic's target;
state a boundary claim. Watch-fors specific to this session: does the
tester confuse "I can't do it" with "I can't check it" (the single most
likely comprehension failure); does the cold open read as flattery or as
argument; does anyone write frequency in the judgeability column.

### Step 10: `curriculum/session_01_mental_models/README.md`

The session index: outcome, the five anatomy artifacts with links, what
the facilitator reads first, and a one-paragraph statement of the teaching
spine so a future author can tell whether a proposed edit belongs.

### Step 11: Trunk updates

- `docs/trunk/DECISIONS.md`: DEC-010 (session directory convention + toil
  inventory format as cross-session contracts).
- `docs/trunk/SPEC.md`: Repository Layout `curriculum/` entry rewritten to
  the actual convention and its DRAFT caveat removed; the DRAFT Sections
  checklist item for Repository Layout closed; Session 1's entry in
  Curriculum Structure confirmed or corrected against what was built.

### Step 12: Verify and complete

`uvx --from vibe-engineer ve validate` (or the installed `ve validate`)
must pass. Prework and practice time budgets are re-added by hand from the
final text. Cross-file consistency check: every filename the convention
promises exists; the inventory columns are described identically in the
handout, the exercises, the practice assignment, and the checkpoint.

## Dependencies

- `docs/chunks/onboarding_setup_guide` (ACTIVE) — the setup guide and
  `course-smoke-test` PASS that Session 1 collects status against.
- `docs/chunks/onboarding_terminal_env` (ACTIVE) — the source of the
  `commit`/`revert` safety net Session 1 mentions but does not teach.

Nothing here blocks on Session 2, which consumes this chunk's convention
and inventory format rather than the reverse.

## Risks and Open Questions

- **Human verification is out of reach in this chunk.** The floor test and
  the first live teach are the real tests, and both need people. The
  artifacts are written to make those cheap (protocol, watch-fors, results
  log), and the pending items are recorded as operator follow-ups rather
  than blocking completion.
- **Demo dependency on a live agent.** The demo needs a working pi install
  on the *facilitator's* machine, which the guide states as a
  precondition, plus the pre-recorded transcript fallback. A demo that
  happens to produce a correct answer on the ambiguous row would defuse
  the reveal; the guide scripts that case explicitly and gives the
  facilitator a second ambiguous row to fall back on.
- **90 minutes may be wrong.** It is a first estimate; the floor test and
  pilot will move it. The timing table is per-beat so a revision is an
  edit to a few cells rather than a rewrite.
- **Inventory format stability.** Sessions 2–6 do not exist yet, so the
  four columns are a bet. DEC-010 records the bet and its revisit
  condition rather than pretending it was validated.

## Deviations

- **Step 6 (facilitator guide), added during review:** the guide's "Before
  the room" section did not tell a facilitator to *send* the prework (only
  to tally the replies), and did not say how a facilitator without a pi
  install gets one for the demo. Both are load-bearing for the
  re-teachability criterion — a guide that assumes the reader already has
  the things the author had is exactly the failure that criterion names.
  Added: send a week ahead, chase non-repliers two days out because a
  non-reply usually means a failed setup, and follow `setup/README.md` end
  to end a week out if you don't have pi.
- **Step 6, timing:** the 60-minute variant's column summed to 59. The
  spare minute went to the cold open (9 rather than 8), on the rule that
  the recruitment beat is the last thing to compress.
- **Step 3 (canned toil):** the persona's task list is eight entries rather
  than a round number chosen for balance, and the handout deliberately
  refuses to publish an answer key — three tasks are clearly inside
  Priya's boundary, two clearly outside, and the rest genuinely
  underdetermined by the sheet. Noticing that the sheet doesn't say enough
  is scored as a correct answer. This is a slightly stronger position than
  the plan's "deliberately spanning" wording implied, and it exists so the
  fallback path produces the same argument-having that the real-work path
  does.
- **No `DRY_RUN.md`:** Session 1 has no participant-executable steps, so
  per the Step-1 convention the file is omitted. The one executable thing
  in the session — the facilitator's demo — is covered by the facilitator
  dry-run section of `FLOOR_TEST.md` instead, which keeps the model-
  nondeterminism requirement (three runs, stated failure condition) in the
  same place as the rest of the session's verification.
