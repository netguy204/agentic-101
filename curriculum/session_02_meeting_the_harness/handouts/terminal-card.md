# The card: everything the course asks you to type

<!-- Chunk: docs/chunks/fluency_session_02 - Session 2 terminal and pi reference card -->

Print this page or keep it open beside the terminal. You don't need to
remember any of it.

- **Nothing happens until you press Enter.** If you typed something and
  nothing happened, press Enter.
- **Don't type the `$`.** It's already on the screen; it means the
  terminal is ready.

---

## Moving around

| You want to… | Type this | With a mouse |
|---|---|---|
| Know which folder you're in | `pwd` | Read the window's title |
| See what's in this folder | `ls` | Look at the icons |
| Go to your practice folder | `cd ~/course-practice` | Double-click your way in |
| Go up one level | `cd ..` | The back arrow |
| Go home | `cd ~` | Click your name in the sidebar |
| Make a new empty file | `touch notes.txt` | Right-click → New Text Document |
| Open this folder in your file browser | `open .` (Mac) `explorer .` (Windows) | — |

`pwd`, `ls` and `cd` only look. They can't change or delete anything.

## Recovering ordinary local file changes

| You want to… | Type this |
|---|---|
| Save a snapshot of this folder as it is right now | `commit` |
| Put this folder back to one of those snapshots | `revert` |
| Get the latest course fixes (start of every session) | `course-update` |

Both ask their questions in plain English.

- **`commit` before the agent edits files.** That lets you recover the
  files. It doesn't control what data is sent or undo anything outside the
  folder.
- If you have unsaved changes, `revert` offers to save them first. **Press
  Enter to accept**, so the thing you're undoing can itself be undone.
- The list is **newest first**, and `revert` adds one to the top as it
  goes. **Read the names, not the numbers.**
- If you go back too far, run `revert` again and pick a later checkpoint.

## Working with pi

| You want to… | Type this |
|---|---|
| Start the agent in this folder | `pi` |
| Continue the last conversation | `pi -c` |
| Leave it | `/quit` |

After `pi`, wait for the pi screen, then type plain-sentence requests in
the box at the bottom. Type `/quit` to get back to the terminal before
using `commit`, `revert`, `pwd` or `ls`.

| Key | What it does |
|---|---|
| **Enter** | Send what you typed |
| **Escape** | Stop pi's current work; then check what already changed |
| **Ctrl+O** | Collapse or expand the tool boxes |
| **Ctrl+C**, twice | Quit in a hurry |

### The four tools

Each thing the agent does appears as a box, using one of four tools:

| Tool | What it means |
|---|---|
| `read` | It opened a file and looked at it |
| `write` | It created a file, or replaced one completely |
| `edit` | It changed part of a file |
| `bash` | It ran a command: moved, renamed, listed, searched |

The boxes show what the agent did. Then open the file to see the result.
The paragraph it writes afterwards describes what it meant to do; don't
use it as proof.

**Privacy:** what you type, and the contents of files pi reads, are sent to
the model provider. A checkpoint doesn't prevent that.

## When you feel lost

| | |
|---|---|
| Something is running and you want it to stop | **Ctrl+C** (terminal) or **Escape** (pi), then check what already changed |
| The screen is a mess | `clear` |
| You don't know where you are | `cd ~/course-practice`, then `pwd` |
| A file is wrong and you want it back | `revert` |
| A wall of red text appeared | Usually a typo. `cd ~/course-practice` and type the line again. |
| Nothing happened | Press Enter. |

Use only the named files in `~/course-practice`. The folder is not a
security boundary. `revert` recovers checkpointed file changes; it can't
undo something sent or done outside the folder.
