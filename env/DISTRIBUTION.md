# Distribution

<!-- Chunk: docs/chunks/onboarding_terminal_env - Managed participant terminal environment -->

Where the `curl | bash` one-liners download from, and every place the
address lives. **The repository is published at
https://github.com/netguy204/agentic-101** (since 2026-08-03), and all four
URL locations point at it. What remains before sending the guide to
participants is verification from a machine with no checkout
(`setup/PRE_COHORT_CHECKLIST.md`, item 1).

## How the installers resolve their payload

Both installers work two ways:

1. **Local**: when the script sits next to the rest of `env/` (a clone or
   an extracted tarball), it uses the local files. This works today and is
   how the smoke tests run.
2. **Remote**: when run standalone (the `curl | bash` case), each payload
   file is downloaded from a base URL.

The base URL lives in exactly one place per installer:

- `env/install.sh` → `A101_BASE_URL_DEFAULT` (line ~20), overridable at run
  time with `AGENTIC101_ENV_BASE_URL`.
- `env/install.ps1` → the mirrored `$BaseUrlDefault`, overridable with the
  same environment variable.

Both hold
`https://raw.githubusercontent.com/netguy204/agentic-101/main/env`.
(`setup/install-pi.sh` carries its own base URL the same way, pointing at
`…/main/setup`, and `setup/README.md` embeds the full one-liners in Steps
1 and 3 — four locations total when the address changes.)

## Publishing status

Done 2026-08-03: pushed to `github.com/netguy204/agentic-101` and the real
path substituted in all four locations (both `env/` installers,
`setup/install-pi.sh`, and the one-liners in `setup/README.md`). Still
owed before anything is sent to participants — enforced as item 1 of
`setup/PRE_COHORT_CHECKLIST.md`:

- Verify all three one-liners from a machine **without a checkout** of
  this repository (the remote-download path has only been exercised
  locally; see the checklist for the per-platform PASS requirement).

If the repository ever moves, repeat the substitution in the same four
locations and re-verify. (History: until 2026-08-03 the URLs deliberately
held a `REPLACE-ME` placeholder so a stale guide would fail loudly at
Step 1 rather than install from the wrong source — DEC-009.)

## One-liner shapes the setup guide embeds

```bash
# macOS
curl -fsSL <BASE_URL>/install.sh | bash
```

```powershell
# Windows
irm <BASE_URL>/install.ps1 | iex
```
