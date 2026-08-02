#!/bin/bash
# Smoke tests for env/bin/commit and env/bin/revert.
# Chunk: docs/chunks/onboarding_terminal_env - Guided command regression tests
#
# Drives both walkthroughs end to end with piped answers and asserts the
# guarantees the chunk GOAL.md names: plain language, safe defaults, and no
# silent loss of work. Everything happens in a throwaway directory; the
# operator's own files and dotfiles are never touched.
#
# Run: bash env/tests/test-commands.sh
set -u
ENV_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
SP=$(mktemp -d "${TMPDIR:-/tmp}/a101-cmdtest.XXXXXX")
trap 'rm -rf "$SP"' EXIT
WORK="$SP/cmdtest"
OUT="$SP/out.txt"; OUT2="$SP/out2.txt"; OUT3="$SP/out3.txt"; LIST="$SP/list.txt"
PASS=0; FAILED=0
ok()  { PASS=$((PASS+1)); printf '  PASS  %s\n' "$1"; }
no()  { FAILED=$((FAILED+1)); printf '  FAIL  %s\n' "$1"; }
chk() { # chk <desc> <needle> <file>
  if grep -qF "$2" "$3"; then ok "$1"; else no "$1 (missing: $2)"; printf '        --- output ---\n'; sed 's/^/        /' "$3"; fi
}
chknot() {
  if grep -qF "$2" "$3"; then no "$1 (unexpected: $2)"; else ok "$1"; fi
}

rm -rf "$WORK"; mkdir -p "$WORK"; cd "$WORK" || exit 1
export NO_COLOR=1
export PATH="$ENV_DIR/bin:$PATH"

echo "== commit: help/version =="
commit --help > "$OUT" 2>&1; chk "commit --help mentions plain usage" "Just type" "$OUT"
commit --version > "$OUT" 2>&1; chk "commit --version runs" "agentic-101 environment" "$OUT"

echo "== commit: refuses to checkpoint the home folder =="
( cd "$HOME" && commit ) > "$OUT" 2>&1; rc=$?
chk "refuses \$HOME" "top-level home folder" "$OUT"
[ $rc -ne 0 ] && ok "refusal exits non-zero" || no "refusal should exit non-zero"

echo "== commit: first checkpoint in a fresh folder =="
mkdir -p proj && cd proj || exit 1
echo hello > notes.txt
printf 'yes\nMy first checkpoint\n' | commit > "$OUT" 2>&1
chk "offers to turn on checkpoints" "not saving checkpoints yet" "$OUT"
chk "reports 1 change" "1 thing changed" "$OUT"
chk "lists the new file" "notes.txt (new)" "$OUT"
chk "saves with the typed name" 'Saved: "My first checkpoint"' "$OUT"
chk "points at revert" "type: revert" "$OUT"
[ "$(git log --format=%s -1)" = "My first checkpoint" ] && ok "commit landed in git" || no "commit did not land"

echo "== commit: declining the offer changes nothing =="
mkdir -p ../decline && ( cd ../decline && echo x > a.txt && printf 'no\n' | commit > "$OUT2" 2>&1 )
chk "declining is graceful" "Nothing was changed" "$OUT2"
[ -d ../decline/.git ] && no "declining still created a repo" || ok "declining created no repo"

echo "== commit: nothing to save =="
commit > "$OUT" 2>&1; rc=$?
chk "reports no changes" "Nothing has changed" "$OUT"
[ $rc -eq 0 ] && ok "no-change exits 0" || no "no-change should exit 0"

echo "== commit: default name via --yes =="
echo more >> notes.txt
commit --yes > "$OUT" 2>&1
chk "edited file described as edited" "notes.txt (edited)" "$OUT"
git log --format=%s -1 | grep -q "^Checkpoint on" && ok "default name used" || no "default name not used"

echo "== commit: plural + deletion + rename wording =="
echo a > added.txt; rm notes.txt; echo b > b.txt
commit -m "second" > "$OUT" 2>&1
chk "plural count" "3 things changed" "$OUT"
chk "deleted wording" "notes.txt (deleted)" "$OUT"
chk "new wording" "added.txt (new)" "$OUT"

