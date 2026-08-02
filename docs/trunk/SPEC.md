# Specification

<!--
This document is the contract. For a curriculum, that means: it defines the
structure, terminology, and quality bars precisely enough that a session or
exercise could be checked for conformance against it.

Mark sections as DRAFT if they're not yet solidified.
-->

## Overview

This specification defines the structure of the Agentic 101 curriculum: its
two-arc progression, the anatomy of a session, the artifacts each session must
contain, participant prerequisites, and how the curriculum is versioned across
cohorts. GOAL.md defines what the curriculum must achieve; this document
defines the shape of the thing that achieves it.

## Terminology

- **Toil**: Recurring, judgment-light work a participant performs manually —
  the raw material every exercise and the capstone operate on.
- **Harness**: The software environment in which an agent runs — its tools,
  configuration, prompts, and extensions. The teaching harness is pi.dev.
- **Agent**: An LLM running in a harness with the ability to take actions
  (read/write files, run commands, call tools), not just converse.
- **Workflow**: A designed, repeatable delegation — a task decomposed into
  steps an agent executes, with defined inputs, outputs, and checkpoints.
- **Delegation**: Handing a task to an agent with enough structure that it
  completes without step-by-step supervision.
- **Judgment**: The ability to discern a reasonable result from an
  unreasonable one in a given domain — to *evaluate* work without
  necessarily being able to produce it.
- **Expertise**: The ability to produce the work yourself. Delegation can
  substitute for expertise; nothing substitutes for judgment.
- **Judgment boundary**: The edge of the space where a participant can
  evaluate outcomes. Tasks inside the boundary are candidates for
  delegation; tasks outside it are not, regardless of how capable the agent
  is (GOAL.md, thesis).
- **Leverage**: The amount of delegated work governed per unit of judgment
  spent. Workflows gain leverage by concentrating judgment at a few
  decisive checkpoints instead of spreading it across every step.
- **Harness adaptation**: Any deliberate modification of the harness to fit
  the participant's work — configuration, prompt templates, skills,
  extensions.
- **Session**: One live cohort meeting plus its prework and practice.
- **Arc**: A contiguous group of sessions with a shared outcome. The
  curriculum has two: **Fluency** and **Capstone**.
- **Prework**: Material a participant completes before a session (≤30 min).
- **Practice**: Between-session application of a session's content to the
  participant's own toil (≤90 min).
- **Capstone**: The final deliverable — a working workflow automating a real
  piece of the participant's toil, demonstrated to the cohort.
- **Toil inventory**: A running list each participant keeps of their own
  delegation candidates, started in Session 1 and mined for the capstone.
  Each entry records not just the task but whether it sits inside the
  participant's judgment boundary — could they evaluate the output?
- **Facilitator guide**: The per-session document that makes a session
  teachable by someone who didn't author it.

## Curriculum Structure (DRAFT)

The curriculum is a multi-session cohort course organized as two arcs.
Session count and titles are draft; the arc structure and outcomes are stable.

### Arc 1 — Fluency (approximately sessions 1–5)

Outcome: participants can judge delegability, direct an agent effectively,
decompose real tasks into workflows, and adapt their harness. Draft session
progression:

1. **Mental models & toil inventory** — what agents are and aren't; how an
   agent differs from a chatbot; judgment vs expertise and drawing your own
   judgment boundary; starting the toil inventory.
2. **Meeting the harness** — terminal survival kit; installing and running
   pi.dev; first delegations; reading what the agent actually did and judging
   whether it was reasonable.
3. **Anatomy of a delegation** — decomposing a task; inputs, outputs,
   checkpoints; writing instructions that survive contact with the agent.
4. **Workflow design** — from one-off delegation to repeatable workflow;
   failure modes and verification; concentrating judgment at the checkpoints
   where it buys the most leverage.
5. **Adapting the harness** — configuration, prompt templates, skills, and
   extensions; making pi.dev fit your work instead of the reverse.

### Arc 2 — Capstone (approximately sessions 6–8)

Outcome: each participant ships a real automation. Draft progression:

6. **Capstone selection & design** — choosing from the toil inventory;
   design review with the cohort.
7. **Build & iterate** — working session; facilitator and peer support;
   handling the gap between design and reality.
8. **Ship & demo** — live demonstrations; hardening for ongoing use;
   what to automate next.

## Session Anatomy

Every session, when authored, consists of:

- **Facilitator guide** — timing, talking points, live-demo scripts,
  anticipated failure points, and recovery moves.
- **Prework** — reading/setup completable in ≤30 minutes by a non-programmer.
- **In-session exercises** — hands-on work operating on the participant's own
  toil wherever possible, with a canned fallback for anyone who can't use
  their real work (confidentiality, no laptop, etc.).
- **Practice assignment** — between-session application, ≤90 minutes,
  designed to displace existing toil rather than add homework.
- **Checkpoint** — an observable behavior that tells the facilitator the
  session's outcome was reached (see TESTING_PHILOSOPHY.md).

## Repository Layout (DRAFT)

- `docs/` — VE project documentation (this tree).
- `curriculum/` — the deliverable material, one directory per session
  (`curriculum/session_01_mental_models/`, etc.), each containing the
  artifacts listed in Session Anatomy.
- `setup/` — participant environment setup instructions and smoke-test
  script (see Prerequisites). Consumes the installer from `env/`.
- `env/` — source of the managed terminal environment (DEC-006/DEC-007/
  DEC-008): platform installers, the guided `commit`/`revert`/
  `course-check` commands, per-cohort version pins (`env/versions.env`),
  smoke tests, and the floor-test protocol.

Layout is draft until the first session chunk is implemented (`env/` is
settled per DEC-008).

## Participant Prerequisites

The curriculum guarantees a starting bar and must not silently assume more:

- A laptop the participant can install software on (macOS or Windows;
  instructions maintained for both).
- Comfort with everyday computer use: files, folders, browser, installing
  applications. **No terminal experience assumed** — Session 2 teaches it.
- LLM API access or subscription; the setup guide states expected costs
  before the cohort begins.
- Completion of the pre-cohort setup guide, verified by a smoke test a
  non-programmer can run and interpret.

## Guarantees

- **Every exercise is completable by the stated audience.** If an exercise
  requires skills not yet taught, that is a curriculum bug.
- **Concept/mechanics separation.** Each session's core concepts are stated
  independently of tool mechanics, so tool churn forces only mechanical
  updates (see GOAL.md durability property).
- **No dead ends.** Every exercise has a documented fallback path for
  participants who get stuck (canned example, pairing, facilitator script).

What is NOT guaranteed: that every participant's chosen toil is automatable
as scoped — capstone selection (Session 6) exists to catch and rescope these.

## Versioning and Compatibility

- The curriculum is versioned per cohort: a git tag (`cohort-YYYY-MM`) marks
  exactly what a cohort was taught.
- Tool versions (pi.dev, models) are pinned in the setup guide per cohort and
  re-validated before each new cohort (see TESTING_PHILOSOPHY.md).
- Material changes between cohorts are ordinary VE chunks; the trunk documents
  change only when the course's goals or structure genuinely change.

## DRAFT Sections

- [ ] Curriculum Structure: session count, titles, and per-session outcomes
      solidify as session chunks are planned.
- [ ] Repository Layout: solidifies with the first implemented session chunk.
