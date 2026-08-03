# Pre-Cohort Checklist

<!-- Chunk: docs/chunks/onboarding_setup_guide - Operator checklist run before every cohort -->

Run this before every cohort, from the top, on a branch. It is the checklist
`docs/trunk/TESTING_PHILOSOPHY.md` (Test Organization) requires to live in
`setup/`: re-pin versions, re-run the smoke test on both platforms, re-run
the exercise dry-runs, tag `cohort-YYYY-MM`.

Items marked **BLOCKING** must be green before `setup/README.md` is sent to a
single participant. The others are strong shoulds.

Copy this file's checkboxes into the cohort's tracking issue, or work through
it in place and commit the ticks — either way, record who ran it and when at
the bottom.

---

## 1. Publish the installers — **BLOCKING**

`setup/README.md` embeds `curl | bash` one-liners containing the token
`REPLACE-ME`. **As written they do not work.** This is deliberate and
documented in `env/DISTRIBUTION.md`; it is also the single most likely way to
ship a broken setup guide, so it is item one.

- [ ] Push this repository to a public remote (or any host serving raw files
      over HTTPS).
- [ ] Replace `REPLACE-ME` with the real path in **all four** places:
      - [ ] `env/install.sh` (`A101_BASE_URL_DEFAULT`)
      - [ ] `env/install.ps1` (`$BaseUrlDefault`)
      - [ ] `setup/install-pi.sh` (`A101_BASE_URL_DEFAULT`)
      - [ ] `setup/README.md` (Steps 1 and 3, three commands)
- [ ] `grep -rn REPLACE-ME env/ setup/` returns nothing.
- [ ] Run both Step 1 one-liners on a machine with **no checkout** of this
      repository, and confirm each ends in `PASS`.
- [ ] Run the Step 3 one-liner the same way, with a real key.

## 2. Re-pin versions

Two pin files, deliberately separate (`setup/pins.env` explains why):
`env/versions.env` pins the environment, `setup/pins.env` pins pi and the
model.

- [ ] `npm view @earendil-works/pi-coding-agent version` — is there a newer
      pi? If so, install it, read its changelog for anything affecting
      keybindings, `-p` mode, or settings, and work through `setup/README.md`
      end to end before adopting it.
- [ ] `pi --list-models | grep openrouter` — confirm `PI_MODEL` from
      `setup/pins.env` is still in the catalog. Model IDs get retired; a
      retired one fails the smoke test at check 5 with an unhelpful provider
      error.
- [ ] Run `env/install.sh` and `env/install.ps1` on clean machines; copy the
      values from `~/.agentic-101/installed-versions.txt` into
      `env/versions.env`; bump `ENV_VERSION`.
- [ ] Update `setup/pins.env`: `PI_VERSION`, `PI_MODEL`, `COHORT`, and
      `EXPECTED_ENV_VERSION` (must match the `ENV_VERSION` you just set).
- [ ] **If any pin changed**, update the sample outputs in `setup/README.md`
      Steps 3 and 4 — they quote the version and model as literal text, and a
      participant comparing their screen against a stale sample will
      reasonably conclude something is broken.

## 3. Keys, spend limits, and what this costs the operator

DEC-006 puts the cost on the operator. That is a real budget line, and the
numbers belong here rather than in a participant's head.

- [ ] Issue one OpenRouter key **per participant** — not one shared key. Per
      participant means per-participant spend visibility and the ability to
      revoke one without disrupting the cohort.
- [ ] Set a hard credit limit on each key. Record the figure here:

      Per-key limit for this cohort: ______________

- [ ] Record the expected consumption and the basis for the estimate:

      Expected per participant, whole course: ______________
      Expected cohort total (participants × limit): ______________
      Basis (previous cohort actuals / estimate): ______________

- [ ] Confirm the prescribed model's current per-token price at OpenRouter
      and note it, since the pinned model may have changed in item 2:

      `PI_MODEL` price at pin time (in/out per 1M tokens): ______________

- [ ] Prepare the per-participant Step 3 email: the `curl … --key <their key>`
      line, complete, so nobody assembles it themselves. The guide tells
      participants to use the facilitator's line rather than the placeholder.
      **Send it as plain text or inside a code block, and check it survives
      as ONE line** — email clients that soft-wrap the line split the key in
      two, which is the likeliest single setup failure (the participant sees
      `unknown option`). Send yourself a test copy first and paste it into a
      terminal.
