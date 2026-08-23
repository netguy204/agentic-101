---
status: ACTIVE
ticket: null
parent_chunk: null
code_paths:
- platform/module.yaml
- platform/README.md
- docs/trunk/PLATFORM_AUTHORING.md
code_references:
- ref: platform/module.yaml
  implements: "Sessions 1 and 2 as parts: five and six sittings transcribed from the\
    \ exercises and the practice laps, minutes from the runsheet timings and PRACTICE.md's\
    \ time budget, sources anchored at the heading each part begins at, and estimated_minutes.lab\
    \ as the sum \u2014 the first lab estimate here to count the practice week"
- ref: platform/README.md
  implements: The rule that a part is a transcription of its exercise, that exercise
    headings are load-bearing because parts anchor into them, and the parts step in
    "Adding a session"
- ref: docs/trunk/PLATFORM_AUTHORING.md
  implements: The lab-is-parts rule pointed at the manifest key that now carries it,
    and the practice week named as part of the lab
narrative: null
investigation: null
subsystems: []
friction_entries: []
depends_on: []
created_after:
- platform_authoring_guide
---

# Chunk Goal

## Minor Goal

`platform/module.yaml` declares each served session's lab as **parts** — the
ordered sittings a self-paced student stops and resumes between — so that
`docs/trunk/PLATFORM_AUTHORING.md` § "Design for the student who is alone"
("a lab is parts, not a document") has somewhere in the manifest to land.

Sessions 1 and 2 each carry five to six parts, transcribed from the natural
structure of their `EXERCISES.md` and `PRACTICE.md` — one part per exercise or
per practice lap, grouped where the room's own runsheet groups them — with
minutes taken from `EXERCISE_RUNSHEET.md`'s timings and PRACTICE.md's stated
time budget, one outcome each in the participant's language, and `sources`
anchored at the heading the part begins at. `estimated_minutes.lab` is the sum
of the parts, which makes it the first honest lab estimate this manifest has
carried: it now counts the practice week, because a self-paced student has no
"between sessions" — the practice laps are simply the last sittings of the lab.

The parts are transcription, not new material. As with the rubrics
(`platform/README.md` § The rules), the participant documents remain the
source: a part may not say anything its exercises do not, and re-timing or
re-splitting an exercise is not finished until its part has been re-read.

Parts are pacing and never a gate — the platform certifies against submitted
artifacts alone — so a student who ignores them is not penalised anywhere.

## Success Criteria

- `pnpm contract:validate /Users/btaylor/Projects/agentic-101`, run from a
  checkout of the platform, reports zero errors and no new warnings: every
  part's `sources` resolves to a real heading, every lab document is named by
  some part, and each session's parts add up to its `estimated_minutes.lab`.
- Every part's minutes trace to a number already written down — the runsheet's
  block timings or PRACTICE.md's time budget — and every outcome to a sentence
  of the participant's own `EXERCISES.md`/`PRACTICE.md`.
- `platform/README.md` § "Adding a session" names parts as a step, and its
  file table describes what the manifest's `parts` key is for.
- `docs/trunk/PLATFORM_AUTHORING.md`'s "a lab is parts, not a document" bullet
  cross-references the manifest key that now carries it.
- The repository is tagged `platform-2026-08-2` (the tag the platform ingests
  to serve parts); pushing is the operator's, not the agent's.
- `ve validate` passes here, and the platform's own
  `docs/chunks/contract_lab_parts/external.yaml` points at this chunk.

## Rejected Ideas

### Leave the practice week out of the parts

Parts would then describe only the in-room exercise block, and
`estimated_minutes.lab` could stay at its old number. Rejected: `PRACTICE.md`
is already in `lab.sources`, and for a student with no cohort the practice laps
ARE the second and third sittings — the exact thing parts exist to name. The
validator agrees: a lab document no part names is a document with nowhere to
appear.

### Split every exercise into its own part

Session 2 has five exercises and three practice laps, which is eight parts —
past the contract's ceiling of six, and past the point where a list is a plan a
student can hold. Exercises the runsheet already runs back-to-back (orientation
and the safety net; reading the log and breaking it on purpose) are grouped
into one sitting each instead.
