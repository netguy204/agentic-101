---
status: COMPLETED
advances_trunk_goal: "Required Properties: Two deliveries, one source — the platform consumes derivatives, never forks; material is iterated in the room and promoted by tag"
proposed_chunks:
- prompt: >-
    Record the dual-authoring policy: future sessions are authored with the
    room version plus a DRAFT platform version, and promoted to the platform
    only after room testing. Rewrite PLATFORM_AUTHORING.md's "A new session,
    in order" to the new sequence (room files + draft transcription together;
    floor test and room iteration; promote; tag), define the draft staging
    convention in platform/README.md (a platform/drafts/<session>/ directory
    holding rubric, audio, recall and a manifest fragment; promotion = move
    into place, add to module.yaml sessions:, validate, tag — a drafted
    session is never listed in module.yaml), and record the decision as
    DEC-013 with the operator's rationale: a course iterated in a live
    classroom has better pedagogical coverage when adapted to the platform
    than one authored for the platform directly.
  depends_on: []
  chunk_directory: platform_dual_authoring
- prompt: >-
    Audit the existing Session 1 and 2 transcriptions against the material as
    it stands after the 2026-08-22 changes (inventory column-3 header rename,
    the revert four-questions rewording, course-update added to Session 2
    PREWORK part 3, the EXERCISES/EXERCISE_RUNSHEET split, environment 1.1.0
    output). Re-read each rubric beside its CHECKPOINT.md per platform/
    README.md's rule; grep platform/ for every wording the deterministic
    checks quote and verify it against the current handouts and env command
    output; check the audio scripts and recall prompts still match the
    concept sources they were written from; run the platform validator
    (pnpm contract:validate from a learning-platform checkout) and fix what
    it reports. Fix drift in the transcription, not the source.
  depends_on: []
  chunk_directory: platform_drift_audit
