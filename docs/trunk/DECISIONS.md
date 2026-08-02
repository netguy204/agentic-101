# Design Decisions

<!--
This document logs significant design choices. Not every decision—just the
ones where there were real alternatives and the reasoning matters.

This is an append-only log. Don't delete old decisions; if a decision is
revisited, add a new entry that references the old one.
-->

## Decision Log

### DEC-001: Teach pi.dev as the sole harness

**Date**: 2026-08-01

**Status**: ACCEPTED

**Decision**: The curriculum teaches one agent harness deeply — pi.dev — and
treats adapting the harness as part of the core skill being taught.

**Context**: The course needs a concrete tool for hands-on work. The audience
is non-developers, so the obvious candidates were polished commercial tools.
But the course's thesis (GOAL.md) is that durable skill comes from designing
workflows and bending tools to fit your work — not from operating a product.

**Alternatives Considered**:
- **Claude Code (or similar full-featured agent)**: Most capable and polished,
  but highly opinionated; participants would learn its opinions rather than
  form their own, and its developer-centric surface buries the mechanics the
  course wants visible.
- **Vendor-neutral survey (multiple tools)**: Maximizes transfer in theory,
  but splits scarce hands-on time across setups and leaves participants
  shallow in everything.
- **No-code automation platforms (Zapier, n8n)**: Familiar UX for the
  audience, but they teach pipeline plumbing, not agentic delegation, and
  hide the agent loop entirely.
- **Chat-only tools (claude.ai, ChatGPT)**: Zero setup friction, but cannot
  demonstrate autonomous multi-step work on files and systems — the whole
  point of the course.

**Rationale**: pi.dev is a deliberately minimal, low-opinion harness — its
own tagline is "Adapt Pi to your workflows, not the other way around." That
makes the harness itself a teachable object: small enough to understand,
unopinionated enough that participants must exercise design judgment, and
extensible enough that harness adaptation is a genuine, achievable exercise
rather than an expert-only activity. Teaching one harness deeply preserves
scarce hands-on time; teaching a *minimal* one keeps the concepts in view.

**Consequences**: More setup friction than commercial tools — the curriculum
must own terminal basics, installation, and API-key setup (Session 2 and the
setup guide exist because of this decision). Participants leave with
transferable understanding of what any harness does, at the cost of not
knowing any polished product's UI. Curriculum maintenance includes tracking
pi.dev releases and re-pinning per cohort.

**Revisit If**: Setup friction proves too high for non-technical cohorts in
pilot (see TESTING_PHILOSOPHY.md), pi.dev stagnates or breaks compatibility
in ways that dominate maintenance, or a comparably minimal harness emerges
with materially lower setup cost.

---

### DEC-002: Multi-session cohort format

**Date**: 2026-08-01

**Status**: ACCEPTED

**Decision**: Deliver the curriculum as a live multi-session cohort course
(roughly weekly), with prework and between-session practice, rather than as a
workshop or self-paced material.

**Context**: The success bar (GOAL.md) is behavior change — participants
shipping and *continuing to use* automations of their own toil — not content
exposure.

**Alternatives Considered**:
- **1–2 day intensive workshop**: Easier to schedule and sell, but no room
  for between-session practice on real work; skills demonstrated in a
  workshop rarely survive re-entry into the job.
- **Self-paced repo/course**: Cheapest to distribute, but this audience lacks
  the scaffolding to push through setup friction and stuck points alone;
  completion rates would be poor.

**Rationale**: The skill only forms when applied to the participant's own
toil between sessions, and cohort accountability plus live facilitation are
what carry non-technical participants past friction points. The spacing also
lets the capstone develop over weeks instead of being a demo built in a rush.

**Consequences**: Materials must include facilitator guides, timing, and
fallback scripts (Session Anatomy in SPEC.md). Practice assignments are
capped so busy professionals can complete them. Self-paced use is not
designed for; if demanded later, it is a separate initiative, not a free
byproduct.

**Revisit If**: Cohort logistics consistently block delivery, or a pilot
shows between-session practice completion is so low the spacing adds no
value over an intensive format.

---

### DEC-003: Staged outcomes — fluency arc, then capstone arc

**Date**: 2026-08-01

**Status**: ACCEPTED

**Decision**: Structure the course as two arcs: build fluency and design
judgment first (Arc 1), then require every participant to ship a working
automation of their own toil as a capstone (Arc 2).

