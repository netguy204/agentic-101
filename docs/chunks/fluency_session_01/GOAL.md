---
status: ACTIVE
ticket: null
parent_chunk: null
code_paths:
- curriculum/README.md
- curriculum/session_01_mental_models/README.md
- curriculum/session_01_mental_models/PREWORK.md
- curriculum/session_01_mental_models/FACILITATOR_GUIDE.md
- curriculum/session_01_mental_models/EXERCISES.md
- curriculum/session_01_mental_models/EXERCISE_RUNSHEET.md
- curriculum/session_01_mental_models/PRACTICE.md
- curriculum/session_01_mental_models/CHECKPOINT.md
- curriculum/session_01_mental_models/FLOOR_TEST.md
- curriculum/session_01_mental_models/handouts/toil-inventory.md
- curriculum/session_01_mental_models/handouts/canned-toil.md
- curriculum/session_01_mental_models/demo/headcount.csv
- curriculum/session_01_mental_models/demo/start-demo.sh
- docs/trunk/SPEC.md
- docs/trunk/DECISIONS.md
code_references:
- ref: curriculum/README.md
  implements: 'The per-session directory convention: session_<NN>_<slug>/ naming,
    the six required filenames, handouts/ and FLOOR_TEST.md/DRY_RUN.md as optional,
    and the rule that cross-session artifacts stay in the introducing session''s handouts/'
- ref: curriculum/session_01_mental_models/README.md
  implements: The session index and the teaching spine stated as load-bearing order,
    with the constraints an editor must not break
- ref: curriculum/session_01_mental_models/PREWORK.md
  implements: 'Prework in ~22 minutes: the leverage argument in the operator''s voice,
    the five-recurring-tasks list, and the setup-status reply that routes a failed
    setup to remediation instead of to a lost evening'
- ref: curriculum/session_01_mental_models/FACILITATOR_GUIDE.md
  implements: 'The re-teachable session: pre-session prep, setup-status collection
    and the remediation route, a 90-minute timing table with a 60-minute variant and
    ordered cutting rules, the cold open''s three statements and two forbidden framings,
    SPEC terminology quoted verbatim, the two-beat demo with its planted judgment
    call and backup row, eleven anticipated failure points with recovery moves, the
    FAQ, and a read-aloud transcript for a demo that cannot run'
- ref: curriculum/session_01_mental_models/EXERCISES.md
  implements: "The participant steps for the three-exercise block — brain dump, the check column, and the skeptic pass — in second person, with the canned-sheet fallback per exercise"
- ref: curriculum/session_01_mental_models/EXERCISE_RUNSHEET.md
  implements: "The facilitator's running order for the block: timing, say-it-like-this, observable outputs, and the misfires each exercise produces, including the skeptic pass where conceding \"I couldn't tell\" is the success case"
- ref: curriculum/session_01_mental_models/PRACTICE.md
  implements: 'The observation-shaped practice week: a 55-minute budget under the
    90-minute cap, the daily pass, the check test that resolves "not sure" entries
    by watching yourself work, the consolidation pass, and the optional new-hire brief'
- ref: curriculum/session_01_mental_models/CHECKPOINT.md
  implements: "The observable checkpoint (\u22653 annotated entries plus a spoken\
    \ boundary claim), how to run the round in seven minutes, the pass/near-miss discrimination\
    \ guide, the private recovery path, and what a room-wide failure obligates in\
    \ Session 2"
- ref: curriculum/session_01_mental_models/FLOOR_TEST.md
  implements: "The floor-test protocol for a comprehension-only session \u2014 verbatim\
    \ tasks, timing measurement against every claimed budget, seven session-specific\
    \ watch-fors, the facilitator demo dry-run with its nondeterminism rule, and the\
    \ pending results log"
- ref: curriculum/session_01_mental_models/handouts/toil-inventory.md
  implements: The four-column toil inventory that persists to the Session 6 capstone
    gate, with worked rows for an in-boundary and an out-of-boundary task and the
    rule that later sessions may add columns but not rename these
