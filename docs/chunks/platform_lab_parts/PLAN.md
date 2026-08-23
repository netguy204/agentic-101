# Implementation Plan

## Approach

Transcription, in the same sense as the rubrics: the participant's
`EXERCISES.md` and `PRACTICE.md` already contain the structure, and the
runsheet already contains the timings. This chunk moves both into
`platform/module.yaml` without inventing either.

The grouping rule is the room's own: **one part per exercise, except where the
runsheet runs two exercises as one block**, and one part per practice lap. That
keeps every part between roughly ten and twenty-five minutes and lands both
sessions at five or six parts — the contract's ceiling is six, and past that a
list of parts stops being something a student can hold in their head.

Minutes come from `EXERCISE_RUNSHEET.md`'s block headings and `PRACTICE.md`'s
own time budget, rounded up to the nearest five where the runsheet's number is
a facilitator's pace (a student alone with the same exercise is slower than a
room being kept on time by someone with a clock). Outcomes are written from the
exercise's own "When you're done" line where it has one.

`estimated_minutes.lab` becomes the sum. For both sessions that is a larger
number than the manifest carried before, because the old number counted only
the exercise block: the practice week was in `lab.sources` but in nobody's
estimate. Counting it is the honest answer for a student with no cohort, and
the platform's validator warns when the two disagree by more than a quarter —
which is how the discrepancy surfaced.

## Sequence

### Step 1: Session 1's parts

`platform/module.yaml`, `sessions[0].lab.parts` — five parts:

| id | from | minutes |
|---|---|---|
| `the_sheet` | `EXERCISES.md` Exercise 1 + Exercise 2 | 25 |
| `skeptic_pass` | Exercise 3 + Wrapping up | 12 |
| `daily_pass` | `PRACTICE.md` 1. The daily pass | 20 |
| `check_test` | `PRACTICE.md` 2. The check test | 15 |
| `consolidation` | `PRACTICE.md` 3. The consolidation pass | 20 |

`estimated_minutes.lab: 92`.

### Step 2: Session 2's parts

`sessions[1].lab.parts` — six parts:

| id | from | minutes |
|---|---|---|
| `where_am_i` | `EXERCISES.md` Exercise 1 + Exercise 2 | 25 |
| `first_delegation` | Exercise 3 | 15 |
| `read_and_break` | Exercise 4 + Exercise 5 + Wrapping up | 25 |
| `solo_lap` | `PRACTICE.md` 1. The solo lap | 20 |
| `two_real_ones` | `PRACTICE.md` 2. Two real ones | 30 |
| `worst_one_worksheet` | `PRACTICE.md` 3. One worksheet, on the worst one | 10 |

`estimated_minutes.lab: 125`.

### Step 3: `platform/README.md`

The file table's `module.yaml` row mentions parts; "Adding a session" gains the
step (split the lab into parts, minutes from the runsheet); and a rule
paragraph states the transcription obligation — re-timing or re-splitting an
exercise is not finished until its part has been re-read — beside the existing
rule that says the same thing about `CHECKPOINT.md` and the rubrics.

### Step 4: `docs/trunk/PLATFORM_AUTHORING.md`

The "a lab is parts, not a document" bullet cross-references
`platform/module.yaml`'s `lab.parts`, now that the manifest has somewhere to
put the structure the bullet asks for, and its "three to five parts" becomes
the contract's actual range.

### Step 5: Validate and tag

`pnpm contract:validate /Users/btaylor/Projects/agentic-101` from a platform
checkout until it is clean, then commit and tag `platform-2026-08-2`. The push
is the operator's.

## Risks and Open Questions

- **Anchors are slugified by the platform's own rules**, which are close to
  GitHub's but not identical (runs of whitespace collapse to a single hyphen,
  so `Exercise 1 — Brain dump` is `#exercise-1-brain-dump`). The validator is
  the arbiter; every anchor here was confirmed by running it.
- **A part's minutes are a promise to a student.** They are the numbers a
  facilitator has watched in the room, but the room has a facilitator in it. If
  the floor tests say a self-paced student takes longer, the parts are where
  that gets corrected — one number, not a rewrite.
- **These headings are now load-bearing.** Renaming an exercise heading in
  `EXERCISES.md` breaks a part's anchor. Unlike the deterministic checks'
  quoted wording, this one fails loudly at validation rather than silently in
  front of a student.

## Deviations

<!-- POPULATE DURING IMPLEMENTATION -->