**Context**: Two plausible success bars existed: "participants can reason
about delegation" (judgment) and "participants ship a real automation"
(artifact). Either alone is insufficient — judgment without shipping doesn't
change behavior; shipping without judgment produces one brittle automation
and no ability to build the next.

**Alternatives Considered**:
- **Capstone-only / project-first**: Motivating, but non-programmers hit the
  full skill stack at once; early failure reads as "this isn't for me."
- **Fluency-only**: Lower pressure, but graduates leave with nothing running,
  and the one-month-retention success criterion becomes unmeasurable.

**Rationale**: Staging lets Arc 1 exercises be small and recoverable while
the toil inventory (started in Session 1) accumulates capstone candidates,
so the capstone is a selection from practiced material rather than a leap.
The capstone makes the course's value concrete and testable.

**Consequences**: Arc 1 sessions must each feed the toil inventory and build
toward capstone-shaped skills — no standalone "topic" sessions. The course
needs an explicit selection/rescoping gate (Session 6) so participants don't
carry unautomatable capstones into the build sessions.

**Revisit If**: Pilot cohorts show the two-arc split leaves too little build
time, or capstone completion rates indicate the fluency arc is too long or
too short.

---

### DEC-004: Audience floor is the non-programmer knowledge worker

**Date**: 2026-08-01

**Status**: ACCEPTED

**Decision**: Design every session, exercise, and document for mixed
knowledge workers with no programming background; technically fluent
participants are accommodated, never required.

**Context**: Cohorts will mix operations, finance, marketing, and PM
backgrounds with the occasional analyst who can read a script. The material
has to pick a floor, because exercises that assume the wrong one fail
publicly and demoralize exactly the people the course exists for.

**Alternatives Considered**:
- **Technical floor (can use a terminal)**: Simplifies Sessions 1–2
  substantially, but excludes most of the intended audience or forces an
  unadvertised prerequisite.
- **Dual-track material**: Serves both audiences on paper, but doubles
  authoring and facilitation load and fragments the cohort experience.

**Rationale**: The problem statement (GOAL.md) is precisely that existing
material serves developers. Setting the floor at the non-programmer keeps
the course pointed at the underserved audience; faster participants are
absorbed via optional depth (e.g., richer harness adaptations) rather than
separate tracks.

**Consequences**: The curriculum owns terminal basics and environment setup
(compounding the cost accepted in DEC-001). Exercise instructions must be
tested against the floor, not the median (TESTING_PHILOSOPHY.md). Advanced
participants may find early sessions slow; optional extensions in practice
assignments are the pressure valve.

**Revisit If**: Actual cohort composition skews technical enough that the
floor wastes most participants' time, or pilot testing shows the
non-programmer floor is unreachable within the session budget.

---

### DEC-005: Judgment-centered pedagogy

**Date**: 2026-08-01

**Status**: ACCEPTED

**Decision**: Organize the entire curriculum around one thesis: successful
use of agentic tooling comes down to understanding where your judgment is
required and applying it with maximum leverage. Every session, exercise, and
the capstone selection gate teach against this frame.

**Context**: A curriculum needs an organizing principle that tells authors
what to include and participants how to generalize. The operator holds this
thesis strongly, with two corollaries: (1) judgment, not expertise, bounds
safe delegation — delegating where you lack expertise is fine, delegating
where you cannot discern reasonable from unreasonable is extremely risky;
and (2) once those bounds are understood, growth comes from applying
judgment more judiciously, at higher-leverage points, not from automating
more indiscriminately.

**Alternatives Considered**:
- **Capability-first framing** ("look what agents can do"): Motivating and
  demo-friendly, but it actively invites the failure mode the thesis names —
  delegating past your judgment boundary because the agent *seems* capable.
- **Risk-checklist framing** (rules for what not to automate): Safe but
  brittle; checklists don't transfer to novel tasks and infantilize an
  audience whose professional judgment is precisely the asset being
  leveraged.
- **Tool-mastery framing** (learn the harness deeply, wisdom follows):
  Concrete and testable, but produces operators, not designers — the exact
  gap identified in GOAL.md's problem statement.

**Rationale**: The judgment frame gives participants a single test they can
apply to any task, including ones no session covered: "can I tell a
reasonable result from an unreasonable one here?" It simultaneously explains
the safety rule (stay inside your judgment boundary) and the growth path
(more delegated work governed per unit of judgment spent). It also respects
the audience: mixed knowledge workers arrive rich in domain judgment and
poor in tooling — the curriculum converts their existing asset into
leverage rather than asking them to acquire a new one. For the first time,
their judgment can compound the way a software engineer's has for decades:
encoded once, governing unbounded executions, no longer applied one meeting
or one document at a time (GOAL.md, "why the moment matters").

