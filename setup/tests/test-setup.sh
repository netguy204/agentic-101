#!/bin/bash
# Tests for setup/install-pi.sh and setup/bin/course-smoke-test.
# Chunk: docs/chunks/onboarding_setup_guide - Setup regression tests
#
# Runs against a throwaway HOME so the operator's real ~/.pi/agent/auth.json,
# settings.json, and practice folder are never touched. The two checks that
# talk to a model are exercised with a stub `pi` on PATH — a real key costs
# money and is not available to CI; the genuine article is item 5 of
# setup/PRE_COHORT_CHECKLIST.md.
#
# Run: bash setup/tests/test-setup.sh
#      bash setup/tests/test-setup.sh --with-npm   (adds a real `npm install
#      -g` of the pinned pi into a temporary prefix; needs network, slow)

set -u
SETUP_DIR=$(CDPATH= cd -- "$(dirname -- "$0")/.." && pwd)
REPO_DIR=$(CDPATH= cd -- "$SETUP_DIR/.." && pwd)
SP=$(mktemp -d "${TMPDIR:-/tmp}/a101-setuptest.XXXXXX")
trap 'rm -rf "$SP"' EXIT
FAKE="$SP/fakehome"
LOG="$SP/run.log"
PASS=0; FAILED=0
with_npm=""
[ "${1:-}" = "--with-npm" ] && with_npm=1

ok() { PASS=$((PASS+1)); printf '  PASS  %s\n' "$1"; }
no() { FAILED=$((FAILED+1)); printf '  FAIL  %s\n' "$1"; }
exists() { [ -e "$2" ] && ok "$1" || no "$1 (missing $2)"; }
absent() { [ ! -e "$2" ] && ok "$1" || no "$1 (still present: $2)"; }
has()  { grep -qF -- "$2" "$3" 2>/dev/null && ok "$1" || no "$1 (missing '$2' in $3)"; }
hasnt(){ grep -qF -- "$2" "$3" 2>/dev/null && no "$1 (unexpected '$2')" || ok "$1"; }

export NO_COLOR=1
export A101_ASSUME_DEFAULTS=1     # never wait on /dev/tty
ROOT="$FAKE/.agentic-101"
KEY=sk-or-v1-testkeytestkeytestkey

# shellcheck source=../pins.env
. "$SETUP_DIR/pins.env"

fresh_home() { rm -rf "$FAKE"; mkdir -p "$FAKE"; }

# The environment installer, so the fake HOME has course-check, commit and
# revert exactly as a participant's machine would after Step 1.
install_env() {
    ( export HOME="$FAKE"; cd "$SP" && bash "$REPO_DIR/env/install.sh" \
        --skip-packages --prefix "$ROOT" ) >"$SP/env.log" 2>&1
}

run_setup() {
    ( export HOME="$FAKE"; cd "$SP" && bash "$SETUP_DIR/install-pi.sh" \
        --prefix "$ROOT" "$@" ) >"$LOG" 2>&1
}

run_smoke() {
    ( export HOME="$FAKE"; export PATH="$1:$ROOT/bin:$PATH"; shift
      cd "$SP" && bash "$SETUP_DIR/bin/course-smoke-test" "$@" ) >"$SP/smoke.log" 2>&1
}

# A stub pi. $1 is the directory to create it in, $2 the behaviour:
#   good  — answers PONG and creates the file it is asked for
#   auth  — fails the way a rejected key fails
#   lazy  — answers, but never creates the file
make_stub_pi() {
    mkdir -p "$1"
    cat > "$1/pi" <<STUB
#!/usr/bin/env bash
for a in "\$@"; do [ "\$a" = "--version" ] && { echo $PI_VERSION; exit 0; }; done
mode=$2
prompt="\${@: -1}"
if [ "\$mode" = auth ]; then
    echo "Error: 401 Unauthorized (no auth credentials found)" >&2
    exit 1
fi
case "\$prompt" in
    *PONG*) echo PONG ;;
    *ready.txt*)
        [ "\$mode" = lazy ] || printf READY > ready.txt
        echo "All done." ;;
    *) echo "unexpected prompt: \$prompt" >&2; exit 3 ;;
esac
STUB
    chmod +x "$1/pi"
}

echo "== dry run changes nothing =="
fresh_home
run_setup --dry-run --skip-packages --key "$KEY"
has "dry run announces itself" "DRY RUN" "$LOG"
absent "dry run wrote no settings" "$FAKE/.pi/agent/settings.json"
absent "dry run wrote no auth file" "$FAKE/.pi/agent/auth.json"
absent "dry run made no practice folder" "$FAKE/$PRACTICE_DIR"

echo "== a bad key is refused before anything is installed =="
fresh_home
run_setup --skip-packages --key "PASTE-YOUR-KEY-HERE"
has "placeholder key rejected" "looks like the placeholder" "$LOG"
absent "placeholder key wrote nothing" "$FAKE/.pi/agent/auth.json"

fresh_home
run_setup --skip-packages --key "hunter2"
has "malformed key rejected" "does not look like an OpenRouter key" "$LOG"
absent "malformed key wrote nothing" "$FAKE/.pi/agent/auth.json"

