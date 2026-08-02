# The Managed Terminal Environment

<!-- Chunk: docs/chunks/onboarding_terminal_env - Managed participant terminal environment -->

This directory is the source of the terminal environment every course
participant installs before the cohort begins. It exists so that "open your
terminal" means the same thing on every laptop in the room: the same shell
(bash), the same prompt, the same two safety commands (`commit`, `revert`),
and pi's keybindings working out of the box (DEC-006, DEC-007 in
`docs/trunk/DECISIONS.md`).

## What gets installed

| | macOS | Windows |
|---|---|---|
| Terminal | Ghostty (Homebrew cask) | Windows Terminal (winget; preinstalled on Win 11) |
| Shell | bash, run *inside Ghostty only* (`command = /bin/bash -l`) | Git Bash (Git for Windows, winget) |
| Runtime | Node.js (Homebrew) | Node.js LTS (winget) |
| git | Homebrew | supplied by Git for Windows |
| Course commands | `~/.agentic-101/bin` on PATH | same |

The participant's system login shell is never changed. On macOS, bash runs
only inside Ghostty; on Windows, Git Bash runs only inside Windows Terminal
(installed as the default profile — participants must never use the
Start-menu "Git Bash" icon, which opens mintty, where pi's keys and Node
behave worse).

## Install one-liners

From a local checkout (works today):

```bash
# macOS
bash env/install.sh
```

```powershell
# Windows (PowerShell)
powershell -ExecutionPolicy Bypass -File env\install.ps1
```

From the published repository (the form the setup guide embeds — requires
the base URL in `env/DISTRIBUTION.md` to be real first):

```bash
# macOS
curl -fsSL <BASE_URL>/install.sh | bash
```

```powershell
# Windows
irm <BASE_URL>/install.ps1 | iex
```

Installer flags (macOS; Windows mirrors them): `--dry-run`,
`--skip-packages` (configure only — used by the smoke tests),
`--strict-versions` (fail on a pin mismatch instead of warning),
`--prefix DIR` (install root; default `~/.agentic-101`).

## What the installers modify, and how to undo it

Every file the installer touches that it does not own gets a timestamped
`.agentic-101-backup-<stamp>` copy beside it on first modification. Managed
edits are delimited blocks (`# >>> agentic-101 <id> >>>` … `# <<< agentic-101
<id> <<<`) replaced wholesale on re-run — installs are idempotent.

- `~/.agentic-101/` — the install root: `bin/` (commit, revert,
  course-check), `lib/`, `shellrc`, `VERSION`, `versions.env` copy, and
  `installed-versions.txt` (the exact versions this machine actually got).
- `~/.bash_profile` — managed block sourcing `~/.agentic-101/shellrc`
  (PATH, prompt). If the participant had a `.bashrc` and no
  `.bash_profile`, the created `.bash_profile` sources `.bashrc` so nothing
  is shadowed.
- `~/.zshrc` (macOS only) — managed block that only adds PATH, so the
  commands also work if a participant opens stock Terminal.app.
- Ghostty config (macOS,
  `~/Library/Application Support/com.mitchellh.ghostty/config`) — managed
  block: `command = /bin/bash -l`, pi's documented
  `keybind = alt+backspace=text:\x1b\x7f`, and `macos-option-as-alt = true`.
  Any legacy `keybind = shift+enter=text:\n` line is removed per pi's docs.
- Windows Terminal `settings.json` (Windows) — via
  `env/windows/Patch-WindowsTerminal.ps1`: pi's two documented `sendInput`
  actions (Shift+Enter → `[13;2u`, Alt+Enter → `[13;3u`, both
  tagged `agentic-101:` so re-runs replace, not duplicate; WT's default
  Alt+Enter=fullscreen binding is removed), plus a Git Bash profile
  (deterministic GUID, `bash.exe -i -l`, starts in `%USERPROFILE%`) set as
  `defaultProfile`.

`env/uninstall.sh` removes the managed blocks and the install root. It
deliberately leaves installed applications (Ghostty, git, Node) alone —
removing a participant's Node is not ours to do — and says so when run.

### The Option-as-Alt tradeoff (macOS)

`macos-option-as-alt = true` makes Option+Enter reach pi as Alt+Enter
(follow-up queueing). The cost: Option-composed characters (é, ñ, ™) cannot
be typed *inside Ghostty*. Everywhere else on the Mac is unaffected. A
participant who needs them in the terminal can delete that one line from
the managed block in Ghostty's config. This is a floor-test audit item
(`env/FLOOR_TEST.md`).

## Per-cohort pinning

`env/versions.env` is the single source of truth; the pinning procedure
(run on clean machines → copy `installed-versions.txt` values back → bump
`ENV_VERSION`, set `COHORT`, tag `cohort-YYYY-MM`) is documented at the top
of that file. Note the platform asymmetry: winget enforces pins; Homebrew
casks can only be verified after the fact (`--strict-versions` turns a
mismatch into a failure). pi itself is pinned by the setup guide
(`setup/`), not here.

## Testing status

- **macOS path**: exercised end-to-end on macOS by `env/tests/` against
  temporary HOME directories and throwaway repositories — see
  `env/FLOOR_TEST.md` for the current results (98 automated checks).
- **Windows path (`install.ps1`, `Patch-WindowsTerminal.ps1`): AUTHORED BUT
  UNTESTED.** No Windows machine or PowerShell was available when this was
  written. The settings.json transformation logic is verified by proxy
  (`docs/chunks/onboarding_terminal_env/wt-patch-parity.js` reproduces it in
  Node against fixtures), but the scripts themselves have never executed on
  Windows. A Windows dry-run is a pre-cohort requirement — see the
  operator follow-ups in `env/FLOOR_TEST.md`.
- **Human floor test**: pending; protocol and empty results log in
  `env/FLOOR_TEST.md`.

## Prerequisite to screen for before the cohort

macOS: installing Homebrew (when absent) prompts once for an admin
password — the only place the install can stop and wait. Windows: corporate
laptops may block winget or the Microsoft Store. Screen both during
pre-cohort onboarding (research §4, caveat 6:
`docs/chunks/onboarding_terminal_env/terminal-research.md`).
