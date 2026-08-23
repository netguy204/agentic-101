# Implementation Plan

## Approach

Session 3's platform version is a **transcription**, not new material. Every
file below is derived from documents that already exist in
`curriculum/session_03_anatomy_of_a_delegation/`, and the rule that governs
each one is already written down: `platform/README.md` § "The rules" for the
rubric, the parts and the script; `docs/trunk/PLATFORM_AUTHORING.md` §
"A new session, in order" step 2 for the order of the work; and
`platform/README.md` § "Drafting a session before it is served" for where it
lands and what promotion will be.

Two things make this chunk different from Sessions 1 and 2's transcriptions:

1. **Nothing here is validated.** `module.yaml` is the only file the platform
   knows the name of, so a file under `platform/drafts/` is invisible to
   `pnpm contract:validate` and to ingest — probe-verified in
   `docs/chunks/platform_dual_authoring/PLAN.md` § Step 1 and re-verified
   here. Every check the validator would have run is therefore run by hand
   and its result recorded in a comment beside the thing it checked: part
   anchors slugged and matched against the real headings, deterministic
   phrases grepped against the files that print them, segment word counts
   measured.
2. **The manifest fragment is Contract v1.1.** `lab.parts[]` did not exist
   when Sessions 1 and 2 were first transcribed; it does now, so the fragment
   is written with parts from the start and `estimated_minutes.lab` is their
   sum with the practice week inside it.

The worked examples followed throughout are Session 2's, because Session 3 is
the same shape of session: `platform/rubrics/02_meeting_the_harness.yaml`
(criterion comments naming the sentence of the bar, near-miss rows verbatim,
`text.contains_all` on pasted `revert --list` output),
`platform/audio/02_meeting_the_harness.md` (why in the script, how on the lab
card), `platform/index/02_meeting_the_harness.md`, and Session 2's
`sessions:` entry in `module.yaml` for the fragment and its parts.

**Testing.** `docs/trunk/TESTING_PHILOSOPHY.md` puts this material under
documentation review rather than automated test; the executable checks
available are `uvx --from vibe-engineer ve validate` (reference integrity)
and `pnpm contract:validate` from `../learning-platform`, which must stay at
two sessions and zero warnings — a clean run *with* the draft present being
the evidence that the draft is invisible and `module.yaml` untouched. The
per-artifact checks the validator cannot reach are run by hand (below) and
their commands recorded in this plan so a later reader can re-run them.

## Sequence

### Step 1: Re-verify that the drafts directory is invisible

Run `pnpm contract:validate /Users/btaylor/Projects/agentic-101` from
`../learning-platform` before creating anything, and again at the end. Both
runs must report two sessions and zero warnings.

### Step 2: Freeze the strings the rubric will quote

Grep, and record the line numbers in rubric comments:

- the four box headings in
  `curriculum/session_03_anatomy_of_a_delegation/handouts/delegation-brief.md`
- the checkpoint names `before run 1`, `after run 1`, `after run 2` in
  `EXERCISES.md` (steps 3, 6, 11) and the *Back to* line in its
  "What you should see"
- `Back to: $target_name` and `Your checkpoints, newest first:` in
  `env/bin/revert`

### Step 3: Slug every heading a part will anchor at

Reimplement the platform's `slugify` (`src/contract/validate.ts`) and run it
over `EXERCISES.md`, `PRACTICE.md` and `FACILITATOR_GUIDE.md`, so the
anchors in `session.yaml` are matched against real headings the way the
validator will match them at promotion.

### Step 4: `session.yaml` — the manifest fragment

One `sessions:` entry, Contract v1.1. Concept sources are the student index
then `PREWORK.md`; lab sources are `EXERCISES.md` and `PRACTICE.md` with
`handouts/`; six parts (three in-session, three practice) with minutes from
`EXERCISE_RUNSHEET.md`'s block headings and `PRACTICE.md`'s time budget;
four artifacts including the carry-forward `worst_delegation`;
`ta_knowledge` per the README's rule, with `CHECKPOINT.md` absent.

### Step 5: `rubric.yaml` — transcribed from `CHECKPOINT.md`

