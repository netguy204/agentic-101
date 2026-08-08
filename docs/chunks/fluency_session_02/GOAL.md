---
status: IMPLEMENTING
ticket: null
parent_chunk: null
code_paths:
  - curriculum/session_02_meeting_the_harness/README.md
  - curriculum/session_02_meeting_the_harness/PREWORK.md
  - curriculum/session_02_meeting_the_harness/FACILITATOR_GUIDE.md
  - curriculum/session_02_meeting_the_harness/EXERCISES.md
  - curriculum/session_02_meeting_the_harness/PRACTICE.md
  - curriculum/session_02_meeting_the_harness/CHECKPOINT.md
  - curriculum/session_02_meeting_the_harness/FLOOR_TEST.md
  - curriculum/session_02_meeting_the_harness/DRY_RUN.md
  - curriculum/session_02_meeting_the_harness/handouts/terminal-card.md
  - curriculum/session_02_meeting_the_harness/handouts/what-did-it-do.md
  - curriculum/session_01_mental_models/handouts/canned-toil.md
  - curriculum/session_01_mental_models/handouts/toil-inventory.md
  - curriculum/README.md
  - docs/trunk/SPEC.md
code_references: []
narrative: null
investigation: null
subsystems: []
friction_entries: []
depends_on: ["fluency_session_01"]
created_after: ["fluency_session_01", "onboarding_setup_guide", "onboarding_terminal_env"]
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
   a concept map onto the file browser participants already know
   (`pi-learning-paths.md` Stage 0 is the operator's own worked version of
   this, including "don't be afraid of the blinking cursor" — mine it for
   voice and for the GUI→terminal mapping).
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
  model or provider choice. Read `env/README.md`, `setup/README.md`, and
  `docs/chunks/onboarding_setup_guide/pi-reference.md` before planning;
  the last is the verified pi reference (four default tools
  read/write/edit/bash, sessions, `!`/`!!`, Ctrl+O to collapse tool
  output, Escape to abort) — distill from it rather than re-deriving pi
  behavior.
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
  entries as the source of the first delegation, and may extend the sheet
  by editing Session 1's handout — not by forking a copy.
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
