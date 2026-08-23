

<!--
This document captures HOW you'll achieve the chunk's GOAL.
It should be specific enough that each step is a reasonable unit of work
to hand to an agent.
-->

# Implementation Plan

## Approach

Two new files under `platform/index/`, a surgical manifest edit, and two
documentation edits. Nothing in `curriculum/` is touched: the session
READMEs keep doing the job they were written for (an author's and a
facilitator's index — artifact table, teaching spine, constraints on
edits, the from/to-session tables), and the platform stops handing them to
students.

The index is a **derivative**, in the sense `platform/README.md` already
uses: a file written *from* `README.md` and `PREWORK.md`, in the course's
voice, addressed to the student. It is the same relationship the audio
script has to the concept prose, and it lives in the same place — under
`platform/`, not in the session directory. That location was decided at
narrative time (GOAL, "Location decision"): an eighth fixed file in
`curriculum/session_NN_*/` would amend DEC-010/DEC-011's fixed set for a
concern only one delivery has, and would leave every future session owing
a file the room never reads.

What goes in each index, and where it comes from:

| Section | Source |
|---|---|
| What the session is for, and its outcome | `README.md`'s **Outcome** line and opening paragraph, re-addressed to "you" |
| What you will do | `README.md`'s teaching spine (the *why*) plus `EXERCISES.md`/`PRACTICE.md`'s arc (the *what*), in prose rather than a mirrored list |
| What it costs | `module.yaml`'s `estimated_minutes` — Contract v1.1 figures: S1 concept 30 / lab 92, S2 concept 25 / lab 125, both lab figures including the practice week |
| What you need first | `PREWORK.md` parts 2–3 and the setup gate, reconciled for a student with no facilitator to email |
| What you hand in | `module.yaml`'s `artifacts` for the session, described in the student's words |

What is deliberately absent: the artifact table (it links
`FACILITATOR_GUIDE.md`, `EXERCISE_RUNSHEET.md`, `FLOOR_TEST.md`,
`DRY_RUN.md` — documents the platform withholds), "Constraints on edits"
(addressed to an author), the teaching-spine numbering as such (an
argument about session design, not something a student needs), and the
"What downstream sessions take from here" / "What this session takes"
tables (course-architecture bookkeeping).

