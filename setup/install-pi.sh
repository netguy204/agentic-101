#!/usr/bin/env bash
# install-pi.sh — install pi at the pinned version and configure it for the course.
# Chunk: docs/chunks/onboarding_setup_guide - Scripted pi install and configuration
#
# Runs after the managed terminal environment (env/install.sh or install.ps1).
# One script for both platforms: DEC-008 puts bash on macOS (inside Ghostty)
# and Windows (Git Bash), so only the environment step differs per platform.
#
#   curl -fsSL <base-url>/install-pi.sh | bash -s -- --key sk-or-v1-...
#   bash setup/install-pi.sh --key sk-or-v1-...      # from a checkout
#
# Asks the participant nothing when --key is supplied — the setup guide has
# them paste one line their facilitator emailed them (chunk GOAL.md: no step
# may require understanding what the command does).
#
# Written for bash 3.2 (macOS system bash) so the same file runs unmodified
# under Git Bash's bash 5 on Windows.

set -u

A101_INSTALL_ROOT_DEFAULT="$HOME/.agentic-101"
A101_BASE_URL_DEFAULT="https://raw.githubusercontent.com/REPLACE-ME/agentic-101/main/setup"
A101_BASE_URL="${AGENTIC101_SETUP_BASE_URL:-$A101_BASE_URL_DEFAULT}"

# Files this script needs beside itself. Paths are relative to setup/.
A101_PAYLOAD="pins.env bin/course-smoke-test"

dry_run=""
skip_packages=""
no_smoke_test=""
install_root="$A101_INSTALL_ROOT_DEFAULT"
api_key=""

usage() {
    cat <<'EOF'
install-pi.sh — install pi and set it up for the agentic-101 course.

  --key KEY           the OpenRouter key your facilitator gave you
  --dry-run           say what would happen, change nothing
  --skip-packages     configure only; do not install pi from npm
  --no-smoke-test     do not run course-smoke-test at the end
  --prefix DIR        course install root (default: ~/.agentic-101)
  -h, --help          show this

Run this after the course environment installer. Without --key the script
asks for the key; with it, nothing is asked at all.
EOF
}

while [ $# -gt 0 ]; do
    case "$1" in
        --key) shift; api_key="${1:?--key needs a value}"; shift ;;
        --key=*) api_key="${1#--key=}"; shift ;;
        --dry-run) dry_run=1; shift ;;
        --skip-packages) skip_packages=1; shift ;;
        --no-smoke-test) no_smoke_test=1; shift ;;
        --prefix) shift; install_root="${1:?--prefix needs a directory}"; shift ;;
        -h|--help) usage; exit 0 ;;
        *) printf 'install-pi.sh: unknown option %s\n' "$1" >&2; usage >&2; exit 2 ;;
    esac
done

# --- output helpers -------------------------------------------------------
#
# The managed environment ships these in lib/common.sh. Use them when they
# are there, so the two installers sound like one voice; fall back to a
# minimal copy when they are not, because this script has to be able to
# explain that the environment is missing.

if [ -f "$install_root/lib/common.sh" ]; then
    # shellcheck source=../env/lib/common.sh
    . "$install_root/lib/common.sh"
else
    if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
        A101_BOLD=$(printf '\033[1m'); A101_DIM=$(printf '\033[2m')
        A101_GREEN=$(printf '\033[32m'); A101_YELLOW=$(printf '\033[33m')
        A101_RED=$(printf '\033[31m'); A101_RESET=$(printf '\033[0m')
    else
        A101_BOLD=""; A101_DIM=""; A101_GREEN=""; A101_YELLOW=""
        A101_RED=""; A101_RESET=""
    fi
    say()  { printf '%s\n' "$*"; }
    bold() { printf '%s%s%s\n' "$A101_BOLD" "$*" "$A101_RESET"; }
    dim()  { printf '%s%s%s\n' "$A101_DIM" "$*" "$A101_RESET"; }
    good() { printf '%s%s%s\n' "$A101_GREEN" "$*" "$A101_RESET"; }
    warn() { printf '%s%s%s\n' "$A101_YELLOW" "$*" "$A101_RESET" >&2; }
    fail() { printf '%s%s%s\n' "$A101_RED" "$*" "$A101_RESET" >&2; exit 1; }
    blank() { printf '\n'; }
    a101_run_stamp() {
        if [ -z "${A101_RUN_STAMP:-}" ]; then
            A101_RUN_STAMP=$(date +%Y%m%d-%H%M%S); export A101_RUN_STAMP
        fi
        printf '%s' "$A101_RUN_STAMP"
    }
    backup_file() {
        a101_target="$1"
        [ -f "$a101_target" ] || return 0
        a101_backup="${a101_target}.agentic-101-backup-$(a101_run_stamp)"
        [ -f "$a101_backup" ] && return 0
        cp "$a101_target" "$a101_backup" || return 1
        dim "  backed up $(basename "$a101_target") -> $(basename "$a101_backup")"
    }
