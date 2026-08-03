# Before the course: setting up your computer

<!-- Chunk: docs/chunks/onboarding_setup_guide - Pre-cohort participant setup guide -->

Welcome. This page takes you from a laptop with nothing installed to a laptop
that is ready for the first session. It should take about **30 minutes**, most
of which is waiting for downloads.

**You do not need to understand any of this.** Every step is a line you copy
and paste, followed by a picture of what you should see afterwards. If what
you see matches, move on. If it doesn't, the last section of this page tells
you what to do. Nothing here requires you to have used a terminal before —
that gets taught properly in Session 2, with a facilitator in the room.

The one thing worth knowing up front: you are about to install a **terminal**,
which is an app where you type instructions instead of clicking them. It looks
severe and it is not. The blinking cursor isn't waiting for permission —
it's waiting for you, and nothing happens until you press Enter.

---

## What this costs you: nothing

Your facilitator has given you a key that pays for everything you do on this
course. There is no account to create, no credit card to enter, no
subscription to choose, and no bill coming to you. The key has a spending
limit on it and it is not yours to worry about.

If any page ever asks you to enter payment details during this setup, stop —
you have gone somewhere you shouldn't be. Nothing in these instructions
requires it.

---

## What you need before you start

- **A laptop you can install software on** — macOS or Windows. If your
  employer manages the machine and blocks installations, tell your
  facilitator now rather than at the first session; it takes a few days to
  sort out.
- **An email from your facilitator** containing two things: your personal
  key (a long line starting with `sk-or-`) and the exact command from Step 3
  below with that key already filled in.
- **About 30 minutes**, and a decent internet connection.
- On a Mac, you will be asked once for **the password you use to log in to
  the computer**. That is normal — it's how macOS lets an installer put
  software on the machine. No other password is ever needed.

---

## A word about copying and pasting

You'll be pasting commands into a terminal window. Pasting works, but the
keyboard shortcut is not always the one you expect:

| | To paste into the terminal |
|---|---|
| **macOS** | `Command + V`, as usual |
| **Windows** | `Ctrl + Shift + V`, **or** just right-click |

On Windows, plain `Ctrl+V` sometimes does nothing in a terminal. That is the
one keyboard difference in this whole guide.

Paste the command, then press **Enter**. Nothing runs until you do.

---

## Step 1 — Install the course environment

This installs the terminal app the course uses, plus the handful of things it
needs underneath. Follow the section for your computer and skip the other one.

> **Facilitator: before you send this page to anyone**, the three install
> commands on it (two here, one in Step 3) contain `REPLACE-ME` and will not
> work as written. Publish the repository and substitute the real address
> first — see item 1 of
> [PRE_COHORT_CHECKLIST.md](PRE_COHORT_CHECKLIST.md) and
> [../env/DISTRIBUTION.md](../env/DISTRIBUTION.md).

### On a Mac

**1a.** Open the app called **Terminal**. It is already on your Mac: press
`Command + Space`, type `Terminal`, and press Enter. A small window with a
blinking cursor appears. (This is *not* the terminal you'll use for the
course — it's just the one that's already there, and we use it once to
install the real one.)

**1b.** Paste this single line and press Enter:

```bash
curl -fsSL https://raw.githubusercontent.com/REPLACE-ME/agentic-101/main/env/install.sh | bash
```

**1c.** Wait. It will print a lot, ask once for your login password, and take
several minutes the first time. When it finishes you should see something
very like this at the bottom:

```
Course environment 1.0.0

  [ok]   commit is ready (/Users/you/.agentic-101/bin/commit)
  [ok]   revert is ready (/Users/you/.agentic-101/bin/revert)
  [ok]   git is installed (git version 2.50.1 (Apple Git-155))
  [ok]   node is installed (v22.20.0)
  [ok]   bash is the shell (3.2.57(1)-release)
  [ok]   Ghostty is configured for pi's keyboard shortcuts

PASS — your course environment is ready.

You're set up. One last thing:
  Open Ghostty (press Command+Space, type Ghostty, press Enter).
  Everything you do in the course happens in that window.
```

