---
status: ACTIVE
ticket: null
parent_chunk: null
code_paths:
- curriculum/README.md
- curriculum/session_02_meeting_the_harness/README.md
- curriculum/session_02_meeting_the_harness/PREWORK.md
- curriculum/session_02_meeting_the_harness/FACILITATOR_GUIDE.md
- curriculum/session_02_meeting_the_harness/EXERCISES.md
- curriculum/session_02_meeting_the_harness/EXERCISE_RUNSHEET.md
- curriculum/session_02_meeting_the_harness/PRACTICE.md
- curriculum/session_02_meeting_the_harness/CHECKPOINT.md
- curriculum/session_02_meeting_the_harness/FLOOR_TEST.md
- curriculum/session_02_meeting_the_harness/DRY_RUN.md
- curriculum/session_02_meeting_the_harness/handouts/terminal-card.md
- curriculum/session_02_meeting_the_harness/handouts/what-did-it-do.md
- curriculum/session_01_mental_models/handouts/canned-toil.md
- curriculum/session_01_mental_models/handouts/toil-inventory.md
- docs/trunk/SPEC.md
code_references:
- ref: curriculum/session_02_meeting_the_harness/README.md
  implements: The session index and the four-step teaching spine stated as
    load-bearing order, with the constraints an editor must not break — chiefly
    that the safety net precedes the first delegation and that the destructive
    prompt stays bounded to a named file
- ref: curriculum/session_02_meeting_the_harness/PREWORK.md
  implements: 'Prework in ~25 minutes that assumes no terminal knowledge and
    survives a broken setup: what a terminal is as a window onto a folder, the
    blinking-cursor reassurance, the commit/revert promise Session 1 made, the
    starred inventory entry with its two pre-written sentences, and a
    course-update then course-smoke-test result reported rather than debugged'
- ref: curriculum/session_02_meeting_the_harness/FACILITATOR_GUIDE.md
  implements: 'The re-teachable hands-on session: the eight-minute setup-triage
    opening (smoke test, aggregate tally, immediate pairing with the non-owner
    driving, a prohibition on debugging in the room), an eleven-row minute-level
    90-minute timing table with a 60-minute variant and ordered cutting rules
    naming exercise 5 as the sacrifice, per-beat talking points with SPEC
    terminology quoted verbatim, eleven anticipated failures with recovery moves,
    the FAQ, and an appendix stating what a normal run looks like'
- ref: curriculum/session_02_meeting_the_harness/EXERCISES.md
  implements: "The participant steps for the five-exercise block — where am I, the safety net (commit/revert with the four-question table), first delegation, what did it actually do (the worksheet), break it on purpose — in second person, with the synthetic-task fallback"
- ref: curriculum/session_02_meeting_the_harness/EXERCISE_RUNSHEET.md
  implements: "The facilitator's running order for the five exercises: timing, say-it-like-this, observable outputs, misfires and recoveries, the projector walkthrough of the first commit, and the exercise-5 prompt rationale"
- ref: curriculum/session_02_meeting_the_harness/PRACTICE.md
  implements: 'The displacement-shaped practice week: a 60-minute budget under the
    90-minute cap, the solo lap within 48 hours that repeats the
    commit-delegate-check-commit loop unaided, two delegations on real work the
    participant was going to do by hand anyway, a worksheet on whichever went
    worst, and an optional item that deliberately produces an unverifiable result'
- ref: curriculum/session_02_meeting_the_harness/CHECKPOINT.md
  implements: The observable checkpoint (a delegation run, the tool calls read
    rather than the prose, a named check, and revert used at least once), the
    six-minute round that collects it, the pass/near-miss discrimination guide,
    four private recovery paths keyed to cause, and the distinction between a
    failed checkpoint and a run where the model simply behaved
- ref: curriculum/session_02_meeting_the_harness/FLOOR_TEST.md
  implements: The floor-test protocol for a hands-on session — nine verbatim tasks
    against a fully provisioned machine and the real TUI, timing measured against
    every claimed budget, nine watch-fors centred on whether the safety net
    actually removes the fear, and a results log recording the human test, the
    Windows pass and the interactive TUI pass as pending
- ref: curriculum/session_02_meeting_the_harness/DRY_RUN.md
  implements: The executed record of every runnable step against the prescribed
    model, with agent steps sampled two and three times, verbatim transcripts, the
    four deviations from a true participant environment stated up front, the three
    defects the run found in the exercise text, and the four things that must
    happen before first teach
- ref: curriculum/session_02_meeting_the_harness/handouts/terminal-card.md
  implements: The one-page reference that lets participants stop memorising — the
    GUI-to-terminal concept map, the commands the course uses (including
    course-update), the two safety commands with the read-the-names-not-the-numbers
    rule, pi's keys, the four
    tools, and a when-you-feel-lost table whose every answer is safe
