---
status: IMPLEMENTING
ticket: null
parent_chunk: null
code_paths:
- curriculum/README.md
- curriculum/session_03_anatomy_of_a_delegation/README.md
- curriculum/session_03_anatomy_of_a_delegation/PREWORK.md
- curriculum/session_03_anatomy_of_a_delegation/FACILITATOR_GUIDE.md
- curriculum/session_03_anatomy_of_a_delegation/EXERCISES.md
- curriculum/session_03_anatomy_of_a_delegation/EXERCISE_RUNSHEET.md
- curriculum/session_03_anatomy_of_a_delegation/PRACTICE.md
- curriculum/session_03_anatomy_of_a_delegation/CHECKPOINT.md
- curriculum/session_03_anatomy_of_a_delegation/FLOOR_TEST.md
- curriculum/session_03_anatomy_of_a_delegation/DRY_RUN.md
- curriculum/session_03_anatomy_of_a_delegation/handouts/delegation-brief.md
- curriculum/session_01_mental_models/handouts/toil-inventory.md
- curriculum/session_01_mental_models/handouts/canned-toil.md
- docs/trunk/SPEC.md
code_references: []
narrative: null
investigation: null
subsystems: []
friction_entries: []
depends_on: []
created_after: ["onboarding_course_update"]
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

`curriculum/session_03_anatomy_of_a_delegation/` owns Session 3 of the
fluency arc — "Anatomy of a delegation" — as the full session anatomy
defined in SPEC.md and the directory convention in `curriculum/README.md`
(DEC-010 as amended by DEC-011): `README.md`, `PREWORK.md`,
`FACILITATOR_GUIDE.md`, `EXERCISES.md` (participant-only),
`EXERCISE_RUNSHEET.md` (facilitator-only), `PRACTICE.md`, `CHECKPOINT.md`,
plus `FLOOR_TEST.md` and `DRY_RUN.md` (the steps execute, so they are
executed from their written instructions before they are taught). It owns
one new cross-session handout, `handouts/delegation-brief.md` — the
one-page form of a delegation (inputs, instruction, outputs, checkpoints)
that Session 4 extends into a workflow and Session 6 gates the capstone
design on — and it extends Session 1's `handouts/canned-toil.md` in place
with a "For Session 3" section. The session is 90 minutes in the shape of
Sessions 1–2.

**This is the session where a delegation stops being a sentence and
becomes a structure.** Session 2 proved participants can hand an agent
work and read what it did; Session 3 teaches *why the ones that went badly
went badly* and how to write instructions that survive contact with the
agent. Its teaching spine:

