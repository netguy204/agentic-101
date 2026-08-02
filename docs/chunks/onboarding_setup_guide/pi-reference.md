# Pi Onboarding Guide

A practical guide for getting new users productive with **pi**, the minimal terminal
coding agent from `@earendil-works/pi-coding-agent`.

This guide is based on a read-through of pi's shipped documentation. Each section
points to the real doc files for deeper reading.

> Doc root: `/Users/btaylor/.nvm/versions/node/v22.20.0/lib/node_modules/@earendil-works/pi-coding-agent`
> (README.md, `docs/*.md`, `examples/*`).

---

## 1. What pi is and the core mental model

Pi is a **minimal terminal coding harness**. The pitch: "Adapt pi to your workflows,
not the other way around, without having to fork and modify pi internals." The core is
deliberately small; anything workflow-specific (sub-agents, plan mode, permission
popups, MCP, background bash) is left to extensions, skills, prompt templates, and
shareable "pi packages." (README.md → *Philosophy*; `docs/usage.md` → *Design
Principles*.)

### The mental model

| Concept | What it means |
|---------|----------------|
| **Harness** | pi is the shell around a model. It gives the model tools and a place to run, and renders the conversation. It does not impose a workflow. |
| **Tools** | Capabilities the model can call. Out of the box pi enables four: `read`, `write`, `edit`, `bash`. Read-only `grep`, `find`, `ls` are built in but disabled by default. Extensions can add or replace tools. (`docs/usage.md` → *Tool Options*) |
| **Model providers** | Where the LLM comes from. Auth via a subscription (`/login`: Claude Pro/Max, ChatGPT Plus/Pro Codex, GitHub Copilot, xAI, OpenRouter, Radius) or an API key (dozens supported). (`docs/providers.md`) |
| **Session** | A conversation, stored as a JSONL tree under `~/.pi/agent/sessions/`. Branchable in-place. Auto-saved. (`docs/sessions.md`) |
| **Context files** | `AGENTS.md` / `CLAUDE.md` loaded from `~/.pi/agent/`, parent dirs, and cwd — concatenated into the system prompt. How you tell pi project conventions. (README.md → *Context Files*) |
| **Customization layers** | Prompt templates (reusable `/name` prompts), skills (on-demand capability packages), extensions (TypeScript modules), themes (JSON color files). All shareable as packages. (README.md → *Customization*) |

### Four run modes
- **Interactive** (default) — the TUI you'll mostly use.
- **Print** (`-p`) — one-shot, prints response and exits; reads piped stdin.
- **JSON** (`--mode json`) — stream all events as JSON lines.
- **RPC** (`--mode rpc`) — JSONL-over-stdin/stdout for process integration.
- Plus an **SDK** for embedding in Node apps. (README.md → *Programmatic Usage*; `docs/sdk.md`)

---

## 2. Installation and first-run setup

### Install
```bash
npm install -g --ignore-scripts @earendil-works/pi-coding-agent
```
`--ignore-scripts` disables dependency lifecycle scripts; pi doesn't need them for a
normal install. Alternative: `curl -fsSL https://pi.dev/install.sh | sh`.

(`docs/quickstart.md` → *Install*; README.md → *Quick Start*)

### Authenticate — pick one
**Option A: subscription** (Claude Pro/Max, ChatGPT Plus/Pro Codex, GitHub Copilot, xAI, OpenRouter, Radius):
```bash
pi
/login    # then select a provider and follow the OAuth flow
```

**Option B: API key** via env var:
```bash
export ANTHROPIC_API_KEY=sk-ant-...
pi
```
Or run `/login` and pick an API-key provider to store the key in
`~/.pi/agent/auth.json` (created with `0600` perms). Auth-file credentials take
priority over env vars. (`docs/providers.md` → *Auth File*, *Resolution Order*)

> A note for Claude Pro/Max users: third-party harness usage (pi counts) draws from
> Anthropic's paid **extra usage**, billed per token — not your plan limits. Pi shows a
> warning by default (`warnings.anthropicExtraUsage`). (`docs/providers.md` → *Claude
> Pro/Max*)

### Start your first session
```bash
cd /path/to/project
pi
```
Pi runs in your current working directory and can modify files there. **Use git or
another checkpointing workflow** if you want easy rollback — pi has no built-in undo
for edits. (`docs/quickstart.md` → *First session*)

