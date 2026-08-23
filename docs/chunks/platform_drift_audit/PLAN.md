# Implementation Plan

## Approach

This chunk is an audit, so most of the work produces a *record* rather than a
diff. The deliverable is `FINDINGS.md` in this chunk directory: one row per
thing a deterministic check quotes, per rubric criterion, per lab part, per
recall prompt — each with the command that verified it and the verdict. The
next material change should be able to re-run the table.

Three rules govern what may be touched, and they come from
[`platform/README.md`](../../../platform/README.md) rather than from this
plan:

1. `CHECKPOINT.md` is the source; the rubric is a transcription and may not
   say anything the checkpoint does not.
2. A lab `part` is a transcription too, and its `#anchor` is load-bearing:
   the session page opens the part at that heading.
3. The audio carries the why; anything a listener would have to look at goes
   out to a `> Lab card:` line. A `$ ` command line, a table or a fence in a
   script is a validator error.

So every fix lands in `platform/` (DEC-010's session files and `env/`,
`setup/` are the source and are read-only here), and the tool of record is the
platform's own validator, run from the sibling checkout before and after:

    cd ../learning-platform && pnpm contract:validate <this worktree>

Because the validator is the same code the platform runs at ingest, a clean
run is the answer and not a rehearsal — but it cannot see the drift this
chunk is about (a rubric quoting a handout header that has since been
reworded parses perfectly), which is why the grep table is the real output.

Testing philosophy: `docs/trunk/TESTING_PHILOSOPHY.md` asks for outcome
checks over process checks. The outcome here is "the string the machine
compares against is the string the file prints", so every verification is a
grep or a scripted substring comparison against the *current* file, recorded
verbatim in FINDINGS.md — not an assertion that somebody read it.

Expected code_paths: `platform/module.yaml`, `platform/audio/02_meeting_the_harness.md`
(plus the chunk's own FINDINGS.md). The rubrics and recall files are expected
to come out unchanged; if they do, that is a result and it is recorded as one.

## Sequence

### Step 1: Establish the baseline

Run the platform validator from `../learning-platform` against this worktree
and record the output verbatim. Read `platform/README.md` end to end first —
its rules, not this plan, decide what counts as drift.

### Step 2: Reconstruct the timeline

`git log` the material (`curriculum/`, `env/`, `setup/`) and the
transcriptions (`platform/`) with timestamps, and establish which of the
2026-08-22 changes actually predate which transcription. The narrative's
premise ("the material changed after the transcriptions were written") is
itself a claim to verify, and the answer decides how much of the audit is
looking for damage versus confirming there is none.

### Step 3: Every quoted string, against the file that prints it

For each deterministic check in the three rubrics, grep the file it reads:

- `01_mental_models.yaml`: `column: In or out of my judgment boundary?`,
  `column: How I'd check`, `table: The sheet` against
  `handouts/toil-inventory.md`; plus the old header (`Could I tell good from
  bad?`) repository-wide to prove nothing stale survives.
- `02_meeting_the_harness.yaml`: `Your checkpoints, newest first:` and
  `Back to:` against `env/bin/revert`; the tool list `[write, edit, bash]`
  against the terminal card's four-tool table.
- `setup.yaml`: all four phrases against `setup/bin/course-smoke-test`'s PASS
  path *and* the sample output in `setup/README.md`, confirming each is from
  a part of its line that interpolates no pin (env 1.1.0 moved the version
  string; a rubric that quoted it would now fail every student).

### Step 4: Rubric beside checkpoint, end to end

Read each rubric next to its `CHECKPOINT.md`. Mechanically confirm every row
of both near-miss tables is present with the facilitator's words, and every
numbered bar item has a criterion. Record the two places where a rubric
deliberately carries something the bar does not state numerically (Session
1's `check_column_filled`, Session 2's `revert --list` evidence) with the
justification each already carries in a comment.

### Step 5: Every path and anchor in the manifest

Script the whole of `module.yaml`: every `curriculum/`, `setup/`, `platform/`
path exists; every `#anchor` (lab parts, `ta_knowledge`) resolves to a real
heading in the file it names. Confirm each session's part minutes sum to
`estimated_minutes.lab`, and read each part's `outcome` against the exercise
it points at.

### Step 6: The Session 2 material changes, against script and recall

Grep the derivatives for the pre-2026-08-22 revert wording ("four things",
"2 things have changed") and for the dropped pull-request example. Then
settle the `course-update` question against the rule — a script is written
FROM the concept sources, and a recall prompt asks about what its segment
said — and record the decision with its reason either way.

### Step 7: Fix what the audit found, in `platform/` only

Confined to genuine drift: paths, anchors, quoted wording, and a part that
opens past a step its document requires. No restructuring of parts, no
re-timing, no touching `concept.sources` (a sibling chunk owns that).

### Step 8: Re-run the validator and write the record

Validator clean, `ve validate` clean, FINDINGS.md complete with every command
and verdict, and the two fixes explained in Deviations below.

## Dependencies

None. `../learning-platform` must be checked out as a sibling for the
validator; the audit is otherwise self-contained in this worktree.

## Risks and Open Questions

- **The audit finds nothing.** Entirely possible, and it is a real result —
  but only if the record shows what was checked. A findings file that says
  "verified" without the command is worth nothing to the next audit.
- **`course-update` is a judgment call.** DEC-012 says every session from
  Session 2 opens with it; `platform/README.md` says commands live on the lab
  card, not in the script. The resolution has to satisfy both, and whichever
  way it goes the reason is recorded.
- **Three sibling chunks are running concurrently.** `platform_student_index`
  edits `module.yaml`'s `concept.sources`; `platform_solo_labs` edits the lab
  text this chunk reads. Edits here stay in the `lab.parts` region and in
  `platform/audio/`, and anything the siblings need to know goes in the
  handoff.

## Deviations

- **Step 7 produced two fixes, not zero and not a list.** The audit found no
  stale quoted wording anywhere — the transcriptions were written after every
  2026-08-22 material change (Step 2), which is the opposite of the
  narrative's premise. What it did find was one structural drift and one
  omission, both recorded in FINDINGS.md as F-1 and F-2:
  - `module.yaml`, Session 2 part `where_am_i`: the part opened at
    `#exercise-1-where-am-i`, which is *below* the "Before exercise 1"
    paragraph that DEC-012 requires every session from Session 2 to open
    with. The unanchored document is now the part's first source, so the
    sitting opens at the top. No part was re-timed, re-split or renamed.
  - `audio/02_meeting_the_harness.md`, segment 1: a second `> Lab card:`
    hand-off names the start-of-session update the terminal card carries.
    The script's speech is unchanged, so no recall prompt changed either —
    a prompt may only ask about what its segment said.
- **Three items are recorded as noted-not-fixed** (FINDINGS.md N-1…N-3)
  rather than changed: Session 2's part minutes run 5 minutes above the
  runsheet's block timings, `first_delegation`'s comment cites 14 minutes
  beside a value of 15, and Session 1's `check_column_filled` is stricter
  than the numbered bar. All three are `platform_lab_parts`' and
  `platform_module_contract`' documented choices, both ACTIVE, and both
  postdate the material this chunk audits; changing them would be
  restructuring rather than drift-fixing.
