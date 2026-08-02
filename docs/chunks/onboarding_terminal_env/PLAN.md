# Implementation Plan

## Approach

The managed environment ships as source in a new top-level `env/` directory
and installs into a single self-contained root on the participant's machine,
`~/.agentic-101/`. Two platform installers (`env/install.sh` for macOS,
`env/install.ps1` for Windows) install the prescribed terminal and its
dependencies, patch the terminal's config for pi's keybindings (DEC-007),
copy the shared command set into `~/.agentic-101/bin`, and hook that
directory onto the PATH of an interactive login bash shell.

Three properties drive every design choice below:

**One shell on both platforms.** DEC-007 already states shell commands in
all course material are bash on both platforms. Git Bash makes that true on
Windows for free; on macOS the login shell is zsh, so the installer
configures Ghostty with `command = /bin/bash -l`. That single line collapses
the whole environment onto one startup file (`~/.bash_profile`), one prompt
string, one PATH mechanism, and one language for `commit`/`revert`. The
change is scoped to Ghostty — the participant's system login shell is
untouched, so nothing outside the course terminal changes. Scripts are
written to bash 3.2 (macOS system bash) so the same files run unmodified
under Git Bash's bash 5.

**Every file we touch is backed up, marked, and re-writable.** The
installers are run more than once (re-install, version bump, a participant
who pastes the line twice), so every edit to a file we do not own is either
a delimited managed block (`# >>> agentic-101 ... >>>`) that is replaced
wholesale on re-run, or a JSON object tagged with an `agentic-101`
identifier we can find and replace. First modification of any file writes a
timestamped `.agentic-101-backup-<stamp>` copy beside it. `env/uninstall.sh`
removes the blocks and the install root.

**Installable non-interactively from one line.** Both installers run with
no prompts and no judgment calls. They resolve their payload two ways: if
the script sits next to the rest of `env/` (a clone or extracted tarball)
it uses the local files; otherwise — the `curl | bash` case — it downloads
each payload file from `AGENTIC101_ENV_BASE_URL`. That keeps the copy-paste
one-liner to a single command while remaining fully testable from a local
checkout.

`commit` and `revert` are plain bash wrappers over git plumbing, written in
the voice of `pi-learning-paths.md` Stage 0.5: checkpoints and snapshots,
never "staging", "index", "HEAD", or "working tree". They are interactive by
default and accept non-interactive flags used only by the smoke test and the
facilitator.