### Project trust (first time in a directory)
If a project contains `.pi/settings.json`, `.pi/extensions`, `.pi/skills`, etc., pi
asks before trusting it. This is an input-loading guard, **not a sandbox**. Trusting
lets pi load that project's settings/resources/extensions. Save a decision with
`/trust` (writes `~/.pi/agent/trust.json`; restart to apply). For non-interactive runs,
`defaultProjectTrust` (`ask` | `always` | `never`) controls fallback, or pass
`--approve`/`-a` / `--no-approve`/`-na`. (`docs/security.md`; `docs/settings.md` →
*Project Trust*)

---

## 3. The essential workflow

### The interactive screen
Top to bottom: **startup header** (shortcuts, loaded context files/skills/extensions)
→ **messages** (yours, assistant, tool calls/results, errors) → **editor** (border color
shows thinking level) → **footer** (cwd, session name, token/cache usage `↑↓RW CH`,
cost, context %, model). (README.md → *Interactive Mode*; `docs/usage.md`)

### Giving instructions
- Type a request, press **Enter** to submit.
- **Multi-line**: `Shift+Enter` (or `Ctrl+Enter` on Windows Terminal).
- **Reference files**: type `@` to fuzzy-search project files, or pass on the CLI:
  `pi @README.md "Summarize this"`.
- **Paste**: `Ctrl+V` (Alt+V on Windows) for image or text; drag images onto the
  terminal.
- **External editor**: `Ctrl+G` (uses `externalEditor`, else `$VISUAL`/`$EDITOR`,
  else Notepad/nano).

### Running shell commands yourself
- `!command` — runs and **sends output to the model**.
- `!!command` — runs **without** sending output (e.g. `!!git status`).
- (`docs/quickstart.md` → *Run shell commands*; README.md → *Editor*)

### Slash commands (type `/`)
The essential set:
| Command | Use |
|---------|-----|
| `/login`, `/logout` | Manage credentials |
| `/model` (or **Ctrl+L**) | Switch models |
| `/scoped-models` | Pick which models cycle on Ctrl+P |
| `/settings` | Thinking level, theme, message delivery, transport |
| `/new`, `/resume` | New / browse past sessions |
| `/tree` | Jump to any point in the session tree and continue |
| `/fork`, `/clone` | Branch off into a new session file |
| `/compact [prompt]` | Manually summarize older context |
| `/session` | Show session file, ID, tokens, cost |
| `/name <name>` | Name the session (findable in `/resume`) |
| `/copy` / **Ctrl+X** | Copy last assistant message |
| `/export [file]`, `/share` | Export to HTML / upload as private gist |
| `/reload` | Reload keybindings, extensions, skills, prompts, themes, context files |
| `/hotkeys` | Show all shortcuts |
| `/quit` | Quit |

Skills appear as `/skill:name`; prompt templates expand as `/templatename`.
(README.md → *Commands*; `docs/usage.md` → *Slash Commands*)

### Keybindings you'll use constantly
| Key | Action |
|-----|--------|
| **Enter** | Submit (or queue a *steering* message if agent is working) |
| **Alt+Enter** | Queue a *follow-up* message (delivered after agent finishes) |
| **Escape** | Cancel/abort; **Escape twice** opens `/tree` |
| **Ctrl+C** | Clear editor; **Ctrl+C twice** quits |
| **Ctrl+L** | Model selector |
| **Ctrl+P** / **Shift+Ctrl+P** | Cycle scoped models forward/back |
| **Shift+Tab** | Cycle thinking level |
| **Ctrl+O** | Collapse/expand tool output |
| **Ctrl+T** | Collapse/expand thinking blocks |
| **Alt+Up** | Retrieve queued messages back to editor |

Full list: `/hotkeys` or `docs/keybindings.md`. Customize via
`~/.pi/agent/keybindings.json` then `/reload`.

### Reading tool output
Tool calls render as collapsible boxes (collapse with **Ctrl+O**). Diffs show with
added/removed highlighting. The model decides which tools to call; you mostly steer
and review. There are **no permission popups by default** — if you want confirmation
gates, install or build an extension (see §4).

### Message queue (work while the agent works)
- **Enter** while busy → steering message (delivered after the current tool batch).
- **Alt+Enter** while busy → follow-up (delivered after the agent fully settles).
- **Escape** aborts and restores queued messages to the editor.
- Configure delivery in `/settings` (`steeringMode`, `followUpMode`: `one-at-a-time`
  default or `all`). (README.md → *Message Queue*)

