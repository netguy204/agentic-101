# The card: everything the course asks you to type

<!-- Chunk: docs/chunks/fluency_session_02 - Session 2 terminal and pi reference card -->

One page. Print it, keep it next to the laptop, and stop trying to remember
any of it. There is nothing on this card you are expected to know by heart —
that is what the card is for.

Two rules before the table:

> **The blinking cursor isn't waiting for permission. It's waiting for you.**
> Nothing happens until you press Enter. If you typed something and nothing
> happened, you forgot to press Enter. This is the most common thing that
> goes wrong, and it happens to everyone.

> **You never type the `$`.** It's already on the screen. It's the terminal
> saying "ready".

---

## Moving around: the same things you do by clicking

Everything here is something you already do in Finder or File Explorer. The
terminal just uses typed words instead of clicks.

| You want to… | Type this | What you'd do with a mouse |
|---|---|---|
| Know which folder you're in | `pwd` | Read the title of the open window |
| See what's in this folder | `ls` | Look at the icons in the window |
| Go to your practice folder | `cd ~/course-practice` | Double-click your way into it |
| Go up one level | `cd ..` | The back arrow |
| Go home | `cd ~` | Click your name in the sidebar |
| Make a new empty file | `touch notes.txt` | Right-click → New Text Document |
| Open this folder in your file browser | `open .` (Mac) `explorer .` (Windows) | — |

`pwd`, `ls` and `cd` only *look*. They cannot change or delete anything. If
you are ever unsure where you are or what's around you, run them freely —
there is no cost and no risk.

## Recovering ordinary local file changes

| You want to… | Type this |
|---|---|
| Save a snapshot of this folder as it is right now | `commit` |
| Put this folder back to one of those snapshots | `revert` |

Both walk you through it in plain English. A few things worth knowing:

- **Checkpoint before the agent edits local files.** `commit`, *then* let it
  work. This helps you recover those file changes; it does not control what
  data is sent or undo an external action.
- `revert` will notice if you have changes it hasn't saved and offer to save
  them first. **Press Enter to accept** — it means even the thing you're
  undoing stays undoable.
- The checkpoint list is **newest first**, and `revert` adds one to the top
  on its way past. **Read the names, not the numbers.**
- Reverting is itself recoverable. If you go back too far, run `revert` again
  and pick a later checkpoint, provided the checkpoint history still exists.

## Working with pi

| You want to… | Type this |
|---|---|
| Start the agent, here in this folder | `pi` |
| Come back to the conversation you were having | `pi -c` |
| Leave it | `/quit` |

After you type `pi` and press Enter, wait for the pi screen. You are no
longer at the terminal prompt: type plain-sentence requests into the box at
the bottom. Nothing here needs to be memorised. Type `/quit` to return to the
terminal before using `commit`, `revert`, `pwd`, or `ls`.

| Key | What it does |
|---|---|
| **Enter** | Send what you typed |
| **Escape** | Ask pi to stop its current work; inspect what already changed |
| **Ctrl+O** | Collapse or expand the tool boxes when the screen gets busy |
| **Ctrl+C**, twice | Quit in a hurry |

### The four tools

When the agent does something, it does it with one of four tools, and each
one shows up on your screen as a box:

| Tool | What it means |
|---|---|
| `read` | It opened a file and looked at it |
| `write` | It created a file, or replaced one completely |
| `edit` | It changed part of a file |
| `bash` | It ran a command — moved, renamed, listed, searched |

Those boxes are the agent's work log: evidence of the actions it requested.
Then inspect the actual file. The paragraph afterwards describes what the
agent meant to do; do not use that paragraph as proof of the result.

**Privacy:** what you type, and the contents of files pi reads, are sent to
the model provider so it can respond. A checkpoint does not prevent that
transmission.

## When you feel lost

| | |
|---|---|
| Something is running and you want it to stop | **Ctrl+C** (in the terminal) or **Escape** (in pi), then inspect what already changed |
| The screen is a mess | `clear` |
| You have no idea where you are | `cd ~/course-practice`, then `pwd` |
| A file is wrong and you want it back | `revert` |
| A wall of red text appeared | Almost always a typo. `cd ~/course-practice` and type the line again — don't try to read the error. |
| Nothing at all happened | Press Enter. |

For this session, use only the named files in `~/course-practice`. The folder
keeps the exercise organized; it is not a hard security boundary. `revert`
recovers ordinary checkpointed file changes, not disclosures or external
actions.
