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
created_after: ["fluency_exercise_split"]
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

Participants get course updates through one deterministic, one-word command.
`course-update`, installed in `~/.agentic-101/bin/` alongside `commit`,
`revert` and `course-check`, compares what is installed against what the
repository publishes and brings the machine current: the course environment
(`env/` payload — `commit`, `revert`, `course-check`, `course-update` itself,
`lib/`, `versions.env`) when the published `ENV_VERSION` differs from
`~/.agentic-101/VERSION`, and pi (version, model/provider settings, the
smoke test, `pins.env`) when the published `setup/pins.env` differs from
what is installed. It finishes in seconds when nothing has changed, needs
no key and no model call, speaks in the same plain-language register as
`commit`/`revert`, and tells the participant exactly one thing to do
afterwards ("close this window and open a new one") only when that is
needed. Every session from Session 2 onward opens with it: the prework's
"run one command" step and the first line of `EXERCISES.md` both say
`course-update`, so an environment fix published between sessions reaches
every participant before the room uses it. When it cannot reach the
network it says so in one line and exits non-zero without changing
anything, and the session carries on.

### Why

On 2026-08-22 the operator ran Session 2's exercise 2 on Windows and found
`commit` printing a git warning (`LF will be replaced by CRLF`) that the
command exists to hide. The fix shipped as environment 1.0.1 the same day —
but the only way a participant who had already set up (David, Session 1
cohort) could get it was to re-run Step 1 of the setup guide, a multi-
minute PowerShell installer they last saw weeks ago, on the facilitator's
say-so. Every future fix to `env/` or to the pi pins has the same
distribution problem. The course needs a standing answer: updates are
pulled by the participant, deterministically, at the start of every
session, with one word.

The operator considered and set aside the obvious alternative — a "sync
up" prompt participants give pi at the start of each exercise set, asking
it to pull the latest updates. Once a participant has pi working, manual
terminal steps are in principle unnecessary. It was rejected for now on
three grounds, recorded below under Rejected Ideas: it lands too late
(Session 2 uses `commit` before pi is opened), it is a broad unverifiable
delegation made at the moment the course is teaching the opposite, and it
is nondeterministic in a place where determinism matters (pi could read
"pull updates" as `git pull` in `~/course-practice`, the checkpoint repo).
The operator's stated boundary: pi's advantage over a script would only
appear if a long tail of environment divergence made a scripted solution
infeasible — that is the condition under which to revisit.

### What the implementing agent needs to know

**What exists.** `env/install.sh` is idempotent and re-runnable (header
comment: "Re-running is safe and produces the same result"); piped from
curl it downloads `A101_PAYLOAD` (`lib/common.sh lib/shellrc.sh bin/commit
bin/revert bin/course-check versions.env`) from `A101_BASE_URL` (default
`https://raw.githubusercontent.com/netguy204/agentic-101/main/env`,
override `AGENTIC101_ENV_BASE_URL`), copies it over `~/.agentic-101/`, and
writes `ENV_VERSION` to `~/.agentic-101/VERSION` (`install.sh:188-191`).
`--skip-packages` skips Homebrew/winget. `env/versions.env` is the single
source of `ENV_VERSION` (bumped on any change to `env/`). `env/bin/
course-check` verifies the environment and prints `Course environment
<VERSION>`; `commit --version` prints `agentic-101 environment <VERSION>`.
`setup/install-pi.sh` (base URL `…/main/setup`, override
`AGENTIC101_SETUP_BASE_URL`, payload `pins.env bin/course-smoke-test`)
installs pi at `PI_VERSION` via `npm install -g --ignore-scripts
@earendil-works/pi-coding-agent@$PI_VERSION`, writes `settings.json` from
`PI_PROVIDER`/`PI_MODEL`/`PI_THINKING_LEVEL`, saves the key to
`~/.pi/agent/auth.json` (requires `--key`; fails without it at
`install-pi.sh:224`), makes `~/course-practice`, copies `course-smoke-test`
and `pins.env` into `~/.agentic-101/`, and runs the smoke test (minutes; it
calls the model). `setup/pins.env` holds `PI_VERSION=0.83.0`,
`PI_PROVIDER`, `PI_MODEL`, `PI_THINKING_LEVEL`, `EXPECTED_ENV_VERSION`,
`PRACTICE_DIR`; `install-pi.sh:170` already warns on an env-version
mismatch but does not act. Windows: `env/install.ps1` installs packages
and patches Windows Terminal, then runs `install.sh --skip-packages` inside
Git Bash. Helpers in `env/lib/common.sh`: `say bold dim good warn fail
blank ask confirm backup_file`. Tests: `env/tests/test-install.sh` (dry
run, first install, idempotent second install, user content preserved),
`env/tests/test-commands.sh`, `setup/tests/test-setup.sh` (see how it stubs
npm/pi — reuse the same stubs).