### Sessions: continue, branch, compact
Sessions auto-save to `~/.pi/agent/sessions/` organized by cwd.
```bash
pi -c                  # continue most recent
pi -r                  # browse past sessions
pi --name "my task"    # named session
pi --session <path|id> # open a specific one
pi --fork <path|id>    # fork into a new file
pi --no-session        # ephemeral (don't save)
```
Inside pi: `/resume`, `/new`, `/tree` (in-place branching in one file), `/fork` (new
file from a previous user message), `/clone` (duplicate active branch). Long sessions
auto-compact when nearing the context window; `/compact` does it manually (lossy — full
history stays in the JSONL, reachable via `/tree`). (`docs/sessions.md`;
`docs/compaction.md`)

---

## 4. Key configuration a new user should know about

Settings live in two files; project overrides global (nested objects merge):

| File | Scope |
|------|-------|
| `~/.pi/agent/settings.json` | Global (all projects) |
| `.pi/settings.json` | Project (current dir, after trust) |

Edit directly or use `/settings`. (`docs/settings.md`)

### Model & thinking
- **Pick a default** in `settings.json`: `defaultProvider`, `defaultModel`,
  `defaultThinkingLevel` (`off|minimal|low|medium|high|xhigh|max`).
- **Switch at runtime**: `/model` or Ctrl+L; cycle with Ctrl+P (set which models cycle
  via `/scoped-models` or `enabledModels` in settings: e.g.
  `["claude-*", "gpt-4o"]`).
- **Thinking level** cycles with Shift+Tab. Editor border color reflects the level.
  Custom token budgets per level via `thinkingBudgets`. (`docs/settings.md` → *Model &
  Thinking*)

### Provider setup
- **Subscriptions**: `/login` → choose provider. Tokens in `~/.pi/agent/auth.json`,
  auto-refresh.
- **API keys**: env var (e.g. `ANTHROPIC_API_KEY`, `OPENAI_API_KEY`, `GEMINI_API_KEY`,
  `DEEPSEEK_API_KEY`, `OPENROUTER_API_KEY`, …) or `/login` → API-key option → stored
  in `auth.json`. Cloud providers (Azure OpenAI, Bedrock, Vertex, Cloudflare) have
  their own env vars — see `docs/providers.md` → *Cloud Providers*.
- **`auth.json` key resolution** supports `!command` (shell, e.g. 1Password/secrets
  store), `$ENV`/`${ENV}` interpolation, escapes (`$$`, `$!`), and literals.
- **Local models** (Ollama, LM Studio, vLLM): add to `~/.pi/agent/models.json`. The
  file reloads every time you open `/model`. (`docs/models.md`)
- **llama.cpp**: `/login llama.cpp`, manage with `/llama`, select with `/model`.
  (`docs/llama-cpp.md`)
- **Custom APIs / OAuth**: write an extension. (`docs/custom-provider.md`)

### Key `PI_*` env vars
| Variable | Effect |
|----------|--------|
| `PI_CODING_AGENT_DIR` | Override config dir (default `~/.pi/agent`) |
| `PI_CODING_AGENT_SESSION_DIR` | Override session storage |
| `PI_OFFLINE` | Disable all startup network ops (update checks, telemetry) |
| `PI_SKIP_VERSION_CHECK` | Skip the pi.dev latest-version check only |
| `PI_TELEMETRY` | `1`/`0` to enable/disable install/update telemetry + attribution headers |
| `PI_CACHE_RETENTION=long` | Extended prompt caching (Anthropic 1h, OpenAI 24h) |
| `VISUAL` / `EDITOR` | External editor fallback for Ctrl+G |

Bash-tool commands also receive `PI_SESSION_ID`, `PI_SESSION_FILE`, `PI_PROVIDER`,
`PI_MODEL`, `PI_REASONING_LEVEL` — useful when the model needs to know which model is
running. (`docs/environment-variables.md`)

### Custom tools / extensions
Extensions are TypeScript modules (loaded via jiti, no compile step) that can register
tools, commands, shortcuts, event handlers, and UI. Place in `~/.pi/agent/extensions/`
(global) or `.pi/extensions/` (project, after trust) for auto-discovery, or load once
with `-e ./my-ext.ts`. Extensions can replace built-in tools, add permission gates, git
checkpointing, sub-agents, plan mode, MCP, custom compaction, etc. — pi explicitly
defers all of this to extensions. (`docs/extensions.md`; `examples/extensions/`)