- [ ] Expect repeat smoke-test runs in your consumption estimate: every
      `course-smoke-test` run makes two paid model calls on that
      participant's key, and the troubleshooting table tells people to
      re-run it.
- [ ] Note the rotation date. Keys are pasted on a command line and land in
      participants' shell history, so treat them as disclosed:

      Revoke/rotate all cohort keys by: ______________

## 4. Re-run the automated tests

- [ ] `bash env/tests/test-install.sh` — green.
- [ ] `bash env/tests/test-commands.sh` — green.
- [ ] `bash setup/tests/test-setup.sh` — green.
- [ ] `uvx --from vibe-engineer ve validate` — clean.

## 5. Re-run the smoke test on both platforms — **BLOCKING**

Two real machines, two real keys, the whole guide followed literally from a
clean state. "Followed literally" means the runner improvises nothing; if
they have to, the guide has a defect (TESTING_PHILOSOPHY.md, Exercise
Dry-Runs).

- [ ] macOS: whole guide, clean machine, ends in `PASS`.
- [ ] Windows: whole guide, clean machine, ends in `PASS`.
- [ ] Run `course-smoke-test` **at least twice** on each machine
      (TESTING_PHILOSOPHY.md: agentic steps are sampled more than once,
      because model behavior varies). Watch check 5 for a reply that passes
      without the model really answering, and check 6 for flakiness — one
      retry is tolerated by the guide's troubleshooting table, repeated
      failure is a defect.
- [ ] Record both in `setup/DRY_RUN.md` — including anything the runner had
      to work out for themselves.

## 6. Outstanding first-time verification — **BLOCKING for the first cohort**

These are carried forward from `env/FLOOR_TEST.md` and `setup/DRY_RUN.md` and
have never been done. They cannot be inherited from a previous cohort because
there hasn't been one.

- [ ] **Windows dry-run of the environment installer.** `env/install.ps1` and
      `env/windows/Patch-WindowsTerminal.ps1` are authored but have never
      executed on Windows. Their logic is verified by proxy only
      (`docs/chunks/onboarding_terminal_env/wt-patch-parity.js`).
- [ ] **Windows dry-run of `setup/install-pi.sh` under Git Bash.** Never run
      on Windows either. Watch specifically for: `npm install -g` permissions,
      whether `pi` lands on Git Bash's PATH without reopening the window, and
      the `auth.json` permission check (Git Bash reports Unix modes oddly, so
      the smoke test tolerates `-rw-r--r--` there — confirm it isn't hiding a
      genuinely world-readable key file on that platform).
- [ ] **Human floor test, macOS** — `env/FLOOR_TEST.md` protocol, plus this
      guide's Steps 3 and 4, with an observer who says nothing.
- [ ] **Human floor test, Windows** — same. Do this one first if only one can
      be scheduled early; it doubles as the first execution of the PowerShell
      installer.
- [ ] **DEC-007 keybinding audit**, both platforms — `env/FLOOR_TEST.md`.
- [ ] Route every observed friction point to `docs/trunk/FRICTION.md`.

## 7. Screen the participants

Both are per-participant and neither is discoverable from here (research §4,
caveat 6, in `docs/chunks/onboarding_terminal_env/terminal-research.md`).

- [ ] Ask every participant to confirm they can install software on their
      laptop. Managed corporate machines block Homebrew, winget, or the
      Microsoft Store, and this takes days to resolve.
- [ ] Ask which platform each participant is on, so a facilitator isn't
      debugging Windows for the first time live.

## 8. Tag the cohort

- [ ] Commit the re-pinned files.
- [ ] `git tag cohort-YYYY-MM && git push --tags` — this is what SPEC.md
      (Versioning and Compatibility) means by "exactly what a cohort was
      taught".

---

## Dry-run without publishing

Items 4 and 5 can be run before item 1 is done, from a checkout, by using the
local form of each installer:

```bash
bash env/install.sh                       # macOS, in place of Step 1
powershell -ExecutionPolicy Bypass -File env\install.ps1   # Windows, Step 1
bash setup/install-pi.sh --key sk-or-v1-...                # both, Step 3
```

This exercises everything except the download path itself, which is exactly
what item 1's last two boxes are for.

---

## Run record

| Cohort | Run by | Date | Notes |
|---|---|---|---|
| | | | |
