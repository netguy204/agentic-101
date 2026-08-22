---
status: IMPLEMENTING
ticket: null
parent_chunk: null
code_paths: []
code_references: []
narrative: null
investigation: null
subsystems: []
friction_entries: []
depends_on: []
created_after: ["fluency_safety_relevance"]
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

Every session directory under `curriculum/` separates its in-session
exercise material by reader. `EXERCISES.md` is **participant-only**: the
numbered steps a participant follows in the room, written to "you", with
what they should see at each step and the canned fallback for anyone who
cannot use their own work. `EXERCISE_RUNSHEET.md` is **facilitator-only**: the
per-exercise running order — time budget, what participants are doing, what
to say and when, what to work live on the projector first, the observable
output that says the exercise landed, the misfires and how to recover them,
stall triage, and pairing/remote logistics. The runsheet points at
`EXERCISES.md` by exercise and step number and never restates the steps, so
commands, prompts, and on-screen text have exactly one source. The
per-session convention (`curriculum/README.md`, `docs/trunk/SPEC.md`
Repository Layout, DEC-010) names seven fixed files, and Sessions 1 and 2
are already in that shape.

### Why

Both existing `EXERCISES.md` files interleave the two readers paragraph by
paragraph: a numbered participant step sequence, then **Say it like this.**,
**Observable output.**, **Most common misfire.**, **If someone stalls.**,
**Fallback.**, **Work one live before they start.**, **Remote delivery.**,
and a **Before starting, say this out loud:** preamble — all facilitator
voice — wrapped around steps written for the participant. The operator found
the mix awkward to use from either seat: a participant reading along hits
stage directions about themselves; a facilitator scanning for the next cue
wades through steps they already know. Splitting by audience lets each file
be focused on what its reader needs, and makes the participant document
safe to hand out or put on a screen as-is.

### What the implementing agent needs to know

**The files to split**
- `curriculum/session_01_mental_models/EXERCISES.md` — three exercises
  (brain dump, check column, skeptic pass), 27 minutes, paper only; the
  facilitator material is roughly half the file.
- `curriculum/session_02_meeting_the_harness/EXERCISES.md` — five exercises
  (where am I, the safety net, first delegation, what did it actually do,
  break it on purpose), 59 minutes; the facilitator material is roughly
  two-thirds of the file, including the `revert` four-question table, the
  "read the names, not the numbers" rule, the exercise-5 prompt rationale
  ("Why this prompt and not 'delete everything'"), and pairing fallbacks.

**What goes where** (the bold lead-ins are the seam — use them)
- To `EXERCISES.md` (participant): the exercise title; the numbered steps
  with exact commands, prompts, and the text the screen shows; "what you
  should see"; the participant's side of the fallback ("if you can't use
  your own work, use the Session 2 section of `canned-toil.md`"); the
  worksheet/handout they fill in; a one-line "if you're stuck, say so — the
  facilitator will pair you" where the runsheet has stall triage. Second
  person throughout. No stage directions, no timings in the headings (the
  facilitator owns the clock), no misfire commentary, no "say it like this".
- To `EXERCISE_RUNSHEET.md` (facilitator): the block overview and time
  budget (currently the opening paragraphs, e.g. "Five exercises, 59 minutes
  … cut *within* an exercise rather than dropping one"); **Before starting,
  say this out loud**; per exercise — minutes, **What participants do** (one
  paragraph, then "steps: `EXERCISES.md` exercise N"), **Work … live before
  they start**, **Say it like this**, **Observable output**, **If someone
  stalls**, every **misfire**, **Fallback** logistics (pairs, odd numbers,
  remote breakouts), **Remote delivery**, and **Wrapping the block**.
  Reference participant steps as "exercise 2, step 5", never by copying
  them.
- Facts that both readers need (e.g. the `revert` answers table: Enter,
  Enter, `2`, `yes`) live once, in `EXERCISES.md`; the runsheet says where
  to look and adds only the facilitator's reason to care (the "typing `1`"
  misfire).

**Voice and floor** — participant text keeps DEC-004's audience floor and
`curriculum/README.md`'s rule that participant-facing text assumes only
what has been taught. The existing participant steps already meet this;
the job is separation and re-addressing, not rewriting. Where the current
text says "participants" inside a step, it becomes "you".