### Skills
On-demand capability packages following the Agent Skills standard. A directory with a
`SKILL.md` (frontmatter: `name`, `description`). Loaded from
`~/.pi/agent/skills/`, `~/.agents/skills/`, `.pi/skills/`, `.agents/skills/` (project,
after trust), packages, settings `skills` array, or `--skill`. Invoked as
`/skill:name` or auto-loaded when a task matches the description (progressive
disclosure: only descriptions are always in context). (`docs/skills.md`)

> You can reuse Claude Code / Codex skills by adding their dirs to settings:
> `"skills": ["~/.claude/skills", "~/.codex/skills"]`.

### Prompt templates
Markdown files in `~/.pi/agent/prompts/*.md` (or `.pi/prompts/`, packages, settings,
`--prompt-template`). Filename = command: `review.md` → `/review`. Support `$1`,
`$@`, `${1:-default}`. Optional `description` and `argument-hint` frontmatter.
(`docs/prompt-templates.md`)

### Themes
JSON color files in `~/.pi/agent/themes/*.json` (or `.pi/themes/`, packages, `--theme`).
Built-ins: `dark`, `light`. Custom themes **hot-reload** on save. Select via `/settings`
or `theme` in settings. 51 required color tokens; `docs/themes.md` has the full list and
a schema URL for editor autocomplete. (`docs/themes.md`)

### Pi packages
Share bundles of extensions/skills/prompts/themes via npm or git:
```bash
pi install npm:@foo/pi-tools
pi install git:github.com/user/repo@v1
pi list
pi config                 # enable/disable individual resources
pi update --all           # update pi + packages
```
⚠️ **Security**: packages run with full system access; extensions execute arbitrary
code and skills can instruct the model to run executables. **Review source before
installing third-party packages.** (`docs/packages.md`; README.md → *Pi Packages*)

### Tool control (CLI flags)
- `--tools read,grep,find,ls` — allowlist (read-only review mode).
- `--exclude-tools ask_question` — disable one tool, keep the rest.
- `--no-builtin-tools` / `-nbt` — disable built-ins, keep extension tools.
- `--no-tools` / `-nt` — disable all.
- Built-in tools available: `read`, `bash`, `edit`, `write`, `grep`, `find`, `ls`.
  (`docs/usage.md` → *Tool Options*)

---

## 5. Quickstart path — the first 5-6 things to actually do

1. **Install and authenticate.**
   ```bash
   npm install -g --ignore-scripts @earendil-works/pi-coding-agent
   export ANTHROPIC_API_KEY=sk-ant-...   # or: pi, then /login
   ```

2. **Run pi in a project and ask it to orient you.**
   ```bash
   cd /path/to/project
   pi "Summarize this repository and tell me how to run its checks."
   ```
   Watch it use `read`/`bash`. Collapse/expand tool output with **Ctrl+O**. (This is the
   fastest way to internalize the harness+tools mental model.)

3. **Add an `AGENTS.md` with project conventions.** In the project root:
   ```markdown
   # Project Instructions
   - Run `npm run check` after code changes.
   - Do not run production migrations locally.
   - Keep responses concise.
   ```
   Then `/reload` (or restart pi). pi loads `AGENTS.md` from `~/.pi/agent/`, parent dirs,
   and cwd. (`docs/quickstart.md` → *Give pi project instructions*)

4. **Set a default model + thinking level and try cycling.** Open `/settings` (or edit
   `~/.pi/agent/settings.json`) to set `defaultModel` and `defaultThinkingLevel`. Try
   **Shift+Tab** to change thinking mid-session, **Ctrl+L** to open the model selector,
   and `/scoped-models` to choose which models cycle on **Ctrl+P**.

5. **Practice steering, sessions, and branching.**
   - While the agent works, type **Enter** to steer it; **Alt+Enter** to queue a
     follow-up; **Escape** to abort.
   - Name your work: `/name refactor auth`.
   - Branch an alternative: **Escape twice** → `/tree` → pick an earlier turn, edit,
     resubmit (creates a branch in the same file). Or `/fork` for a new file.
   - Come back later: `pi -c` (continue most recent) or `pi -r` (browse).

6. **Add one capability and one reusable prompt.**
   - Install a package or skill, e.g. `pi install npm:<some-pi-package>` (review its
     source first), or drop a `SKILL.md` into `~/.pi/agent/skills/`.
   - Create `~/.pi/agent/prompts/review.md`:
     ```markdown
     ---
     description: Review staged git changes
     ---
     Review `git diff --cached` for bugs, security, and error handling.
     ```
     Invoke with `/review`. (`docs/prompt-templates.md`)

