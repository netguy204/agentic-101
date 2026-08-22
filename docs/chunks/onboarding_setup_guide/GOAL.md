---
status: ACTIVE
ticket: null
parent_chunk: null
code_paths:
- setup/README.md
- setup/pins.env
- setup/install-pi.sh
- setup/bin/course-smoke-test
- setup/PRE_COHORT_CHECKLIST.md
- setup/DRY_RUN.md
- setup/WELCOME_EMAIL.md
- setup/tests/test-setup.sh
- docs/trunk/SPEC.md
- docs/trunk/DECISIONS.md
code_references:
- ref: setup/README.md
  implements: 'The participant-facing guide: cost message before any install, per-platform
    environment install, opening the prescribed terminal, scripted pi install, smoke
    test, troubleshooting table, the honest what-was-installed inventory, and the
    getting-updates note (course-update, DEC-012)'
- ref: setup/pins.env
  implements: Per-cohort pins for pi and the prescribed model (DEC-006 model pinning;
    the other half of the pin set is env/versions.env, DEC-009)
- ref: setup/install-pi.sh
  implements: 'Scripted pi install: pinned npm version, generated ~/.pi/agent/settings.json,
    merged 0600 ~/.pi/agent/auth.json, practice directory, smoke-test installation
    (DEC-009); --keep-key reuses the saved key so course-update can re-run it (DEC-012)'
- ref: setup/bin/course-smoke-test
  implements: 'Participant-runnable PASS/FAIL smoke test: delegates to course-check,
    verifies the pi pin, model configuration and key file, then the model answering
    and one outcome-checked agent task in a sandbox directory'
- ref: setup/PRE_COHORT_CHECKLIST.md
  implements: 'The pre-cohort checklist required by TESTING_PHILOSOPHY.md Test Organization:
    publish-before-send gate, re-pinning, per-key spend limits and operator cost expectations,
    both-platform smoke tests, outstanding first-time verification, cohort tagging,
    and how a fix is published between sessions (bump, push, verify course-update)'
- ref: setup/DRY_RUN.md
  implements: 'Dry-run record and its honest limits: what the automated macOS run
    establishes, what Windows and human floor testing still owe'
- ref: setup/WELCOME_EMAIL.md
  implements: 'Per-participant welcome email template (checklist section 3): personal
    Step 3 command, cost message, line-wrap guard, removable alpha section that turns
    the first participant into the dry-run and floor-test record'
- ref: setup/tests/test-setup.sh
  implements: Regression tests against a throwaway HOME and npm prefix, including
    stub-pi coverage of both live-model check paths and the --keep-key cases
narrative: null
investigation: null
subsystems: []
friction_entries: []
depends_on:
- onboarding_terminal_env
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

The `setup/` directory owns the pre-cohort onboarding path. A participant
matching the audience floor (DEC-004: comfortable with everyday computer
use, **no programming or terminal experience**) goes from a fresh macOS or
Windows laptop to a verified working environment — pi.dev installed, LLM
provider access configured, expected costs understood — by following the
guide alone, with no facilitator present. The path terminates in the smoke
test required by SPEC.md (Participant Prerequisites) and
TESTING_PHILOSOPHY.md (Setup Smoke Test): it verifies tools are installed,
the API key works, and one trivial agent task completes, emitting a
pass/fail result the participant can interpret themselves. The directory
also owns the pre-cohort checklist (TESTING_PHILOSOPHY.md, Test
Organization): re-pin tool and model versions, re-run the smoke test on
both platforms, tag `cohort-YYYY-MM`.

Context the implementing agent needs:

- **pi.dev is the harness** (DEC-001). It is a minimal agent harness
  (https://pi.dev, installable via npm — package
  `@earendil-works/pi-coding-agent` — or shell script). DEC-001 explicitly
  accepts that the curriculum owns this setup friction — this chunk is
  that accepted cost being paid. A verified reference distilled from pi's
  shipped docs lives in this chunk directory as `pi-reference.md` —
  distill from it rather than re-deriving pi behavior; it covers install,
  auth paths, project trust, settings, and known pitfalls. The operator
  also authored `pi-learning-paths.md` (repo root), a staged learning
  path in the course's intended voice — its Stage 0 (terminal survival)
  and Stage 1 (install/first session) show the tone and pacing the guide
  should match.
- **Auth is operator-provisioned: an OpenRouter API key** (DEC-006). The
  operator hands each participant an OpenRouter key; the guide's auth
  step is entering that key — no accounts created, no billing configured,
  no provider chosen. pi supports OpenRouter via `/login` (API-key option,
  stored in `~/.pi/agent/auth.json` with 0600 perms) or the
  `OPENROUTER_API_KEY` env var; auth.json is the likelier floor-friendly
  path (env vars are shell-session-scoped and invisible), but decide at
  plan time.
