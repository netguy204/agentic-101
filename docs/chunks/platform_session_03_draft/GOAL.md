---
status: ACTIVE
ticket: null
parent_chunk: null
code_paths:
- platform/drafts/03_anatomy_of_a_delegation/session.yaml
- platform/drafts/03_anatomy_of_a_delegation/rubric.yaml
- platform/drafts/03_anatomy_of_a_delegation/audio.md
- platform/drafts/03_anatomy_of_a_delegation/recall.yaml
- platform/drafts/03_anatomy_of_a_delegation/index.md
- platform/drafts/03_anatomy_of_a_delegation/README.md
- platform/README.md
code_references:
- ref: platform/drafts/03_anatomy_of_a_delegation/session.yaml
  implements: 'Session 3''s manifest fragment at Contract v1.1: concept sources (index
    then PREWORK), lab sources and handouts, six lab.parts anchored at the exercise
    and practice-item headings, the four artifacts including the carry-forward worst_delegation,
    ta_knowledge without CHECKPOINT.md, the post-promotion rubric path, and estimated_minutes.lab
    as the sum of the parts with the practice week in it'
- ref: platform/drafts/03_anatomy_of_a_delegation/rubric.yaml
  implements: 'CHECKPOINT.md transcribed: four criteria in the checkpoint''s order
    and its own see/hear split, the four box headings and the four checkpoint names
    as deterministic checks with their frozen wording sourced in comments, all six
    near-miss rows verbatim with their corrective questions, and the both-runs-required
    decision recorded against the deferred-second-run clause'
- ref: platform/drafts/03_anatomy_of_a_delegation/audio.md
  implements: 'The concept track for the ear: four segments (the three reasons; the
    colleague who cannot see your screen and the four boxes; find the box, change
    it once, run again; the box that decides and why ''out'' is a result), mechanics
    handed off on lab-card lines, each segment closing with its recall prompt'
- ref: platform/drafts/03_anatomy_of_a_delegation/recall.yaml
  implements: One prompt per segment, each asking what its segment actually said,
    with a one-sentence model answer
- ref: platform/drafts/03_anatomy_of_a_delegation/index.md
  implements: 'Session 3''s index for the student: the outcome as their own, concept
    25 / lab 110 with the practice laps named as the last sittings, the prework de-roomed
    for somebody working alone, the model-provider warning, and the four things they
    hand in'
- ref: platform/drafts/03_anatomy_of_a_delegation/README.md
  implements: 'The promotion note: what is staged and where each file goes, that promotion
    waits on FLOOR_TEST.md (all results PENDING), the three things a floor test is
    likely to move, the promotion steps, and what was checked by hand because nothing
    under drafts/ is read by anything'
- ref: platform/README.md
  implements: '"What is not here yet" updated to name Session 3''s draft as existing
    and waiting on its floor test'
narrative: platform_compliance
investigation: null
subsystems: []
friction_entries: []
depends_on:
- platform_dual_authoring
- platform_solo_labs
- platform_student_index
created_after:
- platform_authoring_guide
---
# Chunk Goal

## Minor Goal

`platform/drafts/03_anatomy_of_a_delegation/` contains Session 3's
complete draft platform version, staged under the convention
`platform_dual_authoring` defines, such that promotion after the Session 3
floor test is: move the files into place, add the session to
`module.yaml`, validate, tag — no authoring left. The draft is NOT listed
in `module.yaml` and nothing about it is served. Its contents:

1. **Rubric** (`rubric.yaml`), transcribed from
   `curriculum/session_03_anatomy_of_a_delegation/CHECKPOINT.md` per
   platform/README.md's rules. Four criteria in the checkpoint's own order
   and its own see/hear split ("the first and second are facts you can
   see; the third and fourth are the ones you have to hear"): (1) brief
   written — deterministic from the submitted brief's structure (the four
   named boxes filled; quote the handout's box headings exactly and note
   them as frozen); (2) ran twice with one change between — deterministic
   from the pasted `revert --list` (the names `after run 2`, `Back to:
   before run 1`, `after run 1`, `before run 1` — quote them exactly; they
   come from EXERCISES.md steps and env/bin/revert's `Back to:` prefix,
   both now frozen interfaces); (3) named the box and the reason, and (4)
   named the miss — judged, with the checkpoint's pass exemplars and every
   near-miss row verbatim including corrective questions. The checkpoint's
   "second run deferred to the practice week" clause is a room
   cutting-rule accommodation; the rubric requires both runs and records
   that transcription decision in a comment sourced to the clause.