The version numbers on your machine may differ slightly. What matters is the
word **PASS**. If you got FAIL, jump to [If something went
wrong](#if-something-went-wrong).

### On Windows

**1a.** Open **PowerShell**. Click Start, type `PowerShell`, and press Enter
on "Windows PowerShell". A blue window with a blinking cursor appears. (This
is *not* the terminal you'll use for the course — it's just the one Windows
already has.)

**1b.** Paste this single line and press Enter (remember: `Ctrl + Shift + V`
or right-click to paste):

```powershell
powershell -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/REPLACE-ME/agentic-101/main/env/install.ps1 | iex"
```

**1c.** Wait. Windows may show an installer progress bar or two. When it
finishes you should see the same `[ok]` list and the word **PASS**, followed
by:

```
You're set up. One last thing:
  Close every Windows Terminal window, then open Windows Terminal again
  (Start menu -> type "Terminal" -> Enter). It will open a Git Bash tab.
  Everything you do in the course happens in that window.

  Do NOT use the "Git Bash" icon in the Start menu — pi behaves worse there.
```

That last line matters. There are two things on your Start menu that look
like they'd work; only **Windows Terminal** is the right one. If you got FAIL,
jump to [If something went wrong](#if-something-went-wrong).

---

## Step 2 — Open the course terminal

Close the window from Step 1 completely. From here on, everything happens in
the course terminal.

**On a Mac:** press `Command + Space`, type `Ghostty`, press Enter.

**On Windows:** click Start, type `Terminal`, press Enter on **Windows
Terminal**. (Not "Git Bash". Not "Command Prompt".)

Either way you should get a window showing a short line that ends with a
`$`, with the cursor blinking after it. It looks like this — the `~` (which
names the folder you're in) appears in blue:

```
~ $
```

That `$` is the prompt. It means the terminal is ready for you to type. If
your window looks nothing like that, or the app didn't open, see [If
something went wrong](#if-something-went-wrong).

---

## Step 3 — Install pi and save your key

**pi** is the agent you'll be using — the actual subject of the course. This
step installs it, saves the key your facilitator emailed you, and sets it to
the same model everyone else on the course is using, so that when a
facilitator says "you should see X", you do.

**3a.** Find the email from your facilitator. It contains one long line that
starts with `curl` and has your personal key in the middle of it. Copy that
whole line — it is written for you specifically, so use theirs rather than
retyping the one below.

It will look like this, with a real key where the placeholder is:

```bash
curl -fsSL https://raw.githubusercontent.com/REPLACE-ME/agentic-101/main/setup/install-pi.sh | bash -s -- --key PASTE-YOUR-KEY-HERE
```

**3b.** Paste it into the course terminal and press Enter.

**3c.** It installs pi, saves your key, makes you a practice folder, and
then runs the check from Step 4 automatically. While pi downloads,
**nothing appears on screen for a minute or two** — the window will look
frozen. That is normal; don't close it. You should see:

```
Setting up pi for the agentic-101 course
This installs pi 0.83.0, saves the key your facilitator gave you, and
sets the model everyone on the course uses.

Step 1 of 5 — checking your machine
  course environment 1.0.0 — found
  node v22.20.0 — found
  key sk-or-v1-a… — looks right

Step 2 of 5 — installing pi 0.83.0
  Downloading pi. This usually takes a minute or two, and
  nothing at all will appear on screen while it runs.
  That is normal. Do not close this window.
  pi installed
  pi reports version 0.83.0 — matches the pin

Step 3 of 5 — setting the model everyone on the course uses
  provider openrouter, model anthropic/claude-sonnet-5, thinking medium
  Model configured

Step 4 of 5 — saving your key
  Key saved to /Users/you/.pi/agent/auth.json
  Only you can read that file. You never need to type the key again.

Step 5 of 5 — making your practice folder
  Created /Users/you/course-practice
```

and then, without you doing anything, it runs the check described in Step 4
and finishes with either

```
That's setup finished. Nothing else to do before the first session.
```

or a line telling you setup is *not* finished, in which case read Step 4 and
the troubleshooting section below.

You never have to type or remember that key again. It is saved in a file only
your account can read.

---

## Step 4 — Check that everything works

Step 3 runs this check for you, so you have probably already seen it. Run it
yourself now anyway — it is the command to reach for any time something seems
broken, and it costs nothing to run.

Type this and press Enter:

```bash
course-smoke-test
```

This is the only moment in setup where something talks to the model over
the internet. The two model checks can be slow — **give it up to four
minutes**, and expect quiet pauses after each "asking the model…" line.
What you want:

```
Checking your course setup

  [ok]   the course environment is healthy (commit, revert, git, node)
  [ok]   pi is installed, version 0.83.0
  [ok]   pi is set to the course model (openrouter, anthropic/claude-sonnet-5)
  [ok]   your key is saved and only readable by you
  [--]   asking the model a question — this can take up to a minute…
  [ok]   your key works and anthropic/claude-sonnet-5 answered
  [--]   asking the agent to do a small task — this can take a few minutes…
  [ok]   the agent did a real task: it created a file when asked

PASS — you are ready for the course.
Nothing else to do. Your practice folder is /Users/you/course-practice.
```

**If the last line says PASS, you are finished.** Close the window and come to
the first session. Nothing else is expected of you.

That fifth and sixth check are worth a moment of your attention, because
they're the first thing you'll see the agent do: the fifth asks the model a
question and waits for the right answer back, and the sixth asks the agent to
*create a file* and then goes and looks on your disk to see whether it really
did. That second one is the course in miniature — the agent did something
real, and we checked the result rather than taking its word for it.

---

## If something went wrong

Nothing in this list is your fault, and none of it is unusual. Find the line
that matches what you saw.

**Before anything else, try the fix that solves most of these:** close every
terminal window, open the course terminal again (Step 2), and run
`course-smoke-test`. Newly installed commands often only appear in windows
opened *after* the install.

| What you saw | What to do |
|---|---|
| `bash: course-smoke-test: command not found` | Close the window, open the course terminal again (Step 2), and retype it. If it still says that, Step 3 didn't finish — run it again. |
| Nothing happened when I pasted | Press **Enter**. The terminal waits for it. If nothing pasted at all, use the right shortcut: `Command+V` on Mac, `Ctrl+Shift+V` or right-click on Windows. |
| `unknown option` right after pasting the Step 3 line | Your email program split the long line in two — the second half of your key became a separate command. Ask your facilitator to resend it as a single line (or copy it from the attachment instead), and paste again. |
| `[no] the course environment has a problem` | Run Step 1 again, then close every terminal window and open a new one. |
| `[no] pi is not installed` | Close the window, open the course terminal again, and run Step 3 again. |
| `[no] pi is version …, but this course uses …` | Run Step 3 again — it installs the exact version the course expects. If it comes back, send a screenshot. |
| `[no] pi is not set to the course model` or `pi's course settings are missing` | Run Step 3 again (it rewrites the settings), then `course-smoke-test`. |
| `[no] your key is not saved` | Run Step 3 again, using the exact line from your facilitator's email — the whole line, including the key at the end. |
| `[no] could not reach the model` | Check you're online (load any web page). If you are, your key may not be switched on yet — send your facilitator a screenshot. |
| `[no] the model did not answer within …` or `the agent did not finish within …` | Usually a slow connection or a busy model. Run `course-smoke-test` once more; if it happens twice, send a screenshot. |
| `[no] the model replied, but not as expected` | Run `course-smoke-test` once more. If it happens twice, send your facilitator the lines it printed. |
| `[no] the agent ran but did not create the file` | Run `course-smoke-test` once more. Agents are not perfectly repeatable, and a single retry usually settles it. If it fails twice, send a screenshot. |
| Step 1 asked for a password | Type the password you use to log in to the computer. It won't show any characters as you type — that's normal, keep typing and press Enter. |
| macOS says Ghostty "cannot be opened" | Right-click the Ghostty icon in your Applications folder and choose **Open**, then confirm. macOS only asks this the first time. |
| Windows: I opened "Git Bash" from the Start menu | Close it. Open **Windows Terminal** instead (Start → type `Terminal`). They look similar; only one is set up for the course. |
| Windows: something about winget being blocked | Your employer's IT settings are blocking installations. Send your facilitator the message you saw — this needs sorting before the first session. |

**If none of these match, or you tried the fix and it didn't help:** take a
screenshot of the whole terminal window and send it to your facilitator. Do
that sooner rather than later — setup problems are expected, they're quick to
diagnose from a screenshot, and there is nothing to be gained by struggling
alone the night before session one. A confused participant is a bug in these
instructions, not a bug in you.

---

## What just got installed on your computer

The honest inventory, because you should know what's on your own machine:

| | What it is |
|---|---|
| **Ghostty** (Mac) or **Windows Terminal** (Windows) | The terminal app the course uses. On Windows it's usually already there. |
| **Node.js** and **git** | Two pieces of plumbing pi needs. Widely used, uncontroversial, quiet. |
| **`~/.agentic-101/`** | A folder holding the course's own commands: `commit`, `revert`, `course-check`, `course-smoke-test`. |
| **pi** (`@earendil-works/pi-coding-agent`) | The agent itself — the subject of the course. |
| **`~/.pi/agent/`** | pi's own settings folder: the course model configuration, and your key in a file only your account can read. |
| **`~/course-practice/`** | Your practice folder. A normal folder — you can open it in Finder or File Explorer. Everything you do on the course happens here. |

A few small edits are also made to the settings files that control how your
terminal starts up and how it handles the keyboard — so the course commands
are there when you open a window, and so pi's shortcuts work. Each edit is a
clearly marked block in a file that is backed up before it is touched, and
each is reversible.

Nothing runs in the background. Nothing starts when your computer starts.

**To remove all of it later** takes two steps, and it's worth being precise
about what each one removes:

1. The environment uninstaller described in
   [../env/README.md](../env/README.md) removes the course commands
   (`commit`, `revert`, `course-check`) and undoes the terminal edits.
2. That still leaves the pieces this page installed. To remove those too:

   ```bash
   npm uninstall -g @earendil-works/pi-coding-agent   # removes pi
   rm -rf ~/.pi                                       # removes pi's settings AND your saved key
   rm -rf ~/course-practice                           # removes your practice folder and its contents
   ```

   The `~/.pi` folder is the important one: **your course key is stored
   there**, and no uninstaller touches it automatically. If you only do
   step 1, the key stays on your computer.

Both steps deliberately leave Node, git, and the terminal app alone —
those may be things you now use for other reasons, and removing them isn't
ours to decide.

---

## Two things to know for the first session

**Your practice folder.** To get to it in the terminal, type:

```bash
cd ~/course-practice
```

**The safety net.** pi can change and delete files, and it has no undo button.
That's why the course lives in one folder and why you have two commands:
`commit` saves a checkpoint of your practice folder, and `revert` puts it
back the way it was. You'll be taught both properly in Session 2 — for now,
just know they exist and that nothing you do is permanent.

---

## For facilitators

Everything on this page assumes the operator-side work is done. Before
sending this to a cohort, work through
[PRE_COHORT_CHECKLIST.md](PRE_COHORT_CHECKLIST.md) — it covers publishing the
installers (without which the commands in Steps 1 and 3 do not work),
re-pinning versions, per-key spend limits, and the dry-runs that are still
outstanding. Current testing status is in [DRY_RUN.md](DRY_RUN.md) and
[../env/FLOOR_TEST.md](../env/FLOOR_TEST.md).

[pins.env](pins.env) is the authority on which pi and which model a cohort
runs — the scripts read it, so changing a pin is a one-file edit. The sample
outputs on this page quote those pins as literal text, so re-pinning means
updating the expected-output blocks in Steps 3 and 4 too. The checklist says
so at the point where it matters.