1. **Open on the near-misses, not on new material.** Participants arrive
   with a `what-did-it-do.md` worksheet on their worst practice-week
   delegation and one sentence about it (Session 2 `PRACTICE.md`, "Bring
   to Session 3"). The first ten to fifteen minutes go round the room on
   those sentences. The facilitator sorts them live into the three reasons
   a delegation goes wrong — **it didn't know something** (a missing
   input), **it decided something** (an unstated choice the agent made),
   **I couldn't tell** (no check that would have caught it) — and that
   sorting *is* the anatomy the session then names. Session 2's checkpoint
   obligates this opening when its own round went badly ("open it with the
   worksheets rather than with new material … using the sessions still
   sitting on people's laptops, `pi -r` finds them"); on a good Session 2 it
   is still the opening, because a room full of near-misses is the
   material.
2. **The anatomy, named from their examples.** A delegation is four
   things: **inputs** (what the agent must be able to see — files, facts,
   the thing it will otherwise guess), **the instruction** (what "done
   right" looks like — column 2 of the toil inventory, now made precise
   enough to act on), **outputs** (what done produces, and where), and
   **checkpoints** (where you will look, and what for — column 4 of the
   inventory, turned into a step rather than a hope). SPEC.md's definition
   is quoted verbatim: a **delegation** is "handing a task to an agent with
   enough structure that it completes without step-by-step supervision";
   "enough structure" is the four parts. Each of the three near-miss
   reasons maps to a missing part, which is how the opening pays off.
3. **Write it down, then run it.** The exercise block: each participant
   writes a **delegation brief** (the new handout) for one real inventory
   entry — the one they delegated worst, or a fresh `in` entry that passes
   Session 2's four-question gate — runs it in `~/course-practice`
   (`commit` → `pi` → check → `commit`, the loop from Session 2), compares
   what happened against the brief box by box, revises the brief *once*
   for a reason they can name, and runs it again. The canned fallback is
   Priya's tasks with pre-written briefs in `canned-toil.md`, one of them
   deliberately under-specified so the fallback path meets the same
   near-miss the real-task path does.
4. **"What would I have failed to catch?"** — exercise 4, promised by name
   in Session 2 ("that's exercise 4 of Session 3, arriving early"). Each
   participant names the failure their checkpoint would *not* detect, and
   either adds a second checkpoint to the brief or rules the task out as
   outside their judgment boundary. This is Session 1's judgment boundary
   turned into a design step, and it hands Session 4 its subject: where to
   concentrate judgment, and which failure modes to guard against.
5. **Checkpoint.** Every participant leaves with one brief that ran twice,
   the second run better than the first *for a reason they can name*, and a
   written answer to "what would I have failed to catch". Observable on
   paper and in `~/course-practice`.

### Why

The project GOAL's fluency success criterion asks that a non-programmer
can, unaided, "decompose a real task into an agent-runnable workflow with
judgment concentrated at the checkpoints that matter, and articulate the
failure modes to guard against." Session 3 owns the decomposition half —
one task, one delegation, its four parts — and deliberately stops short of
workflows, leverage and repeatability, which SPEC.md assigns to Session 4.
The near-miss opening exists because Session 2's practice was designed to
produce exactly one bad delegation per participant; a session that
explained the anatomy first and looked at their examples second would
waste the best material the course has ever had in the room.

### What the implementing agent needs to know

**The shape to copy.** `curriculum/session_02_meeting_the_harness/` is the
template for every file: README with the artifact table and the
from/to-later-sessions tables; FACILITATOR_GUIDE with "Before the room",
a minute-level **Timing** table with a 60-minute variant and cutting rules,
beats, the anticipated-failure table, and the FAQ; EXERCISES.md in second
person with "What you should see" and fallbacks; EXERCISE_RUNSHEET.md with
**What participants do / Say it like this / Observable output / misfires /
Fallback** per exercise and "Steps: `EXERCISES.md`, exercise N" instead of
restated steps (DEC-011 — the runsheet never restates a step); PRACTICE.md
with the time-budget table, displacement framing, "Bring to Session 4",
and "If the week gets away from you"; CHECKPOINT.md with the observable
round, the pass/near-miss discrimination, the private recovery path, the
tally table, and "What this checkpoint feeds"; FLOOR_TEST.md and DRY_RUN.md
as in Session 2 (`DRY_RUN.md` records real runs of every agent step, at
least twice each, on the pinned pi — `setup/pins.env` `PI_VERSION`/
`PI_MODEL` — with honest limits; Windows recorded as not run if not run).
Read `docs/chunks/fluency_session_02/GOAL.md` and `PLAN.md` for how that
session was specified and built; the voice source is `pi-learning-paths.md`
at the repo root.

**What Session 2 already promised about this session** (honor every one):
- Opens from the practice-week worksheets and the "one sentence about the
  one that went worst" — asked for "in the first ten minutes" (S2
  `PRACTICE.md`, "Bring to Session 3").
- Assumes every participant can run a delegation unaided and read its
  tool calls; S2 `CHECKPOINT.md` names the recovery if that failed
  room-wide (fifteen minutes on "what did yours actually do" using `pi -r`)
  and the tally table Session 3 is "planned from" — the facilitator guide's
  "Before the room" reads that tally.
- "What would you have failed to catch?" is exercise 4 (S2 runsheet,
  exercise 4 early-finisher question).
- Participants bring: the worksheet, the toil inventory with ticks, the
  sentence. PRACTICE.md told them "if the task turns out to be a bad fit …
  write down what was missing. It's the most useful thing you can bring."
- Vocabulary quoted verbatim from SPEC.md Terminology so Sessions 3–5
  share words: *delegation*, *judgment boundary*, *harness*, *agent*.
  Session 3 adds *delegation* as its word; *workflow* and *leverage* are
  Session 4's and are mentioned only as "next time".