**The transcription rule applies.** The index may not say anything its
sources do not — the same rule `platform/README.md` states for rubrics
("a change to a session's bar or its near-miss table is not finished until
the rubric has been re-read") and for lab parts. Two consequences for how
this is written: the minutes are quoted from the manifest rather than
recomputed, and the index does **not** enumerate lab parts or exercise
numbers, because every enumerated fact is a fact that can drift silently.
It describes the arc; the platform presents the parts from `lab.parts`,
which is where that structure already lives.

**Backreference comments are safe here, and this was verified rather than
assumed** (GOAL success criterion 1). The platform strips HTML comments in
both consumption paths before anything reaches a student:
`src/markdown/render.ts#stripHtmlComments` runs before parsing on the
rendered-text path (its comment names agentic-101's `README.md`
backreferences as the reason it exists), and `src/audio/normalize.ts`
strips them too, inside `speakable()`. So the index files carry a normal
`<!-- Chunk: … -->` line; the audio scripts' "attribution goes in the
table instead" workaround is not needed.

**Path acceptance was verified before writing anything** (GOAL, "Location
decision"): `src/contract/manifest.ts` reads `concept.sources` as plain
strings and `src/contract/validate.ts` only requires each one to exist in
the module's file map. There is no path prefix rule, so
`platform/index/…` under `concept.sources` is legal. The GOAL's fallback
(a student-safe rewrite of the READMEs) is therefore not needed.

### Ordering in `concept.sources`

The index goes **first**, before `PREWORK.md`. The platform renders concept
sources in manifest order, and a student alone at 9pm meets the question
"what is this and what will it cost me?" before the reading. In the room
the README is the facilitator's entry point and the prework is what goes
out first; on the platform there is no facilitator, so the index leads. A
comment in the manifest records that.

### Concurrency

`docs/trunk/PLATFORM_AUTHORING.md` and `platform/README.md` are being
edited by sibling chunks of the same narrative in the same wave. Edits
here stay inside the sections this chunk owns:

- PLATFORM_AUTHORING: the "How the platform consumes a session" table, the
  consequence paragraph that follows it, and the known-gaps bullet about
  session READMEs. **Not** "A new session, in order" (that section belongs
  to `platform_dual_authoring` this wave) and **not** "Design for the
  student who is alone" (`platform_solo_labs`).
- platform/README.md: the "What is in here" file table, and the
  backreference comment block at the top.
- module.yaml: `concept.sources` for both sessions, plus the header
  comment sentence that says README is concept material — which this
  chunk makes false and therefore owes.

## Subsystem Considerations

- **docs/subsystems/session_anatomy** (DOCUMENTED): this chunk USES the
  pattern and deliberately does not extend it. The subsystem's hard
  invariant is the fixed seven-file set whose names never vary by session;
  the student index is a `platform/` derivative precisely so that
  invariant is left alone. No deviation to record, and no entry in the
  subsystem's `chunks` — the anatomy is unchanged.

## Sequence

### Step 1: Verify the contract accepts `platform/index/` (done at planning time)

Read `src/contract/manifest.ts` and `src/contract/validate.ts` in
`../learning-platform`; confirm `concept.sources` entries are validated for
existence only. Record the finding in this plan. **Result: accepted, no
path restriction.** The baseline validator run over this worktree before
any edit is clean (2 sessions, 0 warnings), so anything it reports later
is this chunk's.

### Step 2: `platform/index/01_mental_models.md`

One page, student voice, second person, no links to withheld documents and
no author-facing sections. Opens with a `<!-- Chunk: … -->` backreference.
Sections: what this session is (and that it needs no software), the
outcome as the student's own; what it costs (concept 30, lab 92 including
the practice week, said plainly); what you will do, concept then lab; what
you need before you start, including the note that the prework's "reply to
your facilitator" has no self-paced equivalent — the smoke test is the
setup answer and the material choice is simply yours; what you hand in
(the inventory sheet, annotated, with real checks on the `in` rows; and
the spoken-or-written boundary claim about one task); what happens next.

### Step 3: `platform/index/02_meeting_the_harness.md`

Same shape, from Session 2's README and PREWORK. Extra content this
session's index owes: that this is the session the working environment is
actually needed for and how the student confirms it (`course-update`, then
`course-smoke-test` printing PASS); the model-provider note the prework
carries (invented data only); what the four things to hand in are (the pi
session log, the what-did-it-do worksheet, the `revert --list` output, and
the practice folder's files) and why the `revert --list` output is asked
for at all — a course command leaves no trace in the session log. Costs:
concept 25, lab 125 including the practice week.

### Step 4: `platform/module.yaml`

For session `01_mental_models` and session `02_meeting_the_harness` only:
replace the `curriculum/…/README.md` line in `concept.sources` with the
session's index path, placed first, and add a short comment saying what
the index is and why README is no longer there. Update the header
comment's audience sentence ("PREWORK and README are concept") to the
truth, and add this chunk's backreference to the header block. Touch
nothing else — `lab`, `parts`, `artifacts`, `ta_knowledge` and the
estimates are other chunks' this wave.

### Step 5: `docs/trunk/PLATFORM_AUTHORING.md`

- Split the first row of "How the platform consumes a session": `PREWORK.md`
  keeps the concept-track cell; `README.md` gets a row saying the platform
  does not serve it and names `platform/index/<NN>_<slug>.md` as what it
  serves instead; the index gets its own row as a thing the author writes.
- Replace the "**Session `README.md` files are student-visible**"
  consequence with the rule this chunk establishes: **a served session owes
  a student index**, it is part of the session's platform version alongside
  the rubric, recall prompts and script, and the README stays the author's
  and facilitator's. Keep the underlying warning that anything listed in
  `concept.sources` is read by a student alone at 9pm.
- Delete the known-gaps bullet about session READMEs reaching students
  unedited; it is what this chunk closes. Leave the other two bullets
  alone.

### Step 6: `platform/README.md`

Add an `index/*.md` row to the "What is in here" table, describing it as
each session's student-facing index and saying that it is what
`concept.sources` lists in place of the session's `README.md`. Add this
chunk's backreference comment to the block under the title.

### Step 7: Validate

- `pnpm contract:validate <this worktree>` from
  `/Users/btaylor/Projects/learning-platform` — must be clean, same as the
  baseline.
- `uvx --from vibe-engineer ve validate` — must pass with no new warnings
  (baseline: one pre-existing `platform_solo_labs` ↔ `session_anatomy`
  warning, another chunk's).
- Read both index files start to finish as a student would, checking for
  the failure this chunk exists to prevent: a sentence addressed to
  somebody other than the student.
- `grep` the two index files for `FACILITATOR`, `RUNSHEET`, `FLOOR_TEST`,
  `DRY_RUN`, `CHECKPOINT` — none should appear.

### Step 8: Update `code_paths` in GOAL.md and commit

## Dependencies

None that block. Contract v1.1 (`platform_lab_parts`, commit f29a15b) has
already landed on this branch, which is where the `estimated_minutes` the
indexes quote come from.

## Risks and Open Questions

- **Drift.** The index is now a fourth derivative per session, and every
  number in it (30/92, 25/125) restates the manifest. Mitigated by keeping
  quantities to the two the manifest owns, naming no exercise numbers or
  part titles, and stating the transcription rule in PLATFORM_AUTHORING so
  the obligation is written down rather than remembered.
- **Merge conflicts** with the two sibling chunks editing the same two
  documents. Mitigated by section discipline (see Approach) and by
  reporting, rather than fixing, the stale sentences that live in their
  sections.
- **`PREWORK.md` is still facilitator-shaped in places.** Session 1's part
  3 and Session 2's part 3 both say "reply to your facilitator", and
  PREWORK stays in `concept.sources` — this chunk's scope is the README
  swap. The index absorbs the worst of it with an explicit note; the
  residue is a handoff, not a silent gap.

## Deviations

- **Steps 5 and 6 were narrowed while `platform_dual_authoring` was still
  in flight, then finished once it landed.** `platform/README.md` §
  "Adding a session" and `docs/trunk/PLATFORM_AUTHORING.md` § "A new
  session, in order" both owe the index a line, and both were being
  rewritten in the same wave by that chunk (the `platform/drafts/`
  convention). Editing them concurrently would have collided, so the first
  commit left them alone and recorded the handoff here. `main` then merged
  `platform_dual_authoring`; merging it into this branch made the two
  sections safe to touch, and both were done in the merge commit:
  "Adding a session" gains a step for writing the student index, and step
  1 of "A new session, in order" no longer asks for a "student-safe
  README" — it says the README stays the author's and the facilitator's
  and points at the index in step 2. `platform_dual_authoring` had already
  anticipated the index in its drafts table (`index.md` →
  `index/<NN>_<slug>.md`) and in step 2 of the four-step flow, so those
  needed nothing.
- **A stale known gap was found and left alone.** PLATFORM_AUTHORING's
  known-gaps bullet saying HTML comments in a listenable script are spoken
  by the voice is no longer true: `../learning-platform`'s
  `src/audio/normalize.ts#speakable` strips them before anything reaches
  TTS (committed 2026-08-22, after the gap was written). The same function
  is what makes this chunk's backreference comments safe. It is not this
  chunk's bullet to edit — `platform/README.md` states the same rule in a
  paragraph another chunk owns — so it is reported rather than fixed.
- **Two sentences in the Session 1 index were rewritten after a first
  draft transcribed the room's assumption.** The room's README and prework
  both reassure a participant whose setup failed that Session 1 costs them
  nothing; on the platform the setup rubric gates Session 1, so a student
  reading the index has already passed the smoke test. The index now says
  so instead.
