# Testing Philosophy

<!--
This document establishes how we think about verification in this project.
The "system under test" here is a curriculum, not software: verification
means checking that the material actually produces the outcomes GOAL.md
claims, for the audience it claims them for.
-->

## Testing Principles

- **The audience floor is the test environment.** An exercise "works" only if
  a non-programmer knowledge worker (DEC-004) can complete it from the
  written material. That it works for the author proves nothing — the author
  is the wrong test environment.
- **A confused participant is a bug report, not a participant problem.**
  Stuck points, misread instructions, and "wait, what do I type?" moments get
  logged and fixed like defects (route them to docs/trunk/FRICTION.md).
- **Test against reality before the cohort does.** Every exercise is executed
  end-to-end on a clean machine before it is taught. Agentic exercises are
  additionally run more than once, because model behavior varies.
- **Design exercises to be outcome-checked, not output-checked.** Agent
  output is nondeterministic; exercises must define success as an observable
  outcome ("the agent produced a file that does X, and you verified it") so
  they remain valid across model and version changes.
- **The capstone is the end-to-end test.** Capstone completion and one-month
  retention (GOAL.md success criteria) are the ultimate verification of the
  whole curriculum; everything else is earlier, cheaper signal.

## Test Categories

### Exercise Dry-Runs

Every exercise and demo script is executed from its written instructions on
a clean environment (fresh pi.dev install, pinned versions) before first
teach and again before each cohort. Agentic steps are run at least twice to
sample nondeterminism. The dry-run follows the text literally — if the
runner has to improvise, the text fails.

### Setup Smoke Test

The pre-cohort setup guide ends in a smoke test a participant can run and
interpret themselves (SPEC.md, Prerequisites). It verifies: tools installed,
API key working, a trivial agent task completes. Maintained for macOS and
Windows; re-run whenever a pinned version changes.

### Floor Testing

Before a session is considered done the first time, at least one person
matching the audience floor — comfortable with computers, no programming or
terminal background — works through its prework and exercises while an
author observes silently. Observed friction is fixed, not explained away.

### Pilot Cohort

The first delivery of the full curriculum is explicitly a pilot: smaller
cohort, participants told they are testing the material, extra time buffered
per session, and structured debriefs after each session. Several DEC entries
name pilot results as their revisit trigger; the pilot is where those get
measured.

### In-Session Checkpoints

Each session defines a checkpoint (SPEC.md, Session Anatomy): an observable
participant behavior that tells the facilitator the outcome landed — e.g.,
"every participant has run a delegation and can say what the agent did."
Checkpoints failing mid-cohort trigger adjustment of later sessions, not
just notes for next time.

### Cohort Feedback and Retention Survey

Per-session micro-feedback (what was confusing, what was skipped), an
end-of-cohort survey against the fluency outcomes, and the one-month
follow-up measuring whether capstone automations are still in use. Results
feed the between-cohort revision cycle.

## Hard-to-Test Properties

- **Model nondeterminism**: An exercise can pass dry-runs and still go
  sideways live. Mitigations: outcome-checked design (principle above),
  facilitator guides that script the common failure modes and recovery
  moves, and a "no dead ends" fallback per exercise (SPEC.md, Guarantees).
- **Tool and model drift between cohorts**: Versions are pinned per cohort;
  the full dry-run suite re-runs against new pins before any cohort starts.
  Drift discovered mid-cohort is handled by staying on the pinned versions.
- **Design judgment (the real outcome)**: Fluency is hard to observe
  directly. Proxy: the capstone selection session (Session 6) doubles as an
  assessment — the quality of participants' delegation candidates and
  decompositions is the measurable trace of judgment.
- **Heterogeneous cohorts**: A session can pass floor testing and still lose
  a live cohort's fast half or slow half. Mitigation: optional-depth
  extensions in practice assignments (DEC-004) and facilitator pacing notes.

## What We Don't Test

- **Participants' job performance.** We measure whether automations exist
  and remain in use, not their business impact — that data belongs to the
  participant's employer and isn't collectible honestly.
- **Long-term retention beyond one month.** Worth knowing, not worth the
  survey-fatigue cost at this scale.
- **Portability to unpinned versions.** The curriculum is only claimed to
  work at its pinned versions; forward compatibility is handled by the
  pre-cohort re-validation, not by continuous testing.

## Test Organization

- Dry-run and floor-test results are recorded per session alongside the
  session material in `curriculum/` (exact form solidifies with the
  repository layout, SPEC.md).
- The pre-cohort checklist — re-pin versions, re-run smoke test on both
  platforms, re-run exercise dry-runs, tag `cohort-YYYY-MM` — lives in
  `setup/` and is itself versioned.
- Friction found during any test category is logged to
  docs/trunk/FRICTION.md so recurring pain becomes visible across cohorts.

## CI Requirements

Automation is intentionally light for a documentation-heavy project:

- `ve validate` passes (documentation reference integrity).
- Link and path checks over `curriculum/` and `setup/` once they exist.
- The setup smoke-test script runs in CI where feasible (install + trivial
  agent task with a pinned model), acknowledging that live-model steps may
  need to be stubbed or run pre-cohort instead.

Everything else in this document is human-executed by design: the properties
that matter are about people learning, and no CI job observes that.