- ref: curriculum/session_01_mental_models/handouts/canned-toil.md
  implements: "The no-dead-ends fallback \u2014 a persona with eight recurring tasks\
    \ spanning clearly-judgeable, clearly-not, and underdetermined, with no answer\
    \ key"
- ref: curriculum/session_01_mental_models/demo/headcount.csv
  implements: "The Northwind Coffee demo file for Beats 3-4: seven rows of mechanical
    noise the agent handles well, plus two independent judgment traps (Grace/Brand,
    Hank+Ivy/Field) that no mechanical check catches"
- ref: curriculum/session_01_mental_models/demo/start-demo.sh
  implements: Creates and resets the demo working directory outside the repository
    and prints the facilitator crib, so the live run never dirties the pristine file
    and rehearsals can be repeated
- ref: docs/trunk/DECISIONS.md
  implements: DEC-010, recording the session directory convention and the toil inventory
    format as cross-session contracts, with the rejected alternatives (free-form layout,
    one document per session, spreadsheet inventory, task-plus-flag inventory)
- ref: docs/trunk/SPEC.md
  implements: Repository Layout settled for curriculum/ and the Session 1 entry in
    Curriculum Structure corrected to name the cold-open ordering and the conceptual-only
    constraint
narrative: null
investigation: null
subsystems: []
friction_entries: []
depends_on:
- onboarding_setup_guide
created_after: []
---
<!--
╔══════════════════════════════════════════════════════════════════════════════╗
║  DO NOT DELETE THIS COMMENT BLOCK until the chunk complete command is run.   ║
║                                                                              ║
║  AGENT INSTRUCTIONS: When editing this file, preserve this entire comment    ║
║  block. Only modify the frontmatter YAML and the content sections below      ║
║  (Minor Goal, Success Criteria, Relationship to Parent). Use targeted edits  ║
║  that replace specific sections rather than rewriting the entire file.       ║
╚══════════════════════════════════════════════════════════════════════════════╝

This comment describes schema information that needs to be adhered
to throughout the process.

STATUS VALUES (status answers: how much of the intent does this chunk own?):
- FUTURE: Not yet owned. Queued for later.
- IMPLEMENTING: Being taken into ownership. At most one per worktree.
- ACTIVE: Fully owns the intent that governs the code.
- COMPOSITE: Shares ownership with other chunks. Must be read alongside its co-owners.
- HISTORICAL: No longer owns intent. Kept for archaeological context.

See docs/trunk/CHUNKS.md for the full principle.

FUTURE CHUNK APPROVAL REQUIREMENT:
ALL FUTURE chunks require operator approval before committing or injecting.
After refining this GOAL.md, you MUST present it to the operator and wait for
explicit approval. Do NOT commit or inject until the operator approves.
This applies whether triggered by "in the background", "create a future chunk",
or any other mechanism that creates a FUTURE chunk.

COMMIT BOTH FILES: When committing a FUTURE chunk after approval, add the entire
chunk directory (both GOAL.md and PLAN.md) to the commit, not just GOAL.md. The
`ve chunk create` command creates both files, and leaving PLAN.md untracked will
cause merge conflicts when the orchestrator creates a worktree for the PLAN phase.

PARENT_CHUNK:
- null for new work
- chunk directory name (e.g., "006-segment-compaction") for corrections or modifications

CODE_PATHS:
- Populated at planning time
- List files you expect to create or modify
- Example: ["src/segment/writer.rs", "src/segment/format.rs"]

CODE_REFERENCES:
- Populated after implementation, before PR
- Uses symbolic references to identify code locations

- Format: {file_path}#{symbol_path} where symbol_path uses :: as nesting separator
- Example:
  code_references:
    - ref: src/segment/writer.rs#SegmentWriter
      implements: "Core write loop and buffer management"
    - ref: src/segment/writer.rs#SegmentWriter::fsync
      implements: "Durability guarantees"
    - ref: src/utils.py#validate_input
      implements: "Input validation logic"