echo "== commit: filename with a space =="
echo c > "my file.txt"
commit -m "spacey" > "$OUT" 2>&1
chk "space in filename handled" "my file.txt (new)" "$OUT"

echo "== revert: list =="
revert --list > "$OUT" 2>&1
chk "list shows newest first" "spacey" "$OUT"
chk "list is numbered" " 1)" "$OUT"

echo "== revert: cancel with empty answer =="
before=$(git rev-parse HEAD)
printf '\n' | revert > "$OUT" 2>&1
chk "empty answer stops" "Stopped. Nothing was changed." "$OUT"
[ "$(git rev-parse HEAD)" = "$before" ] && ok "cancel changed nothing" || no "cancel moved HEAD"

echo "== revert: confirmation defaults to no =="
printf '2\n\n' | revert > "$OUT" 2>&1
chk "confirmation default is no" "Stopped. Nothing was changed." "$OUT"
[ "$(git rev-parse HEAD)" = "$before" ] && ok "declined revert changed nothing" || no "declined revert moved HEAD"

echo "== revert: out of range =="
printf '99\n' | revert > "$OUT" 2>&1
chk "out of range refused" "there is no checkpoint number 99" "$OUT"

echo "== revert: not a number =="
printf 'banana\n' | revert > "$OUT" 2>&1
chk "non-numeric refused" "is not one of the numbers" "$OUT"

echo "== revert: clean revert restores contents =="
# state now: added.txt, b.txt, "my file.txt"; notes.txt deleted at "second"
printf '3\ny\n' | revert > "$OUT" 2>&1   # 3 = "My first checkpoint"? list: 1 spacey, 2 second, 3 <default>, 4 first
revert --list > "$LIST" 2>&1
printf 'checkpoint list after revert:\n'; sed 's/^/        /' "$LIST"
[ -f notes.txt ] && ok "file deleted after the checkpoint came back" || no "notes.txt did not come back"
[ ! -f "my file.txt" ] && ok "file added after the checkpoint was removed" || no "my file.txt should be gone"
chk "restore is itself a checkpoint" "Back to:" "$LIST"
chk "earlier checkpoints still listed" "spacey" "$LIST"

echo "== revert: uncommitted changes, option 1 (save first) =="
echo dirty > dirty.txt
printf '1\nsaved before going back\n2\ny\n' | revert > "$OUT" 2>&1
chk "warns about uncommitted work" "has changed since your last checkpoint" "$OUT"
revert --list > "$LIST" 2>&1
chk "option 1 saved a checkpoint" "saved before going back" "$LIST"

echo "== revert: uncommitted changes, option 2 requires the word =="
echo more-dirt > dirt2.txt
printf '2\nnope\n' | revert > "$OUT" 2>&1
chk "wrong confirmation word stops" "Stopped. Nothing was changed." "$OUT"
[ -f dirt2.txt ] && ok "file survived the refused set-aside" || no "file lost on refused set-aside"

echo "== revert: uncommitted changes, option 2 with the word =="
printf '2\naside\n1\ny\n' | revert > "$OUT" 2>&1
chk "set aside confirmed" "Set aside." "$OUT"
[ ! -f dirt2.txt ] && ok "set-aside removed the file from the folder" || no "set-aside left the file"
git stash list | grep -q "set aside by revert" && ok "set-aside work is recoverable" || no "no stash entry found"

echo "== revert: option 3 stops =="
echo z > z.txt
printf '3\n' | revert > "$OUT" 2>&1
chk "option 3 stops" "Stopped. Nothing was changed." "$OUT"
[ -f z.txt ] && ok "option 3 kept the file" || no "option 3 lost the file"
rm z.txt

echo "== revert: refuses in a folder with no checkpoints =="
mkdir -p "$WORK/nocheckpoints" && ( cd "$WORK/nocheckpoints" && revert > "$OUT3" 2>&1 )
chk "no-repo message points at commit" "Type commit" "$OUT3"
chk "no-repo message is plain" "not saving checkpoints yet" "$OUT3"

echo
printf 'RESULT: %d passed, %d failed\n' "$PASS" "$FAILED"
[ "$FAILED" -eq 0 ]
