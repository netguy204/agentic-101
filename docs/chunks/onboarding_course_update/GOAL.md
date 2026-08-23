---
status: ACTIVE
ticket: null
parent_chunk: null
code_paths:
- env/bin/course-update
- env/install.sh
- env/versions.env
- env/README.md
- env/DISTRIBUTION.md
- env/tests/test-update.sh
- setup/install-pi.sh
- setup/pins.env
- setup/README.md
- setup/PRE_COHORT_CHECKLIST.md
- setup/tests/test-setup.sh
- curriculum/README.md
- curriculum/session_02_meeting_the_harness/PREWORK.md
- curriculum/session_02_meeting_the_harness/EXERCISES.md
- curriculum/session_02_meeting_the_harness/EXERCISE_RUNSHEET.md
- curriculum/session_02_meeting_the_harness/handouts/terminal-card.md
- docs/trunk/DECISIONS.md
code_references:
- ref: env/bin/course-update
  implements: "The deterministic update command: fetch both pin files and both installers first, compare to what is installed, run install.sh / install-pi.sh only on a difference, one closing instruction, offline = one line and exit 1, main-then-exit for self-update safety"
- ref: env/install.sh
  implements: "bin/course-update in the payload; payload files replaced copy-then-move so a running course-update keeps its inode"
- ref: env/versions.env
  implements: "ENV_VERSION 1.1.0 — the first environment that ships course-update"
- ref: setup/install-pi.sh
  implements: "--keep-key: reuse the saved auth.json, ask and validate nothing, fail plainly naming Step 3 when there is no saved key"
- ref: setup/pins.env
  implements: "EXPECTED_ENV_VERSION kept in step with ENV_VERSION; the file course-update compares byte-for-byte to detect pin changes"
- ref: env/tests/test-update.sh
  implements: "Regression tests over file:// bases: current, environment bump and self-update, pins change with the key kept and no smoke test, unreachable and partially reachable, dry run"
- ref: setup/tests/test-setup.sh
  implements: "--keep-key cases: saved key byte-identical and never prompted; missing key fails naming Step 3"
- ref: curriculum/README.md
  implements: "Cross-session rule: every session from Session 2 opens with course-update in prework and the first line of EXERCISES.md"
- ref: curriculum/session_02_meeting_the_harness/PREWORK.md
  implements: "Prework runs course-update, then course-smoke-test, and replies with the smoke test's word"
- ref: curriculum/session_02_meeting_the_harness/EXERCISES.md
  implements: "'Before exercise 1' — the participant runs course-update and reopens the window if told to"
- ref: curriculum/session_02_meeting_the_harness/EXERCISE_RUNSHEET.md
  implements: "The facilitator side of course-update before exercise 1: projector first, what most weeks look like, offline carries on"
- ref: curriculum/session_02_meeting_the_harness/handouts/terminal-card.md
  implements: "course-update on the reference card"
- ref: setup/README.md
  implements: "Getting-updates note, the command in the installed inventory, a troubleshooting row, and sample output at 1.1.0"
- ref: setup/PRE_COHORT_CHECKLIST.md
  implements: "Publishing a fix between sessions = bump and push, then verify course-update picks it up"
- ref: env/README.md
  implements: "course-update in the what-gets-installed table"
- ref: env/DISTRIBUTION.md
  implements: "course-update listed as a consumer of both base URLs"
- ref: docs/trunk/DECISIONS.md
  implements: "DEC-012 — deterministic participant-run updates at session start, and the rejected pi sync-up prompt with its revisit condition"
narrative: null
investigation: null
subsystems:
- subsystem_id: session_anatomy
  relationship: uses
friction_entries: []
depends_on: []
created_after: ["fluency_exercise_split"]
---


# Chunk Goal

## Minor Goal