Bonus (non-interactive, for scripts): `pi -p "Summarize this codebase"` or
`cat README.md | pi -p "Summarize this text"`.

---

## 6. Common pitfalls and how to avoid them

1. **No undo / no permission popups.** pi edits files and runs bash with your full
   permissions. There is no built-in confirmation flow. **Commit your work to git
   first**, or run pi in a container/VM for untrusted repos. Want confirmation gates?
   Install/build a `permission-gate`-style extension (`examples/extensions/permission-gate.ts`).
   (`docs/security.md`; README.md → *Philosophy*)

2. **`Shift+Enter` doesn't insert a newline** (or `Alt+Enter` doesn't queue follow-ups).
   pi relies on the **Kitty keyboard protocol**. Most modern terminals work; some need
   config. macOS Terminal has a local-modifier fallback (only works locally, not over
   SSH). Windows Terminal binds Alt+Enter to fullscreen — remap it. Ghostty/WezTerm/
   Alacritty/VS Code each have specific tweaks. **Fix**: see `docs/terminal-setup.md`
   for your terminal. Worst case, `Ctrl+J` is a default newline alias.

3. **Subscription auth uses paid "extra usage."** Claude Pro/Max via `/login` does
   **not** draw from your plan limits — it bills Anthropic extra usage per token. If
   you're surprised by cost, switch to an API key or watch the footer cost/usage. Pi
   warns by default. (`docs/providers.md` → *Claude Pro/Max*)

