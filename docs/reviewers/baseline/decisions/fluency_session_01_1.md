---
decision: APPROVE
summary: "All eight success criteria satisfied in the material; the three criteria that assert things about humans (prework timing, floor test, re-teachability) are implemented as far as authoring can take them and left as named operator follow-ups."
operator_review: null  # DO NOT SET - reserved for operator curation good | bad | feedback: "<message>"
---

## Criteria Assessment

### Criterion 1: All five session-anatomy artifacts exist per SPEC.md (Session Anatomy):

- **Status**: satisfied
- **Evidence**: `curriculum/session_01_mental_models/` contains
  `FACILITATOR_GUIDE.md` (Before the room; a 13-row timing table summing to
  90 with a 60-minute column summing to 60; verbatim talking points per
  beat; a two-beat demo script with the exact `headcount.csv` contents and
  prompt; an eleven-row anticipated-failure/recovery table; an FAQ; a
  read-aloud transcript appendix), `PREWORK.md`, `EXERCISES.md`,
  `PRACTICE.md`, `CHECKPOINT.md`. Fallbacks are present per exercise, and
  `handouts/canned-toil.md` is the shared canned path (SPEC.md, Guarantees:
  no dead ends).

### Criterion 2: Prework is completable in ≤30 minutes by the audience floor; practice

- **Status**: satisfied (authored bar; unverified against a human)
- **Evidence**: `PREWORK.md` budgets 10 + 10 + 2 = 22 minutes against a
  stated "about 25", and requires no software, no terminal, and no working
  setup — a participant whose setup failed completes it and is explicitly
  told to stop rather than debug. `PRACTICE.md` budgets 55 minutes
  (4 × 5-minute daily passes, one 15-minute check test, one 20-minute
  consolidation) against a 90-minute cap, and is observation-shaped: it
  asks participants to notice what they already do, not to produce
  anything new. Timing claims are assertions until the floor test measures
  them, which is exactly what `FLOOR_TEST.md` task 1 and its "time per
  task" record item exist to do.

### Criterion 3: The session opens with the "why the moment matters" argument and teaches