**Consequences**: Evaluating agent output gets as much exercise time as
producing it. The toil inventory records judgeability alongside each task.
Capstone selection (Session 6) screens candidates against the participant's
judgment boundary, and rejecting a task as outside it is treated as
demonstrated skill, not failure. Workflow-design sessions teach checkpoint
placement — where to concentrate judgment — as the core leverage move.
Capability showcases, where used, are always paired with "how would you
check this?"

**Revisit If**: Pilot cohorts show the framing is too abstract for the
audience floor to operationalize, or participants systematically
misclassify their own judgment boundaries in ways the frame can't correct.

---

### DEC-006: Operator-provisioned participant environment

**Date**: 2026-08-02

**Status**: ACCEPTED

**Decision**: Participants do not bring their own auth, model choice, or
terminal. The operator provides each participant an OpenRouter API key; a
shipped pi configuration prescribes the model; and the curriculum ships a
managed cross-platform terminal environment with guided convenience
commands (initially `commit` and `revert`) on the PATH.

**Context**: pi deliberately supports many providers, auth paths
(subscription OAuth, API keys, env vars), and any terminal — and pi's
keybindings behave differently across terminal apps. Left to defaults, a
cohort of non-programmers would arrive with heterogeneous providers,
models, billing exposure, and terminal behavior. Every axis of variation
is a facilitation tax and a floor-testing invalidator: material tested in
one environment silently breaks in another.

**Alternatives Considered**:
- **Bring-your-own API keys**: account creation + billing setup is the
  highest-abandonment step possible for this audience, with heterogeneous
  cost exposure.
- **Subscription OAuth (`/login` with Claude Pro/Max, ChatGPT, Copilot)**:
  lowest friction for subscribers, but fragments provider/model across the
  cohort and Claude Pro/Max via third-party harnesses bills per-token
  *extra usage* — a surprise-cost trap.
- **Stock native terminals with per-platform instructions**: avoids
  shipping an environment, but doubles documentation, breaks keybinding
  consistency, and leaves git-level safety (pi has no undo) untaught or
  terrifying.

**Rationale**: One identical environment converts setup from comprehension
to verification (the setup guide can show exact expected output for every
step), makes floor testing meaningful (test once, valid for everyone),
gives the facilitator one debuggable surface, and centralizes spend
control. The guided `commit`/`revert` wrappers deliver checkpointing
safety — the mitigation for pi's lack of undo — without teaching git,
consistent with the audience floor (DEC-004) and the not-a-programming-
course scope (GOAL.md).

