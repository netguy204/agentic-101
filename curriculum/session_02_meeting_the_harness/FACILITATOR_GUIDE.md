# Session 2 facilitator guide — Meeting the harness

<!-- Chunk: docs/chunks/fluency_session_02 - Session 2 facilitator guide -->

The student works through Session 2 alone on the platform (DEC-014). You
are their instructor: you answer what the automated help can't, and you
run live sessions, one to one or with a small group on a video call, when
a student needs one or you have scheduled one. Students see you as "your
instructor".

**The outcome:** the student has run an agent, seen it change a real
file, checked the result themselves, and undone a change afterwards. The
bar is in [`CHECKPOINT.md`](CHECKPOINT.md).

**Two paths (DEC-016).** Most students work on their agent page: the agent
runs on the course's computer, its folder is listed under "Your files",
each tool call appears as a step (Read, Wrote, Changed, Ran a command), and
the undo is "Undo the last request" or "Earlier versions". Nothing to
install. A student who runs pi on their own computer follows the "If you
run pi on your own computer" box in each exercise: the course terminal,
`~/course-practice`, `commit` and `revert`, with the reference card
([`handouts/terminal-card.md`](handouts/terminal-card.md)) open. Setup and
terminal problems only arise on that path.

---

## What the student does

| Step | Time | Source |
|---|---|---|
| Prework: pick one row (local path also runs `course-update` and `course-smoke-test`) | 10 min (15 local) | `platform/prework/02_meeting_the_harness.md` |
| The audio: four segments | 15 min | `platform/audio/02_meeting_the_harness.md` |
| Find your way, then the safety net (exercises 1 and 2) | 25 min | [`EXERCISES.md`](EXERCISES.md) |
| First delegation (exercise 3) | 15 min | [`EXERCISES.md`](EXERCISES.md) |
| Read what it did, then break it (exercises 4 and 5) | 25 min | [`EXERCISES.md`](EXERCISES.md) |
| Practice: solo lap, two real ones, one worksheet | about 60 min over a week | [`PRACTICE.md`](PRACTICE.md) |
| Submit: from the agent page, the worksheet (the platform adds the agent's record and files); locally, the session log, worksheet, `revert --list` and practice files | — | The platform's checkpoint |

The platform checks items 1 and 4 of the bar mechanically and judges items
2 and 3 against the examples in [`CHECKPOINT.md`](CHECKPOINT.md). A
near-miss gets the corrective question and a second try. After two rounds,
or when the judge isn't confident, the case comes to you.

---

## Before your first student

- **Read** [`EXERCISES.md`](EXERCISES.md),
  [`EXERCISE_RUNSHEET.md`](EXERCISE_RUNSHEET.md) and
  [`CHECKPOINT.md`](CHECKPOINT.md), and skim [`DRY_RUN.md`](DRY_RUN.md).
  The dry run records what the commands actually print, including the two
  places in `revert` that catch people.
- **Run the whole session on your own machine** from the written text: all
  five exercises, in a folder you then delete. About fifteen minutes; the
  agent steps take ten to thirty seconds each. You need to have seen
  `revert`'s questions yourself before you answer a thread about them.
- **Know the pins.** `setup/pins.env` names the pi version and the model.
  "pi is version X, but this course uses Y" from the smoke test means
  re-running Step 3 of the setup guide.

---

## Threads from students

Students reach you through "Stuck on this session?", then "Send to your
instructor". Reply within a day. What usually arrives:

- **A smoke test that says FAIL** (local path), from the prework or
  exercise 1. The student has been told to stop and send you everything it
  printed, and that they can do the session on their agent page meanwhile. Find
  the `[no]` line in `setup/README.md`'s troubleshooting table. If it
  isn't there or the fix doesn't work, offer a 20–30 minute call. Log the
  exact `[no]` line in `docs/trunk/FRICTION.md`; two students hitting the
  same line is a defect in `setup/`.
- **"I think I broke it."** Usually something worked and looked like it
  didn't: a command that prints nothing, `revert` opening with "Wait —",
  a pause while the agent works. Ask what the screen says now, and check
  it against [`DRY_RUN.md`](DRY_RUN.md).
- **Went back to the wrong version.** On the agent page, open "Earlier
  versions" again and pick another; going back loses nothing and they can
  come forward from the same list. Locally, run `revert` again and pick the
  other checkpoint. Read the names, not the numbers.
- **A checkpoint escalation.** The near-miss rows tell you what the
  student said and which question they've been asked. The Recovery section
  of [`CHECKPOINT.md`](CHECKPOINT.md) lists the four usual causes.
- **"Can I use this on my real work?"** Only after the four questions in
  [`PRACTICE.md`](PRACTICE.md): they can evaluate it, they are authorized
  to send the data and delegate the task, the delegation is appropriate
  and isn't a consequential decision, and a person reviews it before
  anything external happens.

If a terminal problem takes more than two exchanges, offer a call and ask
them to share their screen. Reading a screen is faster than describing it.

---

## A live session

Offer one when setup or the terminal has stalled the student, when their
checkpoint escalates, or as a scheduled group session. 45–60 minutes on a
video call with screen sharing.

**Setup first, and separately.** If the student's smoke test isn't PASS,
the call is a setup call: work through `setup/README.md` and its
troubleshooting table. Don't start the exercises on a machine that doesn't
pass.

**Then run the exercises with the student driving.** They share their
screen and type; you watch and say what to look at. Don't take control of
their machine. In order:

1. **The safety net before any real work** (exercises 1 and 2). On the
   agent page: undo a small change, then bring `notes.txt` back from
   "Earlier versions". Locally: `commit` and `revert`, and warn them before
   `revert`: "It asks four questions, one at a time. The first starts with
   *Wait* and gives three numbered choices. Press Enter. That's it being
   careful." Don't move on until `notes.txt` has come back.
2. **The first delegation** (exercise 3). Work their prompt with them
   before they send it. The two gaps are "what your data looks like" and
   "the mess in it"; people fill the first with a *task* ("sort my ticket
   queue") when it needs a *thing* ("a list of tickets with the priorities
   written four different ways").
3. **Reading what it did** (exercise 4). This is the session's content;
   give it the time. Say: "The steps are what it did. The paragraph at the
   end is what it says it did. Read the steps, then look at the file." Then
   ask what they checked, and keep asking "That's what it told you. What
   did you *look at*?" until box 3 is specific.
4. **Breaking it on purpose** (exercise 5), if there's time. If not, it's
   four minutes alone afterwards.

**With a small group:** one person shares their screen for exercise 2
while everyone does it on their own machine, then each person runs
exercises 3–5 on their own machine and you take box 3 from each in turn.
A student whose machine doesn't work watches and does the exercises after
their setup call; don't fix a machine while the group waits.

### What to point at during exercise 4

**Session 1, explicitly.** "Column 2 of your sheet became the instruction.
Column 4 is about to be the check. You wrote both before you'd seen this
software, and they worked unchanged."

**A judgment call the agent made.** In both dry runs on the prepared task,
the agent folded `Complete` into `Done` and said so in its explanation. At
most companies that's right. At some, "complete" means signed off and
"done" means the work stopped, and merging them silently loses a
distinction someone relies on. If the student doesn't raise something like
it, read the agent's explanation aloud and ask: "Do any of those words
mean different things where you work?"

### What pi is, if you have to say it live

The concept track covers this. If you restate it, use SPEC.md's terms:

> A **harness** is the software environment in which an agent runs — its
> tools, configuration, prompts, and extensions. Ours is pi.
>
> An **agent** is an LLM running in a harness with the ability to take
> actions — read and write files, run commands, call tools — not just
> converse.

It acts through four tools: **read** a file, **write** a file, **edit**
part of a file, or **run a command** (bash). Each box on screen is one
tool call; the boxes are its work log.

---

## Anticipated failure points and recovery moves

| What goes wrong | What to do |
|---|---|
| **On the agent page, nothing seems to happen after Send.** | Give it half a minute. While it's working, "Stop" shows. If nothing changes after a minute, send the instructor a note of what the page shows. |
| **On the agent page, "Undo the last request" didn't change anything.** | It undoes only the agent's most recent request, and only if that request changed a file. Use "Earlier versions" to go back further. |
| **On the agent page, the student went back to the wrong version.** | Open "Earlier versions" again and pick another. Going back loses nothing, and they can come forward again from the same list. Read the names, not the positions. |
| **On the agent page, the student can't find the file the agent made.** | It's under "Your files". If it isn't there, the agent didn't make it: read the steps to see what it did instead. |
| **The student wants to use a real file on the agent page.** | "Upload files" adds it to the agent's folder. Only after the four questions in [`PRACTICE.md`](PRACTICE.md); anything the agent reads goes to the model provider. |
| **The smoke test says FAIL** (local path). | Stop. Don't reinstall or follow fixes from the internet. Copy everything the window printed and send it to the instructor ("Stuck on this session?", then "Send to your instructor"). The instructor matches the `[no]` line against `setup/README.md`'s troubleshooting table. |
| **"pi is version X, but this course uses Y."** | Run Step 3 of the setup guide again; it installs the version the course expects. |
| **`could not reach the model` partway through.** | Usually a spending limit on the key, which the instructor fixes outside the session. Send them the message. |
| **The terminal won't open at all.** | A setup problem. Send the instructor what you see; it gets fixed on a setup call with `setup/README.md`. |
| **Nothing happened after typing a command.** | Press Enter. Many commands print nothing when they work; type `ls` to see the result. |
| **The student typed the `$`.** | The `$` is already on screen; it means the terminal is ready. Type the command after it. |
| **A wall of red text.** | Usually a typo. Type `cd ~`, then type the command again. Retyping is quicker than reading the error. |
| **`revert` opens with "Wait —".** | That's normal. It asks four questions, one at a time; the first offers three numbered choices. Press Enter. |
| **The student typed `1` at "Which one should this folder go back to?"** | Not a problem. Run `revert` again and pick the other number. `revert` saved the deletion as the new number 1, so the checkpoint they wanted is number 2. Read the names, not the numbers. |
| **`revert` says there are no checkpoints.** | The `commit` didn't finish, usually because the first question was answered `no`. Run `commit`, answer `yes`, carry on. |
| **Reverted to the wrong checkpoint and lost exercise 4's work.** | Run `revert` again and pick "cleaned up". Reverting is itself a checkpoint, so going back too far can be undone. |
| **A Windows student sees `warning: in the working copy of 'README.txt', LF will be replaced by CRLF…` after `commit`.** | Harmless: git remarking on line endings. The green `Saved:` line below it means the checkpoint worked. Environments at version 1.0.1 or later don't show it. If it appears, re-run **Step 1 of the setup guide** (`irm …/install.ps1 \| iex` on Windows, `curl …/install.sh \| bash` on Mac) after the session, then close and reopen the terminal; `commit --version` should say 1.0.1. |
| **pi is running outside `~/course-practice`.** | Check with `pwd` before sending anything. If something was already made elsewhere, it's in the student's own folder and the exercises only create files; `cd ~/course-practice` and carry on. The folder is a habit, not a security boundary. |
| **The exercise 3 prompt gives an empty file or a lecture.** | The prompt describes the task instead of the material. Ask: "What does the file look like *before* you fix it?" Column 1 of the sheet usually says. |
| **The agent pauses and the student thinks it has frozen.** | Normal. Wait a minute. "Stop" on the agent page, or Escape in pi, stops it. |
| **The agent asks a question instead of doing it.** | Answer it in the request box and send it. It knew it didn't know; it won't always. |
| **Box 3 repeats the agent's summary.** | "That's what it told you. What did you look at?" |
| **The agent did something surprising or wrong.** | A good result. Ask what the student looked at that showed them; that's box 3, and it's a better answer than a run that went perfectly. Agents are nondeterministic, which is why the course teaches checking. |
| **The agent's result was perfect and there's nothing to catch.** | Read the agent's explanation and question one judgment call in it (`Complete` / `Done` is the reliable one). Every run makes calls it doesn't flag. |
| **The agent refuses exercise 5, or asks if they're sure.** | Tell it yes, or "do it anyway". Locally, if it still won't, delete `sample.csv` in the file browser and revert from there. The exercise is the undo. Don't rely on the refusal; it isn't a safety feature. |
| **The student wants a bigger disaster in exercise 5**, such as "delete everything". | No. Locally, the checkpoints live in a hidden folder inside `course-practice`; a prompt broad enough to delete everything can delete those too, and then there's nothing to revert to. The prompt names one file on purpose. Bounding what an agent can touch is Session 4. |
| **The student races ahead** to models, git, or other harnesses. | Point them at the optional item in [`PRACTICE.md`](PRACTICE.md). The model is fixed for the course (DEC-006); adapting the harness is Session 5. |

---

## FAQ — questions you will be asked

**"What if it does something to my other files?"** On the agent page it
works only in its own folder on the course's computer, and can't see your
computer unless you choose "Link a folder". Locally, the exercises name
files in `~/course-practice`, which keeps them bounded and their changes
recoverable, but the folder isn't a security boundary: pi can run with the
same access you have, and it doesn't ask before every action. Use only the
written prompts for now; Session 4 builds stronger scoping and approval
habits.

**"Is my work being sent somewhere?"** Yes. What you type and anything it
reads goes to the model provider to produce a response. That's why the
exercises use invented data shaped like your work. Before you point it at
anything real, check with whoever owns the data.

**"Which AI is this?"** The model in `setup/pins.env`, the same for every
student, so "you should see something like this" holds. Model choice isn't
part of this course.

**"Why can't I just use the chat one in my browser?"** For many things you
can. The browser one gives you text to copy; this one changed a file.
That's the difference from Session 1, and it's why this session needed a
safety net.

**"Do I have to use the terminal?"** No. The agent page does everything
the exercises need. Running pi on your own computer is an option for
students who want the agent close to their own files. What to delegate and
how to check it carries over either way.

**"What if I forget what to type?"** Locally, look at the reference card;
using it is the intended workflow. On the agent page there's nothing to
type except the request.

**"Can I use this on my actual work tomorrow?"** Only after the four
questions in the practice sheet: you can evaluate it, you're authorized to
send the data and delegate the task, the delegation is appropriate and
isn't a consequential decision, and a person reviews it before anything
external happens. A checkpoint adds local recovery; it doesn't replace
those.

---

## Appendix — what a normal run looks like

From [`DRY_RUN.md`](DRY_RUN.md): two full passes on the prepared task, on
the course model.

| Step | What happened, both times |
|---|---|
| `course-smoke-test` | ~10 seconds, PASS |
| Exercise 3 (make the messy file) | One `write` tool call, ~10 seconds, 15 rows with the requested mess |
| Exercise 4 (fix it) | One `write` tool call, ~12 seconds. **Both times it merged `Complete` into `Done` and said so.** Both times it standardised dates to `YYYY-MM-DD` and explained why. |
| Exercise 5 (wreck it) | A `write` and then a `bash` (the rename), ~9 seconds. Complied both times. `.git` untouched, so `revert` worked. |
| `revert` | Restored `sample.csv`, removed `disaster.csv`, both times |

The rows differed completely between the two runs; the outcomes were the
same. That is what "outcome-checked, not output-checked" means
(`docs/trunk/TESTING_PHILOSOPHY.md`).