- **The model is prescribed by shipped configuration** (DEC-006). The
  guide installs a provided pi configuration (`~/.pi/agent/settings.json`
  with `defaultProvider`, `defaultModel`, `defaultThinkingLevel`) so every
  participant runs the same pinned model. This *is* the per-cohort model
  pinning required by SPEC.md (Versioning) — participants never pick a
  model.
- **The terminal is the managed environment from
  docs/chunks/onboarding_terminal_env** (declared in `depends_on`). The
  guide never says "open your terminal" generically — it installs and
  opens the prescribed environment. This is the mitigation for pi's
  keybinding dependence on the Kitty keyboard protocol, which behaves
  differently across stock terminals (pi-reference.md §6).
- **Setup ends inside a sandbox practice directory.** pi edits files and
  runs commands with the participant's full permissions and has no
  built-in undo (pi-reference.md §6). The guide creates a dedicated
  practice directory, and the smoke test runs there, so nothing outside it
  can be touched during onboarding. The managed environment's `commit` /
  `revert` commands provide the checkpoint/restore safety net.
- **The guide is copy-paste-and-verify only.** Every command is presented
  to be pasted verbatim, paired with the expected output (text or
  screenshot) so the participant can self-check. No step may require
  understanding what the command does — the terminal is *taught* in
  Session 2, not here.
- **Costs stated up front** (GOAL.md, Constraints): because the operator
  provides the OpenRouter key, the participant-facing message is that
  usage is covered; the guide still states this explicitly, and the
  pre-cohort checklist documents the operator-side cost expectations and
  per-key spend limits.
- **Version pinning per cohort** (SPEC.md, Versioning): the guide pins
  pi.dev (exact npm package version), the prescribed model, and the
  managed environment version, and documents where/how pins are updated
  between cohorts.

## Success Criteria

- Setup guide exists in `setup/` with complete per-platform paths for macOS
  and Windows (SPEC.md, Participant Prerequisites — both are maintained).
- The guide installs, in order: the managed terminal environment
  (onboarding_terminal_env), pi at a pinned version, the operator-provided
  OpenRouter key, and the shipped model-pinning configuration — each step
  copy-paste with expected output shown.
- Every command is copy-pasteable and paired with expected output; no step
  assumes prior terminal knowledge beyond opening the prescribed terminal
  application (the guide shows how to do that per platform).
- The auth step requires only the operator-provided key: no account
  creation, billing setup, or provider/model selection anywhere in the
  guide.
- The cost message is stated before any install step: usage is covered by
  the operator-provided key; operator-side cost expectations and per-key
  spend limits are documented in the pre-cohort checklist.
- A sandbox practice directory is created during setup; the smoke test
  runs inside it.
- A smoke test exists that a participant can run and interpret unaided; it
  verifies the managed environment (including `commit`/`revert` on PATH),
  the pi installation, key validity, the prescribed model responding, and
  completion of one trivial agent task, and its output is an unambiguous
  pass or fail with a "what to do if it fails" pointer.
- pi.dev, model, and managed-environment versions are pinned, and the
  pinning/update mechanism is documented for the pre-cohort checklist.
- The pre-cohort checklist from TESTING_PHILOSOPHY.md (Test Organization)
  exists in `setup/`.
- At least one clean-environment dry-run of the full guide is performed and
  recorded per platform (TESTING_PHILOSOPHY.md, Exercise Dry-Runs / Setup
  Smoke Test).
- SPEC.md's DRAFT Repository Layout section is confirmed or corrected for
  `setup/` as part of this chunk.

## Rejected Ideas

### Teach terminal basics inside the setup guide

The guide could include a terminal primer so participants understand the
commands they're pasting.

Rejected because: terminal skills are taught live in Session 2 (SPEC.md,
Curriculum Structure), where a facilitator can catch confusion. Pre-cohort,
participants are alone — the guide must succeed with zero comprehension
required, which is why it is copy-paste-and-verify with expected output at
every step.

### Subscription auth via `/login` OAuth

pi supports OAuth login with Claude Pro/Max, ChatGPT, GitHub Copilot, and
others — for participants who already have a subscription, this is the
lowest-friction auth path (no key to paste).

Rejected because: it fragments the cohort across providers and models
(breaking the prescribed-model guarantee), and Claude Pro/Max via pi bills
Anthropic *extra usage* per token rather than drawing on plan limits
(pi-reference.md §2) — a surprise-cost trap for exactly the audience least
equipped to notice it. The operator-provisioned OpenRouter key gives one
auth path, one model, and centrally controlled spend (DEC-006).

### Bring-your-own API keys

Participants could create their own provider accounts and keys.

Rejected because: account creation plus billing setup is the highest-
friction, highest-abandonment step imaginable for the audience floor, and
it produces heterogeneous cost exposure the guide can't honestly summarize.
The operator provides keys instead (DEC-006).