- prompt: >-
    Make the shared lab sources followable by a student who is alone, without
    changing what the room does: Session 1 exercise 3 (the skeptic pass)
    gains a solo path in the participant text (self-skepticism with the same
    question, or the facilitator-as-skeptic framing generalized), with the
    pairing mechanics staying in the runsheet; Session 3 exercise 1 becomes
    individual steps (write your sentence, sort it against the three reasons
    yourself, write the reason on the worksheet) with the round and the
    board tally moving fully to the runsheet; Session 2 gets a sweep for
    room-bound phrasing in participant text. Add the contract-before-the-work
    lines at the top of each EXERCISES.md ("you'll leave with: …" in the
    student's language, matching the checkpoint bar), and add the self-paced
    cadence tolerance to each PRACTICE.md ("or the next time you do this
    task, whenever that is"). Grep platform/ afterward for any frozen wording
    these edits touch.
  depends_on: []
  chunk_directory: platform_solo_labs
- prompt: >-
    Close the student-visible README gap: create a student-facing concept
    index per session as a platform derivative (platform/index/<session>.md
    or equivalent — settle the location; it must not add an eighth fixed file
    to the DEC-010/011 session directory), carrying the session's outcome,
    what the student will do, and time expectations, without the artifact
    tables that link facilitator documents or the author-facing
    constraints-on-edits sections. Point module.yaml's concept.sources at the
    index instead of README.md for Sessions 1 and 2 (Session 3's is authored
    in its draft), update PLATFORM_AUTHORING.md's known-gaps section, and
    validate.
  depends_on: []
  chunk_directory: platform_student_index
- prompt: >-
    Author Session 3's draft platform version under the drafts convention:
    rubric from CHECKPOINT.md (four criteria in the checkpoint's own
    see/hear split — brief-ran-twice deterministic via the pasted
    revert --list and the brief's structure, named-change and named-miss
    judged against the pass/near-miss exemplars with their corrective
    questions; the room's deferred-second-run clause does not apply
    self-paced — both runs are required), audio script and recall prompts
    from the concept material (candidates: the three reasons, the four
    boxes, why one box at a time, what writing "out" means), the manifest
    fragment with artifacts (delegation_brief worksheet with template,
    checkpoint_list text, session_log harness_log, and the worst-delegation
    worksheet + sentence carried in from Session 2's practice week,
    submitted at Session 3 lab start), estimated_minutes from the dry run
    (concept 25, lab 90), the Session 3 student index, and ta_knowledge
    anchors. The draft is NOT added to module.yaml; promotion happens after
    the Session 3 floor test, outside this narrative.
  depends_on: [0, 2, 3]
  chunk_directory: platform_session_03_draft
created_after: []
---

<!--
STATUS VALUES:
- DRAFTING: The narrative is being refined; chunks not yet created
- ACTIVE: Chunks are being created and implemented from this narrative
- COMPLETED: All chunks have been created and the narrative's ambition is realized

ADVANCES_TRUNK_GOAL:
- Reference the specific section of docs/trunk/GOAL.md this narrative advances
- Example: "Required Properties: Must support multi-repository workflows"

PROPOSED_CHUNKS:
- POPULATE THIS ARRAY at narrative-creation time. Leaving it empty defeats the
  discovery surface that lets `ve chunk list-proposed` surface unstarted work.
- Each entry describes a proposed chunk that has not yet been reified via /chunk-create.

Fields and when they are set:
- prompt: Written at narrative-creation time — the refined prompt text for this chunk.
- depends_on: Written at narrative-creation time — see semantics table below.
- chunk_directory: Leave as `null` at narrative-creation time. /chunk-create fills this
  in automatically when the proposed chunk is reified into a real chunk.

DEPENDS_ON SEMANTICS (null vs empty distinction):
  | Value           | Meaning                                 | Oracle behavior |
  |-----------------|----------------------------------------|-----------------|
  | omitted/null    | "I don't know dependencies for this"  | Consult oracle  |
  | []              | "Explicitly has no dependencies"       | Bypass oracle   |
  | [0, 2]          | "Depends on prompts at indices 0 & 2"  | Bypass oracle   |

  - Indices are zero-based and reference other entries in this same array
  - At chunk-create time, index references are translated to chunk directory names
  - Use `[]` when you've analyzed the chunks and determined they're independent
  - Omit the field when you don't have enough context to determine dependencies

- Use `ve chunk list-proposed` to see all proposed chunks that haven't been created yet
-->


## Advances Trunk Goal

"Required Properties: **Two deliveries, one source**" (docs/trunk/GOAL.md) —
the course is taught live and served by the self-paced platform from the
same session material; the platform consumes derivatives, never forks, and
material is iterated in the room and promoted by tag. This narrative makes
the already-served sessions actually comply with that property's rules
(`docs/trunk/PLATFORM_AUTHORING.md`), stages Session 3's platform version
as far as the room's testing allows, and records the authoring policy that
keeps the property true for Sessions 4–6.

## Driving Ambition

The platform is live and serving Sessions 1 and 2, but the material predates
its own authoring rules in places: the session READMEs students see carry
author-facing sections, some lab steps assume a room (Session 1's skeptic
pass needs a pair; Session 3's opening is a spoken round), and the
2026-08-22 material changes (the inventory header rename, the revert
rewording, course-update, the exercise split) have not been verified against
the transcriptions whose deterministic checks quote exact wording. Session 3
is finished for the room but absent from the platform, and the right moment
to transcribe most of it is now — before the floor test freezes wording —
while withholding the tag until the room has proven it.

Going forward the operator wants dual authoring as policy: each new session
is written as the room version plus a draft platform version, and the draft
is promoted to the served manifest only after the session has been tested
in the room. The draft convention this narrative creates (staged under
`platform/drafts/`, never listed in `module.yaml`) is the mechanism; DEC-013
records the policy; PLATFORM_AUTHORING.md's "A new session, in order"
becomes the instruction future session chunks follow.

Success looks like: a platform student never reads author-facing prose; a
student alone can follow every lab step of Sessions 1–3; the validator is
clean over the existing transcriptions after the recent material changes;
Session 3's platform version is one move-and-tag away once its floor test
passes; and Session 4's chunk author knows, from the trunk, to write both
versions together.

## Chunks

1. **Dual-authoring policy and the drafts convention** — PLATFORM_AUTHORING
   "A new session, in order" rewritten; `platform/drafts/` defined in
   platform/README.md; DEC-013.
2. **Transcription drift audit (S1, S2)** — verify rubrics, audio, recall
   and quoted wording against the post-2026-08-22 material; run the
   validator; fix the derivatives.
3. **Solo-followable labs (S1–S3)** — de-room the participant lab text
   (S1 skeptic pass, S3 exercise 1, S2 sweep), add the contract-before-work
   lines and the self-paced cadence tolerance; room semantics unchanged,
   runsheets keep the room mechanics.
4. **Student-facing concept indexes** — replace README.md in
   concept.sources with a per-session student index derivative; close the
   known gap.
5. **Session 3 draft platform version** — rubric, audio, recall, manifest
   fragment with the carry-forward artifact decision, student index; staged
   in drafts, promoted after the floor test (outside this narrative).

## Completion Criteria

- `docs/trunk/PLATFORM_AUTHORING.md` and `platform/README.md` describe the
  dual-authoring flow and the drafts convention; DEC-013 records it; a
  Session 4 author following the trunk would produce both versions.
- The platform validator runs clean over `platform/` for Sessions 1 and 2
  against the current material, and every deterministic check's quoted
  wording has been verified by grep against the files it reads.
- Every lab step in Sessions 1–3's EXERCISES.md is followable by a student
  with no room, no pair and no facilitator, and each EXERCISES.md opens by
  naming what the student will hand in.
- Students on the platform no longer receive author- or facilitator-facing
  prose as concept material for Sessions 1 and 2.
- `platform/drafts/` contains a complete Session 3 platform version whose
  promotion is a move, a manifest entry, a validation and a tag — no
  authoring left — with the explicit note that promotion waits on the
  Session 3 floor test.
- The Session 3 floor test itself, the promotion, and the next platform tag
  are NOT in this narrative's scope; nor are platform-repo changes (the
  FRICTION.md manifest key remains the platform's own known gap).