4. **Project trust prompt on every new project.** If a project has `.pi/` resources or
   `.agents/skills`, pi asks before loading them. This is an *input-loading* guard, not
   a sandbox. To stop the prompts: run `/trust` in a trusted project (saves
   `~/.pi/agent/trust.json`, restart to apply), or set `defaultProjectTrust: "always"`
   (or `"never"`) in global settings. In non-interactive mode, pass `--approve`/`-a` or
   `--no-approve`/`-na`. (`docs/security.md`; `docs/settings.md` → *Project Trust`)

5. **Context window fills up / "compaction" appears.** Long sessions auto-compact
   (lossy summary of old messages; recent ones kept). Full history stays in the JSONL
   file — use `/tree` to revisit. Tune via `compaction.enabled`,
   `compaction.keepRecentTokens`, `compaction.reserveTokens` in settings, or trigger
   manually with `/compact [focus]`. (`docs/compaction.md`)

6. **Bash tool doesn't see your shell aliases.** pi runs bash non-interactively
   (`bash -c`), so aliases aren't expanded. Add to `~/.pi/agent/settings.json`:
   ```json
   { "shellCommandPrefix": "shopt -s expand_aliases\neval \"$(grep '^alias ' ~/.zshrc)\"" }
   ```
   Adjust path for your shell. (`docs/shell-aliases.md`)

7. **Third-party packages are dangerous.** `pi install` runs extensions with full
   system access; skills can instruct the model to run executables. Always **review
   source** before installing. For untrusted repos or unattended automation, run pi in
   a container/sandbox — see `docs/containerization.md` and the `examples/extensions/sandbox/`
   and `gondolin/` examples. (`docs/security.md`; `docs/packages.md`)

8. **Which model am I actually running?** Don't infer from the system prompt. In a bash
   tool run `printf '%s/%s\n' "$PI_PROVIDER" "$PI_MODEL"`. (These vars are injected into
   the LLM bash tool, not into your `!`/`!!` commands.) (`docs/environment-variables.md`
   → *Bash Tool Session Environment*)

9. **Edited a setting/theme/keybinding but nothing changed.** Most resource changes
   apply with `/reload` (keybindings, extensions, skills, prompts, themes, context
   files). `models.json` reloads every time you open `/model`. Custom themes hot-reload
   on save. But `/trust` and some trust changes require a restart. (`docs/usage.md` →
   *Slash Commands*; `docs/themes.md`)

10. **Local model "not available" in `/model`.** Keyless local servers (Ollama, LM
    Studio) still need a dummy `apiKey` in `models.json`, or a saved key via `/login`,
    or `--api-key` — pi treats models as requiring auth before they show up. Also check
    `compat.supportsDeveloperRole: false` / `supportsReasoningEffort: false` for
    OpenAI-compatible servers that don't understand the `developer` role. (`docs/models.md`)

---

## 7. Pointers to deeper docs

All paths relative to:
`/Users/btaylor/.nvm/versions/node/v22.20.0/lib/node_modules/@earendil-works/pi-coding-agent`

### Getting started / daily use
- **README.md** — the overview; *Quick Start*, *Interactive Mode*, *CLI Reference*, *Customization*, *Philosophy*.
- **docs/quickstart.md** — install → auth → first session → common things to try. Start here.
- **docs/usage.md** — interactive mode, slash commands, message queue, sessions, CLI reference, design principles. The day-to-day reference.
- **docs/keybindings.md** — every action ID and default key, plus Emacs/Vim examples. Customize `~/.pi/agent/keybindings.json`.
- **docs/sessions.md** — session storage, branching with `/tree`, `/fork` vs `/clone`, branch summaries.
- **docs/compaction.md** — auto-compaction and branch summarization internals; extension hooks.

### Providers, models, auth
- **docs/providers.md** — subscriptions, API keys (env var table + `auth.json`), cloud providers (Azure, Bedrock, Vertex, Cloudflare), llama.cpp, resolution order.
- **docs/models.md** — custom providers/models via `~/.pi/agent/models.json` (Ollama, vLLM, LM Studio, proxies), supported APIs, provider/model config, `compat` flags, thinking-level maps.
- **docs/custom-provider.md** — register providers from extensions; OAuth; custom streaming APIs; overflow-error normalization.
- **docs/llama-cpp.md** — llama.cpp router server setup and `/llama` usage.
- **docs/environment-variables.md** — all `PI_*` vars, bash-tool session environment, custom bash tool opt-out.

### Configuration
- **docs/settings.md** — every setting (model/thinking, UI, telemetry, network, warnings, compaction, retry, message delivery, terminal, shell, sessions, model cycling, markdown, resources). Project trust details.
- **docs/shell-aliases.md** — enabling shell aliases in the bash tool.
- **docs/terminal-setup.md** — per-terminal keyboard protocol config (Kitty, iTerm2, Ghostty, WezTerm, Alacritty, VS Code, Windows Terminal, etc.).

### Customization & extension
- **docs/extensions.md** — the big one: events, ExtensionContext, ExtensionAPI, custom tools, custom UI, state management, examples reference. Start here for extensions.
- **docs/skills.md** — Agent Skills standard, locations, structure, frontmatter, validation, skill repositories.
- **docs/prompt-templates.md** — locations, format, arguments (`$1`, `$@`, `${1:-default}`), argument hints.
- **docs/themes.md** — theme format, all 51 color tokens, color value formats, hot-reload.
- **docs/packages.md** — install/manage, npm/git/local sources, creating a package, dependencies, filtering, enable/disable via `pi config`.

### Integrations & advanced modes
- **docs/sdk.md** — `createAgentSession`, `createAgentSessionRuntime`, `AgentSessionRuntime`.
- **examples/sdk/** — 13 numbered SDK examples (`01-minimal.ts` → `13-session-runtime.ts`) with a README quick reference.
- **docs/json.md** — JSON event mode.
- **docs/rpc.md** — RPC protocol over stdin/stdout for non-Node integrations.
- **examples/rpc-extension-ui.ts** — RPC extension UI demo.
- **examples/extensions/** — ~70 working extension examples (permission-gate, git-checkpoint, plan-mode, subagent, sandbox, gondolin, custom providers, games, custom editors, …). See `examples/extensions/README.md` for a categorized index.

### Safety
- **docs/security.md** — project trust, no built-in sandbox, running untrusted/unmonitored work.
- **docs/containerization.md** — container/VM/micro-VM patterns.

### Platform notes
- **docs/windows.md**, **docs/termux.md**, **docs/tmux.md**

### Contributing / internals
- **docs/development.md** — setup, forking, debugging.
- **docs/session-format.md** — JSONL session file format and SessionManager API.
- **docs/index.md** / **docs/docs.json** — doc index.

---

### One-paragraph TL;DR
Pi is a small, extensible terminal coding harness: it gives a model four tools
(`read`/`write`/`edit`/`bash`), saves branching sessions as JSONL trees, loads project
instructions from `AGENTS.md`, and lets you add everything else (more tools,
permissions, sub-agents, plan mode, MCP, themes) via TypeScript extensions, skills,
prompt templates, and shareable npm/git packages. To start: `npm install -g
--ignore-scripts @earendil-works/pi-coding-agent`, set an API key (or `/login`), `cd`
into a project, run `pi`, ask it something, and steer with Enter / Alt+Enter / Escape.