fresh_home
run_setup --skip-packages
has "missing key refused" "no key given" "$LOG"
absent "missing key wrote nothing" "$FAKE/.pi/agent/auth.json"

echo "== first install =="
fresh_home
install_env
run_setup --skip-packages --no-smoke-test --key "$KEY"
[ $? -eq 0 ] && ok "installer exited 0" || { no "installer exited non-zero"; sed 's/^/        /' "$LOG"; }
exists "settings written" "$FAKE/.pi/agent/settings.json"
exists "auth written" "$FAKE/.pi/agent/auth.json"
exists "practice folder created" "$FAKE/$PRACTICE_DIR"
exists "practice folder explains itself" "$FAKE/$PRACTICE_DIR/README.txt"
exists "smoke test installed beside the other commands" "$ROOT/bin/course-smoke-test"
exists "pins copied to the install root" "$ROOT/pins.env"
[ -x "$ROOT/bin/course-smoke-test" ] && ok "smoke test is executable" || no "smoke test not executable"
has "settings pin the provider" "\"defaultProvider\": \"$PI_PROVIDER\"" "$FAKE/.pi/agent/settings.json"
has "settings pin the model" "\"defaultModel\": \"$PI_MODEL\"" "$FAKE/.pi/agent/settings.json"
has "settings pin the thinking level" "\"defaultThinkingLevel\": \"$PI_THINKING_LEVEL\"" "$FAKE/.pi/agent/settings.json"
has "auth holds the key" "$KEY" "$FAKE/.pi/agent/auth.json"
has "auth names the provider" "\"$PI_PROVIDER\"" "$FAKE/.pi/agent/auth.json"
hasnt "the key is never echoed in full" "$KEY" "$LOG"
perms=$(ls -l "$FAKE/.pi/agent/auth.json" | cut -c1-10)
[ "$perms" = "-rw-------" ] && ok "auth file is 0600" || no "auth file is $perms, expected -rw-------"
has "the practice folder is not the home folder" "cd ~/$PRACTICE_DIR" "$FAKE/$PRACTICE_DIR/README.txt"

echo "== a key copied out of an email, with stray whitespace =="
fresh_home
install_env
run_setup --skip-packages --no-smoke-test --key "  $KEY
"
has "the key is stored without the stray whitespace" "\"key\": \"$KEY\"" "$FAKE/.pi/agent/auth.json"

fresh_home
install_env
run_setup --skip-packages --no-smoke-test --key "$(printf '%s\r' "$KEY")"
has "a Windows carriage return is stripped too" "\"key\": \"$KEY\"" "$FAKE/.pi/agent/auth.json"

echo "== an existing pi setup survives =="
fresh_home
install_env
mkdir -p "$FAKE/.pi/agent"
printf '{\n  "theme": "light",\n  "defaultModel": "somebody-elses-model"\n}\n' > "$FAKE/.pi/agent/settings.json"
printf '{\n  "anthropic": { "type": "api_key", "key": "sk-ant-keepme" }\n}\n' > "$FAKE/.pi/agent/auth.json"
run_setup --skip-packages --no-smoke-test --key "$KEY"
has "unrelated settings preserved" "\"theme\": \"light\"" "$FAKE/.pi/agent/settings.json"
has "the course model overrides theirs" "$PI_MODEL" "$FAKE/.pi/agent/settings.json"
hasnt "their old model is gone" "somebody-elses-model" "$FAKE/.pi/agent/settings.json"
has "their other credentials survive" "sk-ant-keepme" "$FAKE/.pi/agent/auth.json"
has "the course key is added alongside" "$KEY" "$FAKE/.pi/agent/auth.json"
ls "$FAKE/.pi/agent/" | grep -q 'settings.json.agentic-101-backup-' &&
    ok "settings backed up before editing" || no "no settings backup"
ls "$FAKE/.pi/agent/" | grep -q 'auth.json.agentic-101-backup-' &&
    ok "auth backed up before editing" || no "no auth backup"

echo "== damaged settings do not stop the install =="
fresh_home
install_env
mkdir -p "$FAKE/.pi/agent"
printf 'this is not json at all\n' > "$FAKE/.pi/agent/settings.json"
run_setup --skip-packages --no-smoke-test --key "$KEY"
has "damaged settings replaced with the course ones" "$PI_MODEL" "$FAKE/.pi/agent/settings.json"
ls "$FAKE/.pi/agent/" | grep -q 'settings.json.agentic-101-backup-' &&
    ok "damaged settings kept as a backup" || no "damaged settings lost without a backup"

echo "== re-running is safe =="
fresh_home
install_env
run_setup --skip-packages --no-smoke-test --key "$KEY"
cp "$FAKE/.pi/agent/settings.json" "$SP/settings-before.json"
cp "$FAKE/.pi/agent/auth.json" "$SP/auth-before.json"
run_setup --skip-packages --no-smoke-test --key "$KEY"
diff -q "$SP/settings-before.json" "$FAKE/.pi/agent/settings.json" >/dev/null &&
    ok "settings unchanged on re-run" || no "settings changed on re-run"
