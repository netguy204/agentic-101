---
status: ACTIVE
ticket: null
parent_chunk: null
code_paths:
- platform/index/01_mental_models.md
- platform/index/02_meeting_the_harness.md
- platform/module.yaml
- platform/README.md
- docs/trunk/PLATFORM_AUTHORING.md
code_references:
- ref: platform/index/01_mental_models.md
  implements: "Session 1's index for the student: the outcome as their own, concept
    30 / lab 92 with the practice week named as part of the lab, the arc of the sheet,
    the prework's facilitator email reconciled for somebody working alone, and the
    two things they hand in"
- ref: platform/index/02_meeting_the_harness.md
  implements: "Session 2's index for the student: the outcome as their own, concept
    25 / lab 125 with the practice laps named as the last sittings, the safety-net-first
    ordering, the setup check and the model-provider warning, and the four things
    they hand in — including why `revert --list` is one of them"
- ref: platform/module.yaml
  implements: "concept.sources for both served sessions: the student index first,
    then PREWORK.md; the session README no longer served, with the header comment
    saying why"
- ref: docs/trunk/PLATFORM_AUTHORING.md
  implements: "The authoring rule — a served session owes a student index, bound to
    the same transcription discipline as the rubric — the consumption table that
    separates README from index, and the known gap this closes"
- ref: platform/README.md
  implements: "The index/ row in the directory's file table"
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

Platform students no longer receive author- or facilitator-facing prose as
concept material. Each served session has a student-facing concept index —
a platform derivative at `platform/index/<NN>_<slug>.md` — and
`platform/module.yaml`'s `concept.sources` lists it instead of the
session's `curriculum/.../README.md`. The index is written from the README
and PREWORK in the course's voice, addressed to the student: the session's
outcome, what they will do, honest time expectations (matching
`estimated_minutes`), and what they will hand in — without the artifact
table that links `FACILITATOR_GUIDE.md`, without "Constraints on edits",
and without the from/to-later-sessions tables. One page each. Sessions 1
and 2 have their indexes; Session 3's is authored inside its draft (chunk
`platform_session_03_draft`), following the shape set here.

`docs/trunk/PLATFORM_AUTHORING.md` carries the rule rather than the gap:
its "How the platform consumes a session" table gives `README.md`,
`PREWORK.md` and the index a row each, the consequence beneath it says a
served session owes a student index and binds it to the same transcription
rule the rubric obeys, and the known-gaps entry about student-visible
READMEs is gone because it is closed. `platform/README.md`'s file table
carries the `index/` row. The session READMEs themselves are not edited —
they remain the author/facilitator index, which is what they were for.

Location decision (made at narrative time): the index lives under
`platform/`, not in the session directory — adding an eighth fixed file to
the session set would amend DEC-010/011 for a platform concern, and the
index is a derivative of README/PREWORK exactly as the audio script is a
derivative of the concept prose. The Module Contract places no restriction
on `concept.sources` paths (`src/contract/validate.ts` requires only that
each source exist in the module's file map), so `platform/index/` needs no
fallback; `pnpm contract:validate` accepts it, and refuses a path that does
not exist, which is how that was confirmed rather than assumed.

The index's time expectations quote Module Contract v1.1's
`estimated_minutes` — S1 concept 30 / lab 92, S2 concept 25 / lab 125 —
and say plainly that the lab figure includes the practice week, because
under v1.1 `estimated_minutes.lab` is the sum of the session's `lab.parts`
and a student with no cohort has no "between sessions" to do practice in.

## Success Criteria

- `platform/index/01_mental_models.md` and
  `platform/index/02_meeting_the_harness.md` exist, one page each, student
  voice, no facilitator links or author-facing sections, with backreference
  comments. The comments are safe on both paths a student can reach, which
  was checked in the platform's source rather than assumed:
  `src/markdown/render.ts` strips HTML comments before parsing and
  `src/audio/normalize.ts` strips them inside `speakable()`, so the
  audio-script workaround (attribution kept outside the file) is not
  needed here.
- module.yaml concept.sources for both sessions list the index instead of
  README.md; PREWORK.md remains listed.
- PLATFORM_AUTHORING.md's known-gaps entry is resolved and its consumption
  table updated; platform/README.md's file table lists index/.
- `pnpm contract:validate` from ../learning-platform is clean;
  `uvx --from vibe-engineer ve validate` passes.

## Rejected Ideas

### Rewrite the session READMEs to be student-safe

Keeps concept.sources unchanged. Rejected because: the README genuinely
serves authors and facilitators (artifact tables, constraints on edits,
reading order); making it student-safe strips it of that job or forks its
voice. The platform's own known-gaps note points at a replacement index.

### An eighth fixed file in each session directory

`STUDENT_INDEX.md` beside the seven. Rejected because: it amends
DEC-010/011's fixed set for a platform concern, and every future session
would owe a file that only one delivery reads. The index is a derivative;
derivatives live in platform/.
