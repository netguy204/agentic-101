---
themes: [setup, platform]
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

### 2026-08-23 [platform] Rubric exemplars in spoken register split the judge on worksheet-shaped answers

The platform's staged walkthrough of Session 2 submitted a deliberately
near-miss worksheet whose Tool column read "it just did it". The rubric's
near-miss exemplars for `read_tool_calls` were all spoken-round sentences,
so the judge split five ways and escalated at low confidence instead of
firing the checkpoint's corrective question. The near-miss was the
checkpoint's own most-common row — in the register of the artifact the
platform actually receives. Fixed same day: two worksheet-register
exemplars added to `platform/rubrics/02_meeting_the_harness.yaml`, same
row, same corrective. Rule worth carrying forward: exemplars belong in the
register of the submitted artifact, not only the spoken round.

### 2026-08-23 [platform] Concept-track minutes overstated against the rendered audio

The S1 index and manifest said "about 30 minutes" for a concept track whose
rendered audio runs ~14; S2 claimed 25 against ~15. The honest-minutes rule
(PLATFORM_AUTHORING, "Design for the student who is alone") cuts both ways.
Fixed same day: both index concept rows now state ~15 minutes of listening
and name what the remaining concept time is (the prework's doing-parts,
which the track hands back). Manifest totals unchanged — they cover listen
plus do. Check to add to the drafting habit: word count / 190 ≈ listened
minutes, compared against whatever number the index prints.

### 2026-08-23 [platform] Part and index lines under-specify the sitting or the bar

Three wording gaps from the same walkthrough, all fixed same day: the S1
daily-pass part read as one 20-minute sitting (it is five short passes —
now said in the part title itself, not just the index prose); the S1 index
undersold the bar by one column (judgeability without the written check —
now "and with the actual check written next to it"); S2 part 1's outcome
now names the delete-it-really moment as what makes the rest safe, since
the runsheet's own finding is that nobody who skipped the deletion trusts
the net — and it is the likeliest solo stall.

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

### 2026-08-23 [setup] An already-running Ghostty ignores the course configuration

The operator (as the pilot's first student) had Ghostty running since before
the installer wrote its config. The running instance keeps the configuration
it loaded at startup, so every window it spawned — including ones opened
after install — came up as stock zsh with no course PATH and no pi
keybindings, and `course-smoke-test` was "command not found" in what looked
like a fresh course terminal. The Windows path already guards against
exactly this ("Close every Windows Terminal window, then open Windows
Terminal again"); the macOS path does not, and the installer's closing
"Open Ghostty" reads as satisfied by an already-open Ghostty. Fix: the
installer's closing message and the guide's macOS Step 1 should both say
"If Ghostty is already open, quit it fully (Cmd+Q) first." Rare at the
audience floor (they won't have Ghostty), certain for any student who
already uses it.

### 2026-08-23 [setup] install-pi.sh installs pi into whichever npm is active in the shell that ran it

On a machine with nvm, the operator ran the Step 3 installer from a personal
zsh terminal (nvm active), so `npm install -g` put pi into nvm's prefix
(~/.nvm/.../bin) — visible to personal shells, invisible to the course
terminal, whose bash PATH carries Homebrew's prefix. The smoke test then
showed the confusing split: environment healthy, model configured, key
saved, but "pi is not installed, or not on your PATH". Re-running the
installer inside the course terminal fixed it. Two candidate fixes: the
installer verifies `npm prefix -g` is the expected Homebrew prefix and
warns (or re-execs) when another node manager is shadowing it; and/or the
setup guide's Step 3 says explicitly to paste the command into the course
terminal opened in Step 2, not any terminal. Rare at the audience floor
(no nvm), near-certain for technical students.