- ref: curriculum/session_02_meeting_the_harness/handouts/what-did-it-do.md
  implements: 'The worksheet that is the session''s checkpoint evidence: tool calls
    first, the file on disk second, and the check applied third, with "I couldn''t
    tell" offered as the most valuable answer on the page'
- ref: curriculum/session_01_mental_models/handouts/canned-toil.md
  implements: Session 1's fallback set extended in place with a "For Session 2"
    section — Priya's file-shaped task, the two ready-made prompts, her concrete
    check, and the Complete-versus-Done judgment call to watch for
- ref: curriculum/session_01_mental_models/handouts/toil-inventory.md
  implements: The cross-session sheet's usage table extended with the Session 2
    row, recording that column 2 becomes the instruction and column 4 becomes the
    check
- ref: curriculum/README.md
  implements: The session table's Session 2 row, and the cross-session rules
    extended with what a session whose steps execute owes (a DRY_RUN written by
    running the material) and with Session 2 as the worked example of extending a
    prior session's handouts rather than forking them
- ref: docs/trunk/SPEC.md
  implements: Session 2 recorded as settled in Curriculum Structure, with its
    ordering rationale and duration, and the DRAFT checkbox narrowed to Sessions
    3-8
narrative: null
investigation: null
subsystems:
- subsystem_id: session_anatomy
  relationship: implements
friction_entries: []
depends_on: ["fluency_session_01"]
created_after: ["fluency_session_01", "onboarding_setup_guide", "onboarding_terminal_env"]
---

# Chunk Goal

## Minor Goal

`curriculum/session_02_meeting_the_harness/` owns Session 2 of the fluency
arc — "Meeting the harness" — as the full session anatomy defined in
SPEC.md and the directory convention in `curriculum/README.md` (DEC-010):
`README.md`, `PREWORK.md`, `FACILITATOR_GUIDE.md`, `EXERCISES.md`,
`PRACTICE.md`, `CHECKPOINT.md`, plus `FLOOR_TEST.md` and — unlike Session
1 — a `DRY_RUN.md`, because this session's steps are executable and
therefore must be executed from their written instructions before they are
taught.

**This is the session where the course becomes hands-on.** Session 1 was
deliberately conceptual so a broken setup cost nothing; Session 2 is the
session that needs the environment to work. Its teaching spine:

1. **Terminal survival.** Enough to stop the blinking cursor being scary
   and no more: what a prompt is, where you are (`pwd`), what's here
   (`ls`), moving (`cd`), and that nothing happens until Enter. Framed as
   a concept map onto the file browser participants already know.
   `pi-learning-paths.md` Stage 0 is the operator's own worked version of
   this — including "don't be afraid of the blinking cursor" — and is the
   source of both the voice and the GUI→terminal mapping.