2. **Audio script** (`audio.md`), written for the ear from PREWORK part 1
   and the README spine: segments of 450–900 words, each closing with its
   recall prompt; candidate segmentation — why delegations go wrong (the
   three reasons); the four boxes and the colleague-who-cannot-see-your-
   screen frame; find the box, change it once, run again; the boundary
   found by experiment ("out" is a pass). Tables, commands and anything
   the listener must look at go to `> Lab card:` lines. No HTML comments
   anywhere in the script (they are spoken).
3. **Recall prompts** (`recall.yaml`) — one per segment, asking what the
   segment actually said, one-sentence model answers.
4. **Student index** (`index.md`) — Session 3's, in the shape
   `platform_student_index` sets.
5. **Manifest fragment** (`session.yaml`) — the `sessions:` entry ready to
   paste: concept sources (PREWORK + the index), lab sources (EXERCISES,
   PRACTICE, `handouts/`, plus a comment noting the cross-session
   dependency on Session 1's `canned-toil.md` "For Session 3" and the
   Session 2 terminal card, both already served); artifacts —
   `delegation_brief` (worksheet, template
   `handouts/delegation-brief.md`), `checkpoint_list` (text),
   `session_log` (harness_log, `*.jsonl`), and `worst_delegation`
   (worksheet + text sentence, the Session 2 practice-week output
   submitted at Session 3 lab start — the carry-forward decision from the
   narrative, recorded in a comment); `estimated_minutes: {concept: 25,
   lab: 90}` from the dry run; ta_knowledge — FACILITATOR_GUIDE anchors
   (`#anticipated-failure-points-and-recovery-moves`,
   `#faq-questions-you-will-be-asked`), EXERCISE_RUNSHEET.md, DRY_RUN.md,
   FLOOR_TEST.md. CHECKPOINT.md appears nowhere.
6. **A promotion note** (`README.md` in the draft directory): what
   promotion is, and that it waits on the Session 3 floor test
   (`curriculum/session_03_anatomy_of_a_delegation/FLOOR_TEST.md`, results
   PENDING).

Written against the material as `platform_solo_labs` leaves it (exercise
1 individual, contract lines present) — hence the dependency. Verify the
validator's treatment of the drafts directory matches what
`platform_dual_authoring` recorded. If the floor test later changes
wording the rubric quotes, the draft is updated then — that is the point
of drafting before serving.

**Contract v1.1 note (2026-08-23, commit f29a15b).** Module Contract v1.1
landed before this chunk ran: each served session's `lab` now declares
`parts[]` — 2–6 ordered sittings of `{id, title, minutes, outcome,
sources[]}`, whose sources anchor into the lab documents' `## Exercise N`
headings — and `estimated_minutes.lab` is the sum of the parts and includes
the practice week (S1 92, S2 125). The rules are in `platform/README.md`
("A lab is parts…"). Read them before touching anything they govern.

Consequence here: the draft's manifest fragment is Contract v1.1 —
`lab.parts[]` with 2–6 sittings anchored into Session 3's `## Exercise N`
headings (natural cut: the sentence-and-sort + the brief / the two runs /
box 5 + practice), part minutes from the runsheet's timing table plus the
practice budget, and `estimated_minutes.lab` as their sum including the
practice week (~58 in-session + ~55 practice). Follow S1/S2's parts blocks
in `module.yaml` as the worked examples.

## Success Criteria

- The draft directory contains rubric, audio script, recall prompts,
  student index, manifest fragment and promotion note, complete per
  platform/README.md's rules for each artifact type.
- Every deterministic check's quoted wording (brief box headings,
  checkpoint names, the `Back to:` prefix) is grep-verified against the
  current handout, EXERCISES.md and env/bin/revert, and listed as frozen
  in rubric comments.
- The rubric says nothing CHECKPOINT.md does not, carries every near-miss
  row verbatim with its corrective question, and records the
  both-runs-required transcription decision.
- module.yaml is unchanged; `pnpm contract:validate` from
  ../learning-platform remains clean with the draft present;
  `uvx --from vibe-engineer ve validate` passes.
- Promotion after the floor test would require no authoring — verified by
  a dry read of the promotion note against the draft's contents.