NARRATIVE:
- If this chunk was derived from a narrative document, reference the narrative directory name.
- When setting this field during /chunk-create, also update the narrative's OVERVIEW.md
  frontmatter to add this chunk to its `chunks` array with the prompt and chunk_directory.
- If this is the final chunk of a narrative, the narrative status should be set to COMPLETED
  when this chunk is completed.

INVESTIGATION:
- If this chunk was derived from an investigation's proposed_chunks, reference the investigation
  directory name (e.g., "memory_leak" for docs/investigations/memory_leak/).
- This provides traceability from implementation work back to exploratory findings.
- When implementing, read the referenced investigation's OVERVIEW.md for context on findings,
  hypotheses tested, and decisions made during exploration.
- Validated by `ve chunk validate` to ensure referenced investigations exist.


SUBSYSTEMS:
- Optional list of subsystem references that this chunk relates to
- Format: subsystem_id is the subsystem directory name, relationship is "implements" or "uses"
- "implements": This chunk directly implements part of the subsystem's functionality
- "uses": This chunk depends on or uses the subsystem's functionality
- Example:
  subsystems:
    - subsystem_id: "validation"
      relationship: implements
    - subsystem_id: "frontmatter"
      relationship: uses
- Validated by `ve chunk validate` to ensure referenced subsystems exist
- When a chunk that implements a subsystem is completed, a reference should be added to
  that chunk in the subsystems OVERVIEW.md file front matter and relevant section.

FRICTION_ENTRIES:
- Optional list of friction entries that this chunk addresses
- Provides "why did we do this work?" traceability from implementation back to accumulated pain points
- Format: entry_id is the friction entry ID (e.g., "F001"), scope is "full" or "partial"
  - "full": This chunk fully resolves the friction entry
  - "partial": This chunk partially addresses the friction entry
- When to populate: During /chunk-create if this chunk addresses known friction from FRICTION.md
- Example:
  friction_entries:
    - entry_id: F001
      scope: full
    - entry_id: F003
      scope: partial
- Validated by `ve chunk validate` to ensure referenced friction entries exist in FRICTION.md
- When a chunk addresses friction entries and is completed, those entries are considered RESOLVED

CHUNK ARTIFACTS:
- Single-use scripts, migration tools, or one-time utilities created for this chunk
  should be stored in the chunk directory (e.g., docs/chunks/foo/migrate.py)
- These artifacts help future archaeologists understand what the chunk did
- Unlike code in src/, chunk artifacts are not expected to be maintained long-term
- Examples: data migration scripts, one-time fixups, analysis tools used during implementation

CREATED_AFTER:
- Auto-populated by `ve chunk create` - DO NOT MODIFY manually
- Lists the "tips" of the chunk DAG at creation time (chunks with no dependents yet)
- Tips must be ACTIVE chunks (shipped work that has been merged)
- Example: created_after: ["auth_refactor", "api_cleanup"]