2. **The safety net, before anything can break.** `commit` and `revert`
   are taught here, and taught *before* the first delegation — Session 1's
   PRACTICE.md promises participants exactly this ("You'll be taught both
   properly in Session 2"). The order is load-bearing: pi has no undo
   (DEC-006), so participants must be able to checkpoint and restore
   before they let an agent touch anything.
3. **First delegations.** Running pi in the practice folder, giving it
   work, and watching it use tools. The point is not that the agent
   succeeds — it is that the participant sees an agent *act* rather than
   converse, which is the distinction Session 1 drew conceptually and this
   session makes real.
4. **Reading what the agent actually did, and judging it.** The session's
   real payload and its checkpoint. Participants read the tool calls and
   the diff, then answer the course's recurring question about their own
   task: *was this reasonable, and how do I know?* This is DEC-005's
   "every capability demo is paired with how would you check this" turned
   into the participant's own hands-on habit.

Constraints the implementing agent must honor:

- **Audience floor (DEC-004)**: no prior terminal knowledge, no code. This
  session *teaches* the terminal; it may not assume any of it, including
  in PREWORK.
- **The environment is fixed and shipped.** Participants use the managed
  terminal from `env/` (DEC-007/DEC-008: Ghostty running bash on macOS;
  Windows Terminal + Git Bash profile on Windows) with pi installed and
  pinned by `setup/` (DEC-006/DEC-009: OpenRouter, prescribed model). The
  session teaches *that* environment — never "your terminal", never a
  model or provider choice. `env/README.md` and `setup/README.md` are the
  authorities on what participants have;
  `docs/chunks/onboarding_setup_guide/pi-reference.md` is the verified pi
  reference (four default tools read/write/edit/bash, sessions, `!`/`!!`,
  Ctrl+O to collapse tool output, Escape to abort) and the source for any
  claim the material makes about pi's behavior.
- **All work happens in `~/course-practice`**, the sandbox the setup guide
  creates. Nothing in this session sends a participant outside it.
- **Setup triage is the facilitator's first job.** Some participants will
  arrive broken despite the remediation slot. The facilitator guide must
  open with a triage step (run `course-smoke-test`, who has PASS), a
  pairing plan for anyone who fails, and a rule that the session proceeds
  on time rather than stalling on one laptop.
- **The toil inventory continues.** It is Session 1's handout
  (`session_01_mental_models/handouts/toil-inventory.md`) and stays there
  (`curriculum/README.md`, cross-session rules). Participants arrive with
  8–10 entries and the check column filled in; Session 2 uses those
  entries as the source of the first delegation, and extends the sheet and
  the canned fallback by editing Session 1's handouts — never by forking a
  copy.
- **Nondeterminism is taught, not hidden.** The agent will sometimes do
  something unexpected in front of the room. TESTING_PHILOSOPHY.md
  requires exercises be outcome-checked rather than output-checked, and
  the facilitator guide must script the common failure modes and recovery
  moves — including the framing that an agent doing something surprising
  is a teaching moment about verification, not a broken demo.

## Success Criteria

- All six required files exist per `curriculum/README.md`, plus
  `FLOOR_TEST.md` and `DRY_RUN.md`; content conforms to SPEC.md's Session
  Anatomy.
- PREWORK is completable in ≤30 minutes with no terminal knowledge, and
  works for a participant whose setup is still broken (it must not require
  a working pi — that is what the in-session triage is for).
- PRACTICE fits ≤90 minutes and displaces existing toil rather than adding
  homework, in the register of Session 1's PRACTICE.md (a time-budget
  table, honest minimums, an explicit "if the week gets away from you").
- `commit` and `revert` are taught before the first delegation, and the
  exercises prove the safety net by having participants deliberately let
  the agent make a mess and then `revert` it — the fear is removed by
  demonstration, not by reassurance.
- Every exercise operates on the participant's own toil where possible,
  with a canned fallback (Session 1's `handouts/canned-toil.md` is the
  existing fallback set — reuse or extend it rather than inventing a
  parallel one).
- The checkpoint is observable and stated in `CHECKPOINT.md`: every
  participant has run at least one delegation in `~/course-practice`, can
  say what the agent did by reading its tool calls rather than its prose,
  can state what they checked to decide whether it was reasonable, and has
  used `revert` at least once.
- `DRY_RUN.md` records an actual execution of the session's runnable steps
  from their written instructions on this machine, including at least two
  runs of any agent step (TESTING_PHILOSOPHY.md: agentic steps are sampled
  more than once), with honest limits — Windows is untested and must be
  recorded as such.
- The facilitator guide is sufficient for a facilitator who did not author
  it, includes minute-level timing for a 90-minute session (matching
  Session 1), the setup-triage opening, and recovery moves for the
  anticipated failures (agent does something surprising; a participant's
  key fails mid-session; someone's terminal doesn't open).
- `curriculum/README.md`'s session table and SPEC.md's Curriculum
  Structure entry for Session 2 are updated to settled, mirroring how
  Session 1 was recorded.

## Rejected Ideas

### Teach the terminal thoroughly

Session 2 could give participants a real grounding in the shell — pipes,
redirection, globbing, editing files from the command line.

Rejected because: the course is not a programming course (GOAL.md, Out of
Scope) and terminal fluency is not the skill being taught. Participants
need exactly enough to open the course terminal, know where they are, and
run the handful of commands the course uses. Everything else is
comprehension burden that competes with the actual subject. The `!`/`!!`
escape hatches and pi's own file references mean participants rarely need
raw shell at all.

### Defer `commit`/`revert` until after the first delegation

Getting participants to a working agent faster is motivating, and the
safety net could be introduced once they've seen why they need it.

Rejected because: it inverts the dependency. pi edits files with no undo
(DEC-006), and the whole point of the managed environment is that a
participant can experiment fearlessly. Teaching the net after the fall is
the wrong order, and Session 1's practice assignment has already promised
these commands come in Session 2.

### Let participants pick their own model or provider to compare

Comparing models would be interesting and would surface that the harness
is model-agnostic.

Rejected because: the cohort runs one prescribed model on operator-issued
keys (DEC-006) so that "you should see X" is true for everyone, and
provider choice is exactly the judgment-free variation the setup guide
eliminated. Harness adaptation is Session 5's subject, and even there it
does not extend to per-participant provider sprawl.