diff -q "$SP/auth-before.json" "$FAKE/.pi/agent/auth.json" >/dev/null &&
    ok "auth unchanged on re-run" || no "auth changed on re-run"

echo "== the smoke test, without touching a model =="
run_smoke "$SP/nostub" --no-model
[ $? -eq 0 ] && ok "passes on a correctly set up machine" || { no "failed on a good machine"; sed 's/^/        /' "$SP/smoke.log"; }
has "reports the environment healthy" "the course environment is healthy" "$SP/smoke.log"
has "reports the course model" "pi is set to the course model" "$SP/smoke.log"
has "reports the key saved" "your key is saved" "$SP/smoke.log"
has "says it skipped the model checks" "skipped the two checks" "$SP/smoke.log"
has "ends in PASS" "PASS" "$SP/smoke.log"

echo "== the smoke test notices each thing being wrong =="
mv "$FAKE/.pi/agent/auth.json" "$SP/auth-stashed.json"
run_smoke "$SP/nostub" --no-model
[ $? -ne 0 ] && ok "fails when the key is missing" || no "passed with no key file"
has "says the key is not saved" "your key is not saved" "$SP/smoke.log"
mv "$SP/auth-stashed.json" "$FAKE/.pi/agent/auth.json"

printf '{ "defaultProvider": "anthropic", "defaultModel": "wrong", "defaultThinkingLevel": "off" }\n' \
    > "$FAKE/.pi/agent/settings.json"
run_smoke "$SP/nostub" --no-model
[ $? -ne 0 ] && ok "fails when the model is not the course one" || no "passed with the wrong model"
has "names what is wrong" "not set to the course model" "$SP/smoke.log"
run_setup --skip-packages --no-smoke-test --key "$KEY"   # put it back

echo "== the smoke test's model checks, against a stub pi =="
make_stub_pi "$SP/stub-good" good
run_smoke "$SP/stub-good"
[ $? -eq 0 ] && ok "passes when the model answers and the task lands" || { no "failed against a good stub"; sed 's/^/        /' "$SP/smoke.log"; }
has "reports the key working" "your key works" "$SP/smoke.log"
has "reports the agent task" "created a file when asked" "$SP/smoke.log"
absent "the scratch folder is cleaned up" "$FAKE/$PRACTICE_DIR/.smoke-test"

make_stub_pi "$SP/stub-auth" auth
run_smoke "$SP/stub-auth"
[ $? -ne 0 ] && ok "fails when the key is rejected" || no "passed against a rejected key"
has "names the likely causes" "no internet, or a key" "$SP/smoke.log"
has "does not spend a second call after a failed one" "skipped the agent task" "$SP/smoke.log"

make_stub_pi "$SP/stub-lazy" lazy
run_smoke "$SP/stub-lazy"
[ $? -ne 0 ] && ok "fails when the agent does not do the task" || no "passed when no file was created"
has "checks the disk, not the agent's prose" "did not create the file" "$SP/smoke.log"

echo "== the smoke test notices a version that is not the pin =="
mkdir -p "$SP/stub-oldpi"
printf '#!/usr/bin/env bash\necho 0.0.1\n' > "$SP/stub-oldpi/pi"
chmod +x "$SP/stub-oldpi/pi"
run_smoke "$SP/stub-oldpi" --no-model
[ $? -ne 0 ] && ok "fails on a pi that is not the pinned version" || no "passed on the wrong pi version"
has "names both versions" "but this course uses $PI_VERSION" "$SP/smoke.log"

if [ -n "$with_npm" ]; then
    echo "== a real npm install of the pinned pi (--with-npm) =="
    fresh_home
    install_env
    NPM_PREFIX="$SP/npm-prefix"
    mkdir -p "$NPM_PREFIX"
    ( export HOME="$FAKE"; export npm_config_prefix="$NPM_PREFIX"
      export PATH="$NPM_PREFIX/bin:$PATH"
      cd "$SP" && bash "$SETUP_DIR/install-pi.sh" --prefix "$ROOT" \
          --no-smoke-test --key "$KEY" ) >"$SP/npm.log" 2>&1
    has "npm install reported success" "pi installed" "$SP/npm.log"
    exists "pi binary landed in the temporary prefix" "$NPM_PREFIX/bin/pi"
    installed=$("$NPM_PREFIX/bin/pi" --version 2>/dev/null | head -1)
    [ "$installed" = "$PI_VERSION" ] && ok "installed pi is exactly $PI_VERSION" ||
        no "installed pi is '$installed', expected $PI_VERSION"
    has "the pin was verified after installing" "matches the pin" "$SP/npm.log"
else
    echo "== skipping the real npm install (pass --with-npm to include it) =="
fi

echo
if [ "$FAILED" -eq 0 ]; then
    printf 'PASS  %s/%s\n' "$PASS" "$((PASS + FAILED))"
    exit 0
fi
printf 'FAIL  %s of %s checks failed\n' "$FAILED" "$((PASS + FAILED))"
exit 1
