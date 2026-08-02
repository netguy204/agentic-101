---
status: IMPLEMENTING
ticket: null
parent_chunk: null
code_paths:
  - env/README.md
  - env/DISTRIBUTION.md
  - env/FLOOR_TEST.md
  - env/versions.env
  - env/install.sh
  - env/install.ps1
  - env/uninstall.sh
  - env/lib/common.sh
  - env/lib/shellrc.sh
  - env/bin/commit
  - env/bin/revert
  - env/bin/course-check
  - env/windows/Patch-WindowsTerminal.ps1
  - docs/trunk/SPEC.md
  - docs/trunk/DECISIONS.md
code_references: []
narrative: null
investigation: null
subsystems: []
friction_entries: []
depends_on: []
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

The curriculum ships a **managed terminal environment**: a
participant-facing installation that presents the same shell experience on
macOS and Windows and puts a small set of guided convenience commands on
the PATH. Every session's material and the setup guide
(docs/chunks/onboarding_setup_guide) assume this environment; "open your
terminal" always means *this* terminal, configured identically for every
participant.

The convenience commands wrap scary-but-necessary operations in
interactive walkthroughs. The initial set:

- **`commit`** — checkpoint your work: shows what changed in plain
  language, asks what this checkpoint should be called, and saves it. No
  staging vocabulary, no flags.
- **`revert`** — walk back safely: lists recent checkpoints in plain
  language, lets the participant pick one, confirms what will happen, and
  restores it.

The operator's design bar, verbatim: "Imagine if there was a commit and a
revert command that users could just type and it walked them through the
process instead of what they get with the standard git cli." The commands
are conversational walkthroughs, not thin aliases — a participant who has
never heard of git gets git's safety without git's porcelain.

Context the implementing agent needs:

- **Why this exists**: pi has no built-in undo and no permission gates
  (see docs/chunks/onboarding_setup_guide/pi-reference.md, §6 pitfall 1 —
  pi's own docs say "use git or another checkpointing workflow").
  Checkpointing is the mitigation, but the raw git CLI is exactly the
  comprehension burden the audience floor (DEC-004) forbids. Guided
  wrappers close that gap.
- **Cross-platform consistency is a first-class requirement**, not a
  nice-to-have. pi's keybindings (Shift+Enter, Alt+Enter) depend on the
  Kitty keyboard protocol and behave differently across terminal apps
  (pi-reference.md §6 pitfall 2). Which terminal application(s) to
  prescribe is a planning-time decision; record it in
  docs/trunk/DECISIONS.md. A researched comparison and recommendation
  (August 2026) lives in this chunk directory as `terminal-research.md`:
  no single healthy terminal is first-class on both platforms with solid
  Kitty-protocol support, so it recommends per-platform flagships —
  Windows Terminal + a Git Bash profile on Windows, Ghostty on macOS —
  with WezTerm as the single-app runner-up (stale stable release is the
  cost). It also documents why WSL2 and MSYS2 were rejected in favor of
  Git Bash (pi's own documented Windows path), the mandatory Alt+Enter
  remap on Windows Terminal, and the "mintty trap" (participants must
  never launch the Start-menu Git Bash icon). Its two time-sensitive
  claims were re-verified 2026-08-02 against the projects' GitHub
  releases pages: Windows Terminal 1.25 remains Preview-only (latest
  stable 1.24.11911.0, 2026-07-16 — so the documented `sendInput`
  bindings are required, not optional), and WezTerm's latest stable is
  still 20240203 with nothing newer. If implementation happens
  substantially later than this date, spot-check both again.
- **Installable non-interactively**: the setup guide runs this
  environment's installer as a copy-paste step, so installation must not
  require judgment or interactive choices from the participant.
- **The command set is a starting point.** More wrappers may emerge from
  cohort friction (log FRICTION.md entries rather than speculatively
  building them now).

## Success Criteria

- The environment installs on macOS and Windows and presents the same
  prompt, the same command set, and working pi keybindings on both
  (per-platform installation, identical experience after install).
- `commit` and `revert` exist as interactive guided flows: plain-language
  prompts, no git vocabulary required, safe defaults, and a clear
  confirmation before anything destructive. A participant at the audience
  floor (DEC-004) can checkpoint and restore without instruction beyond
  "type `commit`".
- `revert` cannot silently destroy work: uncommitted changes are
  checkpointed or explicitly confirmed away before restoring.
- The installer runs non-interactively from a single copy-paste command,
  suitable for embedding in the setup guide.
- Versions of everything the environment installs are pinned or pinnable
  per cohort (SPEC.md, Versioning and Compatibility).
- A floor test per TESTING_PHILOSOPHY.md (Floor Testing) is performed for
  the commit/revert walkthroughs and observations recorded.
- SPEC.md's DRAFT Repository Layout is updated to name where the
  environment's source lives in this repo.

## Rejected Ideas

### Teach the standard git CLI instead

Participants could learn `git add`/`git commit`/`git checkout` directly —
it's the transferable skill.

Rejected because: it violates the audience floor (DEC-004) and the
course's scope (GOAL.md: not a programming course). Git fluency is not the
skill being taught; safe checkpointing is a prerequisite for fearless
delegation, and the wrapper delivers it at zero comprehension cost. The
operator explicitly framed the standard git CLI experience as the thing to
avoid.

### Rely on a pi extension for checkpointing

pi's examples include a git-checkpoint extension; checkpointing could live
inside the harness.

Rejected because: participants also need checkpoint/restore *outside* pi
(before and after sessions, when pi isn't running), and a shell command
they can always type is a simpler mental model than harness-internal
state. A pi extension may later complement the shell commands, but the
shell-level walkthrough is the deliverable.