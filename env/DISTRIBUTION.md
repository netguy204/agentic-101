# Distribution

<!-- Chunk: docs/chunks/onboarding_terminal_env - Managed participant terminal environment -->

The one open external dependency of the managed environment: **this
repository has no public remote yet**, so the `curl | bash` one-liner has
nowhere real to download from.

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

Both currently hold the placeholder
`https://raw.githubusercontent.com/REPLACE-ME/agentic-101/main/env`.

## What publishing requires

1. Push this repository to a public remote (or any host that serves raw
   files over HTTPS).
2. Replace `REPLACE-ME` in both installers with the real path; commit.
3. Verify the one-liners from `env/README.md` on a machine without a
   checkout.

**Publishing is a hard pre-cohort gate.** The setup guide
(`setup/README.md`) deliberately embeds the remote one-liner shape with the
`REPLACE-ME` placeholder visible (DEC-009: the guide is written in its
final form; the placeholder cannot survive contact with a real cohort
because the very first participant's Step 1 fails loudly). The gate is
enforced as item 1 of `setup/PRE_COHORT_CHECKLIST.md` — publish, replace
`REPLACE-ME` in all four locations (both `env/` installers **and** the two
URLs in `setup/README.md` / the facilitator email template), and verify on
a machine without a checkout, before anything is sent to participants.

## One-liner shapes the setup guide embeds

```bash
# macOS
curl -fsSL <BASE_URL>/install.sh | bash
```

```powershell
# Windows
irm <BASE_URL>/install.ps1 | iex
```
