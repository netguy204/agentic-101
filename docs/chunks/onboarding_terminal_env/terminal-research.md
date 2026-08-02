# Terminal Emulator Selection for the pi Cohort Course

**Research date:** August 2026. All claims verified against current release pages, official docs, and issue trackers (sources at end). Produced by a research agent for the onboarding_terminal_env chunk; the recommendation below is input to the planning-time terminal decision flagged in this chunk's GOAL.md.

## 0. The finding that reframes the question

pi's own documentation settles two constraints up front:

- **pi requires a bash shell on Windows, and "Git for Windows is sufficient."** pi auto-discovers bash in this order: custom `shellPath` in `~/.pi/agent/settings.json` → `C:\Program Files\Git\bin\bash.exe` → `bash.exe` on PATH (Cygwin/MSYS2/WSL). Git Bash is the path of least resistance by design. ([pi windows.md](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/windows.md))
- **pi's terminal-setup doc explicitly documents Windows Terminal and Ghostty**, including exact config snippets. Windows Terminal: add `sendInput` actions mapping Shift+Enter → `\u001b[13;2u` and Alt+Enter → `\u001b[13;3u` (the latter also un-shadows WT's default Alt+Enter = fullscreen binding). Ghostty: add `keybind = alt+backspace=text:\x1b\x7f`; remove any legacy `shift+enter=text:\n` mapping. ([pi terminal-setup.md](https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/terminal-setup.md))

There is no single terminal that is simultaneously (a) first-class on both Windows and macOS, (b) healthy/actively released, and (c) solid on the Kitty keyboard protocol. Every "one terminal everywhere" candidate fails at least one leg. The evidence therefore favors a per-platform flagship pairing.

## 1. Comparison table

