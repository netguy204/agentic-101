---
status: ACTIVE
ticket: null
parent_chunk: null
code_paths:
  - env/README.md
  - env/DISTRIBUTION.md
  - env/FLOOR_TEST.md
  - env/versions.env
  - env/install.sh
  - env/install.ps1
  - env/uninstall.sh
  - env/lib/common.sh
  - env/lib/shellrc.sh
  - env/bin/commit
  - env/bin/revert
  - env/bin/course-check
  - env/windows/Patch-WindowsTerminal.ps1
  - docs/trunk/SPEC.md
  - docs/trunk/DECISIONS.md
code_references:
  - ref: env/install.sh
    implements: "macOS installer: Ghostty/node/git via Homebrew, payload to ~/.agentic-101 (copy-then-move; includes course-update, DEC-012), managed blocks in ~/.bash_profile, ~/.zshrc, and Ghostty config (bash-inside-Ghostty, pi keybinds, option-as-alt)"
  - ref: env/install.ps1
    implements: "Windows installer (AUTHORED, UNTESTED on Windows): winget packages, payload, LF bash_profile block, Windows Terminal patch, course-check via Git Bash"
  - ref: env/windows/Patch-WindowsTerminal.ps1
    implements: "Required WT settings.json patch per DEC-007: pi sendInput bindings, Alt+Enter unshadowing, Git Bash default profile (mintty trap avoidance)"
  - ref: env/bin/commit
    implements: "Guided plain-language checkpoint walkthrough; $HOME/init guardrails; identity auto-setup"
  - ref: env/bin/revert
    implements: "Guided restore walkthrough; uncommitted-work gate (save-first default, typed set-aside, cancel); restore-forward-as-new-checkpoint so reverts are revertible"
  - ref: env/bin/course-check
    implements: "PASS/FAIL environment diagnostic consumed by installers and the setup guide's smoke test"
  - ref: env/lib/common.sh
    implements: "Shared helpers: TTY-aware output, safe prompts, backup_file, write_managed_block (idempotent delimited edits)"
  - ref: env/lib/shellrc.sh
    implements: "Installed shellrc: PATH prepend, identical two-platform prompt, bash 3.2 silence flag"
  - ref: env/uninstall.sh
    implements: "Removes managed blocks and install root; deliberately leaves applications installed"
  - ref: env/versions.env
    implements: "Per-cohort version pinning source of truth and pinning procedure (SPEC Versioning)"
  - ref: env/tests/test-commands.sh
    implements: "commit/revert end-to-end smoke suite in throwaway repos (45 checks)"
  - ref: env/tests/test-install.sh
    implements: "install/uninstall smoke suite against temp HOME (35 checks)"
  - ref: env/README.md
    implements: "Environment documentation: what installs (including course-update), what is modified, undo story, option-as-alt tradeoff, untested-Windows notice"
  - ref: env/DISTRIBUTION.md
    implements: "Publishing prerequisite for the curl|bash one-liner; base URL locations, including course-update as a consumer of both bases"
  - ref: env/FLOOR_TEST.md
    implements: "Floor-test protocol, DEC-007 keybinding audit items, automated results log, pending human runs"
narrative: null
investigation: null
subsystems: []
friction_entries: []
depends_on: []
created_after: []
---

# Chunk Goal

## Minor Goal

The curriculum ships a **managed terminal environment**: a
participant-facing installation that presents the same shell experience on
macOS and Windows and puts a small set of guided convenience commands on
the PATH. Every session's material and the setup guide
(docs/chunks/onboarding_setup_guide) assume this environment; "open your
terminal" always means *this* terminal, configured identically for every
participant.

The convenience commands wrap scary-but-necessary operations in
interactive walkthroughs. The initial set:

- **`commit`** — checkpoint your work: shows what changed in plain
  language, asks what this checkpoint should be called, and saves it. No
  staging vocabulary, no flags.
- **`revert`** — walk back safely: lists recent checkpoints in plain
  language, lets the participant pick one, confirms what will happen, and
  restores it.