Relevant decisions: DEC-004 (audience floor sets the vocabulary and the
"no judgment required" install bar), DEC-006 (the environment exists at all;
`commit`/`revert` are the named mitigation for pi's missing undo), DEC-007
(the terminal pairing and the two mandatory config patches). One new
decision falls out of this plan and is recorded as DEC-008: environment
source location, install root, and bash-inside-Ghostty on macOS.

Testing follows TESTING_PHILOSOPHY.md. This is a documentation-heavy project
with no test suite; verification is `ve validate` plus executable smoke
checks. Every macOS-side artifact is executed here against temporary `HOME`
directories and throwaway git repositories — never the operator's real
config. The Windows artifacts cannot execute on this machine; they are
authored against pi's shipped `docs/terminal-setup.md` and `docs/windows.md`
and Windows Terminal's documented settings schema, syntax-checked as far as
possible without PowerShell, and marked untested. The human-dependent
success criterion (floor test) is delivered as a written protocol
(`env/FLOOR_TEST.md`) with an empty results log; performing it requires a
person matching the audience floor and is an operator follow-up.

## Sequence

### Step 1: Create `env/` skeleton, version pins, and shared shell library

Files: `env/versions.env`, `env/lib/common.sh`, `env/lib/shellrc.sh`

`env/versions.env` is the single source of truth for per-cohort pinning
(SPEC.md, Versioning and Compatibility): `ENV_VERSION`, plus a pin variable
per installed package (`GHOSTTY_VERSION`, `NODE_VERSION`, `GIT_VERSION`,
`WINDOWS_TERMINAL_VERSION`). Empty value means "latest at install time";
a set value is enforced where the package manager supports it (winget
`--version`) and verified-and-reported where it does not (Homebrew casks).
`--strict-versions` turns a mismatch into a failure. pi itself is *not*
pinned here — the setup guide chunk owns the pi version.

`env/lib/common.sh` holds what `commit`, `revert`, and the installer share:
`say`/`warn`/`fail` output helpers with color only when stdout is a TTY,
`ask` (prompt with default, safe when stdin is not a TTY), `confirm`
(yes/no defaulting to the safe answer), `backup_file`, and
`write_managed_block <file> <marker-id> <content>` implementing the
replace-in-place block edit.

`env/lib/shellrc.sh` is the content installed to `~/.agentic-101/shellrc`
and sourced from the managed block in `~/.bash_profile`: PATH prepend,
identical `PS1` on both platforms, `BASH_SILENCE_DEPRECATION_WARNING=1`
(macOS bash 3.2 startup notice), and nothing else.

### Step 2: Write `commit`

File: `env/bin/commit`

Interactive flow:

1. Locate the folder. If it is not yet checkpointed, explain in one sentence
   what turning on checkpoints means and ask permission to turn it on
   (`git init`). Refuse outright — with an explanation, not an error — in
   `$HOME`, `/`, or any path above an existing repository, so a participant
   cannot accidentally start checkpointing their entire home folder.
2. Ensure a git identity exists. If neither global nor local `user.name`/
   `user.email` is set, set repo-local values derived from the OS username
   and say so in one line. This removes git's identity error wall, which is
   pure comprehension burden at the floor.
3. Summarize what changed in plain language from `git status --porcelain`:
   "3 things changed in this folder: notes.txt (edited), report.md (new),
   old.txt (deleted)". Cap the list, then "…and 4 more".
4. If nothing changed, say so and exit 0 — not an error.
5. Ask what to call the checkpoint, offering a dated default
   ("Checkpoint on Saturday, August 2 at 3:04 PM") that Enter accepts.
6. Save it (`git add -A` then `git commit`) and confirm in plain language,
   naming `revert` as the way back.

Non-interactive surface (facilitator/smoke test only, documented in
`env/README.md`, never taught): `commit "message"`, `--yes`, `--help`,
`--version`. When stdin is not a TTY, prompts resolve to their defaults
rather than hanging.

### Step 3: Write `revert`

File: `env/bin/revert`

Interactive flow:

1. Refuse politely if the folder has no checkpoints yet, pointing at
   `commit`.
2. If anything has changed since the last checkpoint, deal with it before
   going anywhere — this is the "cannot silently destroy work" criterion.
   Three options, safe one first: save these changes as a checkpoint first
   (default, accepted with Enter); set them aside (`git stash push -u` with
   a labelled message, described honestly as recoverable by the
   facilitator, and requiring the participant to type the word `set aside`
   → implemented as typing `set`); or cancel.
3. List the last 10 checkpoints newest-first, numbered, with relative times
   and their names.
4. Ask for a number. Enter with no input cancels — the safe default.
5. State exactly what will happen in plain language, including that
   anything done after that point will be undone, and ask for confirmation
   defaulting to "no".
6. Restore forward, never rewrite history: set the folder's contents to the
   chosen checkpoint and record that restore as a new checkpoint named
   "Back to: <name>". Prior checkpoints stay in the list, so a mistaken
   revert is itself revertible. Implementation uses whichever of
   `git restore --source` / `git read-tree -u --reset` is verified in
   Step 7 to delete files added after the chosen checkpoint; the wrapper
   asserts a clean folder first, so no uncommitted work is at risk.
7. Confirm in plain language, and state that nothing was lost.

Non-interactive surface: `--list`, `--to N`, `--yes`, `--help`, `--version`.

### Step 4: Write `course-check`

File: `env/bin/course-check`

A diagnostic, not a convenience command: prints the environment version,
verifies `commit`/`revert` are on PATH and executable, verifies `git`,
`bash`, and `node` are present with their versions, reports the terminal
config patch state where detectable, and exits 0/1 with a single
unambiguous PASS/FAIL line. The installer runs it as its own last step, and
the setup guide's smoke test (docs/chunks/onboarding_setup_guide) calls it
to satisfy that chunk's "verifies the managed environment including
`commit`/`revert` on PATH" criterion.

### Step 5: Write the macOS installer

File: `env/install.sh`

Ordered, idempotent, no prompts:

1. Refuse to run as root; require macOS; detect architecture.
2. Ensure Homebrew is present; if absent, install it non-interactively
   (`NONINTERACTIVE=1`) and add it to PATH for the rest of the run.
3. `brew install --cask ghostty`; `brew install node git` honoring
   `versions.env`; skip anything already present at the pinned version.
4. Create `~/.agentic-101/{bin,lib}`, copy or download the payload, `chmod
   +x` the commands, write `VERSION` and a copy of `versions.env`.
5. Write `~/.agentic-101/shellrc`; add the managed block to
   `~/.bash_profile` (creating it if needed) and, so a participant who
   opens stock Terminal.app is not stranded without the commands, the same
   block to `~/.zshrc` guarded to only set PATH.
6. Patch Ghostty's config
   (`~/Library/Application Support/com.mitchellh.ghostty/config`) with a
   managed block: `command = /bin/bash -l`, pi's documented
   `keybind = alt+backspace=text:\x1b\x7f`, and `macos-option-as-alt = true`
   so Option+Enter reaches pi as Alt+Enter (research §4 caveat 3). Remove a
   legacy `keybind = shift+enter=text:\n` line if present, per pi's docs.
   The Option-as-Alt tradeoff (accented characters via Option are disabled
   inside Ghostty) is documented in `env/README.md` with a one-line
   removal instruction and is a floor-test item.
7. Run `course-check` and print the next step.

Flags: `--dry-run`, `--skip-packages` (config-only, used by the smoke
tests), `--prefix DIR`, `--strict-versions`, `--help`.

### Step 6: Write the Windows installer and Windows Terminal patch

Files: `env/install.ps1`, `env/windows/Patch-WindowsTerminal.ps1`

`install.ps1` mirrors `install.sh`: `winget install --silent
--accept-package-agreements --accept-source-agreements
--disable-interactivity` for `Git.Git`, `OpenJS.NodeJS.LTS`, and
`Microsoft.WindowsTerminal` (a no-op on Windows 11 where it is
preinstalled), honoring pins via `--version`; then the payload into
`$env:USERPROFILE\.agentic-101`; then the `~/.bash_profile` managed block
written with LF line endings so Git Bash reads it; then the Windows
Terminal patch; then `course-check` run through Git Bash.

`Patch-WindowsTerminal.ps1` is the required piece from DEC-007 (stable WT
1.24 has no native Kitty protocol, and WT's default Alt+Enter = fullscreen
shadows pi's follow-up queueing regardless). It locates `settings.json` at
the Store path
(`%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState`)
or the unpackaged path (`%LOCALAPPDATA%\Microsoft\Windows Terminal`),
backs it up, and then:

- adds the two `sendInput` actions from pi's `docs/terminal-setup.md`
  verbatim (`[13;2u` for shift+enter, `[13;3u` for alt+enter),
  each tagged `"name": "agentic-101: …"` so a re-run replaces rather than
  duplicates, and removes any pre-existing binding of those two chords;
- adds an explicit Git Bash profile with a deterministic GUID pointing at
  `%PROGRAMFILES%\Git\bin\bash.exe -i -l`, starting in `%USERPROFILE%`,
  and sets `defaultProfile` to it — so the participant never needs to pick
  a tab, and never opens the Start-menu mintty "Git Bash" icon (research
  §4 caveat 4);
- prints the "fully close and reopen Windows Terminal" instruction pi's
  docs call for.

The script is authored to be re-runnable and to fail loudly rather than
half-write. It cannot be executed on this macOS machine; the JSON
transformation is therefore also exercised indirectly in Step 7 by
reproducing it in `jq` against the same fixtures, and the file is marked
untested in `env/README.md` and in the completion report.

### Step 7: Smoke-test everything runnable on macOS

Scratch only — no writes to the operator's real `~/.bash_profile`, Ghostty
config, or `~/.pi`.

1. `bash -n` every shell script; run each command's `--help`/`--version`.
2. Verify the git restore idiom (`git restore --source` vs
   `git read-tree -u --reset`) in a throwaway repository: a file added
   after the target checkpoint must be gone after the restore, and a file
   deleted after it must be back. Wire the verified idiom into `revert`.
3. Drive `commit` end-to-end in a throwaway repo with piped stdin: new
   folder → first checkpoint, no-change case, default-name case, refusal in
   `$HOME`.
4. Drive `revert` end-to-end: clean revert, revert with uncommitted changes
   through each of the three options, cancel path, `--list`, out-of-range
   input.
5. Run `install.sh --skip-packages` with `HOME` pointed at a temp dir;
   assert the install root, the `~/.bash_profile` block, the Ghostty
   managed block, the backup files; re-run and assert byte-identical
   results and no duplicated blocks; run `uninstall.sh` and assert clean
   removal. Validate the generated Ghostty config with the `ghostty
   +validate-config` binary available on this machine if it accepts a
   `--config-file` override.
6. Apply the Windows Terminal JSON transformation with `jq` to three
   fixtures (empty settings, settings with an unrelated `actions` array,
   settings already patched) and assert the resulting JSON matches what
   `Patch-WindowsTerminal.ps1` is written to produce, confirming the
   *logic*; platform execution remains untested.

Record results in `env/FLOOR_TEST.md`'s automated-checks section.

### Step 8: Write `env/README.md`, `env/uninstall.sh`, `env/DISTRIBUTION.md`

`env/README.md` — what the environment is, what it installs on each
platform, the install one-liners, the non-interactive flags, the
`~/.agentic-101` layout, what each installer modifies and how to undo it,
the Option-as-Alt tradeoff, per-cohort re-pinning instructions, and an
explicit "Windows path is authored but untested" notice until a Windows
floor test clears it.

`env/uninstall.sh` — removes the managed blocks and the install root on
macOS and Git Bash; leaves installed packages alone (removing a
participant's Node is not ours to do) and says so.

`env/DISTRIBUTION.md` — the one open external dependency: the repository
has no remote yet, so the base URL the `curl | bash` one-liner reads from
is a placeholder in exactly one place per installer
(`AGENTIC101_ENV_BASE_URL`). This file records the one-liner shape, where
the URL is set, and that publishing the repository is a prerequisite for
the setup guide to embed a working line.

### Step 9: Record DEC-008 and update SPEC.md

Append DEC-008 to `docs/trunk/DECISIONS.md`: the managed environment's
source lives in `env/`, installs to `~/.agentic-101/`, and runs bash inside
Ghostty on macOS for shell parity. Alternatives considered: putting the
environment inside `setup/` (rejected — `setup/` owns participant-facing
instructions authored by a different chunk; mixing installable software
into it blurs which chunk owns what), and keeping zsh on macOS with a
parallel zsh prompt and rc file (rejected — doubles the startup-file
surface and diverges the two platforms exactly where DEC-007 says they
should converge).

Update SPEC.md's DRAFT Repository Layout to name `env/` as the managed
environment's source and to say `setup/` consumes its installer. The
Repository Layout DRAFT checkbox stays checked-out (still draft) — the
first *session* chunk is what solidifies it.

### Step 10: Write the floor-test protocol

File: `env/FLOOR_TEST.md`

Per TESTING_PHILOSOPHY.md (Floor Testing), the protocol a silent observer
runs with one person matching the audience floor: preconditions, the exact
tasks ("make a change to a file, then checkpoint it"; "undo everything back
to the checkpoint before last"), what the observer records (hesitations,
misreadings, questions asked aloud, wrong guesses about what a word means,
time to completion), what counts as a defect versus an observation, the
DEC-007 keybinding audit items (the full pi keybinding list on stable
Windows Terminal 1.24; Option+Enter on Ghostty both with and without
`macos-option-as-alt`), and the instruction to route findings to
docs/trunk/FRICTION.md rather than explaining them away. Includes a results
log with the automated-check results from Step 7 filled in and the human
run left empty and marked pending.

### Step 11: Validate and commit

`uvx --from vibe-engineer ve validate` must pass. Commit the chunk
documentation and the `env/` tree together per the project's chunk-commit
convention.

## Dependencies

- No chunk dependencies. `onboarding_setup_guide` consumes this chunk's
  installer but runs after it.
- External to the repository: publishing the repository so the
  `curl | bash` base URL resolves (see Step 8, `env/DISTRIBUTION.md`). Not
  blocking — the installers run from a local copy today.

## Risks and Open Questions

- **Windows is authored blind.** `install.ps1` and
  `Patch-WindowsTerminal.ps1` cannot execute here; no PowerShell is
  installed on this machine. The JSON logic is verifiable by proxy, the
  winget invocations and path resolution are not. Mitigation: conservative
  authoring against documented behavior, loud failure over partial writes,
  and an explicit untested marker until a Windows dry-run clears it.
- **`macos-option-as-alt = true` disables Option-composed characters
  inside Ghostty.** Accepted because a silently dead Alt+Enter is the worse
  failure for this audience, and the setting is scoped to the course
  terminal. Floor-test item; documented removal instruction.
- **Homebrew casks cannot be version-pinned the way winget can.** The
  environment therefore *verifies and reports* the macOS versions it gets
  rather than forcing them, with `--strict-versions` to fail instead. This
  satisfies "pinned or pinnable" honestly rather than claiming a guarantee
  Homebrew does not offer.
- **Homebrew itself may be absent or blocked on a managed laptop.** The
  installer installs it non-interactively, which needs an admin password on
  a first run — the one place the macOS path can stop and wait. Documented
  in `env/README.md` as the single prerequisite to screen for before the
  cohort, matching research §4 caveat 6 for corporate Windows.
- **Git Bash's home directory and `.bash_profile` vs `.bashrc`.** Git Bash
  reads `~/.bash_profile` for login shells; the WT profile is written with
  `-l` to guarantee that. If a participant already has a `.bashrc` and no
  `.bash_profile`, our block goes in `.bash_profile` and a sourcing line
  for `.bashrc` is preserved rather than shadowed.
- **The floor test cannot be performed by an agent.** Everything else in
  the success criteria is delivered; that one criterion ships as a protocol
  plus a pending marker, reported as an operator follow-up rather than
  silently claimed.

## Deviations

<!-- Populated during implementation. -->
