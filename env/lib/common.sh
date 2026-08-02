# shellcheck shell=bash
# Shared helpers for the agentic-101 managed environment.
# Chunk: docs/chunks/onboarding_terminal_env - Managed participant terminal environment
#
# Sourced by env/install.sh, env/uninstall.sh, and the commands in env/bin.
# Written for bash 3.2 (macOS system bash) so the same file runs unmodified
# under Git Bash's bash 5 on Windows.

A101_MARKER_PREFIX="agentic-101"

# Colors, but only when we are talking to a terminal.
if [ -t 1 ] && [ -z "${NO_COLOR:-}" ]; then
    A101_BOLD=$(printf '\033[1m')
    A101_DIM=$(printf '\033[2m')
    A101_BLUE=$(printf '\033[34m')
    A101_GREEN=$(printf '\033[32m')
    A101_YELLOW=$(printf '\033[33m')
    A101_RED=$(printf '\033[31m')
    A101_RESET=$(printf '\033[0m')
else
    A101_BOLD=""; A101_DIM=""; A101_BLUE=""; A101_GREEN=""
    A101_YELLOW=""; A101_RED=""; A101_RESET=""
fi

say()  { printf '%s\n' "$*"; }
bold() { printf '%s%s%s\n' "$A101_BOLD" "$*" "$A101_RESET"; }
dim()  { printf '%s%s%s\n' "$A101_DIM" "$*" "$A101_RESET"; }
good() { printf '%s%s%s\n' "$A101_GREEN" "$*" "$A101_RESET"; }
warn() { printf '%s%s%s\n' "$A101_YELLOW" "$*" "$A101_RESET" >&2; }
fail() { printf '%s%s%s\n' "$A101_RED" "$*" "$A101_RESET" >&2; exit 1; }

# blank — one empty line, used to keep the walkthroughs airy.
blank() { printf '\n'; }

# ask "Question" "default"
#
# Prompts on stderr and echoes the answer on stdout, so it composes as
# answer=$(ask ...). An empty answer, a closed stdin, or a non-interactive
# stdin all resolve to the default: these commands must never hang a smoke
# test or a piped run.
ask() {
    a101_q="$1"
    a101_default="${2:-}"
    if [ -n "$a101_default" ]; then
        printf '%s%s%s %s(press Enter for: %s)%s\n' \
            "$A101_BOLD" "$a101_q" "$A101_RESET" \
            "$A101_DIM" "$a101_default" "$A101_RESET" >&2
    else
        printf '%s%s%s\n' "$A101_BOLD" "$a101_q" "$A101_RESET" >&2
    fi
    printf '%s> %s' "$A101_BLUE" "$A101_RESET" >&2
    if [ -n "${A101_ASSUME_DEFAULTS:-}" ]; then
        printf '%s\n' "$a101_default" >&2
        printf '%s\n' "$a101_default"
        return 0
    fi
    if IFS= read -r a101_reply; then
        :
    else
        # stdin ended (EOF): take the default rather than looping.
        a101_reply=""
        printf '\n' >&2
    fi
    if [ -z "$a101_reply" ]; then
        a101_reply="$a101_default"
    fi
    printf '%s\n' "$a101_reply"
}

# confirm "Question" "yes|no"
#
# Returns 0 for yes, 1 for no. The second argument is the answer Enter gives,
# and it is always the safe one at every call site.
confirm() {
    a101_q="$1"
    a101_default="${2:-no}"
    if [ "$a101_default" = "yes" ]; then
        a101_hint="Y/n"
    else
        a101_hint="y/N"
    fi
    while :; do
        printf '%s%s%s %s[%s]%s ' \
            "$A101_BOLD" "$a101_q" "$A101_RESET" \
            "$A101_DIM" "$a101_hint" "$A101_RESET" >&2
        if [ -n "${A101_ASSUME_DEFAULTS:-}" ]; then
            a101_reply=""
            printf '%s\n' "$a101_default" >&2
        elif ! IFS= read -r a101_reply; then
            a101_reply=""
            printf '\n' >&2
        fi
        [ -z "$a101_reply" ] && a101_reply="$a101_default"
        case "$a101_reply" in
            y|Y|yes|Yes|YES) return 0 ;;
            n|N|no|No|NO)    return 1 ;;
            *) printf '%sPlease answer yes or no.%s\n' "$A101_DIM" "$A101_RESET" >&2 ;;
        esac
    done
}

