#!/bin/bash
# Tests for env/bin/course-update.
# Chunk: docs/chunks/onboarding_course_update - Update-command regression tests
#
# Runs against a throwaway HOME with a "published" copy of env/ and setup/
# served over file:// URLs (curl reads them), so the network is never used.
# pi is a stub on PATH that reports the pinned version. Asserts: nothing
# happens when current; an ENV_VERSION bump reinstalls the environment and
# the command still works afterwards (self-update safety); a pins change
# re-runs the pi installer with the saved key kept and no smoke test; an
# unreachable base changes nothing and exits non-zero; --dry-run changes
# nothing.
#
# Run: bash env/tests/test-update.sh
set -u
ENV_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
REPO_DIR=$(CDPATH= cd -- "$ENV_DIR/.." && pwd)
SP=$(mktemp -d "${TMPDIR:-/tmp}/a101-updatetest.XXXXXX")
trap 'rm -rf "$SP"' EXIT
FAKE="$SP/fakehome"
PUB="$SP/published"
STUB="$SP/stubbin"
ROOT="$FAKE/.agentic-101"
LOG="$SP/update.log"
PASS=0; FAILED=0
ok() { PASS=$((PASS+1)); printf '  PASS  %s\n' "$1"; }
no() { FAILED=$((FAILED+1)); printf '  FAIL  %s\n' "$1"; }
has()  { grep -qF -- "$2" "$3" 2>/dev/null && ok "$1" || { no "$1 (missing '$2' in $3)"; sed 's/^/        /' "$3"; }; }
hasnt(){ grep -qF -- "$2" "$3" 2>/dev/null && no "$1 (unexpected '$2')" || ok "$1"; }
exists() { [ -e "$2" ] && ok "$1" || no "$1 (missing $2)"; }

export NO_COLOR=1
export A101_ASSUME_DEFAULTS=1

# shellcheck source=../../setup/pins.env
. "$REPO_DIR/setup/pins.env"

# --- fixtures -------------------------------------------------------------

publish() { # a fresh "published" copy of the repo's env/ and setup/
    rm -rf "$PUB"; mkdir -p "$PUB"
    cp -R "$REPO_DIR/env" "$PUB/env"
    cp -R "$REPO_DIR/setup" "$PUB/setup"
}

make_stub_pi() { # reports $1 as its version
    mkdir -p "$STUB"
    cat > "$STUB/pi" <<STUBEOF
#!/usr/bin/env bash
for a in "\$@"; do [ "\$a" = "--version" ] && { echo $1; exit 0; }; done
echo "stub pi: unexpected use: \$*" >&2; exit 3
STUBEOF
    chmod +x "$STUB/pi"
}

fresh_install() { # a participant machine after Steps 1 and 3
    rm -rf "$FAKE"; mkdir -p "$FAKE"
    ( export HOME="$FAKE"; cd "$SP" && bash "$REPO_DIR/env/install.sh" --skip-packages --prefix "$ROOT" ) >"$SP/env-install.log" 2>&1 \
        || { echo "fixture: env install failed"; cat "$SP/env-install.log"; exit 1; }
    mkdir -p "$FAKE/.pi/agent"
    printf '{\n  "%s": { "type": "api_key", "key": "sk-or-v1-keepme" }\n}\n' "$PI_PROVIDER" > "$FAKE/.pi/agent/auth.json"
    cp "$REPO_DIR/setup/pins.env" "$ROOT/pins.env"
    make_stub_pi "$PI_VERSION"
}

run_update() {
    ( export HOME="$FAKE"; export PATH="$STUB:$ROOT/bin:$PATH"
      export AGENTIC101_ENV_BASE_URL="${ENV_BASE:-file://$PUB/env}"
      export AGENTIC101_SETUP_BASE_URL="${SETUP_BASE:-file://$PUB/setup}"
      cd "$SP" && "$ROOT/bin/course-update" "$@" ) >"$LOG" 2>&1
    echo $?
}

# --- 0. it is installed and answers --help / --version -----------------------

echo "== installed alongside commit/revert =="
publish; fresh_install
exists "course-update is installed" "$ROOT/bin/course-update"
[ -x "$ROOT/bin/course-update" ] && ok "course-update is executable" || no "course-update not executable"
rc=$(run_update --help); has "--help says what it updates" "Run it at the start of every session" "$LOG"
rc=$(run_update --version); has "--version reports the environment" "agentic-101 environment" "$LOG"

# --- 1. up to date ---------------------------------------------------------

