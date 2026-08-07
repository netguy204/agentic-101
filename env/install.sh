#!/usr/bin/env bash
# install.sh — install the agentic-101 course environment.
# Chunk: docs/chunks/onboarding_terminal_env - Cross-platform installer core
#
# Runs start to finish with no questions asked (chunk GOAL.md: the setup guide
# pastes this as one step, so it must not require judgment from a participant).
#
#   macOS:    curl -fsSL <base-url>/install.sh | bash
#             ./env/install.sh                    # from a checkout
#   Windows:  invoked by install.ps1 inside Git Bash, after PowerShell has
#             installed the applications and patched Windows Terminal.
#
# Everything it changes outside its own install root is either a marked block
# it rewrites in place or a file it backs up first. Re-running is safe and
# produces the same result. env/uninstall.sh undoes it.

set -u

A101_INSTALL_ROOT_DEFAULT="$HOME/.agentic-101"
A101_BASE_URL_DEFAULT="https://raw.githubusercontent.com/netguy204/agentic-101/main/env"
A101_BASE_URL="${AGENTIC101_ENV_BASE_URL:-$A101_BASE_URL_DEFAULT}"

# Files copied to the participant's machine. Paths are relative to env/.
A101_PAYLOAD="lib/common.sh lib/shellrc.sh bin/commit bin/revert bin/course-check versions.env"

dry_run=""
skip_packages=""
strict_versions=""
install_root="$A101_INSTALL_ROOT_DEFAULT"

usage() {
    cat <<'EOF'
install.sh — install the agentic-101 course environment.

  --dry-run           say what would happen, change nothing
  --skip-packages     configure only; do not install any applications
  --strict-versions   fail if an installed version does not match versions.env
  --prefix DIR        install root (default: ~/.agentic-101)
  -h, --help          show this

On Windows this script is run for you by install.ps1 inside Git Bash.
EOF
}

while [ $# -gt 0 ]; do
    case "$1" in
        --dry-run) dry_run=1; shift ;;
        --skip-packages) skip_packages=1; shift ;;
        --strict-versions) strict_versions=1; shift ;;
        --prefix) shift; install_root="${1:?--prefix needs a directory}"; shift ;;
        -h|--help) usage; exit 0 ;;
        *) printf 'install.sh: unknown option %s\n' "$1" >&2; usage >&2; exit 2 ;;
    esac
done

# --- which machine are we on? ---------------------------------------------

case "$(uname -s 2>/dev/null || echo unknown)" in
    Darwin) A101_PLATFORM=macos ;;
    MINGW*|MSYS*|CYGWIN*) A101_PLATFORM=windows ;;
    *) printf 'install.sh: the course environment supports macOS and Windows (Git Bash) only.\n' >&2; exit 1 ;;
esac

# --- locate our own source: a local checkout, or the network --------------

