# Before the course: setting up your computer

<!-- Chunk: docs/chunks/onboarding_setup_guide - Pre-cohort participant setup guide -->
<!-- Facilitators: before sending this page, work through
     PRE_COHORT_CHECKLIST.md. Item 1 verifies the three install commands on
     this page (two in Step 1, one in Step 3) from a machine with no checkout;
     env/DISTRIBUTION.md lists every place the repository address lives.
     setup/pins.env sets which pi and which model the course runs, and the
     sample outputs in Steps 3 and 4 quote those pins as literal text, so
     re-pinning means updating them too. Testing status: DRY_RUN.md and
     ../env/FLOOR_TEST.md. -->

**Time:** about 30 minutes, most of it waiting for downloads.

Each step is a line to copy and paste, followed by what your screen should
show afterwards. If your screen matches, go on. If it doesn't, see [If
something went wrong](#if-something-went-wrong).

You will install a **terminal**: an app where you type instructions instead
of clicking. Nothing runs until you press Enter. Session 2 teaches you how to
use it.

---

## What this costs you: nothing

The key you are given pays for everything you do on this course. There is no
account to create, no credit card and no bill. The key has a spending limit
set by your instructor.

Nothing in this guide asks for payment details. If a page does, stop and
close it.

---

## What you need before you start

- **A Mac or Windows laptop you can install software on.** If your employer
  blocks installations, tell your instructor before you start; it can take a
  few days to sort out.
- **Your setup command:** one line that starts with `curl` and has your
  personal key in it (the key starts with `sk-or-`). Your course setup page
  shows it once, at Step 3; if your instructor emailed it to you, it is in
  that email.
- **About 30 minutes** and a working internet connection.
- **On a Mac, the password you use to log in to the computer.** The installer
  asks for it once. Nothing else asks for a password.

---

## A word about copying and pasting

| | To paste into the terminal |
|---|---|
| **macOS** | `Command + V` |
| **Windows** | `Ctrl + Shift + V`, or right-click |

On Windows, plain `Ctrl + V` sometimes does nothing in a terminal.

Paste the command, then press **Enter**.

---

## Step 1 — Install the course environment

This installs the terminal app the course uses and the tools it needs. Follow
the section for your computer.

### On a Mac

**1a.** Open **Terminal**: press `Command + Space`, type `Terminal`, press
Enter. You use this window once, to install the course terminal.

**1b.** Paste this line and press Enter:

```bash
curl -fsSL https://raw.githubusercontent.com/netguy204/agentic-101/main/env/install.sh | bash
```

**1c.** Wait. It prints a lot, asks once for your login password, and takes
several minutes. When you type the password, no characters appear; type it
and press Enter. It should end with something like this:

```
Course environment 1.1.0

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

Your version numbers may differ. Look for **PASS**. If you see FAIL, go to
[If something went wrong](#if-something-went-wrong).

### On Windows

**1a.** Open **PowerShell**: click Start, type `PowerShell`, press Enter on
"Windows PowerShell". You use this window once, to install the course
terminal.

**1b.** Paste this line and press Enter:

```powershell
irm https://raw.githubusercontent.com/netguy204/agentic-101/main/env/install.ps1 | iex
```

**1c.** Wait. Windows may show an installer progress bar or two. It should
end with the same `[ok]` list, the word **PASS**, and then:

```
You're set up. One last thing:
  Close every Windows Terminal window, then open Windows Terminal again
  (Start menu -> type "Terminal" -> Enter). It will open a Git Bash tab.
  Everything you do in the course happens in that window.

  Do NOT use the "Git Bash" icon in the Start menu — pi behaves worse there.
```

Use **Windows Terminal**. The "Git Bash" icon in the Start menu looks similar
but is not set up for the course. If you see FAIL, go to [If something went
wrong](#if-something-went-wrong).

---

## Step 2 — Open the course terminal

Close the window from Step 1. From now on, use the course terminal.

**On a Mac:** press `Command + Space`, type `Ghostty`, press Enter.

**On Windows:** click Start, type `Terminal`, press Enter on **Windows
Terminal**. Do not use "Git Bash" or "Command Prompt".

You should see a short line ending in `$`, with the cursor after it. The `~`
names the folder you are in and appears in blue:

```
~ $
```

The `$` means the terminal is ready for you to type. If the app didn't open,
or the window looks nothing like this, go to [If something went
wrong](#if-something-went-wrong).

---

## Step 3 — Install pi and save your key

**pi** is the agent you use throughout the course. This step installs it,
saves your key, and sets the model the course uses, so your screen matches
the course material.

**3a.** Copy your setup command (see [What you need before you
start](#what-you-need-before-you-start)). Copy the whole line. Use your own
line; the one below has a placeholder where your key goes:

```bash
curl -fsSL https://raw.githubusercontent.com/netguy204/agentic-101/main/setup/install-pi.sh | bash -s -- --key PASTE-YOUR-KEY-HERE
```

**3b.** Paste it into the course terminal and press Enter.

**3c.** Wait. While pi downloads, **nothing appears on screen for a minute
or two**. Don't close the window. You should see:

```
Setting up pi for the agentic-101 course
This installs pi 0.83.0, saves the key your facilitator gave you, and
sets the model everyone on the course uses.

Step 1 of 5 — checking your machine
  course environment 1.1.0 — found
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

It then runs the course check by itself. The check talks to the model over
the internet, so **give it up to four minutes**; it pauses after each
"asking…" line. You should see:

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

That's setup finished. Nothing else to do before the first session.
```

If the last line says setup is *not* finished, go to [If something went
wrong](#if-something-went-wrong).

Your key is now saved in a file only your account can read. You don't type
it again.

---

## Step 4 — Check that everything works

The check at the end of Step 3 is also a command you can run any time
something seems broken. It costs you nothing. Run it now:

```bash
course-smoke-test
```

It prints the same list as the end of Step 3 (give it up to four minutes)
and ends with:

```
PASS — you are ready for the course.
Nothing else to do. Your practice folder is /Users/you/course-practice.
```

The last two checks ask the model a question, then ask the agent to create a
file and look on your disk to confirm the file is there.

**Done when:** the last line says **PASS**. Copy the whole terminal window
(select all of it, then copy) and paste it into the last step of your course
setup page. Session 1 opens once it is accepted.

---

## If something went wrong

First try this, which fixes most problems: close every terminal window, open
the course terminal again (Step 2), and run `course-smoke-test`. New commands
often only work in windows opened after the install.

Otherwise, find the line that matches what you saw.

| What you saw | What to do |
|---|---|
| `bash: course-smoke-test: command not found` | Close the window, open the course terminal again (Step 2), and retype it. If it still says that, Step 3 didn't finish. Run Step 3 again. |
| Nothing happened when I pasted | Press **Enter**. If nothing pasted, use `Command + V` on a Mac, or `Ctrl + Shift + V` or right-click on Windows. |
| `unknown option` right after pasting the Step 3 line | The line was split in two, so the end of your key ran as a separate command. Copy it again as a single line. If it came by email, copy it from the attachment, or ask your instructor to resend it as one line. |
| `[no] the course environment has a problem` | Run Step 1 again, then close every terminal window and open a new one. |
| `[no] pi is not installed` | Close the window, open the course terminal again, and run Step 3 again. |
| `[no] pi is version …, but this course uses …` | Run Step 3 again; it installs the version the course uses. If the message comes back, contact your instructor. |
| `[no] pi is not set to the course model` or `pi's course settings are missing` | Run Step 3 again, then `course-smoke-test`. |
| `[no] your key is not saved` | Run Step 3 again with your whole setup command, including the key at the end. |
| `[no] could not reach the model` | Check you're online by loading any web page. If you are, your key may not be active yet. Contact your instructor. |
| `[no] the model did not answer within …` or `the agent did not finish within …` | Usually a slow connection or a busy model. Run `course-smoke-test` again. If it happens twice, contact your instructor. |
| `[no] the model replied, but not as expected` | Run `course-smoke-test` again. If it happens twice, contact your instructor. |
| `[no] the agent ran but did not create the file` | Run `course-smoke-test` again. The agent doesn't behave identically every run, and one retry usually passes. If it fails twice, contact your instructor. |
| `course-update` says it could not reach the course updates | Check you can load a web page and try once more. If it still fails, carry on and tell your instructor; nothing on your computer was changed. |
| The installer asked for a password | Type the password you use to log in to the computer. No characters appear as you type. Press Enter when done. |
| macOS says Ghostty "cannot be opened" | In your Applications folder, right-click Ghostty, choose **Open**, then confirm. macOS asks this only the first time. |
| Windows: I opened "Git Bash" from the Start menu | Close it and open **Windows Terminal** (Start, type `Terminal`). |
| Windows: a message about winget being blocked | Your employer's IT settings block installations. Send the message to your instructor; this has to be fixed before Session 1. |

**Contacting your instructor.** On your course setup page, under "Stuck on
any step?", choose "Ask the TA". The TA is automated; a person answers within
a day. Copy the whole terminal window and paste it in, with the step you were
on. Ask early: a setup problem is quick to diagnose from the terminal text.

---

## What just got installed on your computer

| | What it is |
|---|---|
| **Ghostty** (Mac) or **Windows Terminal** (Windows) | The terminal app the course uses. Windows usually has it already. |
| **Node.js** and **git** | Two widely used tools pi needs. |
| **`~/.agentic-101/`** | A folder with the course's own commands: `commit`, `revert`, `course-check`, `course-update`, `course-smoke-test`. |
| **pi** (`@earendil-works/pi-coding-agent`) | The agent. |
| **`~/.pi/agent/`** | pi's settings: the course model, and your key in a file only your account can read. |
| **`~/course-practice/`** | Your practice folder. You can open it in Finder or File Explorer. Your course work happens here. |

The installer also adds a marked block to the files that control how your
terminal starts and handles the keyboard, so the course commands are
available and pi's shortcuts work. Each file is backed up before it is
changed, and each change can be undone.

Nothing runs in the background, and nothing starts when your computer
starts.

**To remove everything later:**

1. Run the environment uninstaller described in
   [../env/README.md](../env/README.md). It removes the course commands
   (`commit`, `revert`, `course-check`) and undoes the terminal changes.
2. Remove pi, its settings and your practice folder:

   ```bash
   npm uninstall -g @earendil-works/pi-coding-agent   # removes pi
   rm -rf ~/.pi                                       # removes pi's settings AND your saved key
   rm -rf ~/course-practice                           # removes your practice folder and its contents
   ```

   Your course key is stored in `~/.pi`. The uninstaller does not remove
   it.

Neither step removes Node, git or the terminal app, in case you use them for
other things.

---

## Three things to know for the first session

**Your practice folder.** To go to it in the terminal, type:

```bash
cd ~/course-practice
```

**The safety net.** pi can change and delete files, and it has no undo. Two
course commands give you one: `commit` saves a checkpoint of your practice
folder, and `revert` puts it back to the last checkpoint. Session 2 teaches
both.

**Getting updates.** From Session 2 on, start each session by typing
`course-update`. It fetches any fixes in a few seconds, and says *Nothing to
do* when there are none. You don't need to run it now.
