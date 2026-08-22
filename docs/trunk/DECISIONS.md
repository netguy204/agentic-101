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

---

### DEC-009: Setup writes pi's configuration for the participant; pins split across two files

**Date**: 2026-08-02

**Status**: ACCEPTED

**Decision**: `setup/` completes DEC-006's operator-provisioned environment
with a scripted step rather than a narrated one. `setup/install-pi.sh`
installs pi at a pinned npm version and writes both
`~/.pi/agent/settings.json` (the prescribed provider, model, and thinking
level) and `~/.pi/agent/auth.json` (the operator's OpenRouter key, `0600`)
directly. Version pins live in two files by domain — `env/versions.env` for
the terminal environment, `setup/pins.env` for pi and the model — and
`setup/` installs its smoke test into the environment's install root,
`~/.agentic-101/bin`.

**Context**: DEC-006 settled *what* participants get (one key, one model, one
terminal). Implementing the setup guide forced three questions it left open:
how the key reaches pi, where the pi and model pins live relative to the
environment's pins, and where a participant-runnable smoke test lives.

**Alternatives Considered**:
- **Walk participants through pi's `/login`**: the path pi itself documents,
  and it means no script ever handles a key. Rejected: `/login` is an
  interactive TUI with a provider list of dozens of entries and arrow-key
  navigation. It cannot be paired with exact expected output, and it fails
  the guide's copy-paste-and-verify rule (chunk GOAL.md) for an audience
  that has never used a terminal (DEC-004).
- **`export OPENROUTER_API_KEY=…`**: one line, no file writing. Rejected: an
  exported variable lives only in the window that set it. A participant who
  closes the terminal loses their key with no visible cause, and the fix —
  editing a shell startup file — is exactly the knowledge the floor says we
  cannot assume.
- **One pin file for everything**: fewer files. Rejected: the two pin sets
  are enforced differently (npm and winget install an exact version;
  Homebrew casks cannot) and are re-validated by different procedures. One
  file would have to explain both, and a mistake in either half would look
  like a mistake in the other.
- **A separate install root for `setup/`**: cleaner chunk ownership.
  Rejected: it would give the participant two PATH entries and two things to
  uninstall, and `env/uninstall.sh` would silently leave half the course
  behind.

**Rationale**: Scripting the configuration is the same trade the environment
installer already made — "runs start to finish with no questions asked" —
extended to the last two files pi needs. It converts the participant's auth
step into pasting one line their facilitator composed for them, which is the
only shape of this step that survives contact with the audience floor.
`auth.json` is what pi's own `/login` would have written, survives shell
restarts, is created `0600`, and takes priority over environment variables
(pi `docs/providers.md`, Auth File). Splitting the pins keeps each file
truthful about how its pins are enforced; sharing one install root keeps the
uninstall story a single sentence.

**Consequences**: The course key is pasted on a command line and therefore
lands in shell history — keys must be per-participant, spend-limited, and
rotated after each cohort (`setup/PRE_COHORT_CHECKLIST.md` item 3). `setup/`
now writes into a directory `env/` owns, so the two must stay in step: this
is a named contract, not an accident, and `EXPECTED_ENV_VERSION` in
`setup/pins.env` makes a mismatch visible. Re-pinning a cohort means editing
two files and the sample outputs in `setup/README.md`, which the checklist
enforces. The chunk that eventually documents the post-course off-ramp
(DEC-006, Consequences) will need to explain how to replace the shipped
`settings.json` and `auth.json` with the graduate's own.

**Revisit If**: pi ships a non-interactive login command that a participant
could paste (which would make the script's file-writing unnecessary), the
operator moves to per-participant provisioning that never puts a key on a
command line, or the two pin files drift often enough that one file with two
clearly labelled halves proves less error-prone.

---

### DEC-010: Fixed per-session directory convention; the toil inventory is a four-column sheet owned by Session 1

**Date**: 2026-08-02

**Status**: ACCEPTED

**Amended**: DEC-011 (2026-08-22) — the in-session exercises element is two
files, `EXERCISES.md` (participant) and `EXERCISE_RUNSHEET.md`
(facilitator); seven fixed filenames, not six.

**Decision**: Course material lives in `curriculum/session_<NN>_<slug>/`,
each session carrying the same six filenames (`README.md`, `PREWORK.md`,
`FACILITATOR_GUIDE.md`, `EXERCISES.md`, `PRACTICE.md`, `CHECKPOINT.md`)
plus optional `handouts/`, `FLOOR_TEST.md`, and `DRY_RUN.md`. The toil
inventory is a handout owned by the session that introduces it
(`curriculum/session_01_mental_models/handouts/toil-inventory.md`) with
four columns — the task and its frequency, what "done right" looks like,
in/out/not-sure judgeability, and how the participant would check. Later
sessions may add columns; they may not rename or renumber these four, and
they extend the original file rather than forking a copy.

**Context**: SPEC.md's Repository Layout left `curriculum/` DRAFT pending
the first implemented session. Session 1 forced both halves of it: where
session material lives, and what shape the artifact that survives all six
sessions takes. The inventory is the only participant artifact that
crosses every session boundary — Session 2 picks a first delegation from
it, Sessions 3–5 use entries as exercise material, and Session 6 gates
capstone selection on it (DEC-003) — so its format is a contract between
chunks that do not yet exist.

**Alternatives Considered**:
- **Free-form per-session structure**, each session chunk choosing its own
  filenames: less ceremony for the author, but a facilitator would have to
  re-learn the layout every session, and no chunk could reference another
  session's material before that session was written. The convention's
  main value is that `curriculum/session_04_workflow_design/EXERCISES.md`
  is a correct reference today.
- **Session-anatomy artifacts as sections of one long per-session
  document**: fewer files, and the material reads in order. Rejected
  because the five artifacts have four different audiences and lifetimes —
  prework is emailed to participants, the facilitator guide is read
  privately before the room, handouts are printed. A single file gets sent
  to a participant with the demo reveal in it.
- **Inventory as a spreadsheet template** (xlsx/Google Sheet): sortable,
  and Session 6 could filter it. Rejected on the audience floor — the
  inventory has to be fillable by someone whose setup failed, in a room,
  with a pen, and the best entries are written in the ten seconds after
  someone catches themselves doing something. A binary file also can't be
  versioned or reviewed in this repository.
- **Recording only the task and a yes/no judgeability flag** (the GOAL's
  literal minimum): simpler, but a flag with no evidence behind it is
  unfalsifiable. The "how I'd check" column is what makes the checkpoint
  observable and what stops "I do it every week" being accepted as an
  answer to judgeability.

**Rationale**: Fixed names mean the convention is learnable once and
referenceable before it exists. Keeping the inventory in the introducing
session's `handouts/` gives it one owner and one location for six
sessions' worth of references, at the cost of Session 6 reaching back into
Session 1's directory — which is honest about where the artifact came
from. Four columns is the smallest set that supports both the Session 1
checkpoint (judgeability, with evidence) and the Session 6 gate
(frequency and duration, to reject a well-judged but trivial capstone).

**Consequences**: Every session chunk creates all six files even when one
is thin; a missing file means "this session has no checkpoint", which is
never intended. Later sessions that want more from the inventory add
columns rather than redesigning it, so a sheet filled in during Session 1
stays valid to the end of the course. `docs/trunk/SPEC.md`'s Repository
Layout is no longer DRAFT. The four-column bet is unvalidated: Sessions
2–6 do not exist, and the first real test of the format is Session 6's
capstone gate.

**Revisit If**: authoring Sessions 2–5 shows the six-file set is wrong for
a hands-on session (a dry-run record or a demo asset directory may want
promoting from optional to required), or the inventory's columns prove
insufficient at the Session 6 gate — most likely by failing to capture
something about a task's *shape* that decides whether it is automatable at
all, which is currently discovered in Session 6 rather than recorded in
Session 1.

### DEC-011: In-session exercise material is split by reader

**Date**: 2026-08-22

**Status**: ACCEPTED (amends DEC-010)

**Decision**: Each session directory carries the in-session exercises as
two files, one per reader. `EXERCISES.md` is participant-only: the
numbered steps a participant follows, in second person, with what they
should see and the canned fallback. `EXERCISE_RUNSHEET.md` is
facilitator-only: the per-exercise running order — time budget, what
participants are doing, what to say and when, what to work live first,
observable output, misfires and recoveries, stall triage, pairing and
remote logistics. The runsheet refers to `EXERCISES.md` by exercise and
step and never restates a step, so commands, prompts, and on-screen text
have exactly one source. DEC-010's fixed filename set is therefore seven,
not six: `README.md`, `PREWORK.md`, `FACILITATOR_GUIDE.md`, `EXERCISES.md`,
`EXERCISE_RUNSHEET.md`, `PRACTICE.md`, `CHECKPOINT.md`. Everything else in
DEC-010 stands.

**Context**: Sessions 1 and 2 were authored with a single `EXERCISES.md`
addressed to "facilitator and participant". In practice it interleaved
the two readers paragraph by paragraph — numbered participant steps
wrapped in **Say it like this**, **Observable output**, **Most common
misfire**, **Fallback** — and the operator found it awkward from either
seat: a participant reading along hits stage directions about themselves;
a facilitator scanning for the next cue wades through steps they already
know. The 2026-08-07 dry run and the 2026-08-22 Windows run both caught
the same text drifting between a step and the commentary about it, which
is the cost of stating one fact in two voices in one file.

**Alternatives Considered**:
- **Fold the facilitator material into `FACILITATOR_GUIDE.md`** and keep
  six files. Rejected: the guide would grow by ~200 lines per session and
  become unwieldy mid-session, and the facilitator already runs the block
  from a dedicated document (the guide says "run it from …"); a separate
  runsheet keeps that working pattern.
- **Keep `EXERCISES.md` as the facilitator sheet and put participant steps
  in `handouts/exercises.md`.** Rejected: participant-facing uppercase
  documents already exist (`PREWORK.md`, `PRACTICE.md`); the steps are a
  document in the course's voice, not a printable reference card; and the
  fixed-name rule wants the participant steps at a fixed uppercase name so
  later chunks can reference them before they exist.
- **One file with a section per audience.** Rejected: that is the status
  quo with headings; each reader still scrolls past the other's material.
- **Split Session 2 only.** Rejected: the convention has to be true for
  every existing session or it is not a convention.

**Rationale**: Two readers, two documents, one source of truth for the
steps. The participant file becomes safe to hand out or put on a screen
as-is; the runsheet becomes the thing a facilitator actually holds during
the block. Making the runsheet *refer* rather than *restate* is what stops
the two files drifting the way the single file already had.

**Consequences**: `curriculum/README.md` and `docs/trunk/SPEC.md` Repository
Layout list seven fixed files and the "runsheet never restates a step"
rule. Sessions 1 and 2 are split (chunk `fluency_exercise_split`); the
steps themselves did not change and Session 2's dry run was not re-run.
Later session chunks author both files from the start. `DRY_RUN.md` and
`FLOOR_TEST.md` execute participant steps and keep pointing at
`EXERCISES.md`; facilitator guides point at the runsheet for running the
block and at `EXERCISES.md` for what participants follow.

**Revisit If**: a session's exercises turn out to need no facilitator
commentary at all (the runsheet would be empty, which the convention says
to write anyway), or the one-source rule proves unworkable because a
participant step genuinely needs different wording for the two readers.
