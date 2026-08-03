# Setup Guide Dry-Run Record

<!-- Chunk: docs/chunks/onboarding_setup_guide - Dry-run results for the setup path -->

`docs/trunk/TESTING_PHILOSOPHY.md` (Exercise Dry-Runs, Setup Smoke Test)
requires the setup path to be executed from its written instructions, on a
clean environment, before it is used — and again before each cohort. This
file is that record.

Read the status honestly: what follows is **not** the clean-machine dry-run
the philosophy asks for. It is everything that could be automated on the
authoring machine, plus a clear statement of what is still owed. The
outstanding items are blocking, and they are carried in
[PRE_COHORT_CHECKLIST.md](PRE_COHORT_CHECKLIST.md) items 5 and 6 so they
cannot be lost.

---

## macOS — automated, against a temporary HOME (2026-08-02)

Run by an agent on macOS 15 (Darwin 25.5.0), Node v22.20.0, npm 10.9.3. Every
step ran against a throwaway `HOME` and a throwaway npm prefix — the
operator's real `~/.pi/agent/`, `~/.bash_profile`, Ghostty config, and global
npm packages were never touched.

| What was run | Result |
|---|---|
| `setup/tests/test-setup.sh --with-npm` | **62/62 PASS** |
| Guide Step 1 — `env/install.sh --skip-packages` into a temp HOME | PASS (`course-check` reports PASS; the applications themselves were not reinstalled) |
| Guide Step 3 — `setup/install-pi.sh` with a real `npm install -g @earendil-works/pi-coding-agent@0.83.0` into a temp prefix | pi installed, `pi --version` = `0.83.0`, matches the pin. 11 seconds on a warm npm cache. |
| Guide Step 4 — `course-smoke-test --no-model` | PASS on all four offline checks |
| The `curl … \| bash -s -- --key …` form of Step 3, served from a local HTTP server standing in for the published repository | PASS — payload downloaded, installed, configured, smoke test run; no hang despite the script itself occupying stdin |
| The same run's smoke-test check 5, against the **real** OpenRouter endpoint with a deliberately invalid key | Reached the service and returned `401 {"message":"User not found."}`, rendered as the readable "could not reach the model" failure; check 6 correctly skipped rather than spending a second call |
| `bash -n` on `install-pi.sh` and `course-smoke-test` | clean |
| `--help` / `--version` on both | exercised |

What the automated run covers, check by check:

- **Checks 1–4 of the smoke test** (environment, pi version, model
  configuration, key file) ran for real against a real installed pi.
- **Checks 5 and 6** (the model answering; the agent completing a task) ran
  against a stub `pi` in three shapes — answers correctly, rejects the key,
  and answers-but-does-nothing — confirming the pass path, both failure
  messages, that a rejected key does not trigger a second paid call, and that
  the task is judged by the file on disk rather than by what the agent said.
- **Check 5's failure path additionally ran for real.** With an invalid key,
  the pinned pi read the generated `settings.json` and `auth.json`, resolved
  `openrouter` / `anthropic/claude-sonnet-5`, reached OpenRouter, and was
  rejected with a 401 — which the check rendered as its readable failure
  message. That exercises the whole configuration chain end to end; what it
  does not exercise is the *success* path, which needs a funded key.

The sample outputs quoted in `setup/README.md` Steps 3 and 4 are copied
from this run — including the installer's two-line opening banner — with
the temporary paths rewritten to `/Users/you`, and the Step 2 and
model-check lines updated to match the post-review wording (frozen-screen
notice; "asking the model…" info lines; see the review fixes commit).
After any change to installer or smoke-test output, re-run and re-compare
these samples — the guide's method is screen-matching, so a stale sample
is a defect.

### Post-review fixes verified (2026-08-02)

