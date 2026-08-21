

# Implementation Plan

## Approach

Revise the existing Session 2 materials in place while preserving the established exercise order. Use one consistent participant-facing model for privacy, local recovery, authorization, consequence, and approval. Extend the existing canned fallback handout with task-shaped options rather than named personas. Update the managed-environment test record only for the Windows installation claim the operator has verified, keeping unrelated human-floor and Session 2 exercise checks pending.

Verification combines targeted searches for superseded claims, documentation validation, and review of the participant journey against `docs/trunk/TESTING_PHILOSOPHY.md`.

## Subsystem Considerations

## Sequence

### Step 1: Correct privacy and recovery language

Update the session index, prework, exercises, facilitator scripts, practice, checkpoint, and terminal card so they consistently distinguish provider transmission, local recovery, and broader safety.

### Step 2: Gate real-world practice

Add an explicit four-question gate: evaluability, authorization, appropriateness of delegation, and human approval before external action. Include the operator's pull-request example to show how agents can perform substantial work while merge and deployment remain human-controlled.

### Step 3: Add mature synthetic fallbacks

Extend the canned handout with metadata cleanup, meeting follow-up, and onboarding coordination options. Present them as reusable task patterns, not simplified professional identities or stories.

### Step 4: Reduce memorization and jargon

Replace the six-command promise with reference-card framing, make terminal/pi mode changes explicit, remove unexplained fallback shell syntax, and simplify participant-facing insider language.

### Step 5: Record Windows installation verification

Update `env/README.md`, `env/FLOOR_TEST.md`, and Session 2's test records to distinguish the operator-verified Windows installation-through-functional-pi path from still-pending audience-floor and full Session 2 exercise passes.

### Step 6: Validate

Run targeted phrase searches, `ve validate`, and any relevant link/path checks. Review the final diff for role-story overreach and consistency.

## Dependencies

No new software or curriculum dependencies. The implementation modifies the active `fluency_session_02` material and the existing Session 1 fallback handout it already extends.

## Risks and Open Questions

- Overcorrecting the safety language could make a bounded introductory exercise sound frightening; wording must remain candid and confidence-building.
- Role relevance can become patronizing if expressed through thin personas; examples remain task-centered.
- The operator verified Windows installation through functional pi, but this does not establish a non-programmer floor test or full Session 2 exercise pass; documentation must preserve that distinction.
