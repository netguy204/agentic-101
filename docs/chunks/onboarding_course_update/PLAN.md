<!--
This document captures HOW you'll achieve the chunk's GOAL.
-->

# Implementation Plan

## Approach

Build `course-update` as a thin, deterministic orchestrator over the two
installers that already exist and are already idempotent — it decides
*whether* to run them, never *how*. Its only logic is: fetch the two
published pin files, compare to what is installed, run the matching
installer only on a difference, and say one plain sentence about what
happened. Everything that knows how to install stays in `env/install.sh`
and `setup/install-pi.sh`; `course-update` adds one capability to the
latter (`--keep-key`) and otherwise passes flags that exist.

Two details are load-bearing and easy to get wrong:

- **Self-update safety.** `course-update` triggers `install.sh`, which
  overwrites `~/.agentic-101/bin/course-update` — the script that is
  running. Bash reads scripts incrementally, so truncate-and-rewrite of the
  running file can execute garbage. Two guards: `course-update` wraps its
  body in `main()` and its last line is `main "$@"; exit $?` (bash has
  parsed the whole file before anything runs, and `exit` stops it reading
  further); and `install.sh` installs each payload file by copying to
  `<dest>.tmp` then `mv -f` over the destination (new inode; the running
  script's open file descriptor keeps the old content).
- **Offline behaviour.** Fetches use `curl -fsSL --connect-timeout 5
  --max-time 20`; a failed fetch short-circuits before any installer runs,
  with the one-line message and a non-zero exit. Both installers already
  stage into a temp dir and only copy on success, so a half-download
  cannot land.

Tests follow the two existing harnesses exactly (throwaway `HOME`,
`--prefix`, `NO_COLOR`, stubbed `pi`/`npm` from `setup/tests/test-setup.sh`)
and point the base URLs at `file://` directories via the existing override
variables, so the network is never needed. If `curl` on the test machine
refuses `file://`, fall back to `python3 -m http.server` on a loopback port
inside the test — decide on first run, record the choice in Deviations.

## Sequence

### Step 1: `install-pi.sh --keep-key`

In `setup/install-pi.sh`: add `keep_key=""` and the `--keep-key` case;
document it in `usage()` ("reuse the key already saved on this machine;
for updates"). In the key-resolution block (around lines 195–235): when
`keep_key` is set, do not prompt and do not validate a typed key; instead
require `"$pi_config_dir/auth.json"` to exist and be non-empty, else
`fail "install-pi.sh: no saved key on this machine — run Step 3 of the
setup guide first."`. In "Step 4 of 5 — saving your key": when `keep_key`
is set, print `dim "  keeping the key already saved"` and skip the write
(and the backup). Everything else (pi install at the pin, settings.json,
practice folder, smoke-test copy, `pins.env` copy) runs as before.
`--no-smoke-test` already exists. Add to `setup/tests/test-setup.sh`:
`--keep-key` with a seeded `auth.json` leaves it byte-identical and does
not prompt; `--keep-key` with no `auth.json` fails with the Step 3
sentence and writes nothing.

### Step 2: `env/bin/course-update`

New file, `#!/usr/bin/env bash`, backreference
`# Chunk: docs/chunks/onboarding_course_update - …`. Locate `A101_ROOT`
and source `lib/common.sh` the way `env/bin/course-check` does (copy its
header). Options: `--dry-run` (say what would change, change nothing),
`-V/--version`, `-h/--help` (help states what it updates and that Windows
Terminal configuration and OS packages need Step 1 of the setup guide).
Defaults: `A101_ENV_BASE="${AGENTIC101_ENV_BASE_URL:-https://raw.githubusercontent.com/netguy204/agentic-101/main/env}"`,
`A101_SETUP_BASE="${AGENTIC101_SETUP_BASE_URL:-…/main/setup}"`.

`main()`:
1. `bold "Checking for course updates…"`.
2. Fetch `$A101_ENV_BASE/versions.env` to a temp file; on failure print the
   "Could not reach the course updates…" line (GOAL text) and `exit 1`.
   Source it in a subshell to read `ENV_VERSION`; compare to
   `$(cat "$A101_ROOT/VERSION")`.
3. Fetch `$A101_SETUP_BASE/pins.env` the same way; read `PI_VERSION`;
   compare to `pi --version | head -1 | tr -d '\r'` (as
   `install-pi.sh:274`), and compare the fetched file to
   `$A101_ROOT/pins.env` with `cmp -s` so a model change counts too.
   Only *after both fetches succeed* does anything run — so an offline
   machine never half-updates.
4. Environment: if different, `say "Course environment: updating
   $installed → $published…"`, then
   `curl -fsSL "$A101_ENV_BASE/install.sh" | AGENTIC101_ENV_BASE_URL="$A101_ENV_BASE" bash -s -- --skip-packages --prefix "$A101_ROOT"`
   (honour `--dry-run` by passing it through and saying "would"). On
   failure: `fail "course-update: the environment update did not finish.
   Nothing else was changed — tell your facilitator."`. Else `good "Course
   environment: up to date ($installed)"`.
5. pi: if different, `say "pi: updating …"`, then
   `curl -fsSL "$A101_SETUP_BASE/install-pi.sh" | AGENTIC101_SETUP_BASE_URL="$A101_SETUP_BASE" bash -s -- --keep-key --no-smoke-test --prefix "$A101_ROOT"`.
   Else `good "pi: up to date ($installed_pi)"`. If `pi` is not on PATH at
   all, say so once and skip this half (setup Step 3 owns that).
6. Closing line: if anything updated, `bold "Close this window and open a
   new one before carrying on."`; else `bold "Nothing to do."`. `exit 0`.
Last line of file: `main "$@"; exit $?`.

Add `bin/course-update` to `A101_PAYLOAD` in `env/install.sh`, and change
the payload copy loop (`install.sh:188`) to `cp … "$dest.tmp" && mv -f
"$dest.tmp" "$dest"`. Check `env/uninstall.sh` removes `bin/*` generically
(if it lists names, add the new one).

### Step 3: versions and sample output

`env/versions.env` `ENV_VERSION=1.1.0`; `setup/pins.env`
`EXPECTED_ENV_VERSION=1.1.0`; `setup/README.md` sample lines "Course
environment 1.0.1" and "course environment 1.0.1 — found" → 1.1.0.

### Step 4: `env/tests/test-update.sh`

Harness as `test-install.sh`. Build a "published" tree: `cp -R env/ $PUB/env`
and `cp -R setup/ $PUB/setup`; install into a fake HOME from the local
checkout (`install.sh --skip-packages --prefix`); seed `~/.pi/agent/auth.json`
and a stub `pi` on PATH (reuse the stub shape from `setup/tests/test-setup.sh`)
printing the pinned version; export `AGENTIC101_ENV_BASE_URL=file://$PUB/env`
and `AGENTIC101_SETUP_BASE_URL=file://$PUB/setup`. Cases, each `has`/`absent`
asserted on the log and the filesystem:
1. **Up to date**: both "up to date" lines, "Nothing to do.", exit 0,
   `VERSION` unchanged, mtime of `bin/commit` unchanged.
2. **Environment bump**: `sed` `ENV_VERSION` in `$PUB/env/versions.env` to
   `9.9.9`; expect "updating", `VERSION` = 9.9.9, `commit --version` says
   9.9.9, closing "Close this window…", exit 0; and `course-update` itself
   still runs afterwards (self-update safety).
3. **pi pins change**: change `PI_MODEL` in `$PUB/setup/pins.env`; with
   stub `npm` (no-op) and stub `pi`; expect `install-pi.sh` ran with
   `--keep-key --no-smoke-test` (log has "keeping the key already saved",
   no "asking the model"), `$ROOT/pins.env` updated, `auth.json` byte-
   identical, exit 0.
4. **Unreachable**: `AGENTIC101_ENV_BASE_URL=file:///nonexistent`; expect the
   one-line message, exit non-zero, nothing changed.
5. **`--dry-run`** on case 2: "would", nothing changed, exit 0.
Run `env/tests/test-install.sh`, `env/tests/test-commands.sh`,
`setup/tests/test-setup.sh` too.

### Step 5: curriculum, setup guide, checklist, decision

- `curriculum/session_02_meeting_the_harness/PREWORK.md` §3: two commands,
  `course-update` then `course-smoke-test`; reply with the smoke test's word;
  the "do not try to fix it" rule unchanged. Mention that `course-update`
  may say to close and reopen the window — do that, then run the smoke test.
- `…/EXERCISES.md`: after the "Stuck at any point?" line, a **Before
  exercise 1** paragraph: "In the course terminal, type `course-update` and
  press Enter. It fetches any course updates since you set up; most weeks
  it says *Nothing to do*. If it tells you to close the window and open a
  new one, do that before going on." `…/EXERCISE_RUNSHEET.md`: the
  facilitator side before exercise 1 — run it on the projector first; this
  is where a between-session fix lands; no internet → it says so, carry on.
- `…/handouts/terminal-card.md`: a row "Get the latest course fixes (start
  of every session) — `course-update`".
- `curriculum/README.md` "Rules that cross sessions": **Every session from
  Session 2 opens with `course-update`** — in the prework's run-one-command
  step and as the first line of `EXERCISES.md`; Session 1 is exempt
  (no terminal before Session 2, DEC-004).
- `setup/README.md`: under "Two things to know for the first session" (or a
  new short "Getting updates later" section) one paragraph; a
  troubleshooting row for "`course-update` says it could not reach the
  course updates" (no internet / try again / tell your facilitator); the
  "What just got installed" list gains the command.
- `setup/PRE_COHORT_CHECKLIST.md` §2: "publishing a fix = bump
  `ENV_VERSION` (and/or pins) and push; verify `course-update` picks it up
  on a participant-like machine". `env/README.md` "What gets installed"
  lists it; `env/DISTRIBUTION.md` notes it as a URL consumer (both bases).
- `docs/trunk/DECISIONS.md`: DEC-012 via the `decision-create` skill —
  decision, context (the 2026-08-22 CRLF fix with no distribution path),
  alternatives from the GOAL's Rejected Ideas (pi sync-up prompt with the
  operator's long-tail revisit condition; fold into smoke test; inside
  commit/revert; re-run Step 1), consequences (publishing = bump + push;
  sessions open with it), revisit-if.