IMPORTANT - created_after is NOT implementation dependencies:
- created_after tracks CAUSAL ORDERING (what work existed when this chunk was created)
- It does NOT mean "chunks that must be implemented before this one can work"
- FUTURE chunks can NEVER be tips (they haven't shipped yet)

COMMON MISTAKE: Setting created_after to reference FUTURE chunks because they
represent design dependencies. This is WRONG. If chunk B conceptually depends on
chunk A's implementation, but A is still FUTURE, B's created_after should still
reference the current ACTIVE tips, not A.

WHERE TO TRACK IMPLEMENTATION DEPENDENCIES:
- Investigation proposed_chunks ordering (earlier = implement first)
- Narrative chunk sequencing in OVERVIEW.md
- Design documents describing the intended build order
- The `created_after` field will naturally reflect this once chunks ship

DEPENDS_ON:
- Declares explicit implementation dependencies that affect orchestrator scheduling
- Format: list of chunk directory name strings, or null
- Default: [] (empty list - explicitly no dependencies)

VALUE SEMANTICS (how the orchestrator interprets this field):

| Value             | Meaning                              | Oracle behavior   |
|-------------------|--------------------------------------|-------------------|
| `null` or omitted | "I don't know my dependencies"       | Consult oracle    |
| `[]` (empty list) | "I explicitly have no dependencies"  | Bypass oracle     |
| `["chunk_a"]`     | "I depend on these specific chunks"  | Bypass oracle     |

CRITICAL: The default `[]` means "I have analyzed this chunk and it has no dependencies."
This is an explicit assertion, not a placeholder. If you haven't analyzed dependencies yet,
change the value to `null` (or remove the field entirely) to trigger oracle consultation.

WHEN TO USE EACH VALUE:
- Use `[]` when you have analyzed the chunk and determined it has no implementation dependencies
  on other chunks in the same batch. This tells the orchestrator to skip conflict detection.
- Use `null` when you haven't analyzed dependencies yet and want the orchestrator's conflict
  oracle to determine if this chunk conflicts with others.
- Use `["chunk_a", "chunk_b"]` when you know specific chunks must complete before this one.

WHY THIS MATTERS:
The orchestrator's conflict oracle adds latency and cost to detect potential conflicts.
When you declare `[]`, you're asserting independence and enabling the orchestrator to
schedule immediately. When you declare `null`, you're requesting conflict analysis.

PURPOSE AND BEHAVIOR:
- When a list is provided (empty or not), the orchestrator uses it directly for scheduling
- When null, the orchestrator consults its conflict oracle to detect dependencies heuristically
- Dependencies express order within a single injection batch (intra-batch scheduling)
- The chunks listed in depends_on will be scheduled to complete before this chunk starts

CONTRAST WITH created_after:
- `created_after` tracks CAUSAL ORDERING (what work existed when this chunk was created)
- `depends_on` tracks IMPLEMENTATION DEPENDENCIES (what must complete before this chunk runs)
- `created_after` is auto-populated at creation time and should NOT be modified manually
- `depends_on` is agent-populated based on design requirements and may be edited

WHEN TO DECLARE EXPLICIT DEPENDENCIES:
- When you know chunk B requires chunk A's implementation to exist before B can work
- When the conflict oracle would otherwise miss a subtle dependency
- When you want to enforce a specific execution order within a batch injection
- When a narrative or investigation explicitly defines chunk sequencing

EXAMPLE:
  # Chunk has no dependencies (explicit assertion - bypasses oracle)
  depends_on: []

  # Chunk dependencies unknown (triggers oracle consultation)
  depends_on: null

  # Chunk B depends on chunk A completing first
  depends_on: ["auth_api"]

  # Chunk C depends on both A and B completing first
  depends_on: ["auth_api", "auth_client"]

VALIDATION:
- `null` is valid and triggers oracle consultation
- `[]` is valid and means "explicitly no dependencies" (bypasses oracle)
- Referenced chunks should exist in docs/chunks/ (warning if not found)
- Circular dependencies will be detected at injection time
- Dependencies on ACTIVE chunks are allowed (they've already completed)
-->

# Chunk Goal

## Minor Goal

The `curriculum/session_01_mental_models/` directory owns Session 1 of the
fluency arc — "Mental models & toil inventory" — as the complete session
anatomy defined in SPEC.md: facilitator guide, prework (≤30 min),
in-session exercises with canned fallbacks, practice assignment (≤90 min),
and an observable checkpoint. As the first implemented session, it also
establishes the per-session directory convention that SPEC.md's DRAFT
Repository Layout section is waiting on.

The session's teaching spine is the curriculum thesis (GOAL.md problem
statement; DEC-005), delivered in this order:

1. **Cold open: "why the moment matters."** The session opens with the
   leverage argument from GOAL.md, not with definitions: software
   engineers' judgment has compounded for decades because it could be
   encoded once in code and govern unbounded executions; everyone else's
   judgment ran one meeting, one document at a time. Agentic tooling lets
   judgment expressed in plain language govern automated work — the
   participants already own the scarce input. This framing was chosen
   deliberately because it tells a skeptical operations manager the course
   is *for them*, and it dignifies rather than threatens.
2. **Mental models.** What an agent is and isn't; how an agent (acts on
   files/systems over multiple steps) differs from a chatbot (converses).