Four criteria in the checkpoint's order, split its way ("the first and
second are facts you can see; the third and fourth are the ones you have to
hear"). All six near-miss rows verbatim with their corrective questions. The
both-runs-required decision recorded in a comment sourced to the
second-run-deferred clause.

### Step 6: `audio.md`, then `recall.yaml`

Four segments — the three reasons; the four boxes and the colleague who
cannot see your screen; find the box, change it once, run again; the
boundary found by experiment. Mechanics to `> Lab card:` lines. Each segment
450–900 words, measured with the platform's own word count, and closing with
its `> Recall:` id.

### Step 7: `index.md` — the student's index

The shape `platform_student_index` set: outcome → what it costs → what you
will do → before you start → what you hand in → what comes next, with the
minutes quoted from `session.yaml`.

### Step 8: `README.md` — the promotion note

What promotion is, that it waits on `FLOOR_TEST.md` (results PENDING), and
what a promoter should expect the first validator run to catch.

### Step 9: Verify

Word counts, anchors and quoted strings re-checked; `ve validate`;
`pnpm contract:validate` again; a dry read of the promotion note against the
draft's contents.

## Dependencies

`platform_dual_authoring` (the drafts convention and DEC-013),
`platform_solo_labs` (the exercise text this is written against),
`platform_student_index` (the index shape). All three are ACTIVE.

## Risks and Open Questions

- **The draft is unverified by construction.** Anything the by-hand checks
  miss surfaces at promotion. Mitigated by reimplementing the validator's own
  slug and word-count functions rather than eyeballing.
- **The floor test has not run.** If it rewords a bar item, a handout heading
  or an exercise heading, the rubric and the parts are re-derived then. That
  is the point of drafting rather than serving, and the promotion note says
  so.

## Deviations

- **Step 4, `estimated_minutes.lab` is 110, not the "~113" the goal
  estimated.** The number is the sum of the parts, and the parts are sourced:
  58 minutes of exercises plus the runsheet's 2-minute wrap is 60, and
  `PRACTICE.md`'s time budget is 20 + 20 + 10 = 50 required minutes. Its
  fourth row (15 minutes, brief an `out` entry) is marked *Optional* on the
  page, so counting it would put a number in front of a student that the
  student's own practice sheet calls optional. 60 + 50 = 110.
- **Step 4, six parts rather than the goal's three-way cut.** The goal's
  "sentence-and-sort + the brief / the two runs / box 5 + practice" is the
  in-session cut and is followed exactly for the first three parts. The
  practice week cannot ride along inside part three: `PRACTICE.md` is a lab
  source, and the validator warns when a lab source no part names, so the
  practice week is three parts of its own — one per numbered item of its time
  budget, which is what Sessions 1 and 2 both do.
- **Step 9 gained a dry promotion.** Verifying a draft that nothing reads by
  reimplementing the validator's checks in Python proves only that the
  reimplementation agrees with itself. So the whole promotion was rehearsed
  in a scratch copy of the repository (`git ls-files` into `/tmp`, the five
  moves, the fragment pasted under `sessions:`, the draft directory removed)
  and the *real* validator run against it: three sessions, zero warnings.
  That is the success criterion "promotion would require no authoring",
  executed rather than read. It does not make the draft verified — the copy
  is a rehearsal and the run that counts is the one after the floor test's
  changes land — and the draft's own `README.md` says so.
- **Step 8 gained a promotion handoff.** Session 2's `where_am_i` part in
  `module.yaml` carries a comment calling itself "the one part in either
  session that opens at the top of its document". Session 3's first part
  opens the same way for the same DEC-012 reason, so at promotion that
  comment needs a word changed. `module.yaml` is not this chunk's to touch,
  so the promotion note flags it under step 2 rather than leaving it to be
  found cold.
- **`platform/README.md` § "What is not here yet" was edited.** Not in the
  original file list. That section said Session 3 "exists in `curriculum/`
  with a complete checkpoint" and then advised the reader to look in
  `drafts/` before concluding a session has no platform version — advice
  that this chunk made answerable. Leaving it would have made the
  directory's own map the last place to learn the draft exists.