### Step 6: verify

`bash env/tests/test-update.sh`, `test-install.sh`, `test-commands.sh`,
`setup/tests/test-setup.sh` all pass; `bash -n` on every touched script;
`uvx --from vibe-engineer ve validate`; relative-link check over
`curriculum/`; `course-update --help` and `--dry-run` run against the real
GitHub base from this checkout's install (read-only; it will report a
version difference until the push lands, which is itself a useful check).

## Dependencies

None beyond the repository. `fluency_exercise_split` is ACTIVE, so the
Session 2 `EXERCISES.md`/`EXERCISE_RUNSHEET.md` shape is settled.

## Risks and Open Questions

- **`curl` and `file://`**: supported by macOS and Git-for-Windows curl;
  if a test machine's curl is built without it, use the loopback
  `http.server` fallback in the tests only.
- **Overwriting the running script**: covered by `main; exit` plus
  tmp-then-mv in `install.sh`; the self-update test (case 2 → re-run)
  is the proof.
- **`pi --version` output shape** across pi versions: reuse exactly the
  `install-pi.sh:274` expression; if pi is missing from PATH, skip the pi
  half with a one-line note rather than failing.
- **First-time participants** (installed before this chunk) do not have
  `course-update` yet; their path is still Step 1 of the setup guide once.
  The facilitator guide's CRLF row already says so; no change needed.