3. **Judgment vs expertise and the judgment boundary.** Per SPEC.md
   Terminology: judgment is the ability to *evaluate* without necessarily
   being able to produce; expertise is the ability to produce. "Delegation
   can substitute for expertise; nothing substitutes for judgment."
   Delegating outside your judgment boundary is taught as the cardinal
   risk — plausible-but-wrong output passes unchallenged.
4. **Toil inventory initiation.** Each participant starts their inventory:
   recurring tasks, each annotated with whether it sits inside their
   judgment boundary ("could I evaluate the output?"). The inventory is
   the raw material Arc 2 mines for capstones (DEC-003), so entry quality
   matters more than entry count.

Constraints the implementing agent must honor:

- **No harness hands-on in Session 1.** pi.dev is introduced in Session 2
  (SPEC.md, Curriculum Structure). Session 1 must work for a participant
  whose pre-cohort setup failed; setup remediation is routed to before
  Session 2, not solved live in Session 1.
- **Any capability demo is paired with "how would you check this?"**
  (DEC-005, Consequences). If the facilitator shows an agent doing
  something impressive, the very next beat is evaluation.
- **Exercises operate on participants' own work** with a canned fallback
  for anyone who can't use their real toil (SPEC.md, Session Anatomy).
- **Audience floor** (DEC-004): no programming or terminal knowledge
  assumed anywhere in the session.
- **Operator-authored source material**: `pi-learning-paths.md` (repo
  root) is a staged learning path written by the operator in the
  course's intended voice — its "Why this guide, why you" opening is a
  worked example of the judgment-leverage framing aimed at this exact
  audience. Mine it for tone, phrasing, and staging; where it overlaps
  Session 1's concepts, prefer its voice.

## Success Criteria

- All five session-anatomy artifacts exist per SPEC.md (Session Anatomy):
  facilitator guide with timing, talking points, anticipated failure
  points, and recovery moves; prework; in-session exercises with canned
  fallbacks; practice assignment; checkpoint definition.
- Prework is completable in ≤30 minutes by the audience floor; practice
  assignment fits ≤90 minutes and is observation-shaped (extend the toil
  inventory from the participant's actual week) rather than added homework.
- The session opens with the "why the moment matters" argument and teaches
  agent-vs-chatbot, judgment-vs-expertise, and the judgment boundary using
  SPEC.md's terminology verbatim, so later sessions inherit consistent
  vocabulary.
- The checkpoint is observable per SPEC.md: every participant leaves with
  a toil inventory containing at least 3 entries, each annotated with
  judgeability, and can articulate for one of their own tasks why it sits
  inside or outside their judgment boundary.
- The toil inventory format is defined here and referenced by later
  sessions (it persists through the capstone selection gate in Session 6).
- The facilitator guide is sufficient for a facilitator who did not author
  it (GOAL.md success criterion: re-teachable).
- SPEC.md's DRAFT Repository Layout section is updated to reflect the
  actual `curriculum/` convention this chunk establishes, and the Session 1
  entry in Curriculum Structure is confirmed or corrected.
- A floor test per TESTING_PHILOSOPHY.md (Floor Testing) is planned before
  first teach; the artifacts note what the observer watches for.

## Rejected Ideas

### Open with "what is an agent" definitions

The conventional intro-session structure: define terms first, motivate
later.

Rejected because: the operator wants the cold open to be the "why the
moment matters" leverage argument — it recruits the audience before asking
them to learn anything, and definitions land better once participants
believe the course is for them.

### Include hands-on harness work in Session 1

Getting participants into pi.dev immediately would make the first session
feel more concrete.

Rejected because: harness introduction is Session 2's job (SPEC.md), and
keeping Session 1 conceptual means a participant whose pre-cohort setup
failed can still fully participate — setup problems get fixed between
Sessions 1 and 2 instead of derailing the opening session.