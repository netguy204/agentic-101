---
status: ACTIVE
ticket: null
parent_chunk: fluency_session_02
code_paths:
- curriculum/session_02_meeting_the_harness/README.md
- curriculum/session_02_meeting_the_harness/PREWORK.md
- curriculum/session_02_meeting_the_harness/FACILITATOR_GUIDE.md
- curriculum/session_02_meeting_the_harness/EXERCISES.md
- curriculum/session_02_meeting_the_harness/EXERCISE_RUNSHEET.md
- curriculum/session_02_meeting_the_harness/PRACTICE.md
- curriculum/session_02_meeting_the_harness/CHECKPOINT.md
- curriculum/session_02_meeting_the_harness/FLOOR_TEST.md
- curriculum/session_02_meeting_the_harness/DRY_RUN.md
- curriculum/session_02_meeting_the_harness/handouts/terminal-card.md
- curriculum/session_02_meeting_the_harness/handouts/what-did-it-do.md
- curriculum/session_01_mental_models/handouts/canned-toil.md
- env/README.md
- env/FLOOR_TEST.md
code_references:
- ref: curriculum/session_02_meeting_the_harness/README.md
  implements: Session framing that distinguishes local recovery from safety and removes
    memorization expectations
- ref: curriculum/session_02_meeting_the_harness/PREWORK.md
  implements: Participant-facing provider disclosure, bounded recovery explanation,
    and reference-card framing
- ref: curriculum/session_02_meeting_the_harness/EXERCISES.md
  implements: "Bounded local-file exercises and jargon reduction in the participant steps, with the local-recovery-not-security-boundary framing and the model-provider disclosure stated to the participant"
- ref: curriculum/session_02_meeting_the_harness/EXERCISE_RUNSHEET.md
  implements: "Corrected facilitator scripts (say-it-like-this, the before-starting statement) and neutral fallback routing"
- ref: curriculum/session_02_meeting_the_harness/FACILITATOR_GUIDE.md
  implements: Accurate privacy and recovery teaching language plus the four-part answer
    for real-work use
- ref: curriculum/session_02_meeting_the_harness/PRACTICE.md
  implements: Four-part real-work gate and human-gated pull-request, merge, and deployment
    example
- ref: curriculum/session_02_meeting_the_harness/CHECKPOINT.md
  implements: Checkpoint evidence that identifies revert as local file recovery rather
    than general safety
- ref: curriculum/session_02_meeting_the_harness/handouts/terminal-card.md
  implements: No-memorization reference, explicit terminal/pi transitions, provider
    disclosure, and recovery limits
- ref: curriculum/session_02_meeting_the_harness/handouts/what-did-it-do.md
  implements: Plain-language artifact inspection wording
- ref: "curriculum/session_01_mental_models/handouts/canned-toil.md#For Session 2\
    \ \u2014 neutral synthetic task options"
  implements: Task-centered metadata, meeting follow-up, and onboarding coordination
    fallbacks
- ref: curriculum/session_02_meeting_the_harness/FLOOR_TEST.md#Windows pass
  implements: Separation of operator-verified Windows installation from the pending
    Session 2 exercise pass
- ref: curriculum/session_02_meeting_the_harness/DRY_RUN.md
  implements: Accurate Windows verification scope in the technical dry-run record
- ref: env/README.md#Testing status
  implements: Operator-verified Windows installation status and remaining test boundaries
- ref: env/FLOOR_TEST.md#Windows installation verification
  implements: Windows operator-verification result distinct from the pending audience-floor
    test
narrative: null
investigation: null
subsystems: []
friction_entries: []
depends_on: []
created_after:
- fluency_session_02
---

# Chunk Goal

## Minor Goal

Session 2 gives non-programmer professionals an accurate mental model of data transmission, distinguishes recoverable local file changes from broader safety, and gates real-work use by judgment, authorization, consequence, and human approval. Its fallback workflows demonstrate recognizable knowledge-work toil without reducing mature participants to role-play personas, while its technical instructions rely on a reference card rather than memorization or unexplained jargon.

## Success Criteria

- Participant-facing materials consistently state that prompts and files read by pi are sent to the model provider; no claim implies that instructions remain solely on the laptop or inside the building.
- `commit` and `revert` are described as recovery for ordinary local file changes, not as containment, confidentiality, or a universal safety system.
- Real-work practice requires evaluability, authorization, non-consequential delegation, and human review before external action; a professional example shows an agent creating a pull request while a person retains merge-to-main and deployment authority.
- Synthetic fallbacks cover metadata cleanup, meeting follow-up, and onboarding coordination as neutral task options rather than identity stories.
- Participant-facing materials say nothing must be memorized, clarify terminal/pi transitions, and remove avoidable technical jargon and unexplained commands.
- Windows installation documentation records the operator-verified end-to-end installation through a functional pi while preserving the separate pending status of audience-floor and Session 2 exercise testing.
- `ve validate` passes and searches find no remaining contradictory privacy or universal-recovery claims in Session 2 participant materials.

## Relationship to Parent

`fluency_session_02` remains authoritative for the session's order: terminal orientation and a proven recovery move precede delegation, and participants still inspect agent activity, inspect the artifact, and apply their own check. This chunk corrects the parent's overly absolute privacy and safety language, broadens its generic programme-manager fallback into mature professional task options, and replaces memorization claims and insider vocabulary with clearer participant guidance.

## Rejected Ideas

### Persona-heavy role stories

Named librarian, project-manager, and HR-manager stories could make representation explicit, but were rejected because mature professionals are better served by credible task patterns than simplified identity narratives.

### Treating judgment as the only delegation gate

A participant may be able to judge an output while lacking authorization to share the data or while delegating an inappropriate consequential decision. Judgment remains necessary but is not sufficient.