# a101_run_stamp — one timestamp per process, used to name backups so a single
# installer run produces at most one backup per file.
a101_run_stamp() {
    if [ -z "${A101_RUN_STAMP:-}" ]; then
        A101_RUN_STAMP=$(date +%Y%m%d-%H%M%S)
        export A101_RUN_STAMP
    fi
    printf '%s' "$A101_RUN_STAMP"
}

# backup_file <path>
#
# Copies <path> beside itself as <path>.agentic-101-backup-<stamp> before we
# touch it. Nothing is overwritten in place without one of these existing.
backup_file() {
    a101_target="$1"
    [ -f "$a101_target" ] || return 0
    a101_backup="${a101_target}.${A101_MARKER_PREFIX}-backup-$(a101_run_stamp)"
    [ -f "$a101_backup" ] && return 0
    cp "$a101_target" "$a101_backup" || return 1
    dim "  backed up $(basename "$a101_target") -> $(basename "$a101_backup")"
}

# write_managed_block <file> <block-id>   (block body on stdin)
#
# Idempotent edit of a file we do not own: any previous block with the same id
# is removed and the new one appended. Re-running an installer therefore never
# duplicates or stacks configuration.
write_managed_block() {
    a101_file="$1"
    a101_id="$2"
    a101_start="# >>> ${A101_MARKER_PREFIX} ${a101_id} >>>"
    a101_end="# <<< ${A101_MARKER_PREFIX} ${a101_id} <<<"
    a101_body=$(cat)
    a101_tmp="${a101_file}.${A101_MARKER_PREFIX}-tmp.$$"

    if [ -f "$a101_file" ]; then
        backup_file "$a101_file" || return 1
        awk -v s="$a101_start" -v e="$a101_end" '
            $0 == s { skip = 1 }
            skip == 0 { print }
            $0 == e { skip = 0 }
        ' "$a101_file" > "$a101_tmp" || return 1
        # Guarantee a newline before the block even if the file lacked one.
        if [ -s "$a101_tmp" ] && [ -n "$(tail -c 1 "$a101_tmp")" ]; then
            printf '\n' >> "$a101_tmp"
        fi
    else
        mkdir -p "$(dirname "$a101_file")" || return 1
        : > "$a101_tmp" || return 1
    fi

    {
        printf '%s\n' "$a101_start"
        printf '%s\n' "$a101_body"
        printf '%s\n' "$a101_end"
    } >> "$a101_tmp" || return 1

    mv "$a101_tmp" "$a101_file"
}

# remove_managed_block <file> <block-id>
remove_managed_block() {
    a101_file="$1"
    a101_id="$2"
    [ -f "$a101_file" ] || return 0
    a101_start="# >>> ${A101_MARKER_PREFIX} ${a101_id} >>>"
    a101_end="# <<< ${A101_MARKER_PREFIX} ${a101_id} <<<"
    grep -Fq "$a101_start" "$a101_file" || return 0
    backup_file "$a101_file" || return 1
    a101_tmp="${a101_file}.${A101_MARKER_PREFIX}-tmp.$$"
    awk -v s="$a101_start" -v e="$a101_end" '
        $0 == s { skip = 1 }
        skip == 0 { print }
        $0 == e { skip = 0 }
    ' "$a101_file" > "$a101_tmp" || return 1
    mv "$a101_tmp" "$a101_file"
}

# has_managed_block <file> <block-id>
has_managed_block() {
    [ -f "$1" ] || return 1
    grep -Fq "# >>> ${A101_MARKER_PREFIX} ${2} >>>" "$1"
}