**The command.** `env/bin/course-update`, added to `A101_PAYLOAD` so it
ships with the environment and updates itself. Behaviour:
1. Fetch `<env base>/versions.env` (curl, short timeout, `-fsSL`). Compare
   `ENV_VERSION` to `~/.agentic-101/VERSION`. If different, run
   `curl -fsSL <env base>/install.sh | bash -s -- --skip-packages` (it
   re-downloads the full payload). Report `Course environment: updated
   1.0.1 → 1.1.0` or `Course environment: up to date (1.1.0)`.
2. Fetch `<setup base>/pins.env`. Compare `PI_VERSION` to the installed pi
   (`pi --version`, as `install-pi.sh:274` reads it) and the pin file to
   the installed `~/.agentic-101/pins.env`. If different, run
   `curl -fsSL <setup base>/install-pi.sh | bash -s -- --keep-key
   --no-check` — two new `install-pi.sh` flags: `--keep-key` reuses the
   saved `auth.json` and fails plainly if there is none ("no saved key —
   run Step 3 of the setup guide"); `--no-check` skips the closing smoke
   test so an update takes seconds. Report `pi: updated 0.83.0 → 0.84.1`
   or `pi: up to date (0.83.0)`.
3. If anything was updated, end with exactly one instruction: `Close this
   window and open a new one before carrying on.` Otherwise `Nothing to
   do.` Exit 0.
4. If a fetch fails: `Could not reach the course updates (no internet, or
   the course site is down). Nothing was changed — carry on with the
   session and tell your facilitator.` Exit non-zero. Never leave a
   half-applied update (the installers already stage to a temp dir first).
5. The env base and setup base default to the same two URLs the installers
   hold and honour the same two override variables, so tests can point
   both at `file://` directories (curl reads `file://` URLs).
Out of scope, stated in the command's `--help` and in `env/README.md`:
Windows Terminal configuration and OS packages (those need Step 1 of the
setup guide). Bump `ENV_VERSION` to 1.1.0 and `EXPECTED_ENV_VERSION` to
match.

**Where it goes in the curriculum.**
- `curriculum/session_02_meeting_the_harness/PREWORK.md` §3 "Run one
  command" becomes two: `course-update`, then `course-smoke-test`; the
  participant still replies with the smoke test's last word, and the "do
  not try to fix it" rule stands.
- `curriculum/session_02_meeting_the_harness/EXERCISES.md` — a "Before
  exercise 1" line at the top: type `course-update`, and if it says to
  close and reopen the window, do that before going on. The runsheet
  (`EXERCISE_RUNSHEET.md`) gets the facilitator side: do it on the
  projector first; it is the moment any between-session fix lands;
  expect `Nothing to do` most weeks; if the room has no internet, it says
  so and the session proceeds.
- `curriculum/README.md` "Rules that cross sessions": every session from
  Session 2 opens with `course-update` in both the prework and the first
  line of `EXERCISES.md`; Session 1 is exempt (no terminal before Session
  2, DEC-004). `handouts/terminal-card.md` lists the command.
- `setup/README.md`: a short "Later: getting updates" note and a
  troubleshooting row; `setup/PRE_COHORT_CHECKLIST.md`: bumping
  `ENV_VERSION`/pins is how a fix is published, and the checklist verifies
  `course-update` from a participant-like machine. `env/DISTRIBUTION.md`
  lists the new URL consumer.
- `docs/trunk/DECISIONS.md`: DEC-012 — updates are distributed by a
  deterministic participant-run command at session start; alternatives
  considered are the Rejected Ideas below.

**Constraints.** Audience floor (DEC-004): output is plain English, no git
or npm vocabulary. No model call, no key needed, seconds when current.
Idempotent. Never touches `~/course-practice`. Same output conventions as
`course-check` (`[ok]`-style lines are fine; one-line verdict at the end).

## Success Criteria

- `course-update` exists in `env/bin/`, ships in `A101_PAYLOAD`, and on an
  up-to-date machine prints the two "up to date" lines and `Nothing to do.`
  in under ten seconds with exit 0, making no changes.
- When the published `ENV_VERSION` is newer, it reinstalls the environment
  payload, `~/.agentic-101/VERSION` and `commit --version` report the new
  version, and the closing line says to close and reopen the window.
- When `setup/pins.env` changes (pi version or model), it re-runs the pi
  installer with `--keep-key --no-check`, the saved key is untouched and
  still works, `pi --version` matches the pin, and no smoke test ran.
- `install-pi.sh --keep-key` without a saved key fails in one plain
  sentence naming Step 3; `--no-check` skips the closing check; both flags
  are in its `--help`.
- With an unreachable base URL it prints the one-line "could not reach"
  message, changes nothing, and exits non-zero.
- Tests: a new `env/tests/test-update.sh` drives all of the above against
  `file://` bases (up to date; env bump; pins bump with stubbed npm/pi;
  unreachable), and `test-install.sh`, `test-commands.sh`,
  `setup/tests/test-setup.sh` still pass.
- `ENV_VERSION` is 1.1.0 and `setup/pins.env` `EXPECTED_ENV_VERSION`
  matches; `setup/README.md` sample output follows.
- Session 2 PREWORK §3 and the top of `EXERCISES.md` say `course-update`;
  the runsheet carries the facilitator side; `terminal-card.md` lists it;
  `curriculum/README.md` states the cross-session rule; DEC-012 is
  recorded; `ve validate` passes.

## Rejected Ideas

### A "sync up" prompt to pi at the start of every exercise set

Once a participant has pi working, they could type "pull the latest course
updates" into pi and let it run the installers.

Rejected (for now) because: (1) Session 2 uses `commit` in exercise 2,
before pi is opened in exercise 3, so the update lands too late for the
case that prompted this; (2) it is a broad delegation the participant
cannot evaluate, made at the moment the course is teaching the judgment
boundary and (in Session 4) scoping — and it models `curl | bash` by an
agent; (3) it is nondeterministic where determinism matters — "pull the
latest updates" could plausibly become `git pull` in `~/course-practice`,
which is the checkpoint repo the safety net depends on. Operator's stated
boundary: revisit if a long tail of environment divergence makes a
scripted solution infeasible — that is where pi's flexibility would earn
its place.

### Fold updating into `course-smoke-test`

Rejected because: the smoke test calls the model and takes minutes; the
update must take seconds, need no key, and be safe to run in a room with
a flaky connection. Keeping them separate also keeps "is my setup
healthy?" and "am I current?" as two questions with two one-word answers.

### Auto-update inside `commit` / `revert`

Rejected because: a recovery tool must never depend on the network or
change itself in the middle of being used.

### Tell participants to re-run Step 1 of the setup guide

What the 2026-08-22 fix had to fall back on. Rejected as the standing
answer because: it is a multi-minute installer in a different shell
(PowerShell on Windows), it needs the facilitator to announce it, and it
is not something a participant will do unprompted at the start of a
session.