**The new handout — `handouts/delegation-brief.md`.** One printable page,
lowercase-hyphenated filename per `curriculum/README.md`. Four boxes in
this order, each with a one-line prompt and a filled-in example row:
**Inputs** ("What must it be able to see? Name the files and facts. If
it can't see it, it will guess."), **Instruction** ("What does done right
look like? Column 2 of your inventory, made precise: one sentence it can
act on."), **Outputs** ("What does done produce, and where?"),
**Checkpoints** ("Where will you look, and what for? Column 4 of your
inventory, as a step you will actually take."), plus a fifth line at the
bottom: **What would I have failed to catch?** (filled in exercise 4). The
handout states it is owned by Session 3 and used by Sessions 4 and 6,
mirrors the toil inventory's "How this sheet is used later" table, and
adds a **Session 3** row to the toil inventory's own usage table
(`session_01_mental_models/handouts/toil-inventory.md`, the "How this
sheet is used later" table — edit in place, never fork; the inventory's
rule is that later sessions may add a row or column but not rename the
four). The brief's instruction box is column 2 of the inventory and its
checkpoints box is column 4 — say so on the page, so the inventory is
visibly the source.

**The fallback — `canned-toil.md` "For Session 3".** Extend Session 1's
handout in place (cross-session rule) with a section shaped like "For
Session 2": two or three of Priya's tasks with pre-written briefs, one of
them deliberately missing an input so a canned-set participant hits a real
near-miss in exercise 3's first run and fixes it in the revision. No
answer key for exercise 4. Session 2's three neutral synthetic options
stay as they are.

**Constraints the implementing agent must honor.**
- Audience floor (DEC-004): no code, no programming vocabulary, no
  "prompt engineering". The word is *brief*, the frame is delegating to a
  colleague who cannot see your screen.
- Every capability demo is paired with "how would you check this"
  (DEC-005). The brief's checkpoints box is that rule made into a form.
- The environment is fixed and shipped (DEC-006–DEC-009): `~/course-practice`,
  pinned pi and model, `commit`/`revert`. Any claim about pi's behavior
  comes from `docs/chunks/onboarding_setup_guide/pi-reference.md` (verify
  `pi -r`, `pi -c`, `/quit`, `Ctrl+O`, `Escape` there before writing them).
- `course-update` opens the session (DEC-012): PREWORK's run-the-commands
  step says `course-update` (the smoke test is not needed again unless the
  facilitator asks for it), `EXERCISES.md` starts with the "Before exercise
  1" paragraph, and the runsheet carries the facilitator side — copy the
  Session 2 wording.
- Real-task use is governed by Session 2 `PRACTICE.md`'s four-question gate
  (evaluable / authorized / appropriate and non-consequential /
  human-approved before external action) and its "it does, you decide"
  example; Session 3's PRACTICE links to it and restates it in one line
  rather than copying it. In-room exercises use invented data or the
  participant's described shape, as Session 2 did.
- Nondeterminism is taught, not hidden (TESTING_PHILOSOPHY.md): the
  facilitator guide scripts the surprising-agent moment as the best thing
  that can happen, and the runsheet's misfires include the agent doing the
  right thing despite a bad brief (which is the hardest case to teach
  from — say so).
- Setup triage is lighter than Session 2's but not absent: a one-line
  "who did `course-update` say *Nothing to do* to?" and pairing for anyone
  whose environment is broken; the session proceeds on time.
- Timing: 90 minutes, 60-minute variant, cutting rules that protect the
  opening and exercise 4 and cut *within* the run-revise-run block.
- `curriculum/README.md`'s session table gains the Session 3 row and
  SPEC.md's Curriculum Structure item 3 is marked settled with a one-
  paragraph summary in the style of items 1 and 2; Session 2's README
  "To later sessions" row for 3 stays true.

**PRACTICE (≤90 min, displacement-shaped).** Run the brief on the real task
twice in the week (the second time after revising it), keep the brief and
the worksheet, and bring the brief to Session 4 — where it becomes the
first step of a workflow. Optional: write a brief for an **out** entry and
notice which box you cannot fill. "Bring to Session 4" names the brief, the
inventory, and one sentence on what the second run caught that the first
did not.

**CHECKPOINT.** Observable: a brief that ran twice (the two `commit`
names in `revert --list` are the evidence on disk), a named reason the
second run was better, and a written "what would I have failed to catch".
The tally table Session 4 is planned from: brief written / ran twice /
named the improvement / named the miss / note.

## Success Criteria

- All seven required files exist per `curriculum/README.md`, plus
  `FLOOR_TEST.md` and `DRY_RUN.md`; content conforms to SPEC.md's Session
  Anatomy; `EXERCISES.md` is participant-only and `EXERCISE_RUNSHEET.md`
  facilitator-only per DEC-011 (the audience-purity checks from
  `docs/chunks/fluency_exercise_split/PLAN.md` Step 5 pass).
- `handouts/delegation-brief.md` exists with the four boxes, the fifth
  line, a filled example, and the ownership/usage statement; the toil
  inventory's usage table has a Session 3 row; `canned-toil.md` has a
  "For Session 3" section with at least one deliberately under-specified
  brief; Session 2's synthetic options are untouched.
- The session opens from the practice-week worksheets and sentences,
  names the three near-miss reasons, and maps each to a missing part of
  the brief; "what would I have failed to catch" is exercise 4.
- Every exercise operates on the participant's own inventory entry where
  possible, with the canned fallback taking the same time and producing
  the same artifact.
- PREWORK ≤30 minutes, opens with `course-update`, and works for someone
  who did only Session 2's solo lap; PRACTICE ≤90 minutes, displacement-
  shaped, links the four-question gate, names what to bring to Session 4.
- CHECKPOINT is observable: a brief that ran twice, a named improvement,
  a written miss; tally table present; recovery paths private; "what this
  checkpoint feeds" names Session 4 and the capstone.
- FACILITATOR_GUIDE is sufficient for a facilitator who did not author it:
  reads Session 2's tally, 90-minute timing with 60-minute variant and
  cutting rules, the near-miss sorting move scripted, anticipated failures
  (the agent gets it right despite a bad brief; a participant's worst
  delegation was outside their boundary; nobody brought a worksheet), FAQ.
- `DRY_RUN.md` records real runs of every agent step from the written
  instructions, at least twice each, on the pinned pi and model, including
  the under-specified canned brief producing a visible near-miss at least
  once; honest limits recorded (Windows, TUI keys).
- `curriculum/README.md` session table and SPEC.md item 3 updated to
  settled; Session 2's forward references to Session 3 remain true;
  `uvx --from vibe-engineer ve validate` passes and all relative links
  under `curriculum/` resolve.

## Rejected Ideas

### Teach workflows and leverage in Session 3

Decomposition naturally wants to continue into "and then chain them".

Rejected because: SPEC.md assigns repeatable workflows, failure modes and
concentrating judgment at the checkpoints that buy the most leverage to
Session 4. Session 3 is one delegation, anatomised. Stopping there is what
lets Session 4 open with "you already have a brief — now make it run
every week."

### Extend the toil inventory with new columns instead of a new handout

The inventory rule allows later sessions to add columns, so inputs and
checkpoints could be columns 5 and 6.

Rejected because: a brief is a per-delegation document (it is revised and
re-run), not a per-task row; the inventory has to stay fillable with a pen
in a room in ten seconds; and Session 4 and the capstone need a document
they can extend into a workflow, which a row cannot carry. The brief
visibly *draws* from columns 2 and 4 instead.

### A Session-3-only worksheet, deciding later whether Sessions 4–6 adopt it

Rejected because: Sessions 4 and 6 would then either fork a second
template or retrofit this one; owning it from Session 3 (as Session 1 owns
the inventory) gives it one home and one usage table.

### Reuse Session 2's synthetic tasks as the only fallback

Rejected because: they have no built-in near-miss, so a canned-set
participant would never meet the session's central experience. Priya's
tasks with one deliberately under-specified brief do.

### Make it 120 minutes to fit two full runs plus discussion

Rejected because: the 90-minute shape is a cross-session contract with
cohorts' calendars (DEC-002); the exercise block cuts within the
run-revise-run loop rather than dropping the opening or exercise 4.

### Teach "prompt engineering" techniques

Rejected because: it names the wrong skill (DEC-004, DEC-005). The session
teaches what a colleague who cannot see your screen needs to be told, in
the participant's own words; the brief's four boxes are the whole
technique.