echo "== up to date: nothing to do =="
before=$(cat "$ROOT/VERSION")
rc=$(run_update)
[ "$rc" = 0 ] && ok "exit 0 when current" || no "expected exit 0, got $rc"
has "environment reported current" "Course environment: up to date ($before)" "$LOG"
has "pi reported current" "pi: up to date ($PI_VERSION)" "$LOG"
has "closing line" "Nothing to do." "$LOG"
hasnt "no reopen instruction" "Close this window" "$LOG"
[ "$(cat "$ROOT/VERSION")" = "$before" ] && ok "VERSION unchanged" || no "VERSION changed"

# --- 2. environment bump ---------------------------------------------------

echo "== environment bump: reinstalls and still runs afterwards =="
sed -i.bak 's/^ENV_VERSION=.*/ENV_VERSION=9.9.9/' "$PUB/env/versions.env"
rc=$(run_update --dry-run)
[ "$rc" = 0 ] && ok "dry run exits 0" || no "dry run exit $rc"
has "dry run says would" "would update the course environment $before → 9.9.9" "$LOG"
has "dry run closing line" "Dry run finished. Nothing was changed." "$LOG"
[ "$(cat "$ROOT/VERSION")" = "$before" ] && ok "dry run changed nothing" || no "dry run changed VERSION"

rc=$(run_update)
[ "$rc" = 0 ] && ok "update exits 0" || no "update exit $rc"
has "announces the update" "Course environment: updated $before → 9.9.9" "$LOG"
has "tells them to reopen" "Close this window and open a new one" "$LOG"
[ "$(cat "$ROOT/VERSION")" = "9.9.9" ] && ok "VERSION is now 9.9.9" || no "VERSION is $(cat "$ROOT/VERSION")"
( export HOME="$FAKE"; "$ROOT/bin/commit" --version ) | grep -q "9.9.9" && ok "commit --version reports 9.9.9" || no "commit --version stale"
rc=$(run_update)
[ "$rc" = 0 ] && ok "course-update still runs after updating itself" || no "self-update broke course-update (exit $rc)"
has "now current again" "Course environment: up to date (9.9.9)" "$LOG"
has "nothing to do after" "Nothing to do." "$LOG"

# --- 3. pins change (model only) -------------------------------------------

echo "== pins change: pi installer re-run with the saved key, no smoke test =="
publish; fresh_install
sed -i.bak 's|^PI_MODEL=.*|PI_MODEL=anthropic/claude-test-model|' "$PUB/setup/pins.env"
cp "$FAKE/.pi/agent/auth.json" "$SP/auth-before.json"
rc=$(run_update)
[ "$rc" = 0 ] && ok "pins update exits 0" || no "pins update exit $rc"
has "environment untouched" "Course environment: up to date" "$LOG"
has "settings updated, pi not reinstalled" "pi: course settings updated (pi $PI_VERSION)" "$LOG"
cmp -s "$SP/auth-before.json" "$FAKE/.pi/agent/auth.json" && ok "saved key byte-identical" || no "auth.json changed"
grep -q "claude-test-model" "$ROOT/pins.env" && ok "installed pins.env refreshed" || no "pins.env not refreshed"
grep -q "claude-test-model" "$FAKE/.pi/agent/settings.json" 2>/dev/null && ok "pi settings carry the new model" || no "settings.json not updated"
hasnt "no smoke test ran" "asking the model" "$LOG"
has "tells them to reopen" "Close this window and open a new one" "$LOG"
rc=$(run_update)
has "pins now current" "pi: up to date ($PI_VERSION)" "$LOG"

# --- 4. unreachable --------------------------------------------------------

echo "== unreachable: one line, nothing changed, non-zero =="
publish; fresh_install
before=$(cat "$ROOT/VERSION")
rc=$(ENV_BASE="file:///nonexistent-agentic-101" run_update)
[ "$rc" != 0 ] && ok "exit non-zero when unreachable" || no "expected non-zero exit"
has "says it could not reach" "Could not reach the course updates" "$LOG"
has "says nothing changed" "Nothing was changed" "$LOG"
hasnt "did not report up to date" "up to date" "$LOG"
[ "$(cat "$ROOT/VERSION")" = "$before" ] && ok "VERSION untouched" || no "VERSION changed while unreachable"

# env reachable but setup not: still nothing runs
sed -i.bak 's/^ENV_VERSION=.*/ENV_VERSION=9.9.9/' "$PUB/env/versions.env"
rc=$(SETUP_BASE="file:///nonexistent-agentic-101" run_update)
[ "$rc" != 0 ] && ok "partial reachability still stops" || no "expected non-zero exit"
[ "$(cat "$ROOT/VERSION")" = "$before" ] && ok "no half-update when one fetch fails" || no "environment updated despite a failed fetch"

echo
echo "RESULT: $PASS passed, $FAILED failed"
[ "$FAILED" -eq 0 ]