The chunk review found, and reproduced, a defect in the smoke test's
timeout wrapper: `sh -c` without `exec` meant the kill hit the wrapper
shell and the real pi survived as an orphan — still spending the key. The
fix (`exec` in both payloads; TERM→KILL→`wait` teardown wrapped to discard
job-control noise) was re-verified directly: a 300-second fake payload
driven through the fixed `run_with_timeout` with a 2-second limit returned
124 in ~3s with **zero surviving processes** and no "Terminated" noise.
The model-answer check was also hardened: it now asks for a computation
("What is 19 plus 23?") and accepts only a last non-empty line whose
digits are `42`, so an error path echoing the prompt can no longer pass
the key check. Both regression suites re-run green after the fixes
(60/60; with `--with-npm`, 64/64).

### What this does *not* establish

- **No clean machine.** The authoring machine already had Node, npm, git and
  Homebrew. Nothing here proves the first-run experience: the Homebrew
  install and its single password prompt, the Ghostty download, or a
  `PATH` that does not yet contain `npm`'s global bin.
- **No funded key, so no successful model call.** The rejection path reached
  OpenRouter for real (above), but nothing has yet confirmed that
  `anthropic/claude-sonnet-5` under `pi -p` returns `PONG` on demand, that it
  creates the file check 6 asks for, or that either finishes inside the 90-
  and 180-second timeouts. Those three are the substance of items 5 and 6 of
  the checklist.
- **No human.** An agent following instructions it wrote is the wrong test
  environment (TESTING_PHILOSOPHY.md, first principle).

## Windows — **NOT PERFORMED**

Nothing in the Windows path has ever executed. This is two layers of
untested, not one:

- `env/install.ps1` and `env/windows/Patch-WindowsTerminal.ps1` are authored
  but have never run on Windows (`env/README.md`, Testing status). Their
  settings.json logic is verified only by proxy, in Node, against fixtures.
- `setup/install-pi.sh` has never run under Git Bash. It is written to bash
  3.2 and uses nothing macOS-specific, and the smoke test already tolerates
  Git Bash's odd permission reporting on `auth.json` — but "written to work"
  is not "seen to work".

Do the Windows dry-run **first** when scheduling, for exactly this reason.
Specific things to watch, beyond a plain PASS:

- Does `npm install -g` succeed without elevation under Git Bash?
- Is `pi` on the PATH in the same window that installed it, or must the
  participant reopen the terminal? Step 3 of the guide assumes the former and
  the installer warns if not — confirm which happens.
- Does `auth.json` end up genuinely private, or only apparently so? The smoke
  test accepts `-rw-r--r--` on Windows because Git Bash misreports modes;
  confirm the underlying ACL is not world-readable.
- Does `course-smoke-test`'s `run_with_timeout` behave under Git Bash's
  process model?

## Human floor test — **NOT PERFORMED**, both platforms

Per TESTING_PHILOSOPHY.md (Floor Testing), a person matching the audience
floor works through the guide while an author watches in silence. The
protocol lives in [../env/FLOOR_TEST.md](../env/FLOOR_TEST.md); its task list
covers the environment. Add these tasks for this guide:

1. "Install pi using the line in your email." (Watch: do they copy the whole
   line, key included? Do they paste with the right shortcut?)
2. "Check that your setup works." (Do they find `course-smoke-test` in the
   guide? Do they read PASS as 'I am finished'?)
3. Break something first — rename `~/.pi/agent/auth.json` — and ask them to
   run the check and act on what it says. (Does the FAIL line send them to
   the right row of the troubleshooting table?)

Route observed friction to `docs/trunk/FRICTION.md`.

---

## Log

| Date | Platform | What was run | Result | By |
|---|---|---|---|---|
| 2026-08-02 | macOS 15 | Automated: full test suite `--with-npm`; guide steps 1, 3, 4 against a temp HOME; the `curl \| bash` form of step 3 against a local server | 62/62 PASS; guide steps PASS; check 5 reached OpenRouter and failed correctly on an invalid key | agent (chunk `onboarding_setup_guide`) |
| | Windows | — | **pending** | |
| | macOS | Clean machine, real key, human | **pending** | |
| | Windows | Clean machine, real key, human | **pending** | |