The operator's design bar, verbatim: "Imagine if there was a commit and a
revert command that users could just type and it walked them through the
process instead of what they get with the standard git cli." The commands
are conversational walkthroughs, not thin aliases — a participant who has
never heard of git gets git's safety without git's porcelain.

Context the implementing agent needs:

- **Why this exists**: pi has no built-in undo and no permission gates
  (see docs/chunks/onboarding_setup_guide/pi-reference.md, §6 pitfall 1 —
  pi's own docs say "use git or another checkpointing workflow").
  Checkpointing is the mitigation, but the raw git CLI is exactly the
  comprehension burden the audience floor (DEC-004) forbids. Guided
  wrappers close that gap.
- **Cross-platform consistency is a first-class requirement**, not a
  nice-to-have. pi's keybindings (Shift+Enter, Alt+Enter) depend on the
  Kitty keyboard protocol and behave differently across terminal apps
  (pi-reference.md §6 pitfall 2). The prescribed terminals are DEC-007
  (Windows Terminal + Git Bash profile on Windows; Ghostty running bash on
  macOS, per DEC-008). A researched comparison and recommendation
  (August 2026) lives in this chunk directory as `terminal-research.md`:
  no single healthy terminal is first-class on both platforms with solid
  Kitty-protocol support, so it recommends per-platform flagships —
  Windows Terminal + a Git Bash profile on Windows, Ghostty on macOS —
  with WezTerm as the single-app runner-up (stale stable release is the
  cost). It also documents why WSL2 and MSYS2 were rejected in favor of
  Git Bash (pi's own documented Windows path), the mandatory Alt+Enter
  remap on Windows Terminal, and the "mintty trap" (participants must
  never launch the Start-menu Git Bash icon). Its two time-sensitive
  claims were re-verified 2026-08-02 against the projects' GitHub
  releases pages: Windows Terminal 1.25 remains Preview-only (latest
  stable 1.24.11911.0, 2026-07-16 — so the documented `sendInput`
  bindings are required, not optional), and WezTerm's latest stable is
  still 20240203 with nothing newer. If implementation happens
  substantially later than this date, spot-check both again.
- **Installable non-interactively**: the setup guide runs this
  environment's installer as a copy-paste step, so installation must not
  require judgment or interactive choices from the participant.
- **The command set is a starting point.** More wrappers may emerge from
  cohort friction (log FRICTION.md entries rather than speculatively
  building them now).

## Success Criteria

- The environment installs on macOS and Windows and presents the same
  prompt, the same command set, and working pi keybindings on both
  (per-platform installation, identical experience after install).
- `commit` and `revert` exist as interactive guided flows: plain-language
  prompts, no git vocabulary required, safe defaults, and a clear
  confirmation before anything destructive. A participant at the audience
  floor (DEC-004) can checkpoint and restore without instruction beyond
  "type `commit`".
- `revert` cannot silently destroy work: uncommitted changes are
  checkpointed or explicitly confirmed away before restoring.
- The installer runs non-interactively from a single copy-paste command,
  suitable for embedding in the setup guide.
- Versions of everything the environment installs are pinned or pinnable
  per cohort (SPEC.md, Versioning and Compatibility).
- A floor test per TESTING_PHILOSOPHY.md (Floor Testing) is performed for
  the commit/revert walkthroughs and observations recorded.
- SPEC.md's DRAFT Repository Layout is updated to name where the
  environment's source lives in this repo.

## Rejected Ideas

### Teach the standard git CLI instead

Participants could learn `git add`/`git commit`/`git checkout` directly —
it's the transferable skill.

Rejected because: it violates the audience floor (DEC-004) and the
course's scope (GOAL.md: not a programming course). Git fluency is not the
skill being taught; safe checkpointing is a prerequisite for fearless
delegation, and the wrapper delivers it at zero comprehension cost. The
operator explicitly framed the standard git CLI experience as the thing to
avoid.

### Rely on a pi extension for checkpointing

pi's examples include a git-checkpoint extension; checkpointing could live
inside the harness.

Rejected because: participants also need checkpoint/restore *outside* pi
(before and after sessions, when pi isn't running), and a shell command
they can always type is a simpler mental model than harness-internal
state. A pi extension may later complement the shell commands, but the
shell-level walkthrough is the deliverable.