Participants get course updates through one deterministic, one-word command.
`course-update`, installed in `~/.agentic-101/bin/` alongside `commit`,
`revert` and `course-check`, compares what is installed against what the
repository publishes and brings the machine current: the course environment
(`env/` payload — `commit`, `revert`, `course-check`, `course-update` itself,
`lib/`, `versions.env`) when the published `ENV_VERSION` differs from
`~/.agentic-101/VERSION`, and pi (version, model/provider settings, the
smoke test, `pins.env`) when the published `setup/pins.env` differs from
what is installed. It finishes in seconds when nothing has changed, needs
no key and no model call, speaks in the same plain-language register as
`commit`/`revert`, and tells the participant exactly one thing to do
afterwards ("close this window and open a new one") only when that is
needed. Every session from Session 2 onward opens with it: the prework's
"run one command" step and the first line of `EXERCISES.md` both say
`course-update`, so an environment fix published between sessions reaches
every participant before the room uses it. When it cannot reach the
network it says so in one line and exits non-zero without changing
anything, and the session carries on.

### Why

On 2026-08-22 the operator ran Session 2's exercise 2 on Windows and found
`commit` printing a git warning (`LF will be replaced by CRLF`) that the
command exists to hide. The fix shipped as environment 1.0.1 the same day —
but the only way a participant who had already set up (David, Session 1
cohort) could get it was to re-run Step 1 of the setup guide, a multi-
minute PowerShell installer they last saw weeks ago, on the facilitator's
say-so. Every future fix to `env/` or to the pi pins has the same
distribution problem. The course needs a standing answer: updates are
pulled by the participant, deterministically, at the start of every
session, with one word.

The operator considered and set aside the obvious alternative — a "sync
up" prompt participants give pi at the start of each exercise set, asking
it to pull the latest updates. Once a participant has pi working, manual
terminal steps are in principle unnecessary. It was rejected for now on
three grounds, recorded below under Rejected Ideas: it lands too late
(Session 2 uses `commit` before pi is opened), it is a broad unverifiable
delegation made at the moment the course is teaching the opposite, and it
is nondeterministic in a place where determinism matters (pi could read
"pull updates" as `git pull` in `~/course-practice`, the checkpoint repo).
The operator's stated boundary: pi's advantage over a script would only
appear if a long tail of environment divergence made a scripted solution
infeasible — that is the condition under which to revisit.

### How it is built

**What it builds on.** `env/install.sh` is idempotent and re-runnable (header
comment: "Re-running is safe and produces the same result"); piped from
curl it downloads `A101_PAYLOAD` (`lib/common.sh lib/shellrc.sh bin/commit
bin/revert bin/course-check versions.env`) from `A101_BASE_URL` (default
`https://raw.githubusercontent.com/netguy204/agentic-101/main/env`,
override `AGENTIC101_ENV_BASE_URL`), copies it over `~/.agentic-101/`, and
writes `ENV_VERSION` to `~/.agentic-101/VERSION` (`install.sh:188-191`).
`--skip-packages` skips Homebrew/winget. `env/versions.env` is the single
source of `ENV_VERSION` (bumped on any change to `env/`). `env/bin/
course-check` verifies the environment and prints `Course environment
<VERSION>`; `commit --version` prints `agentic-101 environment <VERSION>`.
`setup/install-pi.sh` (base URL `…/main/setup`, override
`AGENTIC101_SETUP_BASE_URL`, payload `pins.env bin/course-smoke-test`)
installs pi at `PI_VERSION` via `npm install -g --ignore-scripts
@earendil-works/pi-coding-agent@$PI_VERSION`, writes `settings.json` from
`PI_PROVIDER`/`PI_MODEL`/`PI_THINKING_LEVEL`, saves the key to
`~/.pi/agent/auth.json` (requires `--key`; fails without it at
`install-pi.sh:224`), makes `~/course-practice`, copies `course-smoke-test`
and `pins.env` into `~/.agentic-101/`, and runs the smoke test (minutes; it
calls the model). `setup/pins.env` holds `PI_VERSION=0.83.0`,
`PI_PROVIDER`, `PI_MODEL`, `PI_THINKING_LEVEL`, `EXPECTED_ENV_VERSION`,
`PRACTICE_DIR`; `install-pi.sh:170` warns on an env-version
mismatch; `course-update` is what acts on it. Windows: `env/install.ps1` installs packages
and patches Windows Terminal, then runs `install.sh --skip-packages` inside
Git Bash. Helpers in `env/lib/common.sh`: `say bold dim good warn fail
blank ask confirm backup_file`. Tests: `env/tests/test-install.sh` (dry
run, first install, idempotent second install, user content preserved),
`env/tests/test-commands.sh`, `setup/tests/test-setup.sh` (see how it stubs
npm/pi — reuse the same stubs).

