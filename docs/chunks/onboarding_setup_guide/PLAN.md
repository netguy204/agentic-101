# Implementation Plan

## Approach

`setup/` becomes the pre-cohort path: one participant-facing guide, one
scripted installer that pins pi and writes its configuration, one smoke
test, and the operator's per-cohort checklist. The managed terminal
environment from `docs/chunks/onboarding_terminal_env` already owns the
terminal, the shell, node, git, and the `commit`/`revert`/`course-check`
commands; this chunk owns everything from "pi is not installed" to "a
verified pass".

Three structural choices shape everything below.

**One bash script serves both platforms after the environment is
installed.** DEC-008 put bash on both platforms (Ghostty runs
`/bin/bash -l` on macOS; Git Bash inside Windows Terminal on Windows), so
only the *environment* install step differs per platform. `setup/install-pi.sh`
runs unmodified under macOS bash 3.2 and Git Bash bash 5, matching
`env/`'s dialect constraint. The guide therefore has exactly two install
commands: one that differs by platform (the environment) and one that does
not (pi).

**Setup is scripted, not narrated.** DEC-004's floor is a participant with
no terminal experience, and the GOAL forbids any step that requires
understanding what a command does. Walking someone through pi's interactive
`/login` TUI — arrow keys, a provider list of dozens of entries, a paste
prompt — fails that bar and cannot be paired with exact expected output.
Instead `install-pi.sh` writes `~/.pi/agent/auth.json` and
`~/.pi/agent/settings.json` directly, so the participant's entire auth step
is pasting one line the facilitator emailed them. This is the same trade the
environment installer already made ("runs start to finish with no questions
asked").

**Reuse `env/`'s conventions rather than inventing new ones.** Managed
blocks, timestamped backups, the `say`/`good`/`warn` output vocabulary, the
PASS/FAIL final line, and the "what to do if it fails" footer all come from
`env/lib/common.sh` and `env/bin/course-check`. The smoke test installs into
`~/.agentic-101/bin` — the same root — so `env/uninstall.sh` still removes
everything in one place and the participant has one PATH to think about.

### Decisions this plan makes

**Auth: `auth.json`, not an environment variable.** The GOAL leans this way
and the reasoning holds. An `export OPENROUTER_API_KEY=…` lives only in the
shell session that ran it; a participant who closes the terminal loses it
with no visible cause, and the recovery ("add it to a startup file") is
exactly the terminal knowledge the floor says we cannot assume.
`~/.pi/agent/auth.json` survives restarts, is created `0600`, is what pi's
own `/login` would have written, and takes priority over env vars (pi
`docs/providers.md`, Auth File). The installer merges into an existing
`auth.json` rather than overwriting it, so a participant who already uses pi
keeps their other credentials.

**The pinned model is `anthropic/claude-sonnet-5` at thinking level
`medium`, via provider `openrouter`.** Verified present in pi 0.83.0's
OpenRouter catalog (`pi --list-models`). It is strong enough that a
first-session delegation succeeds on the first try — the thing that decides
whether a non-programmer believes the course works — without the per-token
cost of an Opus-class model across a cohort. `defaultThinkingLevel: medium`
matches DEC-006's "shipped configuration prescribes the model" and keeps
latency reasonable in a live session. The pin is data in `setup/pins.env`,
not a literal in prose, so re-pinning is a one-file edit.

**pi is pinned to `0.83.0`** — the current published version of
`@earendil-works/pi-coding-agent`, verified installed and working on the
authoring machine. npm enforces exact pins, so unlike the Homebrew casks in
`env/versions.env` this pin is real on both platforms.

**The guide embeds the remote `curl | bash` one-liner, marked with its
publish prerequisite.** `env/DISTRIBUTION.md` forbids embedding it as
working truth until the repository is published, but the local-checkout form
(`bash env/install.sh`) is worse for the audience: it presupposes cloning a
git repository, which is further outside the floor than anything else in the
guide. So the guide shows the shape participants will actually use, carrying
the same `REPLACE-ME` token the installers already carry, with a facilitator
note directly above it and item 1 of the pre-cohort checklist blocking
distribution until the substitution is done and verified. The local form is
documented in the checklist as the dry-run path.

**The practice directory is `~/course-practice`.** Visible in Finder and
Explorer (unlike `~/.agentic-101`), short enough to type, and not `$HOME` —
which matters because `commit` refuses to run there.

## Subsystem Considerations

No subsystems exist in `docs/subsystems/`. The managed environment in `env/`
is a sibling deliverable owned by `docs/chunks/onboarding_terminal_env`, not
a subsystem; this chunk consumes it through three documented surfaces
(the install root `~/.agentic-101`, `course-check`, and `commit`/`revert` on
PATH) and adds one file to its `bin/`.

## Sequence

### Step 1: `setup/pins.env` — the per-cohort pin set

Mirrors `env/versions.env` in shape and commentary so the two files read as
one system. Holds `PI_VERSION`, `PI_PROVIDER`, `PI_MODEL`,
`PI_THINKING_LEVEL`, `EXPECTED_ENV_VERSION`, `COHORT`, and the practice
directory name. Documents at the top how to re-pin and where the *other*
pin file lives.

### Step 2: `setup/install-pi.sh`

Bash 3.2, same argument style as `env/install.sh` (`--dry-run`,
`--prefix`, `-h`), plus `--key <KEY>` and `--no-smoke-test`. Resolves its
own payload locally or from the base URL exactly as `env/install.sh` does,
sourcing `~/.agentic-101/lib/common.sh` when present and falling back to a
minimal inline copy of the output helpers when it is not (the script must
survive being run before, or without, the environment).

Steps, each announced as "Step N of 5":

1. Preflight — refuse `sudo`; require `node` and `npm`; warn if the managed
   environment is missing or its `VERSION` does not match
   `EXPECTED_ENV_VERSION`.
2. Install pi: `npm install -g --ignore-scripts @earendil-works/pi-coding-agent@$PI_VERSION`,
   then verify `pi --version` equals the pin.
3. Write `~/.pi/agent/settings.json` — generated from `pins.env`, so the
   model pin has exactly one source. Backs up any existing file first and
   preserves unrelated keys the participant may have set.
4. Write `~/.pi/agent/auth.json` — `{"openrouter": {"type":"api_key","key":"…"}}`,
   merged into any existing file, `chmod 0600`. The key comes from `--key`,
   else from `$OPENROUTER_API_KEY`, else a prompt read from `/dev/tty` (so
   it works under `curl | bash`, where stdin is the script). Validates the
   key's shape (`sk-or-…`) and refuses an obvious placeholder.
5. Create `~/course-practice` with a short `README.txt`, install
   `course-smoke-test` into `~/.agentic-101/bin`, then run it unless
   `--no-smoke-test`.

### Step 3: `setup/bin/course-smoke-test`

The participant-runnable verifier. Structure and vocabulary copied from
`env/bin/course-check`: one line per check, `[ok]`/`[no]`, one final PASS or
FAIL line, and a "what to do" footer on failure. Checks, in order, each
short-circuiting sensibly:

1. The managed environment — delegates to `course-check` (which covers
   `commit`/`revert` on PATH, git, node, bash, terminal config) and reports
   its verdict as this test's first check.
2. pi is installed and is the pinned version.
3. `~/.pi/agent/settings.json` names the pinned provider, model, and
   thinking level.
4. `~/.pi/agent/auth.json` exists, is `0600`, and holds an `openrouter` key.
5. The key works and the prescribed model answers: `pi -p --no-session`
   with a prompt demanding an exact token back. Separating this from check 6
   is what makes a bad key distinguishable from a failed task.
6. One trivial agent task, run inside a scratch directory under
   `~/course-practice`: ask pi to create a file with known content, then
   verify the file on disk. This is the outcome-checked design
   TESTING_PHILOSOPHY.md asks for — it does not grade pi's prose. The
   scratch directory is removed afterwards.

Network-dependent checks 5 and 6 get a timeout and a failure message that
names the likely cause (no internet, key not yet activated, spend limit
reached).

### Step 4: `setup/README.md` — the participant guide

The deliverable. Voice matched to `pi-learning-paths.md` Stage 0/1: the
GUI analogy first, the reason it matters second, the command third, the
expected output fourth. Sections:

- What you're about to do, and how long it takes.
- **What this costs you: nothing** — stated before the first command, per
  the GOAL and trunk GOAL.md Constraints.
- What you need before you start (laptop, the two things the facilitator
  emailed you).
- Step 1 — install the course environment (per-platform: macOS block,
  Windows block, each with how to find the app that runs the command and
  the expected tail of the output).
- Step 2 — open the course terminal (per-platform, with what you should see).
- Step 3 — install pi and your key (one command, both platforms).
- Step 4 — check everything works (`course-smoke-test`, with the full
  expected PASS output shown verbatim).
- If something went wrong — a symptom→action table, ending in "send your
  facilitator the whole screen".
- What you just installed and how to remove it — the honest inventory,
  pointing at `env/README.md`'s undo story.

Every command block is one pasteable line. Expected output is shown as a
fenced block immediately after each command.

### Step 5: `setup/PRE_COHORT_CHECKLIST.md`

The TESTING_PHILOSOPHY.md (Test Organization) checklist, as ordered
checkboxes with the command to run beside each item:

1. **Blocking**: publish the repository and replace `REPLACE-ME` in
   `env/install.sh`, `env/install.ps1`, `setup/install-pi.sh`, and
   `setup/README.md`; verify the one-liners from a machine with no checkout.
2. Re-pin: run both installers clean, copy `installed-versions.txt` into
   `env/versions.env`, check npm for a newer pi and re-pin `setup/pins.env`,
   confirm the model ID still exists in `pi --list-models`.
3. Operator cost expectations and per-key spend limits — the numbers the
   GOAL requires be documented here: how keys are issued, what limit each
   carries, what a cohort is expected to consume, and rotation after the
   cohort.
4. Re-run the smoke test on both platforms; re-run `env/tests/` and
   `setup/tests/`.
5. Re-run exercise dry-runs (points at `setup/DRY_RUN.md` and the pending
   items in `env/FLOOR_TEST.md`).
6. Tag `cohort-YYYY-MM`.

Carries the pending Windows dry-run and the pending floor tests from
`env/FLOOR_TEST.md` as explicit blocking items, per the handoff from
`onboarding_terminal_env`.

### Step 6: `setup/DRY_RUN.md`

The clean-environment dry-run record the GOAL asks for, per platform: what
was run, what was observed, what remains. Records honestly that the macOS
run was performed against a temporary HOME by an agent (not a clean
machine, not a human), and that Windows is unperformed — matching the
`env/FLOOR_TEST.md` precedent of stating testing status plainly.

### Step 7: `setup/tests/test-setup.sh`

Automated checks in the style of `env/tests/`: run against a temporary HOME
and a temporary npm prefix, never the operator's real files. Covers
`install-pi.sh --dry-run`; settings.json generation and merge-preservation;
auth.json creation, permissions, merge, and placeholder rejection; the
smoke test's non-network checks failing and passing correctly; and idempotent
re-runs. The two live-model checks are exercised against a stub `pi` on
PATH; a real key is required for the genuine article, and the script says so.

### Step 8: Trunk updates

- `docs/trunk/SPEC.md` — confirm and sharpen the Repository Layout entry for
  `setup/`, naming the actual files, and record in the DRAFT list that
  `setup/` is now settled (as `env/` already is).
- `docs/trunk/DECISIONS.md` — DEC-009 recording the three cross-chunk
  contracts this chunk creates: `auth.json` as the auth path, the pin split
  between `env/versions.env` and `setup/pins.env`, and `setup/` installing
  `course-smoke-test` into the environment's install root.

### Step 9: Verify and complete

`uvx --from vibe-engineer ve validate`, `bash -n` on every script,
`setup/tests/test-setup.sh` green, one real end-to-end run of
`install-pi.sh` + `course-smoke-test` against a temp HOME on this machine
(the authoring machine has a working pi and node), then `ve chunk complete`.

## Dependencies

- `docs/chunks/onboarding_terminal_env` (ACTIVE) — supplies `~/.agentic-101`,
  `course-check`, `commit`/`revert`, node, git, and the terminals.
- An OpenRouter API key for the live-model portion of the smoke test. Not
  available to the authoring agent; those two checks are verified with a stub
  `pi` and by inspection, and are listed as an operator follow-up.
- Publishing the repository — blocks the one-liner, not this chunk.

## Risks and Open Questions

- **The two live-model checks cannot be executed here.** No OpenRouter key
  is available. Mitigation: exercise the surrounding logic with a stub `pi`
  on PATH in the tests, and record a blocking operator follow-up.
- **Windows is authored-untested, twice over.** `env/install.ps1` was never
  run, and `install-pi.sh` has never run under Git Bash. The guide must not
  claim otherwise; `DRY_RUN.md` and the checklist say so plainly.
- **`npm install -g` may need elevated permissions** on a machine where node
  came from somewhere other than Homebrew/winget. The installer detects
  `EACCES` and prints the specific recovery rather than a raw npm error.
- **Model availability drift.** `anthropic/claude-sonnet-5` could leave
  OpenRouter's catalog between cohorts; checklist item 2 verifies it and the
  smoke test fails loudly with a readable message if it is gone.
- **The key lands in shell history** when pasted as `--key`. Acceptable for
  a spend-limited course key; the checklist requires rotation after each
  cohort.

## Deviations

- **Step 2 — added an opt-out of the key prompt.** `install-pi.sh` honours
  `A101_ASSUME_DEFAULTS` (the environment's existing "never prompt"
  convention from `env/lib/common.sh`) and skips the `/dev/tty` read. Without
  it, the "no key given" test would block on a terminal that may not exist in
  CI.

- **Step 2 — the pasted key is stripped of whitespace before use.** Not
  planned. A key copied out of an email routinely arrives with a trailing
  space or, on Windows, a carriage return, and the resulting 401 is
  indistinguishable from a bad key. OpenRouter keys contain no whitespace, so
  all of it is removed. Two tests cover it.

- **Step 3 — the two model calls run with stdin closed.** Not planned. When
  the smoke test runs at the end of a `curl | bash` install, the script's own
  pipe is still the process's stdin, and `pi -p` reads stdin when it is not a
  terminal. `</dev/null` on both calls removes the hazard.

- **Step 7 — verification went further than planned.** The plan said the
  live-model checks would be "verified by inspection". In the event:
  - `setup/tests/test-setup.sh --with-npm` performs a *real*
    `npm install -g @earendil-works/pi-coding-agent@0.83.0` into a temporary
    prefix and asserts the resulting binary reports the pinned version.
  - The `curl … | bash -s -- --key …` form of Step 3 was run end to end
    against a local HTTP server standing in for the published repository,
    confirming the download path, that stdin does not hang, and that the
    installer's own remote-payload failure message is correct when the URL is
    the unpublished placeholder.
  - That run's smoke-test check 5 reached the **real** OpenRouter endpoint
    with a deliberately invalid key and was rejected with a 401, which the
    check rendered as its readable failure. The whole configuration chain —
    generated `settings.json`, generated `auth.json`, provider and model
    resolution inside pi — is therefore verified against the live service.
    Only the success path still needs a funded key.

  `setup/DRY_RUN.md` records all of this, and what it still does not
  establish.

- **Step 9 — the independent review did not return.** A reviewing agent was
  dispatched against the GOAL's success criteria, the audience floor, and the
  shell scripts; it never reported back. The review was completed by
  self-review against the success criteria plus the live verifications above,
  which found and fixed the three defects listed here. An independent read of
  `setup/README.md` by someone who did not write it remains worth doing, and
  is subsumed by the human floor test the checklist already requires.
