#!/usr/bin/env bash
# uninstall.sh — remove the agentic-101 course environment's configuration.
# Chunk: docs/chunks/onboarding_terminal_env - Reversal of the installers
#
# Removes what the installers added: the managed blocks in the shell startup
# files and the Ghostty config, and the install root. It deliberately does NOT
# uninstall Ghostty, node, or git — those are the participant's applications
# now, and removing them is not ours to decide.
#
# Runs on macOS and in Git Bash on Windows (where it cannot undo the Windows
# Terminal patch; see the note it prints).

set -u

install_root="${AGENTIC101_HOME:-$HOME/.agentic-101}"
keep_root=""

usage() {
    cat <<'EOF'
uninstall.sh — remove the agentic-101 course environment.

  --keep-commands   remove the shell/terminal configuration but keep
                    ~/.agentic-101 (and so commit/revert) in place
  --prefix DIR      install root to remove (default: ~/.agentic-101)
  -h, --help        show this
EOF
}

while [ $# -gt 0 ]; do
    case "$1" in
        --keep-commands) keep_root=1; shift ;;
        --prefix) shift; install_root="${1:?--prefix needs a directory}"; shift ;;
        -h|--help) usage; exit 0 ;;
        *) printf 'uninstall.sh: unknown option %s\n' "$1" >&2; exit 2 ;;
    esac
done

self_dir=$(CDPATH= cd -- "$(dirname -- "${BASH_SOURCE[0]:-$0}")" && pwd)
if [ -f "$self_dir/lib/common.sh" ]; then
    . "$self_dir/lib/common.sh"
elif [ -f "$install_root/lib/common.sh" ]; then
    . "$install_root/lib/common.sh"
else
    printf 'uninstall.sh: cannot find lib/common.sh.\n' >&2
    exit 1
fi

blank
bold "Removing the agentic-101 course environment"

remove_managed_block "$HOME/.bash_profile" "shell" && dim "  cleaned ~/.bash_profile"
remove_managed_block "$HOME/.zshrc" "shell" && dim "  cleaned ~/.zshrc"

ghostty_config="$HOME/Library/Application Support/com.mitchellh.ghostty/config"
if [ -f "$ghostty_config" ]; then
    remove_managed_block "$ghostty_config" "ghostty" && dim "  cleaned Ghostty's config"
fi

if [ -n "$keep_root" ]; then
    dim "  keeping $install_root (--keep-commands)"
else
    if [ -d "$install_root" ]; then
        rm -rf "$install_root" && dim "  removed $install_root"
    fi
fi

case "$(uname -s 2>/dev/null || echo unknown)" in
    MINGW*|MSYS*|CYGWIN*)
        blank
        warn "Windows Terminal's settings.json was not touched. To undo that part,"
        warn "restore the newest settings.json.agentic-101-backup-* file next to it,"
        warn "or delete the entries named \"agentic-101: …\" by hand."
        ;;
esac

blank
good "Done. Ghostty, node and git were left installed."
say "Open a new terminal window for the change to take effect."
