# Project Goal

<!--
This document is the stable anchor for the entire project. It should rarely change.
Write in terms of WHAT and WHY, not HOW. The how belongs in SPEC.md and in chunks.
-->

## Problem Statement

Working professionals — in operations, finance, marketing, program management,
and other knowledge work — spend a meaningful fraction of every week on toil:
repetitive, judgment-light tasks like report assembly, inbox triage, data
reshaping, status chasing, and document formatting. Agentic AI tooling is now
capable of absorbing much of this work, but the professionals who would benefit
most are the least served by existing training:

- **Developer-oriented material** assumes fluency with code, git, and software
  workflows that this audience does not have.
- **"Prompt tips" material** teaches conversational tricks, not the durable
  skill of decomposing work, designing a workflow, and delegating it to an
  agent that runs without hand-holding.
- **Opinionated commercial tools** teach users to operate a product, not to
  reason about automation. When the product changes or doesn't fit their work,
  the skill evaporates.

The missing skill is **agentic workflow design**, and its foundation is
judgment. Successful use of agentic tooling comes down to understanding where
your judgment is required and applying it with maximum leverage. Two things
fall out of that thesis:

1. **Judgment, not expertise, bounds safe delegation.** It is fine — often
   ideal — to delegate work you lack the expertise to do yourself, so long as
   you can discern a reasonable result from an unreasonable one. Delegating
   where you *cannot* make that discernment is extremely risky: plausible-but-
   wrong output passes unchallenged. The boundary of your judgment, not your
   ability to do the work by hand, defines the space of problems you should
   solve with an agent.
2. **Leverage comes from spending judgment judiciously.** Once the bounds are
   understood, you don't grow by automating more indiscriminately — you grow
   by applying your judgment at fewer, higher-leverage points: in the design
   of the workflow and at the checkpoints that govern the most delegated work.

This thesis is also why the moment matters. Software engineers have had
leveraged judgment for decades, for one structural reason: they could encode
a decision once, in code, and have it govern unbounded executions. Everyone
else's judgment — however good — ran only in person: one meeting, one
review, one document at a time. It never compounded. Agentic tooling is the
first technology that lets judgment expressed in plain language govern
automated work, which means the leverage that used to require knowing how to
program now requires only knowing what reasonable looks like. This
curriculum's audience already owns the scarce input; what they lack is the
machinery, and the machinery just became accessible.

The curriculum teaches that skill — recognizing which of your own tasks are
delegable, decomposing them into agent-shaped pieces, building the workflow,
and adapting your tools, including the agent harness itself, when they don't
fit — to non-developers, delivered as a multi-session cohort course.

## Required Properties

- **Judgment-centered.** Every session traces back to the central thesis:
  locate where your judgment is required, respect its bounds, and apply it
  with maximum leverage (DEC-005). Participants learn to map their own
  judgment boundary and treat it — not their expertise — as the limit on what
  they delegate. Evaluating agent output is drilled as seriously as producing
  it.
- **Accessible to non-programmers.** A participant who is comfortable with
  computers but has never written code or opened a terminal must be able to
  complete every session. Any technical prerequisite (terminal basics,
  installing tools, API keys) is taught inside the curriculum, not assumed.
- **Teaches design judgment, not tool trivia.** The core deliverable is the
  participant's ability to evaluate a task for delegability and design a
  workflow around it. Tool mechanics are the medium, never the message.
- **Grounded in each participant's real toil.** Exercises operate on the
  participant's own work wherever possible. Canned examples exist only as
  fallbacks and for shared vocabulary.
- **Harness adaptation is first-class.** Participants learn that the harness
  (pi.dev) is theirs to modify — configuring, extending, and reshaping it is
  part of the skill being taught, not an advanced afterthought. See DEC-001.
- **Staged outcomes.** The curriculum builds fluency and judgment first, then
  requires each participant to ship a working automation of their own toil as
  a capstone. See DEC-003.
- **Cohort-deliverable.** The material must be teachable as a live
  multi-session course: facilitator notes, session timing, prework, and
  between-session practice are part of the curriculum, not left to the
  instructor to invent. See DEC-002.
- **Durable against tool churn.** Concepts and exercise designs must survive
  model and tool version changes with only mechanical updates (version pins,
  screenshots, command syntax).

## Constraints

- **Audience:** mixed knowledge workers with heterogeneous technical comfort;
  no programming background can be assumed.
- **Participant time:** busy professionals; between-session work must fit in
  roughly 1–2 hours per week and ideally *replaces* existing toil rather than
  adding to it.
- **Harness:** pi.dev is the teaching harness (DEC-001). The curriculum may
  reference other tools for contrast but teaches one harness deeply.
- **Delivery:** live cohort sessions; material must work over video call as
  well as in person.
- **Cost:** participants need LLM API access; setup and per-session usage
  costs must be modest and stated up front.

## Out of Scope

- **Teaching programming.** Participants may end up reading or lightly editing
  configuration and small scripts, but this is not a software development
  course and does not aim to produce programmers.
- **LLM internals.** How models are trained, fine-tuning, evals, and ML theory
  are out of scope beyond the minimal mental model needed to predict agent
  behavior.
- **Building agents from scratch.** API-level agent development, SDK
  programming, and harness authorship are out of scope; *adapting* an existing
  harness is in scope.
- **Enterprise rollout.** Procurement, governance, security review, and
  org-wide deployment of agentic tooling are not covered.
- **Vendor certification.** The course does not aim to certify mastery of any
  commercial product.

## Success Criteria

- A participant with no programming background completes the fluency arc and
  can, unaided: judge a candidate task against their own judgment boundary
  (including rejecting tasks whose output they couldn't evaluate), decompose
  a real task into an agent-runnable workflow with judgment concentrated at
  the checkpoints that matter, and articulate the failure modes to guard
  against.
- Every graduating participant ships a capstone: a working agentic workflow
  that automates a real piece of their own recurring toil, demonstrated live
  to the cohort.
- At least half of capstone automations are still in use one month after the
  cohort ends (measured by follow-up survey).
- Each participant has made at least one deliberate adaptation of their
  harness (configuration, prompt template, skill, or extension) to fit their
  own work.
- The curriculum is re-teachable: a facilitator who did not author it can run
  a cohort from the materials alone.