fi

step()  { blank; bold "$*"; }
would() { dim "  would: $*"; }

# --- locate our own source: a local checkout, or the network --------------

a101_self_dir() {
    case "${BASH_SOURCE[0]:-}" in
        ""|bash|-|/dev/fd/*|/proc/self/fd/*) return 1 ;;
    esac
    d=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" 2>/dev/null && pwd) || return 1
    [ -f "$d/pins.env" ] || return 1
    printf '%s' "$d"
}

A101_SRC=$(a101_self_dir || true)
A101_TMP=""
cleanup() { [ -n "$A101_TMP" ] && rm -rf "$A101_TMP"; }
trap cleanup EXIT INT TERM

if [ -z "$A101_SRC" ]; then
    # Piped from curl: fetch what we need into a scratch directory first.
    command -v curl >/dev/null 2>&1 || fail "install-pi.sh: curl is required."
    A101_TMP=$(mktemp -d "${TMPDIR:-/tmp}/agentic-101-setup.XXXXXX") || exit 1
    A101_SRC="$A101_TMP"
    for rel in $A101_PAYLOAD; do
        mkdir -p "$A101_SRC/$(dirname "$rel")"
        if ! curl -fsSL "$A101_BASE_URL/$rel" -o "$A101_SRC/$rel"; then
            printf 'install-pi.sh: could not download %s from %s\n' "$rel" "$A101_BASE_URL" >&2
            printf 'install-pi.sh: see env/DISTRIBUTION.md — the course files may not be published yet.\n' >&2
            exit 1
        fi
    done
fi

# shellcheck source=pins.env
. "$A101_SRC/pins.env" || fail "install-pi.sh: could not read pins.env."
: "${PI_VERSION:?pins.env is missing PI_VERSION}"
: "${PI_PROVIDER:?pins.env is missing PI_PROVIDER}"
: "${PI_MODEL:?pins.env is missing PI_MODEL}"
: "${PI_THINKING_LEVEL:=medium}"
: "${PRACTICE_DIR:=course-practice}"

pi_config_dir="${PI_CODING_AGENT_DIR:-$HOME/.pi/agent}"
practice_path="$HOME/$PRACTICE_DIR"

blank
bold "Setting up pi for the agentic-101 course"
dim  "This installs pi $PI_VERSION, saves the key your facilitator gave you, and"
dim  "sets the model everyone on the course uses."
[ -n "$dry_run" ] && dim "DRY RUN — nothing will actually change."

# --- step 1: is this machine ready? ---------------------------------------

step "Step 1 of 5 — checking your machine"

[ "$(id -u 2>/dev/null || echo 1)" != "0" ] ||
    fail "install-pi.sh: do not run this with sudo. It installs into your own home folder."

case "$(uname -s 2>/dev/null || echo unknown)" in
    Darwin|MINGW*|MSYS*|CYGWIN*) ;;
    *) fail "install-pi.sh: the course supports macOS and Windows (Git Bash) only." ;;
esac

if [ -f "$install_root/VERSION" ]; then
    found_env=$(cat "$install_root/VERSION")
    if [ -n "${EXPECTED_ENV_VERSION:-}" ] && [ "$found_env" != "$EXPECTED_ENV_VERSION" ]; then
        warn "  The course environment is version $found_env; this setup expects"
        warn "  $EXPECTED_ENV_VERSION. Continuing, but tell your facilitator."
    else
        dim "  course environment $found_env — found"
    fi
else
    warn "  The course environment is not installed in $install_root."
    warn "  Install it first (Step 1 of the setup guide), then run this again."
    warn "  Continuing anyway — pi will work, but commit and revert will not."
fi

command -v node >/dev/null 2>&1 ||
    fail "install-pi.sh: node is not installed. Run the course environment installer first."
command -v npm >/dev/null 2>&1 ||
    fail "install-pi.sh: npm is not installed. Run the course environment installer first."
dim "  node $(node --version 2>/dev/null) — found"

# --- the key --------------------------------------------------------------
#
# Wanted before anything is installed: finding out the key is missing after a
# two-minute npm install is a worse experience than finding out now.

if [ -z "$api_key" ]; then
    api_key="${OPENROUTER_API_KEY:-}"
fi

if [ -z "$api_key" ] && [ -z "$dry_run" ]; then
    if [ -r /dev/tty ]; then
        # stdin is the script itself under `curl | bash`, so read the tty.
        printf '%sPaste the key your facilitator emailed you, then press Enter:%s\n' \
            "$A101_BOLD" "$A101_RESET" >&2
        printf '> ' >&2
        IFS= read -r api_key < /dev/tty || api_key=""
        printf '\n' >&2
    fi
fi

if [ -z "$dry_run" ]; then
    case "$api_key" in
        "")
            fail "install-pi.sh: no key given. Run this again with --key followed by
the key your facilitator emailed you." ;;
        *PASTE*|*paste*|*YOUR-KEY*|*your-key*|*REPLACE*|sk-or-v1-xxx*)
            fail "install-pi.sh: that looks like the placeholder, not a real key.
Copy the whole line your facilitator emailed you, including the key." ;;
        sk-or-*) ;;
        *)
            fail "install-pi.sh: that does not look like an OpenRouter key — they
start with sk-or-. Check what your facilitator emailed you." ;;
    esac
    masked="${api_key%${api_key#??????????}}"
    dim "  key ${masked}… — looks right"
fi

# --- step 2: install pi ---------------------------------------------------

step "Step 2 of 5 — installing pi $PI_VERSION"

pi_pkg="@earendil-works/pi-coding-agent@$PI_VERSION"

if [ -n "$skip_packages" ]; then
    dim "  skipped (--skip-packages)"
elif [ -n "$dry_run" ]; then
    would "npm install -g --ignore-scripts $pi_pkg"
else
    say "  This takes a minute or two. npm prints a lot; that is normal."
    npm_log=$(mktemp "${TMPDIR:-/tmp}/agentic-101-npm.XXXXXX")
    if npm install -g --ignore-scripts "$pi_pkg" >"$npm_log" 2>&1; then
        good "  pi installed"
    else
        if grep -q 'EACCES' "$npm_log"; then
            warn "  npm was not allowed to install pi for your whole account."
            warn "  Send this to your facilitator — it is a one-line fix on their end,"
            warn "  and not something you should work around with sudo."
        fi
        tail -20 "$npm_log" >&2
        rm -f "$npm_log"
        fail "install-pi.sh: pi did not install. Nothing else was changed."
    fi
    rm -f "$npm_log"
fi

if [ -z "$dry_run" ] && [ -z "$skip_packages" ]; then
    installed_pi=$(pi --version 2>/dev/null | head -1 | tr -d '\r')
    if [ "$installed_pi" = "$PI_VERSION" ]; then
        dim "  pi reports version $installed_pi — matches the pin"
    elif [ -z "$installed_pi" ]; then
        warn "  pi installed but is not on your PATH yet. Close this window, open a"
        warn "  new one, and run course-smoke-test."
    else
        warn "  pi reports $installed_pi but the course pins $PI_VERSION. Tell your facilitator."
    fi
fi

# --- step 3: the course's pi configuration --------------------------------
#
# DEC-006: a shipped configuration prescribes the model, so nobody picks one.
# Generated from pins.env, so the model pin has exactly one source. Written
# with node (a hard dependency of the course anyway) so that any settings the
# participant already had survive.

step "Step 3 of 5 — setting the model everyone on the course uses"
dim "  provider $PI_PROVIDER, model $PI_MODEL, thinking $PI_THINKING_LEVEL"

settings_file="$pi_config_dir/settings.json"

if [ -n "$dry_run" ]; then
    would "write $settings_file"
else
    mkdir -p "$pi_config_dir" || fail "install-pi.sh: could not create $pi_config_dir."
    backup_file "$settings_file"
    A101_SETTINGS_FILE="$settings_file" \
    A101_PROVIDER="$PI_PROVIDER" \
    A101_MODEL="$PI_MODEL" \
    A101_THINKING="$PI_THINKING_LEVEL" \
    node -e '
      const fs = require("fs");
      const f = process.env.A101_SETTINGS_FILE;
      let s = {};
      if (fs.existsSync(f)) {
        try { s = JSON.parse(fs.readFileSync(f, "utf8")) || {}; }
        catch (e) { s = {}; }            // unreadable settings: start clean, the backup has the original
        if (typeof s !== "object" || Array.isArray(s)) s = {};
      }
      s.defaultProvider = process.env.A101_PROVIDER;
      s.defaultModel = process.env.A101_MODEL;
      s.defaultThinkingLevel = process.env.A101_THINKING;
      fs.writeFileSync(f, JSON.stringify(s, null, 2) + "\n");
    ' || fail "install-pi.sh: could not write $settings_file."
    good "  Model configured"
fi

# --- step 4: the key ------------------------------------------------------
#
# auth.json rather than an environment variable: an exported variable lives
# only in the terminal window that set it, and a participant who closes that
# window loses their key with no visible cause. auth.json survives restarts,
# is created 0600, and is exactly what pi's own /login would have written
# (pi docs/providers.md, Auth File).

step "Step 4 of 5 — saving your key"

auth_file="$pi_config_dir/auth.json"

if [ -n "$dry_run" ]; then
    would "write $auth_file (0600)"
else
    mkdir -p "$pi_config_dir" || fail "install-pi.sh: could not create $pi_config_dir."
    backup_file "$auth_file"
    A101_AUTH_FILE="$auth_file" \
    A101_PROVIDER="$PI_PROVIDER" \
    A101_KEY="$api_key" \
    node -e '
      const fs = require("fs");
      const f = process.env.A101_AUTH_FILE;
      let a = {};
      if (fs.existsSync(f)) {
        try { a = JSON.parse(fs.readFileSync(f, "utf8")) || {}; }
        catch (e) { a = {}; }
        if (typeof a !== "object" || Array.isArray(a)) a = {};
      }
      a[process.env.A101_PROVIDER] = { type: "api_key", key: process.env.A101_KEY };
      fs.writeFileSync(f, JSON.stringify(a, null, 2) + "\n", { mode: 0o600 });
    ' || fail "install-pi.sh: could not write $auth_file."
    chmod 600 "$auth_file" 2>/dev/null || true
    good "  Key saved to $auth_file"
    dim "  Only you can read that file. You never need to type the key again."
fi

# --- step 5: somewhere to practise, and the check -------------------------

step "Step 5 of 5 — making your practice folder"

if [ -n "$dry_run" ]; then
    would "create $practice_path"
    would "install course-smoke-test into $install_root/bin"
else
    mkdir -p "$practice_path" || fail "install-pi.sh: could not create $practice_path."
    if [ ! -f "$practice_path/README.txt" ]; then
        cat > "$practice_path/README.txt" <<EOF
This is your course practice folder.

Everything you do in the agentic-101 course happens here. It is a normal
folder — you can open it in Finder or File Explorer like any other, and put
files in it the usual way.

Why one dedicated folder: pi can change and delete files, and it has no
undo button. Keeping the course inside this folder means nothing else on
your computer can be touched by mistake. The commit command saves a
checkpoint of this folder; revert puts it back.

To get here from the terminal, type:  cd ~/$PRACTICE_DIR
EOF
    fi
    good "  Created $practice_path"

    if [ -d "$install_root/bin" ] || mkdir -p "$install_root/bin" 2>/dev/null; then
        cp "$A101_SRC/bin/course-smoke-test" "$install_root/bin/course-smoke-test" &&
            chmod +x "$install_root/bin/course-smoke-test" ||
            warn "  could not install course-smoke-test into $install_root/bin"
    fi
    cp "$A101_SRC/pins.env" "$install_root/pins.env" 2>/dev/null || true
fi

# --- verify ---------------------------------------------------------------

blank
if [ -n "$dry_run" ]; then
    bold "Dry run finished. Nothing was changed."
    exit 0
fi

if [ -z "$no_smoke_test" ] && [ -x "$install_root/bin/course-smoke-test" ]; then
    PATH="$install_root/bin:$PATH" "$install_root/bin/course-smoke-test"
    smoke_status=$?
    blank
    if [ "$smoke_status" -eq 0 ]; then
        bold "That's setup finished. Nothing else to do before the first session."
    else
        bold "Setup is not finished — see the FAIL message above."
    fi
    exit "$smoke_status"
fi

bold "Done. Run course-smoke-test to check everything works."
blank