**The command.** `env/bin/course-update` is in `A101_PAYLOAD`, so it
ships with the environment and updates itself. Behaviour:
1. Fetch `<env base>/versions.env` (curl, short timeout, `-fsSL`). Compare
   `ENV_VERSION` to `~/.agentic-101/VERSION`. If different, run
   `curl -fsSL <env base>/install.sh | bash -s -- --skip-packages` (it
   re-downloads the full payload). Report `Course environment: updated
   1.0.1 → 1.1.0` or `Course environment: up to date (1.1.0)`.
2. Fetch `<setup base>/pins.env`. Compare `PI_VERSION` to the installed pi
   (`pi --version`, as `install-pi.sh:274` reads it) and the pin file to
   the installed `~/.agentic-101/pins.env`. If different, run
   `curl -fsSL <setup base>/install-pi.sh | bash -s -- --keep-key
   --no-smoke-test` — `--no-smoke-test` already exists and skips the closing smoke test so an
   update takes seconds; `--keep-key` reuses the saved
   `auth.json` and fails plainly if there is none ("no saved key — run
   Step 3 of the setup guide"). Report `pi: updated 0.83.0 → 0.84.1`
   or `pi: up to date (0.83.0)`.
3. If anything was updated, end with exactly one instruction: `Close this
   window and open a new one before carrying on.` Otherwise `Nothing to
   do.` Exit 0.
4. If a fetch fails: `Could not reach the course updates (no internet, or
   the course site is down). Nothing was changed — carry on with the
   session and tell your facilitator.` Exit non-zero. Never leave a
   half-applied update (the installers already stage to a temp dir first).
5. The env base and setup base default to the same two URLs the installers
   hold and honour the same two override variables, so tests can point
   both at `file://` directories (curl reads `file://` URLs).
Out of scope, stated in the command's `--help` and in `env/README.md`:
Windows Terminal configuration and OS packages (those need Step 1 of the
setup guide). `ENV_VERSION` is 1.1.0 and `EXPECTED_ENV_VERSION` matches.
When only the pins changed and the installed pi already matches
`PI_VERSION`, `--skip-packages` is passed too, so a model change takes
seconds.

**Where it sits in the curriculum.**
- `curriculum/session_02_meeting_the_harness/PREWORK.md` §3 "Run two
  commands": `course-update`, then `course-smoke-test`; the participant
  replies with the smoke test's last word, and the "do not try to fix it"
  rule stands.
- `curriculum/session_02_meeting_the_harness/EXERCISES.md` — a "Before
  exercise 1" paragraph at the top: type `course-update`, and if it says
  to close and reopen the window, do that before going on. The runsheet
  (`EXERCISE_RUNSHEET.md`) carries the facilitator side: do it on the
  projector first; it is the moment any between-session fix lands;
  expect `Nothing to do` most weeks; if the room has no internet, it says
  so and the session proceeds.
- `curriculum/README.md` "Rules that cross sessions": every session from
  Session 2 opens with `course-update` in both the prework and the first
  line of `EXERCISES.md`; Session 1 is exempt (no terminal before Session
  2, DEC-004). `handouts/terminal-card.md` lists the command.
- `setup/README.md` has a "Getting updates" note, the command in the
  installed inventory, and a troubleshooting row; `setup/PRE_COHORT_CHECKLIST.md`
  says bumping `ENV_VERSION`/pins and pushing is how a fix is published, and
  verifies `course-update` from a participant-like machine. `env/README.md`
  and `env/DISTRIBUTION.md` list the command and its two URL bases.
- `docs/trunk/DECISIONS.md`: DEC-012 records the decision; its alternatives
  are the Rejected Ideas below.

**Constraints.** Audience floor (DEC-004): output is plain English, no git
or npm vocabulary. No model call, no key needed, seconds when current.
Idempotent. Never touches `~/course-practice`. Same output conventions as
`course-check` (`[ok]`-style lines are fine; one-line verdict at the end).

## Success Criteria

- `course-update` exists in `env/bin/`, ships in `A101_PAYLOAD`, and on an
  up-to-date machine prints the two "up to date" lines and `Nothing to do.`
  in under ten seconds with exit 0, making no changes.
- When the published `ENV_VERSION` is newer, it reinstalls the environment
  payload, `~/.agentic-101/VERSION` and `commit --version` report the new
  version, and the closing line says to close and reopen the window.
- When `setup/pins.env` changes (pi version or model), it re-runs the pi
  installer with `--keep-key --no-smoke-test`, the saved key is untouched and
  still works, `pi --version` matches the pin, and no smoke test ran.
- `install-pi.sh --keep-key` without a saved key fails in one plain
  sentence naming Step 3; the flag is in its `--help`; the existing
  `--no-smoke-test` is what `course-update` passes.
- With an unreachable base URL it prints the one-line "could not reach"
  message, changes nothing, and exits non-zero.
- Tests: a new `env/tests/test-update.sh` drives all of the above against
  `file://` bases (up to date; env bump; pins bump with stubbed npm/pi;
  unreachable), and `test-install.sh`, `test-commands.sh`,
  `setup/tests/test-setup.sh` still pass.
- `ENV_VERSION` is 1.1.0 and `setup/pins.env` `EXPECTED_ENV_VERSION`
  matches; `setup/README.md` sample output follows.
- Session 2 PREWORK §3 and the top of `EXERCISES.md` say `course-update`;
  the runsheet carries the facilitator side; `terminal-card.md` lists it;
  `curriculum/README.md` states the cross-session rule; DEC-012 is
  recorded; `ve validate` passes.

## Rejected Ideas

### A "sync up" prompt to pi at the start of every exercise set

Once a participant has pi working, they could type "pull the latest course
updates" into pi and let it run the installers.

Rejected (for now) because: (1) Session 2 uses `commit` in exercise 2,
before pi is opened in exercise 3, so the update lands too late for the
case that prompted this; (2) it is a broad delegation the participant
cannot evaluate, made at the moment the course is teaching the judgment
boundary and (in Session 4) scoping — and it models `curl | bash` by an
agent; (3) it is nondeterministic where determinism matters — "pull the
latest updates" could plausibly become `git pull` in `~/course-practice`,
which is the checkpoint repo the safety net depends on. Operator's stated
boundary: revisit if a long tail of environment divergence makes a
scripted solution infeasible — that is where pi's flexibility would earn
its place.

### Fold updating into `course-smoke-test`

Rejected because: the smoke test calls the model and takes minutes; the
update must take seconds, need no key, and be safe to run in a room with
a flaky connection. Keeping them separate also keeps "is my setup
healthy?" and "am I current?" as two questions with two one-word answers.

### Auto-update inside `commit` / `revert`

Rejected because: a recovery tool must never depend on the network or
change itself in the middle of being used.

### Tell participants to re-run Step 1 of the setup guide

What the 2026-08-22 fix had to fall back on. Rejected as the standing
answer because: it is a multi-minute installer in a different shell
(PowerShell on Windows), it needs the facilitator to announce it, and it
is not something a participant will do unprompted at the start of a
session.