**Consequences**: The operator bears usage costs and key management
(issuance, spend limits, rotation). The curriculum owns a software
deliverable (the managed environment) with real maintenance, not just
documents. Participants' course environment differs from what they'd
assemble alone — an off-ramp ("using your own key and terminal after the
course") should eventually be documented so graduates aren't stranded.
Chunks affected: onboarding_terminal_env, onboarding_setup_guide, and
Session 2's terminal teaching.

**Revisit If**: Operator-side cost or key-management burden proves
unsustainable, the managed environment's maintenance dominates curriculum
upkeep, or OpenRouter's model coverage/pricing stops fitting the
prescribed-model approach.

---

### DEC-007: Prescribed terminals — Windows Terminal + Git Bash on Windows, Ghostty on macOS

**Date**: 2026-08-02

**Status**: ACCEPTED

**Decision**: The managed environment (DEC-006) prescribes per-platform
flagship terminals: on Windows, Windows Terminal running a Git Bash
(Git for Windows) profile set as default; on macOS, Ghostty. Shell
commands in all course material are bash on both platforms.

**Context**: pi's core UX (Shift+Enter newline, Alt+Enter queueing)
depends on the Kitty keyboard protocol, which stock terminals support
unevenly, and pi requires a bash shell on Windows. The operator's ideal
was one terminal identical everywhere. Research (August 2026, verified
2026-08-02; full report in
docs/chunks/onboarding_terminal_env/terminal-research.md) found no single
terminal that is simultaneously first-class on both platforms, healthy,
and Kitty-protocol-solid.

**Alternatives Considered**:
- **WezTerm on both platforms** (the single-app option): full protocol
  support and one config file, but its latest stable release is
  2024-02-03 with active development only in nightlies — prescribing
  stale or nightly builds to dozens of novices is a worse trade than
  per-platform chrome differences. Strengthens if WezTerm resumes stable
  releases.
- **Ghostty everywhere**: reference-quality protocol support but no
  official Windows build (community forks are unaffiliated and must not
  be suggested to participants).
- **WSL2 for bash on Windows**: right for developers, wrong here —
  reboot + virtualization requirements, a second filesystem, and a
  second Node/npm install are each support tickets multiplied by a
  cohort.
- **iTerm2 on macOS**: acceptable substitute (pi works out of the box);
  Ghostty preferred for its scriptable plain-text config and defaults.
- **Alacritty, Tabby, Hyper, Rio, Warp**: eliminated on protocol gaps,
  abandonment, obscurity, or account-nudge onboarding (details in the
  research report).

**Rationale**: The experience that fills the course — bash prompt, shell
commands, pi TUI with working keybindings — is identical across the
pairing; what differs (window chrome, Cmd vs Ctrl) differs on any
cross-platform choice. Git Bash is pi's own documented Windows path
(auto-discovered at `C:\Program Files\Git\bin\bash.exe`), keeps the
participant's home directory in their real Windows profile, and reaches
Windows npm — where pi installs — with zero extra steps. Both terminals
are their platform's flagship: largest user bases, active releases, MIT,
free, no accounts, non-interactively installable (winget/brew).

**Consequences**: The environment installer maintains two platform
scripts. On Windows the installer must patch Windows Terminal's
settings.json with pi's documented `sendInput` bindings for Shift+Enter
and Alt+Enter (required while stable WT lacks native Kitty protocol —
confirmed still Preview-only as of 2026-08-02 — and harmless after) and
set Git Bash as the default profile so participants never launch the
Start-menu mintty "Git Bash" icon. On macOS the installer appends pi's
documented keybind lines to Ghostty's config. Floor testing must audit
the full pi keybinding list on stable Windows Terminal and Option+Enter
behavior on Ghostty.

**Revisit If**: WezTerm resumes stable releases (re-run the single-app
comparison), Ghostty ships an official Windows build, or floor testing
surfaces protocol failures the sendInput/keybind patches can't cover.

---

### DEC-008: Environment source in `env/`, install root `~/.agentic-101/`, bash inside Ghostty on macOS

**Date**: 2026-08-02

**Status**: ACCEPTED

**Decision**: The managed environment's source lives in the repository's
top-level `env/` directory; it installs into a single self-contained root,
`~/.agentic-101/`; and on macOS the prescribed terminal (Ghostty) runs
bash (`command = /bin/bash -l`) so that both platforms present the same
shell.

**Context**: Implementing DEC-006/DEC-007 forced three placement choices:
where the environment's source lives relative to `setup/`, where it
installs on participant machines, and what shell macOS participants get —
Ghostty would default to zsh while Windows participants get Git Bash.

**Alternatives Considered**:
- **Source inside `setup/`**: rejected — `setup/` owns participant-facing
  instructions authored by a different chunk (onboarding_setup_guide);
  mixing installable software into it blurs which chunk owns what.
- **Keep zsh on macOS** with a parallel zsh prompt and rc file: rejected —
  doubles the startup-file surface (two rc files, two prompt syntaxes, two
  PATH mechanisms) and diverges the platforms exactly where DEC-007 says
  they should converge. Scripts are written to bash 3.2 (macOS system
  bash) so identical files run under Git Bash's bash 5.
- **Scattered install (commands into /usr/local/bin, config in place)**:
  rejected — a single root makes uninstall honest and the "what did this
  change on my machine" story tellable in one sentence.

**Rationale**: One shell means one startup file (`~/.bash_profile`), one
prompt, one PATH mechanism, and one scripting dialect for
`commit`/`revert` on both platforms. Scoping the bash switch to Ghostty's
config leaves the participant's system login shell untouched — nothing
outside the course terminal changes.

**Consequences**: Course material can assume bash syntax everywhere.
Participants who open stock Terminal.app on macOS still get the commands
on PATH (a guarded `~/.zshrc` block) but not the course prompt or
keybindings. All environment edits are delimited managed blocks with
timestamped backups; `env/uninstall.sh` reverses them but deliberately
leaves installed applications alone.

**Revisit If**: A future macOS drops bash from the base system, or session
material turns out to need zsh-specific behavior.