| Terminal | Platforms | Kitty keyboard protocol | Maintenance (Aug 2026) | Install | License / cost | Account? |
|---|---|---|---|---|---|---|
| **Windows Terminal** | Windows only | **Native in Preview 1.25** (Mar 2026); stable 1.24 lacks it but pi's documented `sendInput` bindings deliver the exact CSI-u sequences pi needs ([devblogs](https://devblogs.microsoft.com/commandline/windows-terminal-preview-1-25-release/), [pi docs](https://pi.dev/docs/latest/terminal-setup)) | Excellent; stable 1.24.11911.0 Jul 16 2026; preinstalled on Win 11, auto-updates via Store ([releases](https://github.com/microsoft/terminal/releases)) | Preinstalled / `winget install Microsoft.WindowsTerminal` | MIT, free | No |
| **Ghostty** | macOS, Linux. **No official Windows** — only unaffiliated community forks (Winghostty etc.); libghostty targets Windows but no supported build ([discussion #2563](https://github.com/ghostty-org/ghostty/discussions/2563), [#12290](https://github.com/ghostty-org/ghostty/discussions/12290)) | Full (reference-quality, v1.0+) ([fsck.com survey](https://blog.fsck.com/agent-blog/2026/02/26/terminal-keyboard-protocol/)) | Excellent; 1.3.1 Mar 13 2026, 6-month cycle ([release notes](https://ghostty.org/docs/install/release-notes/1-3-0)) | `brew install --cask ghostty` | MIT, free | No |
| **iTerm2** | macOS only | Full, automatic since 3.5; pi: "works out of the box" | Healthy, long-established | `brew install --cask iterm2` | GPL-2, free | No |
| **WezTerm** | Win/mac/Linux | Full but opt-in (`enable_kitty_keyboard = true`); Shift+Enter works by default via modifyOtherKeys per pi docs. Known gaps on Windows: kitty protocol not honored through WSL ([helix #11760](https://github.com/helix-editor/helix/issues/11760)), assorted encoding bugs ([#3984](https://github.com/wezterm/wezterm/issues/3984)) | **Last stable release Feb 3 2024** (2.5 years); nightlies active; community openly asking about stale releases ([#7299](https://github.com/wezterm/wezterm/issues/7299)) | winget `wez.wezterm` / `brew install --cask wezterm` (both serve the 2024 build) | MIT, free | No |
| **Alacritty** | Win/mac/Linux | Implemented since 0.13, but with open correctness gaps — apps requesting flags get `KittyKeyboardFlags(0x0)` ([#8836](https://github.com/alacritty/alacritty/issues/8836), [#8792](https://github.com/alacritty/alacritty/issues/8792)) | Good; 0.17.0 Apr 6 2026 ([releases](https://github.com/alacritty/alacritty/releases)) | winget / brew cask | Apache-2.0, free | No |
| **kitty** | macOS, Linux, BSD. **No Windows**, explicitly wontfix ([#4069](https://github.com/kovidgoyal/kitty/issues/4069)) | Full (protocol author) | Excellent | brew | GPL-3, free | No |
| **Warp** | Win/mac/Linux | Supported | Active; client open-sourced Apr 2026 (MIT + AGPL); cloud/AI platform (Oz) proprietary | winget / brew | Open-core; free tier | Login optional for core terminal since Nov 2024, but AI/agent features require account — the login-nudge first-run flow is hostile UX for this audience ([warp.dev](https://www.warp.dev/blog/lifting-login-requirement)) |
| **Rio** | Win/mac/Linux | Full | Active (v0.4.7 Jun 9 2026) but young, small user base, tiny community — support risk for 30+ novices ([releases](https://github.com/raphamorim/rio/releases)) | winget/choco/brew | MIT, free | No |
| **Tabby** | Win/mac/Linux | **None in practice** — xterm.js-based; xterm.js only gained kitty protocol in Jan 2026 ([PR #5600](https://github.com/xtermjs/xterm.js/pull/5600)) and Tabby has not shipped it; momentum declining ([discussion #10190](https://github.com/Eugeny/tabby/discussions/10190)) | Alive (1.0.235 Jul 2026) but slowing | winget/brew | MIT, free | No |
| **Hyper** | Win/mac/Linux | None (old xterm.js) | **Effectively dead**; no meaningful releases since ~2023 | — | MIT | No |

Eliminations: **kitty** and **Ghostty** (no Windows), **Hyper** (dead), **Tabby** (no kitty protocol — hard fail on pi's core UX), **Warp** (account-nudge onboarding + open-core AI upsell aimed at exactly the confusion this audience must avoid), **Rio** (too obscure to prescribe to non-programmers), **Alacritty** (protocol gaps under active bug reports, no tabs, config-file-only UX, historically weak emoji/font fallback).

## 2. Bash on Windows: the top pairing in detail

### Winner: Git Bash (Git for Windows) opened *inside* Windows Terminal

- **Install:** `winget install --id Git.Git` — silent, non-interactive, signed installer. Windows Terminal then auto-detects Git Bash and adds a "Git Bash" profile automatically.
- **Home directory:** `C:\Users\<name>` — the student's real Documents folder is `~/Documents`, visible in Explorer, no translation layer. Paths in course material like `cd ~/Documents/pi-projects` work and the folder is findable in normal Windows.
- **npm/node:** Windows Node (`winget install OpenJS.NodeJS.LTS`) is directly on Git Bash's PATH; `npm install -g @earendil-works/pi-coding-agent` installs to `%APPDATA%\npm` and `pi` resolves in Git Bash with zero extra steps. One node install, one world.
- **pi interop:** pi finds `C:\Program Files\Git\bin\bash.exe` automatically — no settings needed.
- **Critical instruction for the course:** students must never launch the Start-menu "Git Bash" icon (mintty). mintty has only partial CSI-u (no full kitty protocol per the [fsck.com survey](https://blog.fsck.com/agent-blog/2026/02/26/terminal-keyboard-protocol/)) and Windows Node is a known problem child under mintty (winpty workarounds). Inside Windows Terminal, bash runs under ConPTY and Node behaves natively. The pi community independently converged on exactly this: "use Windows Terminal to fire up Git Bash, then run pi there" ([pi #1348](https://github.com/earendil-works/pi/issues/1348)).

### WSL2 — rejected for this audience

Install requires `wsl --install` + reboot + virtualization enabled (BIOS/corp-policy failures on a nonzero fraction of laptops); a second, separate filesystem ("where did my file go?"); a second Node/npm install inside Linux (nvm/apt — the Windows npm doesn't carry over); Windows files only via slow `/mnt/c`. Every one of these is a support ticket multiplied by dozens of students. WSL2 is the right answer for developers, the wrong one for this course.

### MSYS2 — rejected

Git Bash *is* a curated MSYS2 subset. Raw MSYS2 adds pacman, environment-selection confusion (MSYS vs MINGW64), and nothing the course needs.

## 3. Recommendation

**Primary: Windows Terminal + Git Bash profile on Windows; Ghostty on macOS.**

Rationale against the five requirements:

1. **Consistency:** the parts of the experience that fill 95% of the course — the bash prompt, shell commands, and the pi TUI with Shift+Enter/Alt+Enter — are identical. What differs is window chrome, which differs between macOS and Windows *no matter which terminal you pick* (title bars, fonts, Cmd vs Ctrl). Paying WezTerm's staleness tax to unify chrome that can't fully unify is a bad trade.
2. **Protocol:** Ghostty is the reference-quality kitty-protocol implementation. Windows Terminal has native support in Preview 1.25, and on stable 1.24 pi's documented `sendInput` bindings deliver byte-identical CSI-u sequences (`\u001b[13;2u` / `\u001b[13;3u`) — deterministic, and they remain harmless after 1.25 reaches stable. Both render truecolor and emoji well.
3. **Popular/maintained:** these are the two flagship terminals of their platforms — the largest user bases in the entire candidate set, active quarterly/semiannual releases, MIT-licensed, free, no accounts.
4. **Bash on Windows:** best-in-class per Section 2, and it is pi's own documented happy path.
5. **Scriptable install:** Windows one-liner: `winget install Git.Git OpenJS.NodeJS.LTS` (+ WT preinstalled on Win 11; `winget install Microsoft.WindowsTerminal` covers Win 10) plus a PowerShell step that patches `settings.json` with pi's two `sendInput` actions and sets Git Bash as default profile. macOS: `brew install --cask ghostty && brew install node`, then append two lines to Ghostty's plain-text config file (`~/Library/Application Support/com.mitchellh.ghostty/config`). No GUI clicking on either platform.

An acceptable macOS substitution is **iTerm2** (pi: "works out of the box," zero config) if floor-testing surfaces Ghostty friction — but Ghostty's text-file config is easier to script than iTerm2's plists, and its defaults are better.

**Runner-up: WezTerm on both platforms.** It wins only in one scenario: the course authors decide a *single config file and pixel-similar screenshots on both OSes* is worth more than project health, and they are willing to (a) pin and distribute nightly builds (the winget/brew stable is a Feb 2024 binary with 2.5 years of unfixed bugs), (b) ship a `wezterm.lua` with `enable_kitty_keyboard = true` and `default_prog = {'C:\\Program Files\\Git\\bin\\bash.exe','-l'}`, and (c) accept a hobbyist-cadence project as their foundation. If WezTerm cuts a fresh stable release before the course ships, this option strengthens considerably — watch [issue #6341](https://github.com/wezterm/wezterm/issues/6341).

## 4. Risks and caveats of the recommendation

1. **WT stable (1.24) has no native kitty protocol yet.** Mitigated by the `sendInput` bindings, but those cover exactly Shift+Enter and Alt+Enter — any *other* pi chord relying on progressive enhancement won't disambiguate until 1.25 ships stable (delayed; 1.26 also pushed, per Microsoft's July 2026 servicing notes). Audit the course's full keybinding list against WT 1.24 during floor-testing, or standardize on WT Preview 1.25 (`winget install Microsoft.WindowsTerminal.Preview`) — at the cost of the word "Preview" in front of novices.
2. **Alt+Enter is contested on Windows.** WT's default Alt+Enter = fullscreen shadows pi even with native protocol support; the remap is mandatory, not optional. The settings.json patch must be applied while WT is closed (WT rewrites the file).
3. **Option+Enter on macOS/Ghostty.** macOS Option-key text substitution can interfere with alt-modifier reporting; pi's Ghostty guidance (alt+backspace fix) shows alt combos need attention. Floor-test Option+Enter; if it fails, add `macos-option-as-alt = true` to the scripted Ghostty config.
4. **The mintty trap.** After installing Git for Windows, a "Git Bash" icon appears in the Start menu. Students who click it get mintty — where pi's keybindings and Node behave worse. The guide needs an explicit "always open Windows Terminal, then the Git Bash tab" callout with a screenshot, and ideally the install script sets Git Bash as WT's default profile so the WT icon alone is sufficient.
5. **Version skew from auto-updates.** WT updates via Microsoft Store, Ghostty via Sparkle. Generally good (bindings keep working; native 1.25 protocol support arriving mid-course is strictly additive), but screenshots may drift cosmetically.
6. **Installer friction.** winget/git/node installers are signed — no SmartScreen prompts expected; `npm -g` on Windows needs no admin. On corporate-managed Windows laptops, winget or Store access may be blocked — screen for this in pre-course onboarding. macOS first launch of Ghostty triggers a standard Gatekeeper confirm (it is notarized; one click).
7. **Fonts.** Both terminals ship good defaults (Cascadia Mono / JetBrains Mono) with emoji fallback; no Nerd Font install is required unless pi's TUI uses powerline glyphs — verify once during floor-testing before adding a font step.
8. **Ghostty ships no official Windows build and none is imminent** — do not let students discover "Winghostty" (unaffiliated fork) and assume parity; the guide should never mention Ghostty in the Windows track.

## 5. Sources

- pi Windows doc — https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/windows.md
- pi terminal setup — https://pi.dev/docs/latest/terminal-setup and https://github.com/earendil-works/pi/blob/main/packages/coding-agent/docs/terminal-setup.md
- pi Windows/Git Bash workaround — https://github.com/earendil-works/pi/issues/1348
- Windows Terminal Preview 1.25 announcement (kitty protocol) — https://devblogs.microsoft.com/commandline/windows-terminal-preview-1-25-release/
- Windows Terminal releases (1.24 stable / 1.25 preview status) — https://github.com/microsoft/terminal/releases
- Terminal kitty-protocol survey, Feb 2026 (Jesse Vincent) — https://blog.fsck.com/agent-blog/2026/02/26/terminal-keyboard-protocol/
- Ghostty Windows status — https://github.com/ghostty-org/ghostty/discussions/2563, https://github.com/ghostty-org/ghostty/discussions/12290
- Ghostty 1.3 release notes — https://ghostty.org/docs/install/release-notes/1-3-0
- WezTerm releases (Feb 2024 latest stable) — https://github.com/wezterm/wezterm/releases; stale-release issue — https://github.com/wezterm/wezterm/issues/7299; release checklist — https://github.com/wezterm/wezterm/issues/6341
- WezTerm kitty-protocol issues — https://github.com/wezterm/wezterm/issues/3984, https://github.com/helix-editor/helix/issues/11760
- Alacritty kitty gaps — https://github.com/alacritty/alacritty/issues/8836, https://github.com/alacritty/alacritty/issues/8792; releases — https://github.com/alacritty/alacritty/releases
- kitty on Windows (wontfix) — https://github.com/kovidgoyal/kitty/issues/4069
- Warp login-optional — https://www.warp.dev/blog/lifting-login-requirement; open-sourcing (Apr 2026) — https://www.helpnetsecurity.com/2026/04/30/warp-open-source-client/
- xterm.js kitty protocol PR — https://github.com/xtermjs/xterm.js/pull/5600; Tabby momentum — https://github.com/Eugeny/tabby/discussions/10190
- Rio releases — https://github.com/raphamorim/rio/releases
- mintty compatibility notes — https://github.com/mintty/mintty/wiki/Tips
