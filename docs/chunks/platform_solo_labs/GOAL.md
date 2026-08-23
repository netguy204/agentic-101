---
status: ACTIVE
ticket: null
parent_chunk: null
code_paths:
- curriculum/session_01_mental_models/EXERCISES.md
- curriculum/session_01_mental_models/EXERCISE_RUNSHEET.md
- curriculum/session_02_meeting_the_harness/EXERCISES.md
- curriculum/session_02_meeting_the_harness/PRACTICE.md
- curriculum/session_03_anatomy_of_a_delegation/EXERCISES.md
- curriculum/session_03_anatomy_of_a_delegation/EXERCISE_RUNSHEET.md
- curriculum/session_03_anatomy_of_a_delegation/PRACTICE.md
- platform/module.yaml
code_references:
- ref: curriculum/session_01_mental_models/EXERCISES.md
  implements: 'Exercise 3 restructured as a solo skeptic pass (you ask the question
    of your own answer), with the pair form as an in-room aside; the contract paragraph
    naming what the student leaves with'
- ref: curriculum/session_01_mental_models/EXERCISE_RUNSHEET.md
  implements: The room's form of exercise 3 — pairing stated as how the room runs the
    individual steps, with the odd-number, no-pair and remote fallbacks it already owned
- ref: curriculum/session_02_meeting_the_harness/EXERCISES.md
  implements: 'Room-dependency sweep at unchanged exercise and step numbering: the stuck
    line, the setup-failure row, exercise 2''s gating sentence, and the wrap-up as a
    self-check; the contract paragraph'
- ref: curriculum/session_02_meeting_the_harness/PRACTICE.md
  implements: The self-paced cadence clause on the two-entry practice loop, budgets unchanged
- ref: curriculum/session_03_anatomy_of_a_delegation/EXERCISES.md
  implements: 'Exercise 1 as individual steps (write the sentence, sort it against the
    three reasons, write the reason on the worksheet) with the round as an in-room aside;
    the sweep and the contract paragraph'
- ref: curriculum/session_03_anatomy_of_a_delegation/EXERCISE_RUNSHEET.md
  implements: The round as the room's form of exercise 1, over the individual steps — the
    board tally and worked placements it already owned
- ref: curriculum/session_03_anatomy_of_a_delegation/PRACTICE.md
  implements: The self-paced cadence clause at the three places the working week set the
    timing, budgets unchanged
- ref: platform/module.yaml
  implements: 'Forced derivative fix: the skeptic_pass part''s comment, which justified
    the solo reading by a no-pair note that no longer exists'
narrative: platform_compliance
investigation: null
subsystems:
- subsystem_id: session_anatomy
  relationship: uses
friction_entries: []
depends_on: []
created_after:
- platform_authoring_guide
---


# Chunk Goal

## Minor Goal

Every lab step in Sessions 1–3's `EXERCISES.md` is followable by a student
who is alone — no room, no pair, no facilitator — without changing what the
room does. The specific room-bound spots, from the platform-compliance
review:

1. **Session 1, exercise 3 (the skeptic pass)** — participant text says
   "In pairs." Restructure so the steps are individual: the participant
   plays their own skeptic (the same question — "how would you know if it
   was wrong?" — asked of their own answer until it is concrete or they
   concede "actually, I couldn't tell"), with the pair version as the
   in-room framing. The runsheet already owns the pairing mechanics,
   odd-number fallback and remote delivery; move anything else
   room-mechanical there. The exercise's outcome (at least one row changed
   after the pass) must survive both forms.
2. **Session 3, exercise 1 (your worst one)** — participant text is a
   spoken round ("when it's your turn… as the others go…"). Make the steps
   individual: write your sentence; sort it yourself against the three
   reasons (which stay in the participant text — they are the concept);
   write the reason on the worksheet. The round, the board tally and the
   sort-out-loud move go fully to `EXERCISE_RUNSHEET.md` (most already
   are). The room loses nothing: the facilitator runs the round over the
   individual steps.
3. **Session 2 sweep** — read `EXERCISES.md` for anything that assumes the
   room ("say so — you'll be paired", the wrap-up's show of hands). Keep
   references to the room where they are harmless; remove dependencies on
   it. The same sweep on Sessions 1 and 3 after their restructures.
4. **The contract before the work** — each `EXERCISES.md` opens with two
   or three lines naming what the student will have at the end, in their
   language, matching the checkpoint bar (S1: an inventory with at least
   three `in` rows with real checks, and a boundary claim; S2: a cleaned
   `sample.csv` they checked, a filled worksheet, and having used revert;
   S3: a brief that ran twice, the one-change sentence, box 5 filled).
5. **Practice cadence tolerance** — S2 and S3 `PRACTICE.md` phrase timing
   as the working week ("when the task next comes round"); add the
   self-paced clause ("— or the next time you do this task, whenever that
   is") without changing the budgets.

Constraints: DEC-011 audience purity holds (no facilitator voice enters
EXERCISES.md — run the purity greps from
`docs/chunks/fluency_exercise_split/PLAN.md` Step 5); the room semantics
are unchanged (what moved to a runsheet is still done in the room);
Session 2's dry-run-verified steps are not renumbered (the runsheet and
floor test reference exercise/step numbers); after editing, grep
`platform/` for any wording the rubrics quote from these files and fix the
derivative if touched (`platform/README.md`, "Deterministic checks quote
handout text, exactly"). The corresponding session chunks
(`fluency_session_01/02/03`) stay ACTIVE; update their `code_references`
descriptions only if a file's role changed, which it should not.

**Contract v1.1 note (2026-08-23, commit f29a15b).** Module Contract v1.1
landed before this chunk ran: each served session's `lab` now declares
`parts[]` — 2–6 ordered sittings of `{id, title, minutes, outcome,
sources[]}`, whose sources anchor into the lab documents' `## Exercise N`
headings — and `estimated_minutes.lab` is the sum of the parts and includes
the practice week (S1 92, S2 125). The rules are in `platform/README.md`
("A lab is parts…"). Read them before touching anything they govern.

Consequence here: **the `## Exercise N` headings in Sessions 1 and 2
EXERCISES.md are load-bearing** — parts anchor into them and renaming one
fails contract validation loudly. This chunk's edits keep every existing
exercise heading byte-identical (Session 3's are not yet anchored, but keep
them stable anyway — its draft will anchor them). Run
`pnpm contract:validate` from `../learning-platform` after the edits.

## Success Criteria

- S1 exercise 3 and S3 exercise 1 are followable alone from the participant
  text, and the runsheets carry the room mechanics that moved; the in-room
  flow described in each runsheet is unchanged in substance.
- Each of the three EXERCISES.md files opens by naming what the student
  will leave with, consistent with its CHECKPOINT.md bar.
- S2 and S3 PRACTICE.md carry the cadence clause; budgets unchanged.
- Audience-purity greps pass (0 facilitator-voice hits in EXERCISES.md,
  0 numbered steps in runsheets); all relative links resolve;
  `uvx --from vibe-engineer ve validate` passes.
- A grep of `platform/` for wording touched by these edits is recorded,
  with derivative fixes if any were needed.
- Exercise and step numbering in Sessions 2 and 3 is unchanged.