**The convention to amend**
- `curriculum/README.md` — the "Required files" table (currently six rows,
  `EXERCISES.md` audience "Facilitator and participant") gains an
  `EXERCISE_RUNSHEET.md` row with audience "Facilitator", `EXERCISES.md`
  becomes audience "Participant", and the prose around it ("these six
  files", "The five names other than `README.md` map one-to-one onto the
  Session Anatomy list") is corrected: seven files; the Session Anatomy
  "in-session exercises" element maps to two files, one per reader.
- `docs/trunk/SPEC.md` Repository Layout (lines ~128–137) — the fixed
  filename list.
- `docs/trunk/DECISIONS.md` DEC-010 (line ~486) — records "six filenames";
  record the amendment the way DECISIONS.md handles amendments (a new
  decision that references DEC-010, or an amendment note on DEC-010 — follow
  the file's existing practice), so the six-file statement does not stand
  uncorrected. Use the `decision-create` skill if adding a decision.

**References that must keep resolving** (fix every one; `ve validate` must
pass)
- Session READMEs' file tables and reading-order prose:
  `session_01_mental_models/README.md:26`,
  `session_02_meeting_the_harness/README.md:25,35`.
- Facilitator guides: `session_01_mental_models/FACILITATOR_GUIDE.md:28`;
  `session_02_meeting_the_harness/FACILITATOR_GUIDE.md:27,176,286` — the
  "Run it from `EXERCISES.md`" cue becomes "run it from
  `EXERCISE_RUNSHEET.md`"; the pre-session "read EXERCISES.md end to end"
  becomes both files.
- `session_02_meeting_the_harness/FLOOR_TEST.md:56` and `DRY_RUN.md:6` —
  the dry run executes participant steps, so they keep pointing at
  `EXERCISES.md`; check the quoted passages still exist.
- `session_01_mental_models/handouts/canned-toil.md:154` links to Session
  2's `EXERCISES.md`.
- `docs/chunks/fluency_session_01/GOAL.md` and
  `docs/chunks/fluency_session_02/GOAL.md` — `code_paths` gain
  `EXERCISE_RUNSHEET.md`; their `code_references` entries for `EXERCISES.md`
  are re-described so each still names what that file now is. Both new
  runsheets and both trimmed `EXERCISES.md` files carry a
  `<!-- Chunk: docs/chunks/fluency_exercise_split - … -->` backreference for
  the split alongside the session chunk's existing one.

**Recent edits to preserve** (committed today, 2026-08-22, do not regress):
the Session 2 `revert` table's first row reads *"Wait — 1 thing in this
folder has changed since your last checkpoint… Type 1, 2 or 3."*; the
lead-in reads "four questions, one at a time — the first offers three
numbered choices"; the same wording in the "second misfire" note and the
facilitator guide's warn-line; and the facilitator guide's failure-point
row for the Windows CRLF warning.

## Success Criteria

- `curriculum/session_01_mental_models/` and
  `curriculum/session_02_meeting_the_harness/` each contain
  `EXERCISES.md` (participant-only) and `EXERCISE_RUNSHEET.md`
  (facilitator-only), and no paragraph in either file addresses the other
  reader: `EXERCISES.md` has no "say it like this", "observable output",
  "misfire", "fallback" logistics, or timings; the runsheet has no numbered
  participant step sequences.
- Every command, prompt, expected on-screen text, and worksheet instruction
  appears in exactly one of the two files (`EXERCISES.md`); the runsheet
  references them by exercise and step.
- Nothing taught is lost: every bold-lead-in paragraph from the current
  files can be found in the runsheet, and every numbered step in
  `EXERCISES.md`. The Session 2 corrections listed above survive verbatim.
- `curriculum/README.md`, `docs/trunk/SPEC.md` Repository Layout, and
  DECISIONS.md (DEC-010 amended or superseded) describe seven fixed files
  with the exercise element split by reader, so a later session chunk can
  reference `curriculum/session_04_workflow_design/EXERCISE_RUNSHEET.md`
  before it exists.
- All links and prose references listed above resolve; `uvx --from
  vibe-engineer ve validate` passes; `fluency_session_01` and
  `fluency_session_02` GOAL.md `code_paths`/`code_references` reflect the new
  files.
- `session_02_meeting_the_harness/DRY_RUN.md` still reads correctly against
  the participant file (its quoted passages exist in `EXERCISES.md`), and a
  note in its deviations or addendum records that the file was split after
  the 2026-08-07 run without re-running the steps (the steps themselves are
  unchanged).
- `bash env/tests/test-commands.sh` is unaffected (no env/ changes expected)
  — run it anyway to confirm the working tree is clean of collateral damage.

## Rejected Ideas

### Fold the facilitator material into FACILITATOR_GUIDE.md

Keeps the six-file convention untouched; the per-exercise cues become a
"Running the exercises" section of the guide.

Rejected because: the guide would grow by ~200 lines per session and become
unwieldy to scan mid-session, and the facilitator already runs the exercise
block from a dedicated document (the guide says "Run it from
`EXERCISES.md`"). A separate runsheet preserves that working pattern.

### Keep EXERCISES.md as the facilitator sheet; put participant steps in handouts/exercises.md

Rejected because: participant-facing uppercase documents already exist
(`PREWORK.md`, `PRACTICE.md`), the steps are a document in the course's
voice rather than a printable reference card, and the fixed-name rule
(references can precede existence) wants the participant steps at a fixed
uppercase name too.

### One file, two sections per audience

Rejected because: that is the current state — the interleaving is the
problem, and sectioning within one file still forces each reader to scroll
past the other's material.

### Split Session 2 only

Rejected because: the operator wants the convention settled for Sessions
3–6, and leaving Session 1 in the old shape would make the convention false
for an existing session.