a101_self_dir() {
    # $0 is "bash" or "-" when piped from curl; fall back to the network then.
    case "${BASH_SOURCE[0]:-}" in
        ""|bash|-|/dev/fd/*|/proc/self/fd/*) return 1 ;;
    esac
    d=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]}")" 2>/dev/null && pwd) || return 1
    [ -f "$d/lib/common.sh" ] || return 1
    printf '%s' "$d"
}

A101_SRC=$(a101_self_dir || true)
A101_TMP=""
cleanup() { [ -n "$A101_TMP" ] && rm -rf "$A101_TMP"; }
trap cleanup EXIT INT TERM

if [ -z "$A101_SRC" ]; then
    # Piped from curl: fetch the payload into a scratch directory first, so a
    # half-downloaded install never lands on the participant's machine.
    command -v curl >/dev/null 2>&1 || { printf 'install.sh: curl is required.\n' >&2; exit 1; }
    A101_TMP=$(mktemp -d "${TMPDIR:-/tmp}/agentic-101.XXXXXX") || exit 1
    A101_SRC="$A101_TMP"
    for rel in $A101_PAYLOAD; do
        mkdir -p "$A101_SRC/$(dirname "$rel")"
        if ! curl -fsSL "$A101_BASE_URL/$rel" -o "$A101_SRC/$rel"; then
            printf 'install.sh: could not download %s from %s\n' "$rel" "$A101_BASE_URL" >&2
            printf 'install.sh: see env/DISTRIBUTION.md — AGENTIC101_ENV_BASE_URL may need to be set.\n' >&2
            exit 1
        fi
    done
fi

# shellcheck source=lib/common.sh
. "$A101_SRC/lib/common.sh"

step() { blank; bold "$*"; }
would() { dim "  would: $*"; }

# --- preflight ------------------------------------------------------------

[ "$(id -u 2>/dev/null || echo 1)" != "0" ] || fail "install.sh: do not run this with sudo. It installs into your own home folder."

if [ -f "$A101_SRC/versions.env" ]; then
    # shellcheck source=versions.env
    . "$A101_SRC/versions.env"
else
    fail "install.sh: versions.env is missing from $A101_SRC."
fi
: "${ENV_VERSION:=unknown}"

blank
bold "Installing the agentic-101 course environment (version $ENV_VERSION)"
dim  "This sets up your terminal, pi's keyboard shortcuts, and the commit and revert commands."
[ -n "$dry_run" ] && dim "DRY RUN — nothing will actually change."

# --- step 1: applications -------------------------------------------------

brew_bin() {
    if command -v brew >/dev/null 2>&1; then command -v brew; return 0; fi
    for p in /opt/homebrew/bin/brew /usr/local/bin/brew; do
        [ -x "$p" ] && { printf '%s' "$p"; return 0; }
    done
    return 1
}

check_version() {
    # check_version <label> <pinned> <actual>
    [ -z "$2" ] && return 0
    case "$3" in
        *"$2"*) dim "  $1 matches the pinned version ($2)"; return 0 ;;
    esac
    if [ -n "$strict_versions" ]; then
        fail "install.sh: $1 is $3 but versions.env pins $2."
    fi
    warn "  $1 is $3, but versions.env pins $2. Homebrew cannot install an"
    warn "  arbitrary older version; re-pin versions.env or accept this version."
}

if [ -n "$skip_packages" ]; then
    step "Step 1 of 4 — applications: skipped (--skip-packages)"
elif [ "$A101_PLATFORM" = "windows" ]; then
    step "Step 1 of 4 — applications: installed by install.ps1"
    dim "  On Windows, PowerShell installs Git, Node and Windows Terminal with winget."
else
    step "Step 1 of 4 — installing the applications"
    if [ -n "$dry_run" ]; then
        would "install Homebrew if missing, then: ghostty (cask), node, git"
    else
        BREW=$(brew_bin || true)
        if [ -z "$BREW" ]; then
            say "  Homebrew is not installed yet. Installing it — macOS will ask for"
            say "  your password, the same one you use to log in to this computer."
            NONINTERACTIVE=1 /bin/bash -c \
                "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
                || fail "install.sh: Homebrew did not install. Nothing else was changed."
            BREW=$(brew_bin) || fail "install.sh: Homebrew installed but cannot be found."
        fi
        eval "$("$BREW" shellenv)"

        if [ -d "/Applications/Ghostty.app" ]; then
            dim "  Ghostty is already installed."
        else
            say "  Installing Ghostty (the course terminal)…"
            "$BREW" install --cask ghostty || fail "install.sh: could not install Ghostty."
        fi
        say "  Installing node and git…"
        "$BREW" install node git >/dev/null 2>&1 || warn "  node/git install reported a problem; continuing."

        ghostty_v=$(/Applications/Ghostty.app/Contents/MacOS/ghostty --version 2>/dev/null | head -1 || true)
        check_version "Ghostty" "${GHOSTTY_VERSION:-}" "${ghostty_v:-unknown}"
        check_version "node" "${NODE_VERSION:-}" "$(node --version 2>/dev/null || echo unknown)"
        check_version "git" "${GIT_VERSION:-}" "$(git --version 2>/dev/null || echo unknown)"
    fi
fi

# --- step 2: the course commands ------------------------------------------

step "Step 2 of 4 — installing the commit and revert commands"
if [ -n "$dry_run" ]; then
    would "copy $A101_PAYLOAD into $install_root"
else
    mkdir -p "$install_root/bin" "$install_root/lib" || fail "install.sh: could not create $install_root."
    for rel in $A101_PAYLOAD; do
        cp "$A101_SRC/$rel" "$install_root/$rel" || fail "install.sh: could not copy $rel."
    done
    chmod +x "$install_root"/bin/* || fail "install.sh: could not make the commands runnable."
    printf '%s\n' "$ENV_VERSION" > "$install_root/VERSION"
    {
        printf '# Recorded by install.sh on %s\n' "$(date '+%Y-%m-%d %H:%M:%S')"
        printf '# Copy these into env/versions.env to pin a cohort (see that file).\n'
        printf 'ENV_VERSION=%s\n' "$ENV_VERSION"
        printf 'NODE_VERSION=%s\n' "$(node --version 2>/dev/null)"
        printf 'GIT_VERSION=%s\n' "$(git --version 2>/dev/null | awk '{print $3}')"
        if [ "$A101_PLATFORM" = "macos" ]; then
            printf 'GHOSTTY_VERSION=%s\n' \
                "$(/Applications/Ghostty.app/Contents/MacOS/ghostty --version 2>/dev/null | head -1 | awk '{print $NF}')"
        fi
    } > "$install_root/installed-versions.txt"
    good "  Installed into $install_root"
fi

# --- step 3: shell startup ------------------------------------------------

step "Step 3 of 4 — teaching your shell about the new commands"
shellrc_block=$(cat <<EOF
# Managed by the agentic-101 course environment. Edit env/lib/shellrc.sh in
# the course repository instead of this block — reinstalling overwrites it.
if [ -f "$install_root/shellrc" ]; then
    . "$install_root/shellrc"
fi
EOF
)

if [ -n "$dry_run" ]; then
    would "write $install_root/shellrc"
    would "add the managed block to $HOME/.bash_profile"
    [ "$A101_PLATFORM" = "macos" ] && would "add the managed block to $HOME/.zshrc"
else
    cp "$A101_SRC/lib/shellrc.sh" "$install_root/shellrc" || fail "install.sh: could not write the shell fragment."

    # Git Bash on Windows and bash-inside-Ghostty on macOS both read
    # .bash_profile for a login shell. If a .bashrc exists and .bash_profile
    # does not, keep the .bashrc sourced so we do not shadow a setup the
    # participant already has.
    if [ ! -f "$HOME/.bash_profile" ] && [ -f "$HOME/.bashrc" ]; then
        printf '%s\n' '[ -f ~/.bashrc ] && . ~/.bashrc' > "$HOME/.bash_profile"
    fi
    printf '%s\n' "$shellrc_block" | write_managed_block "$HOME/.bash_profile" "shell" \
        || fail "install.sh: could not update ~/.bash_profile."

    # On macOS a participant who opens stock Terminal.app instead of Ghostty
    # still gets the commands; the prompt line in shellrc is bash-only by design.
    if [ "$A101_PLATFORM" = "macos" ]; then
        printf '%s\n' "$shellrc_block" | write_managed_block "$HOME/.zshrc" "shell" \
            || warn "  could not update ~/.zshrc; the commands will still work in Ghostty."
    fi
    good "  Shell startup configured"
fi

# --- step 4: the terminal -------------------------------------------------

step "Step 4 of 4 — configuring the terminal for pi"

if [ "$A101_PLATFORM" = "windows" ]; then
    dim "  On Windows, install.ps1 patches Windows Terminal (pi's Shift+Enter and"
    dim "  Alt+Enter bindings, and Git Bash as the default profile)."
else
    ghostty_config="$HOME/Library/Application Support/com.mitchellh.ghostty/config"
    ghostty_block=$(cat <<'EOF'
# The course runs bash on macOS and Windows alike (DEC-007) so that every
# instruction in the material is the same on both. This changes Ghostty only —
# your normal login shell is untouched.
command = /bin/bash -l

# pi's documented Ghostty keybinding (pi docs/terminal-setup.md).
keybind = alt+backspace=text:\x1b\x7f

# Make the Option key act as Alt, so Option+Enter reaches pi as Alt+Enter —
# that is how pi queues a follow-up message. Trade-off: Option+letter no longer
# types accented characters inside Ghostty. Delete this line to get them back
# (see env/README.md).
macos-option-as-alt = true
EOF
)
    if [ -n "$dry_run" ]; then
        would "add the managed block to $ghostty_config"
    else
        mkdir -p "$(dirname "$ghostty_config")"
        # Older Claude Code versions added a shift+enter mapping that stops pi
        # seeing the real key; pi's docs say to remove it.
        if [ -f "$ghostty_config" ] && grep -q 'shift+enter=text:' "$ghostty_config"; then
            backup_file "$ghostty_config"
            grep -v 'shift+enter=text:' "$ghostty_config" > "$ghostty_config.tmp.$$" &&
                mv "$ghostty_config.tmp.$$" "$ghostty_config"
            dim "  removed an old shift+enter mapping that stops pi seeing the key"
        fi
        printf '%s\n' "$ghostty_block" | write_managed_block "$ghostty_config" "ghostty" \
            || fail "install.sh: could not update Ghostty's configuration."
        good "  Ghostty configured"
    fi
fi

# --- verify ---------------------------------------------------------------

blank
if [ -n "$dry_run" ]; then
    bold "Dry run finished. Nothing was changed."
    exit 0
fi

if [ -x "$install_root/bin/course-check" ]; then
    PATH="$install_root/bin:$PATH" "$install_root/bin/course-check" || true
fi

blank
bold "You're set up. One last thing:"
if [ "$A101_PLATFORM" = "macos" ]; then
    say "  Open ${A101_BOLD}Ghostty${A101_RESET} (press Command+Space, type Ghostty, press Enter)."
else
    say "  Close every Windows Terminal window and open ${A101_BOLD}Windows Terminal${A101_RESET} again."
fi
say "  Everything you do in the course happens in that window."
blank
