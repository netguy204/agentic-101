# Learning Path: Getting Effective with the `pi` Coding Agent

## Why this guide, why you

You already know your job deeply — the edge cases, the tedious
reports, the workarounds you've built in spreadsheets. That knowledge is
about to become a new kind of leverage. With an agent like `pi`, you can
build the small tools and automations that used to require a programmer
on your team — without becoming a developer yourself. The agent does
the typing; you supply the judgment about what's worth building and
whether the result is right. This guide teaches you how to steer it.

`pi` is a minimal terminal coding-agent harness. Unlike tools that bake in
every feature, pi ships a small core — a chat UI plus four default tools
(`read`, `write`, `edit`, `bash`) — and pushes every other capability into
add-on **skills** and **extensions** you can ignore until you need them.

This guide is a progressive path from "what is pi?" to "I can extend it for my
workflow." It's organized into stages. Don't try to learn everything at once —
each stage builds on the last.

> **If the terminal scares you, start at Stage 0.** It teaches just enough
> terminal survival — mapped onto the file browser you already know — so the
> rest of the guide makes sense. If you're already comfortable with `cd`, `ls`,
> and running a command, skip to [Stage 1](#stage-1--get-started-install--first-session).

> **Doc paths below** are absolute because pi's docs ship inside the installed
> npm package. They are the source of truth. File paths under `.pi/` and
> `~/.pi/` are live config locations you'll edit. (The `~` tilde is shorthand
> for your home folder — so `~/.pi/` means "the `.pi` folder inside your home
> folder," the same place you'd see your Documents or Desktop.)

---

## For leaders and skimmers (if you read nothing else)

**The thesis in one sentence:** your non-programming team's domain judgment
now has a new kind of leverage — they can build the small tools and
automations that used to require a programmer, by describing the work in
plain English and letting an agent do the typing. No one has to become a
developer; the scarce input shifts from keystrokes to judgment.

**What that looks like, before → after:**

- **File a ticket → build it yourself.** A data-cleanup that used to wait on
  IT for a script becomes a plain-English prompt (see Stage 1.5's messy-CSV
  moment, where inconsistent department tags get standardized by reasoning,
  not find-and-replace).
- **Rigid automation that breaks → an agent that reasons.** A fixed Zapier
  pipeline fails on the edge case it wasn't built for; an agent reads each
  item and decides (the [Zapier comparison](#if-you-already-use-zapier-make-or-chatgpt)
  spells out the shift).
- **Judgment-shaped work, not just fixed steps.** Anything that needs a
  decision per item — triage, categorization, drafting — moves from "live
  with it" to "describe it and check the result."

**The risk picture is honest, not reassuring** — see [For leaders: what
could go wrong](#for-leaders-what-could-go-wrong), immediately below. Read
that block before you fund a rollout; it's the section your security partner
will ask for.

**If you're triaging but not rolling out:** the five features that repay the
first hour of learning are listed in [The 5 features to master
first](#the-5-features-to-master-first), right below the risk block — a
skimmer's entry point, not a buried reference.

## For leaders: what could go wrong

pi is powerful because it runs with real reach into your environment, and
that's exactly why the risk picture matters. Four decision factors, framed as
what a leader needs to weigh — not keystroke warnings:

1. **Local blast radius (the damage a wrong move can do) is "whatever
   your account can do," bounded by git as a safety net.** pi runs with
   *your* permissions and no sandbox (it isn't sealed off from the rest of
   your machine — it can touch anything you can); it can modify or delete any
   file you can. The mitigation is built into this course:
   [Stage 0.5](#stage-05--your-safety-net-git-in-four-commands) teaches a
   `git` snapshot-and-revert net so any change is undoable before it's
   committed. The blast radius is your account, not a whole org.
2. **Prompts and file contents leave the machine for the LLM provider.** To
   do inference, pi sends what you type *and* the file contents it reads to
   your model provider (Anthropic, OpenAI, Google, etc.). That's the data-flow
   question your security partner will ask about: nothing stays on your
   machine. A data-handling policy — no secrets, credentials, or regulated data
   in agent prompts or the folders it reads — is the control, not pi's
   settings.
3. **For untrusted repos or unattended runs (no human watching to cancel if
   it goes wrong), isolate with a container or VM.** Unattended or
   no-human-in-the-loop runs amplify blast radius; repos from outside the org
   can carry `.pi/` resources. A container or VM is how you isolate those
   cases.
4. **Project trust is an input-loading guard, not isolation.** pi's
   `/trust` prompt only decides whether to load a project's config files; it
   does **not** sandbox the code that runs. Treat it as hygiene, not a
   security boundary.

The throughline: pi is a teammate with real permissions and real reach, used
by a human supplying judgment. The controls above — a git net, a data
policy, isolation for the untrusted case — are how you make that safe to
scale past one curious user.

## The 5 features to master first

If you only learn five things, learn these. (Skimmer's note: this is the
one screen to internalize before reading the rest; the stages below teach
them in context.)

1. **`/hotkeys` — your in-app panic button.** Type it any time; everything you
   can do is listed there, so you never need to memorize shortcuts.
2. **The message queue (steering vs follow-up).** Keep working instead of
   waiting idle — your hands stay busy while pi works. Enter = steer,
   Alt+Enter = follow-up, Escape = abort.
3. **Session branching with `/tree`.** Try a different approach without losing
   anything — both versions stay saved. Double-Escape opens it fast.
4. **Context files (`AGENTS.md`).** One file shapes every session in that
   project, so your judgment is encoded once and applied every time.
5. **Skills (`/skill:name`).** Capabilities on demand. In this project, the
   global workflow skills (chunk-*, narrative-*, investigation-*) encode a
   repeatable way of working — using them beats reinventing the process.

> Model + thinking control (`Ctrl+L`, `Shift+Tab`) is genuinely useful, but
> it's polish — match the cheap model to trivial work, high thinking to hard
> problems. Save it for after the five above feel routine.

---

## Jargon glossary (read once, refer back anytime)

The terminal has its own vocabulary. It's not harder than what you already
use — it just uses different words for things you already do in your file
browser. Keep this nearby; every term is also defined in-line the first time
it appears.

| Term | What it means | The GUI version you already know |
|------|----------------|----------------------------------|
| **Terminal** | A text-only app where you type commands instead of clicking | A Finder / Explorer window, but you navigate by typing |
| **Shell** | The program showing the blinking cursor; it turns your typing into actions | The Finder app itself, but text-only |
| **Directory** | A folder. Same thing — "directory" is just the terminal word | A folder |
| **Path** | The folder-by-folder "address" of a file, like `/Users/you/project/file.md` | The breadcrumbs in a Finder window's title bar |
| **Command** | A typed instruction; you press Enter to run it | A menu item you'd click |
| **Argument** | What goes *after* the command, like the folder name in `cd Projects` | The folder name you double-click |
| **Flag** | An optional switch starting with `-`, like `ls -a` ("show hidden files too") | A checkbox in a preferences panel |
| **stdout / output** | The text the terminal prints back after you run a command | The "reply window" after you click OK |
| **Environment variable** | A named value your shell remembers for that session, like a saved preference | A saved preference other apps can read |
| **`export`** | "Set this preference for the current terminal session." It vanishes when you close the window unless saved to a startup file | Setting a preference that other apps in the session can read |
| **Sandbox** | A sealed-off playpen where actions can't escape or damage the rest of your computer | (No clean GUI analog — it's a containment concept) |
| **Checkpoint system** | A saved snapshot you can undo to | "Save As…" a version you can revert to |
| **Session** | One connected conversation with pi, saved automatically | Like an open chat thread that auto-saves |
| **Tool call** | pi reaching for one of its tools (read a file, run a command) and reporting back | Like a coworker picking up a tool from their desk and telling you what they found |
| **Extension** | An add-on module that gives pi a new capability | Like a browser extension or app plug-in |

---

## Prerequisites (what to know before you start)

You don't need to be an expert. You need:

- **Terminal survival** — open a terminal, know which folder you're in, move
  into a folder you can also see in your file browser, and run a command you
  can read back. **If you can't do this yet, that's exactly what
  [Stage 0](#stage-0--terminal-survival-for-gui-natives) teaches.** Don't skip
  it — pi is a terminal app, there's no GUI.
- **Four git commands as a safety net** — pi modifies files freely and has no
  undo, so we use `git init`, `git add`, `git commit`, and `git restore` to
  snapshot and revert. If git is new to you, that's expected —
  [Stage 0.5](#stage-05--your-safety-net-git-in-four-commands) teaches just
  those four before you need them.
- **One LLM account** — a Claude Pro/Max subscription, ChatGPT Plus/Pro,
  GitHub Copilot, **or** an API key from Anthropic/OpenAI/Google/etc. You do
  *not* need to know what an "API key" is — pi will walk you through it.
- **Reading Markdown and JSON** — config files, skills, and docs are all text.
- Helpful-but-optional: basic TypeScript, if you eventually want to hand-edit
  extensions yourself in Stage 5 (pi can write them for you, so this is
  genuinely optional).

That's it. No framework knowledge required.

> **Already use Zapier, Make, n8n, Airtable automations, or ChatGPT?** There's
> a short section just below — [If you already use Zapier, Make, or
> ChatGPT](#if-you-already-use-zapier-make-or-chatgpt) — that maps those tools
> onto pi and names the one thing pi does that they can't. Read it before
> Stage 0 if you want to calibrate "is this worth it vs. what I already have?"

---

## If you already use Zapier, Make, or ChatGPT

If you've automated anything, you've probably used Zapier, Make, n8n, or
Airtable automations — and if you've used an AI chat tool, you've used
ChatGPT. Good tools, all of them. Here's where `pi` fits and where it's
genuinely different. The table below maps what you know onto pi's parts;
the load-bearing row is the last one.

| What you know | The pi version | How they're alike |
|---|---|---|
| A Zap (Zapier) / scenario (Make) | A pi **session** | One connected run of steps |
| An Action step | A **tool call** (`read`, `write`, `bash`…) | One discrete operation in the run |
| A custom integration / app connector | An **extension** | Adds a capability the core didn't ship |
| A template / recipe | A **skill** | Reusable, on-demand capability |
| Filters and branching paths | ***no direct analog — the agent branches itself by reasoning*** | This is the row that matters |

That last row is the whole shift: a Zapier pipeline executes a sequence
**you designed in advance** — every branch built by hand — while an agent
**plans and adapts at runtime**, based on what it actually finds.

**Why an agent, not just another automation?** Take inbox triage. The
Zapier version is rigid: you pre-build every branch — "if subject
contains *refund* → route to billing; if *bug* → route to eng; everything
else → default queue." It breaks on the edge case, like *"my order is
wrong and I want my money back,"* which mentions neither keyword cleanly.
The agent version: you describe what "needs a human decision" looks like
in plain English; the agent reads each item, decides which bucket it fits,
drafts a reply, and logs it — handling that edge case by reasoning, not
by a branch you forgot to build. You supply the judgment (what "needs
action" means); the agent supplies the flexible execution.

**Why the terminal, then?** Because it gives the agent **full reach**
into your real environment — your actual files, any command-line tool,
anything on your machine — rather than only the apps a vendor built a
connector for. Zapier links app A to app B only if both ship pre-built
integrations; the agent can work with *any* file or tool on your computer
because the terminal is the universal interface. Which is why Stage 0 (below) teaches terminal survival — not as friction,
but as the door to that reach.

> You're not replacing your automations; you're adding a tool that handles
> the judgment-shaped work the fixed-workflow ones can't. Same thesis as
> the opening: your judgment is the scarce input. Zapier is brilliant at
> the steps you could spell out in advance; pi is the one for the steps
> that need a decision per item. They sit side by side.

---

## Stage 0 — Terminal survival (for GUI natives)

**Goal:** Be comfortable enough in the terminal that the rest of this guide
makes sense. You will *not* become a terminal expert here — just oriented and
safe.

**Outcome: You can open a terminal, move into a folder you can also see in
your file browser, run a command, and read its reply.**

### The GUI → terminal concept map

Everything here is something you already do by clicking. The terminal just
uses typed words instead.

| You want to… (GUI action) | Type this | GUI analogy | Why it matters |
|---|---|---|---|
| See which folder you're in (the window's title bar) | `pwd` | The name at the top of your open Finder window | pi commands act on the *current* folder; you must know where "here" is |
| See what's in the open folder | `ls` | Looking at the icons inside the window | Confirms you're in the right place before running pi |
| Open a folder (double-click into it) | `cd foldername` | Double-clicking a subfolder | Moves "here" somewhere else |
| Go back out / up one level | `cd ..` | The back arrow / clicking the parent in the path bar | The escape hatch when you went too deep |
| Go back to your home folder | `cd ~` | Clicking your username in the Finder sidebar | Resets you to a safe, known place |
| Make a new folder (File → New Folder) | `mkdir projectname` | Right-click → New Folder | Creates a project home before you `cd` into it |
| Run a command at all | Type it, then press **Enter** | Like clicking "OK" in a dialog | Nothing happens until you press Enter; the cursor just blinks |

### Don't be afraid of the blinking cursor

> The blinking cursor isn't waiting for permission — it's waiting for *you*.
> Nothing will happen until you type something and press **Enter**; the
> terminal never "goes ahead on its own." If you typed something and nothing
> happened, you almost certainly forgot to press Enter.

### First safe commands (run these before installing anything)

None of these change or delete files — they only *look*:

1. `pwd` — "where am I?" (safe, read-only)
2. `ls` — "what's here?" (safe, read-only)
3. `cd ~` — "take me home" (safe; always works)

**Safe vs. destructive-looking:** `pwd`, `ls`, `cd`, `cat`, `clear` are purely
informational — they cannot delete or damage anything. Commands starting with
`rm` (remove), `mv` (move/overwrite), or `>` (overwrite a file) *can* destroy
data; don't run those until you know what they do.

**Recovery, if you feel lost or stuck:**
- Press `Ctrl+C` — the universal "cancel, never mind" key. You cannot break
  anything by pressing it.
- Type `clear` and Enter to wipe a cluttered screen.
- Type `cd ~` and Enter to return home, then `pwd` to reorient.

### Try it

1. Open your file browser and create a folder called `pi-practice` somewhere
   you can find it (e.g. in your Documents or home folder).
2. Open a terminal and run `pwd`, then `ls`. Notice the output is the same
   list of folders you see in the file browser.
3. `cd` into `pi-practice` (you'll need to `cd` to its parent first — e.g.
   `cd Documents/pi-practice`). Run `pwd` again — the path now ends in
   `pi-practice`, matching the folder you're looking at in your file browser.
4. Run `ls` — it's empty, just like the empty folder in your browser. You've
   confirmed the terminal and the file browser are showing you the same place.

---

## Stage 0.5 — Your safety net (git, in four commands)

**Goal:** Set up a safety net so anything pi does can be undone.

**Outcome: You can snapshot a folder and throw away changes to return to that
snapshot.**

Here's the honest part: pi modifies your files freely, and it has no undo —
like a coworker editing a shared document with Track Changes turned **off**.
So before you let pi touch anything, you turn on the equivalent of Track
Changes yourself. That's all `git` is here: a snapshot tool, not a
collaboration tool. You will learn exactly four commands and nothing more.

### The GUI → git concept map

Same idea as Stage 0's table — everything here is something you already do by
clicking.

| You want to… (GUI action) | Type this | GUI analogy | Why it matters |
|---|---|---|---|
| Turn on Track Changes for this folder | `git init` | Switching on "Track Changes" in a shared doc | One-time setup; makes the folder able to remember snapshots |
| Select everything before saving a version | `git add .` | Selecting all the changes before clicking "Save version" | Tells git which changes to include in the next snapshot (`.` = everything) |
| Save a named snapshot you can return to | `git commit -m "snapshot"` | "Save As…" a version with a name | Creates the checkpoint you can revert to; the `-m` bit is the snapshot's label |
| Throw away all unsaved changes since the last snapshot | `git restore .` | "Revert to saved" / discarding uncommitted edits | Your escape hatch — undoes everything since the last commit |
| See what's changed since the last snapshot | `git status` | Viewing the Track Changes pane | Tells you what's clean, what's staged, what's changed |

### Try it

Stay in the `pi-practice` folder from Stage 0 (run `pwd` — the path should
end in `pi-practice`):

1. `git init` — turns on Track Changes for this folder.
2. Create or edit a tiny file (e.g. make `notes.txt` with one line in your
   text editor — the same way you'd edit any file in your file browser).
3. `git add .` then `git commit -m "first snapshot"` — you've saved a
   snapshot.
4. `git status` — it says nothing to commit; you're clean.
5. Edit `notes.txt` again, then `git status` — it now shows the file has
   changed since the snapshot.
6. `git restore .` — throws away that edit. `git status` again confirms you're
   back to clean, exactly where the snapshot was. That's the whole safety net.

> `git` is a huge and intimidating subject out in the world — branching,
> merging, remotes, pull requests. You don't need any of that for this guide.
> You need exactly these four commands — `init`, `add`, `commit`, `restore` —
> and one read-only helper, `status`, to look around. You can ignore
> everything else about git until long after this course. If a git command
> ever does something you didn't expect, `git status` (see what's going on)
> and `git restore .` (throw away the changes) are your escape hatches.

---

## Stage 1 — Get started (install → first session)

**Goal:** Have pi running and answering in your project.

**Outcome: You can start `pi` in a project folder and get a useful answer back.**

**Read:**
- README "Quick Start" + "Providers & Models" sections:
  `/Users/btaylor/.nvm/versions/node/v22.20.0/lib/node_modules/@earendil-works/pi-coding-agent/README.md`
- Quickstart (full): `.../docs/quickstart.md`
- Providers (skim the auth table): `.../docs/providers.md`

**Understand / be able to do:**
> Before you install: if you haven't run through Stage 0.5 yet, do — it takes
> two minutes and means everything from here on is undoable.

- Install pi (`npm install -g --ignore-scripts @earendil-works/pi-coding-agent`).
  Reading that command: `npm install` is the command, `-g` and
  `--ignore-scripts` are flags ("install globally" and "don't auto-run the
  package's setup scripts" — the cautious choice; npm normally runs a
  package's setup code on install, and this tells it *not* to), and the
  long string is the package name. Press Enter to run it.
- Authenticate (the normal way is `/login`):
  - **Default — `/login` (no typing secrets):** run `pi`, then `/login`, and
    pick your provider (a subscription, or paste an API key). pi opens a
    browser window, you click approve — like signing into any app with Google.
    You never type a secret into the terminal, and pi stores it in
    `~/.pi/agent/auth.json` so you never retype it.
  - **Advanced alternative — API key as an environment variable.** Only if you
    already manage keys this way: `export ANTHROPIC_API_KEY=sk-ant-...` then
    `pi` (the `sk-ant-...` is a placeholder for your real key — the `sk-ant-`
    prefix is how Anthropic keys begin, `...` means the rest of your key, pasted
    in full). This sets a preference for the current terminal session only. If
    you want the key to persist across terminal restarts you *can* add it to a
    shell startup file — but most people just use `/login` and never deal with
    this.
- Run `pi` inside a project folder and send your first prompt.
- Know pi's **four default tools**: `read`, `write`, `edit`, `bash`. (Three
  more — `grep`, `find`, `ls` — are built in but *off* by default; enable them
  with `--tools` later if you want — a flag meaning “turn these extra tools
  on.”)

> **What is a "tool call"?** Think of pi as a coworker you're chatting with
> over a messaging app. They can't touch your computer directly — but they
> have four tools on their desk: read a file, write a file, edit a file, run a
> command. Each **tool call** is them reaching for one and reporting back what
> they found. The text that scrolls by in the UI is their work log. You
> didn't need to know how to read a file or run a command — you just
> needed to know what to ask for. The skill that matters now is your
> judgment about what needs doing.

### Try it (the first 30 seconds)

This is the gentlest possible start — no environment variables, no project
assumptions:

1. In the `pi-practice` folder you made in Stage 0, run `pi`.
2. When it starts, type `/hotkeys` and press Enter. Glance at it — this is
   your in-app reference; you never need to memorize it. (It's your "panic
   button": everything you can do is listed there.)
3. If pi asks you to log in, run `/login` and pick your provider. Done.
4. Type one plain-English sentence: `"What files are in this folder?"` Press
   Enter. That's it — you're using pi. Watch the tool calls appear in the UI
   (that's pi reaching for its `bash` or `read` tool to look around).

**Check your understanding (predict, then run):** Before you run the next one,
predict — if you ask pi to create a tiny file *and then* read it back to you,
how many tool calls should appear in the UI? Run it and see if you were right.

**Then bridge back to the GUI:** open that same folder in your file browser
and see the file pi made. The terminal and your file browser are showing the
same thing — pi just got there by typing instead of clicking.

---

## Stage 1.5 — The moment this pays for itself

**Goal:** Feel the leverage — do one small thing that would've needed a
programmer (or an hour of manual cleanup) and watch it happen in plain
English.

**Outcome: You've watched the agent take a real judgment task off your plate,
end-to-end, no script written.**

So far you've installed pi and asked it to look around. Now do something
that would've been a ticket you filed with IT, or an hour of careful
find-and-replace, or — most likely — "I'll just live with it." The point
isn't the task itself; it's that your judgment about what needs doing is
now the scarce input. This is the payoff the opening of this guide
promised.

Here's a spreadsheet every knowledge worker has met: a column of
department tags where the same team is spelled five different ways. Create
this file in your `pi-practice` folder and call it `tags.csv`:

```csv
name,department
Alice,Marketing
Bob,marketing
Carol,Mktg
Dave,mktg.
Eve,MARKETING
Frank,Digital Mktg Team
Grace,Brand & Mktg
```

Seven rows, but the department column is a mess: "Marketing" appears
five ways (`Marketing`, `marketing`, `Mktg`, `mktg.`, `MARKETING`), and
the last two (`Digital Mktg Team`, `Brand & Mktg`) need a real decision,
not just a spelling fix.

Now send pi this one prompt:

> `tags.csv` has a column of department tags written five inconsistent ways.
> Standardize them all to one clean name, and use your judgment on the
> ambiguous ones — tell me what you chose and why.

Watch what happens. pi reaches for its `read` tool to open the file, then
its `bash` or `write` tool to put the cleaned version back. In between,
it *reasons*: those five spellings are all Marketing; `Digital Mktg Team`
really is Marketing (it's a team, under marketing); `Brand & Mktg` is
Marketing too (brand lives under marketing). The cleaned file lands with
a single consistent value in the column, and pi writes back a short
note explaining each call it made on the ambiguous rows.

> **This is the shape of the new power.** A spreadsheet formula can't do
> this — `=PROPER()` can't reason about "Brand & Mktg," and neither can a
> find-and-replace without you pre-listing every misspelling. That
> reasoning is *your* expertise: you know what these tags should be, and
> you know the ambiguous ones need a human decision. You didn't write a
> script, you didn't learn a formula, you didn't file a ticket. You
> applied judgment and the agent did the mechanical work at scale.
> Everything else in this guide is about doing more of this, more
> fluently.

### Try it

1. Create `tags.csv` in `pi-practice` with the content above.
2. Run `pi` and send the prompt. Watch the tool calls appear as pi reads,
   reasons, and writes.
3. Open `tags.csv` back up in your file browser — the column is clean, and
   pi's note explains its judgment calls. That's the whole thing.

Now that you've felt the payoff, the next stage is about working this way
fluidly — sessions, references, steering pi mid-task without waiting
around.

---

## Stage 2 — Core daily workflow (the 20% you'll use every day)

**Goal:** Work fluidly inside the interactive UI. This is the most important
stage.

**Outcome: You can hold a multi-turn session with pi, reference a file with
`@`, and abort or continue it.**

**Read:**
- Using Pi: `.../docs/usage.md` — the interactive UI, slash commands, message
  queue, sessions, context files.
- Sessions: `.../docs/sessions.md` — auto-save, `/tree` branching, `/fork`,
  `/clone`, `/resume`.
- Keybindings (skim, bookmark): `.../docs/keybindings.md`

### First pass — learn these, ignore the rest for now

- **Send a prompt and watch it work** — type, press Enter, watch tool calls.
- **Reference files:** type `@` in the editor to fuzzy-search (search that
  matches roughly by a few letters, like filtering a file list), or
  `pi @file.md "..."`.
- **Abort:** press `Escape` to cancel what pi is doing. Press it twice to open
  `/tree` fast.
- **Continue last session:** `pi -c` reopens your most recent session.

> **What is a "session"?** A session is like an open word-processor document —
> pi saves it automatically as you type, like auto-save in Google Docs. The
> folder `~/.pi/agent/sessions/` is just where those saved documents live. `pi
> -c` reopens the last one, like "Recent Files."

### Second pass — once the basics feel easy

- **Run shell commands from the editor:** `!command` (output sent to model) or
  `!!command` (output hidden from model).
- **Steer while working (the message queue).** This is the highest-value habit
  once you're past the first day:
  > Think of it like a hold-queue in a chat app: type now, it sends at the
  > right beat instead of interrupting pi mid-step.
  >
  > - `Enter` = "after this step" (**steer** — delivered after the current tool
  >   batch).
  > - `Alt+Enter` = "when you're all done" (**follow-up** — delivered after pi
  >   fully finishes).
  > - `Escape` = "stop now" (abort).
  >
  > Worked example: pi is editing 5 files. You press `Enter` and type "also
  > add comments." pi finishes file 3, then sees your note before starting
  > file 4.
- **Switch models / thinking:** `Ctrl+L` model picker, `Shift+Tab` cycle
  thinking level, `Ctrl+P` cycle scoped models (presets for specific task
  types).
- **Branch conversations:** `/tree` lets you jump to any earlier point and
  continue, keeping alternatives in one file.
  > Like "Track Changes → restore an earlier version and keep typing," but
  > both versions stay saved in the same file. It's pi's superpower for "let
  > me try a different approach" without losing anything.
- **Manage sessions:** `pi -c` (continue last), `pi -r` (browse), `/session`
  (info), `/name` (label it). Sessions auto-save to `~/.pi/agent/sessions/`.

### Try it

1. Start a session, work on something for a few turns, then `/tree` back to an
   early message and take a different path. Notice both branches are preserved.
2. *Then* (separately, so it's not subtle): while pi is mid-task, queue a
   steering message with `Enter`. Observe it's delivered at the right moment
   without you waiting idle.

> The full shortcut reference moved to the [Keybindings appendix](#keybindings-reference)
> so it doesn't crowd your first pass. You don't need to memorize it —
> `/hotkeys` shows it all in-app anytime.

---

## Stage 3 — Customize your setup (make pi fit *you*)

**Goal:** Configure pi so it behaves the way you want across projects.

**Outcome: You can put project rules in `AGENTS.md` and confirm pi follows
them.**

**Read:**
- Settings: `.../docs/settings.md`
- Context files + project trust: `.../docs/usage.md` (the "Context Files" and
  "Project Trust" sections) and `.../docs/security.md`
- Prompt templates: `.../docs/prompt-templates.md`
- Terminal setup (if anything looks off): `.../docs/terminal-setup.md`
- Themes (optional, skim): `.../docs/themes.md`

**Understand / be able to do:**
- **Context files (`AGENTS.md`):** pi loads `AGENTS.md` (or `CLAUDE.md`) from
  `~/.pi/agent/`, parent dirs, and the current folder. This is where your
  professional judgment gets encoded as instructions pi follows in every
  session — not a settings file for formatting, but the place you write down
  how *this* team defines "done," what matters here, and what good output looks
  like in your work.
  > It's a sticky note pinned to the project folder that pi reads every time
  > it walks in — but instead of "keep answers short," it holds your
  > judgment: "here's how we categorize these, here's what counts as a
  > blocker, here's what 'done' means for this deliverable." The most
  > leveraged single file in your setup — because it's the one place your
  > expertise becomes instructions the agent obeys automatically.
- **Settings files:** global `~/.pi/agent/settings.json` and project
  `.pi/settings.json` (overrides global). Use `/settings` for the common ones.
- **Project trust:** pi asks before loading a project's `.pi/` resources
  (extensions, skills, settings). This is an *input-loading* guard, **not a
  sandbox** — it won't make untrusted code safe. Approve with `/trust`.
  > (A sandbox is a sealed-off playpen where actions can't escape. Trust is
  > *not* that — it only decides whether pi reads the project's config files.)
- **Prompt templates:** drop a Markdown file in `~/.pi/agent/prompts/` (or
  `.pi/prompts/`) and invoke it with `/filename`. Great for repetitive prompts
  like code review or PR analysis. Templates can take arguments — for example
  `/review $1` lets you write `review.md` once and reuse it as
  `/review src/app.py`, where `$1` (the first argument) lands wherever you
  put it in the template, and `$@` means "all the arguments." (See
  `.../docs/prompt-templates.md` for the full syntax when you need it.)
  > A template is a reusable macro — a command you fire with `/name` — as
  > opposed to `AGENTS.md`, which shapes *every* session automatically.
- **Keybindings:** edit `~/.pi/agent/keybindings.json`, then `/reload`.
- **Themes:** JSON color files in `~/.pi/agent/themes/`; hot-reload while editing.

**Try it:**
1. Create an `AGENTS.md` in a project with 2-3 rules that encode how *you*
   think about the work — not formatting, but judgment. Imagine you summarize
   customer feedback for your team. You'd write rules like:
   - *"When summarizing customer feedback, always separate product complaints
     from service complaints — that's how this team sorts what to fix first."*
   - *"Flag any feedback mentioning the word 'churn,' 'cancel,' or 'leave' —
     those go to the top, because retention is our priority this quarter."*
   - *"Group complaints by feature, not by customer — we decide by where the
     pain clusters, not who complained loudest."*
   These aren't preferences; they're how you'd brief a new hire on the work.
   Restart pi and ask it to summarize some sample feedback — confirm it sorts,
   flags, and groups the way you wrote.
2. Make a prompt template `~/.pi/agent/prompts/review.md` and run `/review` in
   a session.

> **Notice what just happened.** The rules you wrote aren't formatting —
> they're your expertise, captured once and applied every time pi walks into
> this folder. This is the file where "your judgment is the power" stops being
> a claim and becomes a concrete file on disk. Remember the messy `tags.csv`
> in Stage 1.5, where your judgment about the ambiguous department tags was the
> scarce input? `AGENTS.md` is where you capture *that* kind of judgment once,
> so you don't re-explain it every session. The agent does the typing; you
> supply the judgment — and here you only have to supply it once.

**Check your understanding (explain back to yourself):** In one sentence, what
is the difference between `AGENTS.md` and a prompt template? *(Answer: AGENTS.md
shapes every session automatically; a template is a command you fire with
`/name` when you want it.)*

---

## Stage 4 — Leverage skills (huge in *this* project)

**Goal:** Use on-demand capability packages instead of only raw CLI. This
project is skill-heavy, so this stage matters more here than for most users.

**Outcome: You can invoke a skill by name with `/skill:name` and describe what
it did.**

**Read:**
- Skills: `.../docs/skills.md`

**Understand / be able to do:**
- A **skill** is a folder with a `SKILL.md` (frontmatter `name` + `description`
  + instructions). pi lists only descriptions in context (progressive
  disclosure) and loads the full instructions on demand.
  > "Frontmatter" just means a small labeled block at the very top of the
  > file, between two `---` lines, that holds metadata the tool reads before
  > the rest. For a skill it looks like this:
  > ```md
  > ---
  > name: my-skill          ← the name you invoke with /skill:my-skill
  > description: Does X     ← the one-line summary pi shows in its context
  > ---
  > (the full instructions pi loads on demand go below this line)
  > ```
  > pi keeps its desk tidy: it shows only each skill's one-line *description* in
  > its context, like a menu listing dish names. When you actually order
  > `/skill:name`, the full recipe (instructions) comes out. This keeps pi's
  > short-term memory from cluttering up with skills it isn't using.
  >
  > A skill is like a reusable macro / saved action in an app: it lives in a
  > folder and runs on demand.
- **Invoke explicitly:** `/skill:name` — forces the skill to load. Do this when
  you know you want a capability.
- **Auto-load:** the model reads a matching skill's `SKILL.md` when a task fits
  its description. Not always reliable — prefer explicit `/skill:name` when it
  matters.
- **Where skills live:**
  - Global: `~/.pi/agent/skills/` and `~/.agents/skills/`
  - Project (after trust): `.pi/skills/` and `.agents/skills/`
  - From packages and settings
- Skills can include helper scripts and reference docs; use relative paths from
  the skill folder.

**What's already available in *this* project** (don't reinvent — use these):

A couple of skills you can recognize as useful without any development
context:

- **`find-skills`** — tell it what you're trying to do in plain English; it
  suggests the skills that fit. It's the skill that makes the others findable.
- **`friction-log`** — jot down one thing that was annoying or slow about your
  day, in plain words; it files it away for later pattern-spotting. A sticky
  note for pain points, captured once.

There are roughly fifteen more — a web-search skill, a couple for recording
decisions, a few for the way *this* particular project organizes its work.
You don't need to know their names. Run `/skill:find-skills` when you have a
real task and it'll suggest ones that fit.

**Try it:**
1. Run `/skill:find-skills` and describe a small real task in plain English —
   something you'd actually do this week ("look up what's new in the latest
   release notes for my editor," "jot down the one thing that slowed me
   today," "draft a one-paragraph summary of a meeting I just had"). See what
   it suggests.
2. Pick one it suggests and invoke it on that real task with `/skill:name`.
   For example, `/skill:brave-search` to look something up, or
   `/skill:friction-log` to capture one pain point from your day. Watch it do
   something useful — read back what it produced.

> Every skill here was written by a human who captured their judgment in a
> Markdown file — you can write one too; it's a doc, not code. Your
> judgment, encoded once, applied every time.

Many capable people stop here, and that's a complete, working setup. If you
*want* to keep going, Stage 5 is where you make the tool itself a little
sharper — and that compounds.

---

## Stage 5 — Sharpen the tool (refine your environment)

**Goal:** Tune the tool to fit your hand — add a capability, change a
behavior, or share a setup with a teammate. The difference here is the
*subject* — you're now refining the tool itself, not just using it.

This is a flywheel, not a fork in the road. Stage 3 taught you one
sharpening move (a reusable prompt template), Stage 4 another (a skill),
and Stage 5 adds the third — a small extension, when nothing else fits.
Same judgment-and-direction work, pointed at a new target: a sharper tool
makes you more powerful, which lets you refine it further.

**Outcome: You can refine your environment to fit your work — add one small
extension from the examples and see it take effect.**

**Read:**
- Extensions (the big one): `.../docs/extensions.md`
- TUI components (if your extension needs UI): `.../docs/tui.md`
- Custom models / providers: `.../docs/models.md` and `.../docs/custom-provider.md`
- Pi packages (share your work): `.../docs/packages.md`
- Programmatic use: `.../docs/sdk.md` (SDK) and `.../docs/rpc.md` (RPC mode)
- Reference examples: `.../examples/extensions/` (~70 working extensions) and
  `.../examples/sdk/`

**Understand / be able to do:**
- An **extension** is a small file you drop in a folder to add a new button or
  behavior. It can register tools, commands, shortcuts, handle lifecycle
  events, replace UI, and more. Loaded from `~/.pi/agent/extensions/` or
  `.pi/extensions/`; test with `pi -e ./file.ts` (the `-e` flag means "load
  just this one extension file for this run" — handy to try a change in
  isolation before installing it properly).
  > An extension is like a browser extension or app plug-in: a file you drop in
  > a folder to add new buttons and behaviors.

  The file itself is written in TypeScript, and the top of it always looks
  like this:

  ```ts
  export default function (pi: ExtensionAPI) {
    // ...what the extension does...
  }
  ```

  Reading that line the way you read the `npm install` command back in
  Stage 1 — it's paste-in text where each piece means something specific:
  - `export default` = "this is the thing pi loads." (`export` you met in
    the glossary — "set this so other things can read it"; `default` just
    means "the main one in this file.")
  - `function (pi: ExtensionAPI)` = the function receives an API object,
    a handle pi hands you with methods like "register a tool" or "listen
    for an event." You name it `pi` by convention; it's the lever you pull
    inside the body.
  - The body `{ ... }` = what the extension actually does. *You* describe
    that behavior in plain English and pi writes it for you — you don't
    have to. (The same way you've asked pi to edit a config file all
    along: you say what you want, it does the typing.)

  So the whole flow is: tell pi the behavior you want in plain language, let
  it write the file into `~/.pi/agent/extensions/`, then restart pi (or run
  `pi -e ./file.ts` to test it in isolation) and see it take effect.
- Common extension patterns (all have example files): permission gates,
  git checkpointing, path protection, custom compaction, custom editors,
  status lines/widgets, subagents, games-while-waiting.
- **Custom models:** add Ollama/LM Studio/vLLM/proxies via
  `~/.pi/agent/models.json` if they speak OpenAI/Anthropic/Google APIs. For
  custom OAuth/APIs, write an extension (see `custom-provider-gitlab-duo`).
- **Packages:** bundle extensions+skills+prompts+themes, share via npm or git.
  `pi install npm:@foo/bar` or `pi install git:github.com/user/repo`.
- **SDK / RPC:** embed pi in your own app (`createAgentSession`, a single
  function call that starts a pi session from your code) or drive it as a
  subprocess over JSONL (`pi --mode rpc` — the `--mode rpc` flag tells pi to
  run without its chat UI and instead read and reply in structured text lines,
  so another program can steer it).

**Try it:**
1. Copy `.../examples/extensions/hello.ts` into `~/.pi/agent/extensions/`,
   restart pi, and run `/hello`.
2. Skim `.../examples/extensions/permission-gate.ts` and
  `git-checkpoint.ts` — these two patterns (confirm dangerous commands, auto-
  checkpoint with git) are the highest-value extensions for most people.

---

## Common pitfalls & concepts that trip people up

- **"pi has no sandbox."** It runs with your permissions and modifies files
  freely — no built-in undo (see [For leaders: what could go wrong](#for-leaders-what-could-go-wrong)
  for the full risk picture). The operator habit: commit a clean snapshot
  with `git status` showing nothing to commit before letting pi touch a
  folder, so `git restore .` undoes anything — nothing is permanent until you
  commit it yourself.
- **Confusing `/tree` vs `/fork` vs `/clone`.** `/tree` keeps alternatives in
  *one* file (in-place branching). `/fork` and `/clone` create *new* session
  files. Use `/tree` to explore; `/fork`/`/clone` to split off.
- **Expecting built-in sub-agents / plan mode / MCP / permission popups.** pi
  intentionally omits these. They're addable via extensions or packages (this
  project's `hierarchy` extension *is* a sub-agent system).
- **Forgetting skills auto-load unreliably.** The model won't always read a
  skill's `SKILL.md` on its own. When a capability matters, invoke it
  explicitly with `/skill:name`.
- **Project trust surprises.** A cloned repo with `.pi/` resources will prompt
  before loading them. Non-interactive modes (`-p`, `--mode json/rpc`) skip the
  prompt and follow `defaultProjectTrust` — use `-a`/`-na` to override per-run.
  (Here `-p` means "print/non-interactive mode" so pi doesn't wait for you to
  answer prompts; `--mode json/rpc` means "talk to me in structured text lines
  instead of the chat UI"; and `-a` / `-na` mean "answer yes" / "answer no" to
  the trust prompt for that one run.)
- **Editing config and expecting it to apply.** After editing keybindings,
  skills, extensions, prompts, themes, or context files, run `/reload` (or
  restart). Settings via `/settings` apply immediately.
- **Compaction is lossy (but recoverable).** Long sessions auto-summarize older
  messages to fit context. Full history stays in the JSONL file — use `/tree`
  to revisit. `/compact [instructions]` lets you steer the summary.
- **Windows Terminal `Alt+Enter`.** It's fullscreen by default; remap it (see
  `terminal-setup.md`) or you can't queue follow-up messages.

---

## Where to get help / next steps

- **In pi:** `/hotkeys` (all shortcuts — your panic button), `/changelog` (what's
  new), `/session` (current session info), `/help`-style commands.
- **Docs index:** `.../docs/index.md` and `.../docs/docs.json` list every doc.
- **Examples to learn from:** `.../examples/extensions/` (~70 extensions) and
  `.../examples/sdk/`.
- **Community:** pi Discord — link in the README header.
- **Philosophy (why pi is minimal):** read the linked blog post at the bottom of
  the README (`https://mariozechner.at/posts/2025-11-30-pi-coding-agent/`).
  Understanding *why* features are omitted makes the rest click.

**Suggested next steps after this guide:**
1. Finish Stages 0-3 — get a working `AGENTS.md` and a prompt template in place.
2. Try 2-3 global skills from this project's toolkit on real work.
3. Only then consider Stage 5 (extensions). Start by reading an example that
   matches a need you actually have, and adapt it.

---

## What you can now do that you couldn't before

Before this, a small automation that would save your team an hour a week
meant filing a ticket and waiting — maybe forever. Now you can describe
the thing in plain English and watch it get built in front of you, then
check it against what you know is right. That's the shift this guide was
about: your domain knowledge didn't get replaced, it got leveraged. The
agent handles the keystrokes; you decide whether the output is worth
keeping.

And it compounds. Every session teaches you a better way to ask, and
Stage 5 is where you sharpen the tool further — a reusable prompt here,
a skill there, a small extension when nothing else fits. Your judgment
gets more leveraged the more you use it, not less.

---

## Keybindings reference (appendix — look up, don't memorize)

You never need to memorize this; `/hotkeys` shows it all in-app. Here it is for
offline reference.

| Key | Action |
|-----|--------|
| `Ctrl+C` | Clear editor (twice = quit) |
| `Escape` | Cancel/abort (twice = open `/tree`) |
| `Ctrl+L` | Model selector |
| `Shift+Tab` | Cycle thinking level |
| `Ctrl+P` | Cycle scoped models |
| `Ctrl+O` / `Ctrl+T` | Collapse tool output / thinking blocks |
| `Ctrl+X` | Copy last assistant message |
| `Ctrl+G` | Open external editor |
| `Enter` | Queue a steering message |
| `Alt+Enter` | Queue a follow-up message |
