---
status: ACTIVE
ticket: null
parent_chunk: null
code_paths:
- platform/module.yaml
- platform/audio/02_meeting_the_harness.md
- docs/chunks/platform_drift_audit/FINDINGS.md
code_references:
- ref: docs/chunks/platform_drift_audit/FINDINGS.md
  implements: "The audit record: every quoted string, path, anchor and rubric row, with the command that verified it"
- ref: platform/module.yaml#sessions::02_meeting_the_harness::lab::parts::where_am_i
  implements: "F-1: the first Session 2 sitting opens at the top of EXERCISES.md, where DEC-012's session-start step lives"
- ref: platform/audio/02_meeting_the_harness.md#Segment 1 — A window onto a folder
  implements: "F-2: course-update reaches the self-paced student as a lab-card hand-off, not as speech"
narrative: platform_compliance
investigation: null
subsystems: []
friction_entries: []
depends_on: []
created_after:
- platform_authoring_guide
---
# Chunk Goal

## Minor Goal

The Session 1 and Session 2 platform transcriptions (`platform/rubrics/`,
`platform/audio/`, `platform/recall/`, `platform/module.yaml`) verifiably
match the material as it stands today: every wording a deterministic check
quotes is checked against the file that prints it, and drift is fixed **in
the derivatives, never the source**. [`FINDINGS.md`](FINDINGS.md) beside
this file is the record of the pass — every grep, every verdict, and the
reasoning behind each fix — and it is the model the next material change
follows. Five things carry the risk, and the record covers each:

1. **Inventory header rename** — `handouts/toil-inventory.md` column 3 is
   now "In or out of my judgment boundary?". `rubrics/01_mental_models.yaml`
   quotes it (line ~55) — verify every quoted heading/column in both
   rubrics against the current handouts, character for character including
   punctuation (the platform/README.md rule).
2. **Session 2 revert rewording** — the exercise now says "four questions,
   one at a time — the first offers three numbered choices" and quotes
   "Wait — 1 thing in this folder has changed". Grep the S2 rubric, audio
   and recall for the old wording ("four things", "2 things have changed").
3. **course-update** — Session 2 PREWORK §3 now runs `course-update` before
   `course-smoke-test`, and EXERCISES has a "Before exercise 1" paragraph.
   The audio script was written from PREWORK; decide whether the script
   must mention it (the rule: a recall prompt has to ask about what its
   segment actually said — and a script is written FROM the concept
   sources) and update script/recall as needed. The setup rubric
   (`rubrics/setup.yaml`) checks smoke-test output — verify it against
   env 1.1.0's actual output (`Course environment 1.1.0`, the CRLF fix).
4. **The exercise split** — module.yaml's lab sources and ta_knowledge
   entries reference EXERCISES.md and EXERCISE_RUNSHEET.md; verify every
   listed path and anchor (`#anticipated-failure-points-and-recovery-moves`,
   `#faq-questions-you-will-be-asked`) still resolves against the current
   files.
5. **The rubric-beside-checkpoint rule** — re-read each rubric next to its
   CHECKPOINT.md end to end (platform/README.md: "a change to a session's
   bar or its near-miss table is not finished until the rubric has been
   re-read"). The checkpoints themselves are unchanged, so this pass is a
   confirmation rather than a repair — and the record says so explicitly,
   because a rubric nobody has re-read looks exactly like one that has.

Method: `../learning-platform` is checked out as a sibling; run
`pnpm contract:validate` from there against this repository, before and
after fixes, and read the warnings. Record every verified-clean item and
every fix in the chunk (a table in the PLAN's Deviations or a findings
file in the chunk directory), so the next material change has a model for
what this audit looks like.

**Contract v1.1 note (2026-08-23, commit f29a15b).** Module Contract v1.1
landed before this chunk ran: each served session's `lab` now declares
`parts[]` — 2–6 ordered sittings of `{id, title, minutes, outcome,
sources[]}`, whose sources anchor into the lab documents' `## Exercise N`
headings — and `estimated_minutes.lab` is the sum of the parts and includes
the practice week (S1 92, S2 125). The rules are in `platform/README.md`
("A lab is parts…"). Read them before touching anything they govern.

Consequence here: the audit's scope includes the new `parts[]` blocks —
verify each part's `sources` anchor resolves against the current
`## Exercise N` headings, that part minutes still sum to
`estimated_minutes.lab`, and note that f29a15b postdates the 2026-08-22
material changes (its transcription choices are current; the audit's
subject is the older rubric/audio/recall files).

## Success Criteria

- Every string a deterministic check quotes has been grep-verified against
  the file it reads, and the greps are recorded.
- The S2 audio/recall either cover course-update or the decision not to is
  recorded with the reason; the setup rubric matches env 1.1.0 output.
- Both rubrics re-read beside their checkpoints, stated in the record.
- `pnpm contract:validate` from ../learning-platform runs clean (errors
  fixed; warnings read and either fixed or recorded with reasons).
- No file under `curriculum/`, `env/` or `setup/` is modified by this
  chunk; all fixes land in `platform/`.