- **A pins change that also needs a key change** (new provider) cannot be
  handled by `--keep-key`; `install-pi.sh` will still validate what it has
  at first use and the smoke test will show it — out of scope, noted in
  `--help`.

## Deviations

- **`--no-smoke-test` already existed** in `install-pi.sh`; the GOAL's
  provisional `--no-check` name was corrected before planning. Only
  `--keep-key` was added.
- **The self-update hazard was real but had a different mechanism.** The
  first run of `test-update.sh` failed case 2 with `published_env\xE2:
  unbound variable`; experiments showed bash handles both copy-then-move and
  in-place overwrite of a `main; exit`-wrapped script fine. The actual cause
  was `$published_env…` — a multibyte ellipsis immediately after the
  variable name is swallowed into the identifier in this locale. Fixed with
  `${published_env}…`; a grep confirms no other course script has a variable
  immediately followed by a non-ASCII byte. Both guards (main-then-exit,
  tmp-then-mv) are kept as cheap insurance.
- **Settings-only pin changes skip reinstalling pi.** When the published
  `PI_VERSION` matches the installed pi, `course-update` passes
  `--skip-packages` to `install-pi.sh` so a model change takes seconds rather
  than an `npm install`.
- **`setup/tests/test-setup.sh` has two pre-existing environment-dependent
  failures on the authoring machine** (the smoke test's "pi is version 0.84.2,
  but this course uses 0.83.0" — the local pi is newer than the pin) and four
  when `OPENROUTER_API_KEY` is exported in the shell (the installer correctly
  picks it up). Verified identical against a `git archive HEAD` baseline; not
  regressions. The new `--keep-key` cases pass.
