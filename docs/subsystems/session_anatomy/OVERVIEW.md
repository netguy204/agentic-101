---
status: DOCUMENTED
code_references:
- ref: curriculum/README.md
  implements: 'The canonical statement of the convention: session_<NN>_<slug>/ naming,
    the seven fixed filenames with the exercises element split by reader, optional
    handouts//FLOOR_TEST.md/DRY_RUN.md, and the cross-session rules (handout ownership,
    runsheet-never-restates, course-update opening, participant text assumes only
    what has been taught)'
  compliance: COMPLIANT
- ref: docs/trunk/SPEC.md
  implements: The authority on what each artifact must contain (Session Anatomy) and
    the fixed filename list (Repository Layout)
  compliance: COMPLIANT
- ref: curriculum/session_01_mental_models/README.md
  implements: "Session 1 as the pattern's first instance: conceptual-only, no DRY_RUN.md\
    \ (nothing executable \u2014 the omission is the rule, not a deviation)"
  compliance: COMPLIANT
- ref: curriculum/session_02_meeting_the_harness/README.md
  implements: 'Session 2 as the first executable instance: full file set including
    DRY_RUN.md written by running the material'
  compliance: COMPLIANT
- ref: curriculum/session_03_anatomy_of_a_delegation/README.md
  implements: Session 3, authored to the settled convention from the start (both exercise
    files, dry run before completion)
  compliance: COMPLIANT
- ref: curriculum/session_01_mental_models/handouts/toil-inventory.md
  implements: 'The archetypal cross-session handout: owned by its introducing session,
    a usage table through Session 6, an extend-don''t-rename contract'
  compliance: COMPLIANT
- ref: curriculum/session_01_mental_models/handouts/canned-toil.md
  implements: The shared fallback, extended in place with a per-session section (For
    Session 2, For Session 3) rather than forked
  compliance: COMPLIANT
- ref: curriculum/session_03_anatomy_of_a_delegation/handouts/delegation-brief.md
  implements: The second cross-session artifact, following the inventory's ownership
    and usage-table shape
  compliance: COMPLIANT
chunks:
- chunk_id: fluency_session_01
  relationship: implements
- chunk_id: fluency_session_02
  relationship: implements
- chunk_id: fluency_session_03
  relationship: implements
- chunk_id: fluency_exercise_split
  relationship: implements
- chunk_id: fluency_safety_relevance
  relationship: uses
- chunk_id: onboarding_course_update
  relationship: uses
- chunk_id: platform_solo_labs
  relationship: uses
created_after: []
---
<!--
DO NOT DELETE THIS COMMENT until the subsystem reaches STABLE status.
This documents the frontmatter schema and guides subsystem discovery.

STATUS VALUES:
- DISCOVERING: Initial exploration phase; boundaries and invariants being identified
- DOCUMENTED: Core patterns captured; deviations tracked but not actively prioritized
- REFACTORING: Active consolidation work in progress; agents should improve compliance
- STABLE: Subsystem well-understood; changes should be rare and deliberate
- DEPRECATED: Subsystem being phased out; see notes for migration guidance

AGENT BEHAVIOR BY STATUS:
- DOCUMENTED: When working on code that touches this subsystem, document any new
  deviations you discover in the Known Deviations section below. Do NOT prioritize
  fixing deviations as part of unrelated work.
- REFACTORING: When working on code that touches this subsystem, attempt to leave
  the subsystem better than you found it. If your work touches code that deviates
  from the subsystem's patterns, improve that code as part of your work (where relevant
  to your scope). This is "opportunistic improvement"—not a mandate to fix
  everything, but to improve what you touch.

STATUS TRANSITIONS:
- DISCOVERING -> DOCUMENTED: When Intent, Scope, and Invariants sections are populated
  and the operator confirms they capture the essential pattern
- DOCUMENTED -> REFACTORING: When the operator decides to prioritize consolidation work
- REFACTORING -> STABLE: When all known deviations have been resolved
- REFACTORING -> DOCUMENTED: When consolidation is paused (deviations remain but are
  no longer being actively prioritized)
- Any -> DEPRECATED: When the subsystem is being replaced or removed

CODE_REFERENCES:
- Symbolic references to code related to this subsystem
- Format: {file_path}#{symbol_path} where symbol_path uses :: as nesting separator
- Each reference includes a compliance level:
  - COMPLIANT: Fully follows the subsystem's patterns (canonical implementation)
  - PARTIAL: Partially follows but has some deviations
  - NON_COMPLIANT: Does not follow the patterns (deviation to be addressed)
- Example:
  code_references:
    - ref: src/validation.py#validate_frontmatter
      implements: "Core validation logic"
      compliance: COMPLIANT
    - ref: src/validation.py#ValidationError
      implements: "Error type for validation failures"
      compliance: COMPLIANT
    - ref: src/legacy/old_validator.py#validate
      implements: "Legacy validation (uses string matching instead of regex)"
      compliance: NON_COMPLIANT
    - ref: src/api/handler.py#process_input
      implements: "Input processing with inline validation"
      compliance: PARTIAL
-->


# session_anatomy

## Intent

Every course session is the same seven-file shape, so that a facilitator
learns the layout once, a chunk can reference a session's file before that
session exists, and the material stays teachable by someone who didn't
write it. The pattern exists because the curriculum's deliverable is not
code but a re-teachable course (docs/trunk/GOAL.md success criterion):
without a fixed anatomy, each session would be authored ad hoc, forward
references would be guesses, and the discipline that keeps the material
honest — dry runs from the written text, floor tests before first teach,
checkpoints the next session is planned from — would have nowhere to
attach.

## Scope

### In Scope

