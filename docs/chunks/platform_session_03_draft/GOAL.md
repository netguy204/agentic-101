---
status: FUTURE
ticket: null
parent_chunk: null
code_paths: []
code_references: []
narrative: platform_compliance
investigation: null
subsystems: []
friction_entries: []
depends_on: ["platform_dual_authoring", "platform_solo_labs", "platform_student_index"]
created_after: ["platform_authoring_guide"]
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

`platform/drafts/03_anatomy_of_a_delegation/` contains Session 3's
complete draft platform version, staged under the convention
`platform_dual_authoring` defines, such that promotion after the Session 3
floor test is: move the files into place, add the session to
`module.yaml`, validate, tag — no authoring left. The draft is NOT listed
in `module.yaml` and nothing about it is served. Its contents:

1. **Rubric** (`rubric.yaml`), transcribed from
   `curriculum/session_03_anatomy_of_a_delegation/CHECKPOINT.md` per
   platform/README.md's rules. Four criteria in the checkpoint's own order
   and its own see/hear split ("the first and second are facts you can
   see; the third and fourth are the ones you have to hear"): (1) brief
   written — deterministic from the submitted brief's structure (the four
   named boxes filled; quote the handout's box headings exactly and note
   them as frozen); (2) ran twice with one change between — deterministic
   from the pasted `revert --list` (the names `after run 2`, `Back to:
   before run 1`, `after run 1`, `before run 1` — quote them exactly; they
   come from EXERCISES.md steps and env/bin/revert's `Back to:` prefix,
   both now frozen interfaces); (3) named the box and the reason, and (4)
   named the miss — judged, with the checkpoint's pass exemplars and every
   near-miss row verbatim including corrective questions. The checkpoint's
   "second run deferred to the practice week" clause is a room
   cutting-rule accommodation; the rubric requires both runs and records
   that transcription decision in a comment sourced to the clause.
2. **Audio script** (`audio.md`), written for the ear from PREWORK part 1
   and the README spine: segments of 450–900 words, each closing with its
   recall prompt; candidate segmentation — why delegations go wrong (the
   three reasons); the four boxes and the colleague-who-cannot-see-your-
   screen frame; find the box, change it once, run again; the boundary
   found by experiment ("out" is a pass). Tables, commands and anything
   the listener must look at go to `> Lab card:` lines. No HTML comments
   anywhere in the script (they are spoken).
3. **Recall prompts** (`recall.yaml`) — one per segment, asking what the
   segment actually said, one-sentence model answers.
4. **Student index** (`index.md`) — Session 3's, in the shape
   `platform_student_index` sets.
5. **Manifest fragment** (`session.yaml`) — the `sessions:` entry ready to
   paste: concept sources (PREWORK + the index), lab sources (EXERCISES,
   PRACTICE, `handouts/`, plus a comment noting the cross-session
   dependency on Session 1's `canned-toil.md` "For Session 3" and the
   Session 2 terminal card, both already served); artifacts —
   `delegation_brief` (worksheet, template
   `handouts/delegation-brief.md`), `checkpoint_list` (text),
   `session_log` (harness_log, `*.jsonl`), and `worst_delegation`
   (worksheet + text sentence, the Session 2 practice-week output
   submitted at Session 3 lab start — the carry-forward decision from the
   narrative, recorded in a comment); `estimated_minutes: {concept: 25,
   lab: 90}` from the dry run; ta_knowledge — FACILITATOR_GUIDE anchors
   (`#anticipated-failure-points-and-recovery-moves`,
   `#faq-questions-you-will-be-asked`), EXERCISE_RUNSHEET.md, DRY_RUN.md,
   FLOOR_TEST.md. CHECKPOINT.md appears nowhere.
6. **A promotion note** (`README.md` in the draft directory): what
   promotion is, and that it waits on the Session 3 floor test
   (`curriculum/session_03_anatomy_of_a_delegation/FLOOR_TEST.md`, results
   PENDING).

Written against the material as `platform_solo_labs` leaves it (exercise
1 individual, contract lines present) — hence the dependency. Verify the
validator's treatment of the drafts directory matches what
`platform_dual_authoring` recorded. If the floor test later changes
wording the rubric quotes, the draft is updated then — that is the point
of drafting before serving.

## Success Criteria

- The draft directory contains rubric, audio script, recall prompts,
  student index, manifest fragment and promotion note, complete per
  platform/README.md's rules for each artifact type.
- Every deterministic check's quoted wording (brief box headings,
  checkpoint names, the `Back to:` prefix) is grep-verified against the
  current handout, EXERCISES.md and env/bin/revert, and listed as frozen
  in rubric comments.
- The rubric says nothing CHECKPOINT.md does not, carries every near-miss
  row verbatim with its corrective question, and records the
  both-runs-required transcription decision.
- module.yaml is unchanged; `pnpm contract:validate` from
  ../learning-platform remains clean with the draft present;
  `uvx --from vibe-engineer ve validate` passes.
- Promotion after the floor test would require no authoring — verified by
  a dry read of the promotion note against the draft's contents.