- **Status**: satisfied
- **Evidence**: `FACILITATOR_GUIDE.md` beat 1 (0:05, 11 min) is the
  leverage argument in three ordered statements, before any definition;
  beat 2 (0:16) introduces agent-vs-chatbot. Definitions are quoted from
  SPEC.md Terminology rather than paraphrased — agent ("an LLM running in
  a harness with the ability to take actions … not just converse"),
  judgment ("discern a reasonable result from an unreasonable one in a
  given domain — to *evaluate* work without necessarily being able to
  produce it"), expertise plus "Delegation can substitute for expertise;
  nothing substitutes for judgment", and judgment boundary (second person,
  otherwise verbatim). The guide flags the quoting as deliberate so later
  sessions inherit the vocabulary. `README.md` records the order as
  load-bearing, and the guide names the two framings that break the cold
  open (threat, hype).

### Criterion 4: The checkpoint is observable per SPEC.md: every participant leaves with

- **Status**: satisfied
- **Evidence**: `CHECKPOINT.md` states both halves of the bar (≥3 entries
  annotated with judgeability; a spoken boundary claim naming the check),
  gives the 7-minute round mechanics and a per-participant recording
  table, and supplies the discrimination guide a facilitator actually
  needs: what a pass sounds like, a five-row near-miss table with the
  correction to say aloud (including "it's in because I do it every week"
  → frequency is not judgeability, and the expertise/judgment confusion
  flagged as the most common), a private recovery path for a participant
  who can't produce one, and the obligation on Session 2 if the checkpoint
  fails across the room.

### Criterion 5: The toil inventory format is defined here and referenced by later

- **Status**: satisfied
- **Evidence**: `handouts/toil-inventory.md` defines four columns — task
  and frequency, what "done right" looks like, in/out/not-sure, and how
  I'd check — with two filled-in rows, one deliberately **out**. It states
  its own lifecycle through Session 6 and that later sessions may add
  columns but may not rename or renumber these four. The contract is
  recorded as DEC-010 and restated in `curriculum/README.md` (artifacts
  that outlive their session stay in the introducing session's
  `handouts/`) and in the session README's downstream table. The four
  columns are described consistently in the handout, `EXERCISES.md`,
  `PRACTICE.md`, and `CHECKPOINT.md`.

### Criterion 6: The facilitator guide is sufficient for a facilitator who did not author

- **Status**: satisfied (as far as authoring can establish; first teach is the real test)
- **Evidence**: The guide assumes no authorship knowledge: it names what
  to read first and in what order, when to send the prework and to chase
  non-repliers, how to get a working pi install if they lack one
  (`setup/README.md` end to end, a week out), what to print, the setup
  tally table and the aggregate-not-individual script for the door, the
  exact demo file and prompt, what the agent will plausibly do, a named
  backup ambiguous row for when the reveal doesn't fire, cutting rules in
  priority order with two beats marked never-cut, and a transcript to read
  aloud when the demo can't run. Two gaps were found during this review
  and fixed rather than deferred: the guide did not say to send the
  prework, and did not tell a facilitator without pi how to get one.

### Criterion 7: SPEC.md's DRAFT Repository Layout section is updated to reflect the

- **Status**: satisfied
- **Evidence**: SPEC.md's Repository Layout `curriculum/` entry now states
  the `session_<NN>_<slug>/` rule, the six fixed filenames, the optional
  `handouts/`, `FLOOR_TEST.md`, and `DRY_RUN.md`, and the
  outlives-its-session rule; the trailing "layout is draft" paragraph is
  replaced with a settled statement citing DEC-008/009/010; the DRAFT
  Sections checklist item for Repository Layout is checked. The Session 1
  entry in Curriculum Structure was **corrected**, not merely confirmed —
  it did not mention that the session opens with the leverage argument
  before definitions, which is the ordering the chunk GOAL treats as
  load-bearing. It now names that order, the conceptual-only constraint
  and why (a failed setup costs the participant nothing), and the
  90-minute length.

### Criterion 8: A floor test per TESTING_PHILOSOPHY.md (Floor Testing) is planned before

- **Status**: satisfied
- **Evidence**: `FLOOR_TEST.md` follows `env/FLOOR_TEST.md`'s shape:
  preconditions (a tester who has not seen the material and does not know
  the thesis — "someone who already agrees tests nothing"), seven verbatim
  tasks covering prework through checkpoint, what the observer records
  including time-per-task against each claimed budget, and the
  defect/observation distinction with defects blocking cohort use. Seven
  session-specific watch-fors are listed, led by the "I can't do it" vs
  "I can't check it" confusion. A separate facilitator dry-run section
  requires the demo be run at least three times on the pinned model per
  TESTING_PHILOSOPHY.md's nondeterminism rule, with a stated failure
  condition (fewer than two of three runs producing the expected wrong
  answer means the demo file needs a more reliably ambiguous row). All
  three results sections are `PENDING` with the reason stated.

## Notes on constraints (not numbered criteria, but binding per GOAL.md)

- **No harness hands-on**: satisfied. The only agent in the room is on the
  facilitator's screen; `commit`/`revert` appear once, in an FAQ answer,
  with an explicit instruction not to teach them.
- **Capability demos paired with evaluation** (DEC-005): satisfied and
  structural — the demo is scripted as two beats where beat 2 is "how
  would you check this?" followed by a reveal that the impressive output
  is wrong in the one place only the room could catch. The guide states
  that beat 1 may be cut but never run alone.
- **Own work with canned fallback**: satisfied. `handouts/canned-toil.md`
  is written to take the same time and produce the same artifact, and is
  framed as a full-quality path rather than a consolation prize.
- **Audience floor (DEC-004)**: satisfied. No programming, terminal, or
  harness knowledge appears in any participant-facing file. The
  optional-depth pressure valve is in `PRACTICE.md`.
- **Voice from `pi-learning-paths.md`**: satisfied. The prework's "Why this
  course, why you" and the cold open reuse its argument and register; the
  demo is its tags.csv moment rebuilt so the ambiguous row is wrong for a
  reason only the room knows.

## Pending human verification (operator follow-ups, not blockers)

1. Human floor test at the audience floor — `FLOOR_TEST.md`, Results log.
2. Facilitator demo dry-run, ≥3 runs on the pinned model.
3. First-teach record: actual timings and checkpoint results.

These are the three criteria that assert something about people rather
than about the material. Nothing in the repository can close them, and
`FLOOR_TEST.md` is written so that closing them is a scheduling problem
rather than a design problem.
