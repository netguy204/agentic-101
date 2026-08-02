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

The sample outputs quoted in `setup/README.md` Steps 3 and 4 are copied
verbatim from this run, with the temporary paths rewritten to `/Users/you`.

### What this does *not* establish

- **No clean machine.** The authoring machine already had Node, npm, git and
  Homebrew. Nothing here proves the first-run experience: the Homebrew
  install and its single password prompt, the Ghostty download, or a
  `PATH` that does not yet contain `npm`'s global bin.
- **No real key, so no real model call.** Checks 5 and 6 have never talked to
  OpenRouter. The prompts, the timeouts, the parsing of the reply, and the
  actual behaviour of `anthropic/claude-sonnet-5` under `pi -p` are unverified
  against the live service.
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
| 2026-08-02 | macOS 15 | Automated: full test suite `--with-npm`; guide steps 1, 3, 4 against a temp HOME | 62/62 PASS; guide steps PASS | agent (chunk `onboarding_setup_guide`) |
| | Windows | — | **pending** | |
| | macOS | Clean machine, real key, human | **pending** | |
| | Windows | Clean machine, real key, human | **pending** | |