- **The per-session directory convention**: `session_<NN>_<slug>/` with the
  seven fixed files (`README.md`, `PREWORK.md`, `FACILITATOR_GUIDE.md`,
  `EXERCISES.md`, `EXERCISE_RUNSHEET.md`, `PRACTICE.md`, `CHECKPOINT.md`),
  optional `handouts/`, `FLOOR_TEST.md`, `DRY_RUN.md` (DEC-010 as amended
  by DEC-011).
- **The audience split**: `EXERCISES.md` participant-only in second person;
  `EXERCISE_RUNSHEET.md` facilitator-only, referring to steps by number and
  never restating them, so commands and on-screen text have one source.
- **Cross-session handout ownership**: artifacts that outlive their session
  (toil inventory, canned-toil, delegation brief) live in the introducing
  session's `handouts/`, carry a usage table, are extended in place with
  per-session sections, and never fork or rename their load-bearing parts.
- **The testing discipline**: a session whose steps execute owes a
  `DRY_RUN.md` written by actually running the material (agent steps at
  least twice, deviations and text corrections recorded, honest limits
  stated) and a `FLOOR_TEST.md` protocol with PENDING results before first
  teach (TESTING_PHILOSOPHY.md).
- **The session-to-session chain**: each CHECKPOINT.md defines an
  observable bar and a tally table the next session is planned from; each
  PRACTICE.md is displacement-shaped (≤90 min, "bring to Session N+1", "if
  the week gets away from you"); each session opens with `course-update`
  from Session 2 on (DEC-012).
- **The register**: audience floor (DEC-004 — no programming or terminal
  vocabulary beyond what is taught), SPEC.md Terminology quoted verbatim so
  sessions share words, capability demos paired with "how would you check
  this" (DEC-005).

### Out of Scope

- **`env/` and `setup/` tooling** — `commit`/`revert`/`course-check`/
  `course-update`, the installers and pins. The sessions consume these; the
  `onboarding_*` chunks own them (DEC-008/009/012).
- **The content of any particular session** — what Session 3 teaches is
  `fluency_session_03`'s intent; this subsystem owns only the shape it
  teaches it in.
- **Trunk documentation structure** (SPEC/DECISIONS/TESTING_PHILOSOPHY
  themselves) — they are authorities this pattern cites, not instances of
  it.

## Invariants

### Hard Invariants

- **Fixed names, so references can precede existence.** A file's name and
  place never vary by session; `curriculum/session_04_workflow_design/EXERCISES.md`
  is a correct reference today. Renaming or renumbering a fixed file, a
  handout's load-bearing columns/boxes, or a session directory breaks
  cross-session contracts recorded in DEC-010/011.
- **The runsheet never restates a step.** Every command, prompt, and
  expected output lives once, in `EXERCISES.md`; the 2026-08-07 and
  2026-08-22 findings both came from the same fact stated in two voices
  drifting apart.
- **Cross-session artifacts are edited in place, never forked.** One owner,
  one location, one usage table per artifact.
- **An executable session is dry-run from its written text before it is
  taught, and the record states what it does not establish.** If the runner
  improvises, the text is wrong and gets fixed — the dry run is the test
  suite for prose.
- **Participant-facing text assumes only what has been taught** (DEC-004).
  An exercise needing an untaught skill is a curriculum bug.

### Soft Conventions

- **Checkpoint rounds are short spoken frames** ("three sentences each, no
  discussion") with a pass/near-miss table and a private recovery section —
  keeps the bar observable without turning the round into conversation.
- **Facilitator guides carry a timing table with a 60-minute variant and
  ordered cutting rules** naming what is never cut; the designated
  sacrifice is stated so a late room degrades predictably.
- **Handouts use lowercase-hyphenated filenames**; repository-voice
  documents use the fixed uppercase names.
- **"The agent doing something surprising is the best thing that can
  happen"** — nondeterminism is scripted as a teaching moment in every
  facilitator guide, not hidden.

## Implementation Locations

`curriculum/README.md` states the convention and is the file to update
when the pattern itself changes (with DECISIONS.md recording why — the
pattern's changes so far are DEC-010, DEC-011, DEC-012). SPEC.md's Session
Anatomy section is the authority on artifact content. The three session
directories are the instances; Session 2 is the richest exemplar (first
executable session, first DRY_RUN.md), Session 3 the first authored to the
settled convention end to end. The three cross-session handouts show the
ownership pattern at one, two and three consuming sessions respectively.

## Known Deviations

None currently. All three sessions were brought to the amended convention
by `fluency_exercise_split` (2026-08-22); Session 1's missing `DRY_RUN.md`
is the rule for non-executable sessions, not a deviation. Sessions 4–6 do
not exist yet — the likeliest future deviation is a new session authored
against a stale memory of the six-file convention, which `ve validate`
will not catch; check `curriculum/README.md` first.

## Chunk Relationships

### Implements

- **fluency_session_01** — established the convention (DEC-010) and the
  first instance, plus the two original cross-session handouts.
- **fluency_session_02** — the first executable instance: DRY_RUN
  discipline, checkpoint tally feeding the next session, extending
  handouts in place.
- **fluency_session_03** — the first session authored to the settled
  convention throughout; added the third cross-session handout.
- **fluency_exercise_split** — the audience split (DEC-011): seven files,
  runsheet-never-restates.

### Uses

- **fluency_safety_relevance** — revised Session 2 content within the
  pattern without changing the pattern.
- **onboarding_course_update** — inserted the `course-update` opening into
  the anatomy (the cross-session rule in `curriculum/README.md`, DEC-012);
  the command itself is out of scope.
- **platform_solo_labs** — makes the participant lab text followable alone
  within the pattern's audience-purity invariants; the pattern itself is
  unchanged.


## Consolidation Chunks

No consolidation needed — no NON_COMPLIANT references.
