---
themes: [setup]
proposed_chunks: []
---

# Friction Log

<!--
GUIDANCE FOR AGENTS — DO NOT REMOVE THIS COMMENT

This guidance block is permanent project documentation. Agents MUST NOT delete,
modify, or move this comment. It exists to help future agents understand how to
work with the friction log correctly.

THEMES:
- Starts empty; themes are added organically as friction is logged
- Each theme is a short identifier (e.g., "cli", "docs", "testing")
- When logging friction, use an existing theme if it fits, or add a new one

PROPOSED_CHUNKS:
- Starts empty; entries are added when friction patterns emerge
- Format: list of {prompt, chunk_directory, addresses} where:
  - prompt: The proposed chunk prompt text describing work to address the friction
  - chunk_directory: Populated when/if the chunk is created via /chunk-create
  - addresses: List of entry titles this chunk would address
- Add a proposed_chunk when 3+ entries share a theme, or when recurring pain is evident
- The prompt should describe the work, not just "fix friction"

When appending a new friction entry:
1. Read existing themes - cluster the new entry into an existing theme if it fits
2. If no theme fits, add a new theme to frontmatter
3. Use the format: ### YYYY-MM-DD [theme-id] Title

Entry status is DERIVED, not stored:
- OPEN: Entry title not in any proposed_chunks.addresses
- ADDRESSED: Entry title in proposed_chunks.addresses where chunk_directory is set
- RESOLVED: Entry is addressed by a chunk that has reached COMPLETE status
-->

## Entries

<!--
ENTRY FORMAT — DO NOT REMOVE THIS COMMENT

Agents are instructed to preserve this comment. It documents the required format.

Each entry follows this structure:

    ### YYYY-MM-DD [theme-id] Title

    Description of the friction point. Include enough context for future readers
    to understand what happened and why it was painful.

Where:
- YYYY-MM-DD: Date the friction was observed
- [theme-id]: Category from the themes list in frontmatter (e.g., [cli], [docs])
- Title: Brief summary of the friction point (used as the entry identifier)

New entries are appended below this comment.
-->

### 2026-08-22 [setup] env/install.sh looks frozen during the silent node/git step

A real setup run (the operator, as the platform pilot's first student) closed
the terminal during Step 1 of 4: `brew install node git` runs with all output
silenced and, when Homebrew decides to auto-update or upgrade, sits for
several minutes with the last visible line being "Installing node and git…".
install-pi.sh already warns "nothing at all will appear on screen while it
runs. That is normal." — install.sh's brew step needs the same courtesy line,
and ideally a completion line per app. The interrupted install left no
partial-state warning; the re-run succeeded because the installer is
idempotent, which is the only reason this was cheap to recover.
