# shellcheck shell=bash
# agentic-101 course environment — shell startup fragment.
# Chunk: docs/chunks/onboarding_terminal_env - Managed participant terminal environment
#
# Installed to ~/.agentic-101/shellrc and sourced from a managed block in
# ~/.bash_profile (Git Bash on Windows, bash inside Ghostty on macOS) and
# ~/.zshrc (so a participant who opens a stock macOS Terminal still finds the
# course commands). Everything here must be valid in both bash and zsh.

AGENTIC101_HOME="${AGENTIC101_HOME:-$HOME/.agentic-101}"
export AGENTIC101_HOME

# Put the course commands (commit, revert, course-check) on the PATH exactly
# once, no matter how many times this file is sourced.
case ":$PATH:" in
    *":$AGENTIC101_HOME/bin:"*) ;;
    *) PATH="$AGENTIC101_HOME/bin:$PATH"; export PATH ;;
esac

# macOS system bash is 3.2 and prints a "the default interactive shell is now
# zsh" notice at startup unless this is set. The course prescribes bash on both
# platforms (DEC-007), and that notice would be the first thing a participant
# ever sees in a terminal.
BASH_SILENCE_DEPRECATION_WARNING=1
export BASH_SILENCE_DEPRECATION_WARNING

# One prompt on both platforms: the name of the folder you are in, then a
# marker showing the computer is waiting for you. Matches the mental model
# taught in Session 2 — "which folder am I in?" is the only question a
# beginner's prompt needs to answer.
if [ -n "${BASH_VERSION:-}" ]; then
    PS1='\[\033[1;34m\]\W\[\033[0m\] $ '
fi
