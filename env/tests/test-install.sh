#!/bin/bash
# Smoke tests for env/install.sh and env/uninstall.sh.
# Chunk: docs/chunks/onboarding_terminal_env - Installer regression tests
#
# Runs the installer against a throwaway HOME with --skip-packages, so it
# exercises every file edit the installer makes without installing anything
# and without ever touching the real ~/.bash_profile, ~/.zshrc or Ghostty
# config. Asserts idempotency, backups, and that existing user content
# survives both install and uninstall.
#
# Run: bash env/tests/test-install.sh   (macOS; the Windows half needs Windows)
set -u
ENV_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
SP=$(mktemp -d "${TMPDIR:-/tmp}/a101-installtest.XXXXXX")
trap 'rm -rf "$SP"' EXIT
FAKE="$SP/fakehome"
LOG="$SP/install.log"
PASS=0; FAILED=0
ok() { PASS=$((PASS+1)); printf '  PASS  %s\n' "$1"; }
no() { FAILED=$((FAILED+1)); printf '  FAIL  %s\n' "$1"; }
exists() { [ -e "$2" ] && ok "$1" || no "$1 (missing $2)"; }
absent() { [ ! -e "$2" ] && ok "$1" || no "$1 (still present: $2)"; }
has()  { grep -qF "$2" "$3" 2>/dev/null && ok "$1" || { no "$1 (missing '$2' in $3)"; }; }
hasnt(){ grep -qF "$2" "$3" 2>/dev/null && no "$1 (unexpected '$2')" || ok "$1"; }

GHOSTTY_CFG="Library/Application Support/com.mitchellh.ghostty/config"
export NO_COLOR=1

fresh_home() { rm -rf "$FAKE"; mkdir -p "$FAKE"; }
run_install() { ( export HOME="$FAKE"; cd "$SP" && bash "$ENV_DIR/install.sh" "$@" ) > "$LOG" 2>&1; }

echo "== dry run changes nothing =="
fresh_home
run_install --dry-run --skip-packages
has "dry run announces itself" "DRY RUN" "$LOG"
absent "dry run created no install root" "$FAKE/.agentic-101"
absent "dry run created no .bash_profile" "$FAKE/.bash_profile"

echo "== first install =="
fresh_home
run_install --skip-packages
if [ $? -ne 0 ]; then no "installer exited non-zero"; sed 's/^/        /' "$LOG"; else ok "installer exited 0"; fi
exists "install root" "$FAKE/.agentic-101"
exists "commit installed" "$FAKE/.agentic-101/bin/commit"
exists "revert installed" "$FAKE/.agentic-101/bin/revert"
exists "course-check installed" "$FAKE/.agentic-101/bin/course-check"
exists "common.sh installed" "$FAKE/.agentic-101/lib/common.sh"
exists "shellrc installed" "$FAKE/.agentic-101/shellrc"
exists "VERSION written" "$FAKE/.agentic-101/VERSION"
exists "installed-versions recorded" "$FAKE/.agentic-101/installed-versions.txt"
[ -x "$FAKE/.agentic-101/bin/commit" ] && ok "commit is executable" || no "commit not executable"
has "bash_profile block" "agentic-101 shell" "$FAKE/.bash_profile"
has "zshrc block" "agentic-101 shell" "$FAKE/.zshrc"
has "ghostty runs bash" "command = /bin/bash -l" "$FAKE/$GHOSTTY_CFG"
has "ghostty pi keybind" 'keybind = alt+backspace=text:\x1b\x7f' "$FAKE/$GHOSTTY_CFG"
has "ghostty option-as-alt" "macos-option-as-alt = true" "$FAKE/$GHOSTTY_CFG"
has "course-check ran and passed" "PASS" "$LOG"

echo "== the installed commands work from the install root =="
( export HOME="$FAKE"; export PATH="$FAKE/.agentic-101/bin:$PATH"; \
  mkdir -p "$SP/instproj" && cd "$SP/instproj" && rm -rf .git && echo hi > a.txt && \
  printf 'yes\nfrom the installed copy\n' | commit ) > "$SP/instproj.log" 2>&1
has "installed commit works" "Saved:" "$SP/instproj.log"

echo "== second install is idempotent =="
cp "$FAKE/.bash_profile" "$SP/bp-before.txt"
cp "$FAKE/$GHOSTTY_CFG" "$SP/gc-before.txt"
run_install --skip-packages
diff -q "$SP/bp-before.txt" "$FAKE/.bash_profile" >/dev/null && ok "bash_profile unchanged on re-run" || no "bash_profile changed on re-run"
diff -q "$SP/gc-before.txt" "$FAKE/$GHOSTTY_CFG" >/dev/null && ok "ghostty config unchanged on re-run" || no "ghostty config changed on re-run"
n=$(grep -c "agentic-101 shell" "$FAKE/.bash_profile")
[ "$n" = "2" ] && ok "exactly one block (open+close markers)" || no "block markers duplicated ($n found)"
ls "$FAKE"/.bash_profile.agentic-101-backup-* >/dev/null 2>&1 && ok "re-run backed up the file it edited" || no "no backup created"

echo "== existing user content is preserved =="
fresh_home
printf '# my own settings\nexport MY_VAR=1\n' > "$FAKE/.bash_profile"
mkdir -p "$FAKE/$(dirname "$GHOSTTY_CFG")"
printf 'theme = dark\nkeybind = shift+enter=text:\\n\n' > "$FAKE/$GHOSTTY_CFG"
run_install --skip-packages
has "user bash_profile line kept" "export MY_VAR=1" "$FAKE/.bash_profile"
has "user ghostty setting kept" "theme = dark" "$FAKE/$GHOSTTY_CFG"
hasnt "legacy shift+enter mapping removed" "shift+enter=text:" "$FAKE/$GHOSTTY_CFG"
ls "$FAKE/Library/Application Support/com.mitchellh.ghostty/"config.agentic-101-backup-* >/dev/null 2>&1 \
  && ok "ghostty config backed up before edit" || no "no ghostty backup"

echo "== .bashrc without .bash_profile is not shadowed =="
fresh_home
printf 'export FROM_BASHRC=1\n' > "$FAKE/.bashrc"
run_install --skip-packages
has "bash_profile sources .bashrc" ". ~/.bashrc" "$FAKE/.bash_profile"
has "and still loads the course env" "agentic-101 shell" "$FAKE/.bash_profile"

echo "== shellrc puts the commands on PATH =="
out=$( export HOME="$FAKE"; /bin/bash -lc 'command -v commit; echo "PS1=$PS1"' 2>&1 )
case "$out" in
  *".agentic-101/bin/commit"*) ok "login bash finds commit" ;;
  *) no "login bash did not find commit: $out" ;;
esac
case "$out" in
  *'PS1=\['*) ok "prompt is set for bash" ;;
  *) no "prompt not set: $out" ;;
esac

echo "== uninstall =="
run_uninstall() { ( export HOME="$FAKE"; bash "$ENV_DIR/uninstall.sh" ) > "$SP/uninstall.log" 2>&1; }
run_uninstall
absent "install root removed" "$FAKE/.agentic-101"
hasnt "bash_profile block removed" "agentic-101 shell" "$FAKE/.bash_profile"
has "user content survived uninstall" "FROM_BASHRC" "$FAKE/.bashrc"

echo
printf 'RESULT: %d passed, %d failed\n' "$PASS" "$FAILED"
[ "$FAILED" -eq 0 ]
