# Practice: two real ones

<!-- Chunk: docs/chunks/fluency_session_02 - Session 2 practice assignment -->

**About 60 minutes, spread across the week. Cap it at 90.**

Two of the three things on this page are work you were going to do anyway.
That is deliberate: the point of this course is not to add an hour to your
week, it is to move an hour of your week onto something else. If this
assignment feels like homework, you have picked the wrong tasks — pick more
annoying ones.

**Where you're heading:** by Session 3, you'll have delegated three times in
total (once in the room, twice alone) and you'll have one delegation that
went badly. The one that went badly is the valuable one. Session 3 is about
why it went badly and how to write instructions that survive contact with an
agent, and it works much better if you arrive with your own example.

---

## The time budget

| When | How long | What |
|---|---|---|
| Within 48 hours of the session | 20 min | The solo lap (below) — the same loop, alone, while it's fresh |
| Twice during the week | 15 min each | Two real delegations on real tasks (below) |
| Once, before Session 3 | 10 min | Fill in a worksheet for whichever one went worst |
| | **60 min** | |

The half hour of slack is real. Use it on the second real delegation if it
turns out to be more interesting than you expected, which happens.

---

## 1. The solo lap (20 minutes, within 48 hours)

Do the whole session's loop again, on your own, in `~/course-practice`. Not
because you need the practice with the commands — because doing it once
without a facilitator in the room is the difference between having seen
something and being able to do it.

Everything you need is on
[`handouts/terminal-card.md`](handouts/terminal-card.md). The loop, in order,
and the order *is* the lesson:

> **`commit` → delegate → check → `commit`**

1. Open the course terminal, `cd ~/course-practice`, `pwd` to be sure.
2. `commit`. Name it something like "before Tuesday".
3. Run `pi` and ask it for something small. Anything — ask it to make you a
   packing list, tidy a file it made last week, or summarise the README
   that's sitting in the folder.
4. Look at what changed: the tool boxes, then the actual file.
5. `commit` again, or `revert` if you didn't like it.

**Do it within 48 hours.** This is the single highest-value twenty minutes on
the page and its value halves every day you leave it.

**If you get stuck**, the card has a "when you feel lost" section with
bounded ways to stop, reorient, or recover local files. If you're stuck for
more than five minutes, stop and email your facilitator — the same rule as
before the course: a confused participant is a bug in our material, and
struggling alone teaches nobody
anything.

---

## 2. Two real ones (15 minutes each)

Now the part that replaces work rather than adding it. **Transmission
reminder:** what you type and the contents of files pi reads are sent to the
model provider. `commit` and `revert` provide local file recovery only.

Before using a real task, it must pass **all four questions**:

1. **Evaluable:** Can you tell a reasonable result from an unreasonable one
   and name the check you will apply? If not, do not delegate it.
2. **Authorized:** Are you allowed to delegate this task and send its data to
   the course model provider? If someone else owns the data or process, ask
   first.
3. **Appropriate and non-consequential:** Is this suitable draft or
   preparation work, rather than a consequential decision about a person,
   money, access, employment, health, legal rights, or another high-stakes
   outcome? The agent may prepare evidence; a responsible person decides.
4. **Human-approved before external action:** Can a person review the actual
   output and explicitly approve it before anything is sent, published,
   merged, deployed, purchased, scheduled, or otherwise acted on outside the
   practice folder? If not, keep the task synthetic.

**Professional example:** a human can authorize an engineering agent to
inspect a repository, make changes, run checks, and open a pull request as a
specifically approved external action. Creating the pull request is
substantial delegated work, but it grants no authority to merge: a human
reviews the diff and test evidence before choosing whether to merge to
`main`, and deployment remains a separate human-approved action. Approval to
open the pull request is not approval to merge or deploy.

**Pick two entries from your toil inventory marked `in` that also pass the
other three questions.** Not the starred one from the session — two others.
When each task next comes round:

1. At the terminal prompt, `cd ~/course-practice`, then `commit`. This gives
   local file recovery only.
2. Type `pi`, wait for the pi screen, and ask for what you want in a plain
   sentence. Column 2 of your sheet — "what done right looks like" — is your
   instruction.
3. **Apply the check in column 4 to the actual output.**
4. Keep the result as a draft until the required person reviews and approves
   any external action.
5. Type `/quit` to return to the terminal. `commit` if the local files are
   worth keeping; `revert` if they are not.

**About your real data.** You have three honest options and all three are
fine:

| | When to use it |
|---|---|
| **Describe the shape and let it invent the data**, like we did in the room | Anything sensitive, or anything you can't easily get out of the system it lives in |
| **Copy a small, real, non-sensitive extract into `~/course-practice`** | Only when you are authorized to send it to the model provider as well as save it locally |
| **Use the task but not the data** — a made-up version of a real job | When you want the practice more than the output |

If you're unsure whether something is safe to send, that's a genuine
question, and the answer is "ask whoever owns it, before you do it, not
after". Noticing that you should ask is exactly the kind of judgment this
course is about. Nothing on this assignment requires you to send anything you
have doubts about.

**If the task turns out to be a bad fit** — the agent flounders, or it needs
something it can't see — **that is a result, not a failure**. Write down what
was missing. It's the most useful thing you can bring to Session 3.

---

## 3. One worksheet, on the worst one (10 minutes, before Session 3)

Take the delegation that went least well and fill in a
[`handouts/what-did-it-do.md`](handouts/what-did-it-do.md) properly. All
three boxes, plus the question at the bottom:

> **What would I have failed to catch?**

Bring it. Session 3 opens with these, and a room full of near-misses is worth
more than a room full of successes.

If all three of your delegations went perfectly, do the worksheet on the one
where the agent made a decision you hadn't asked it to make. There will be
one — it makes small calls constantly and only mentions some of them.

---

## Optional, if you want more

Pick one entry marked **out** — one you honestly could not check. Ask the
agent to do it, and then sit with the output for two minutes and try to find
a way to tell whether it's right.

You won't be able to, and the specific way you can't is worth noticing: the
output will be fluent, well-organised, plausible, and completely
unverifiable by you. Write down one sentence about what you'd need to know to
check it. That sentence is the exact distance between where your judgment
ends and where that task lives, and it's a more useful thing to own than
another successful delegation.

Don't use the result for anything.

---

## Bring to Session 3

- **Your worksheet** from part 3.
- **Your toil inventory**, with ticks against the entries you delegated.
- **One sentence about the one that went worst.** You'll be asked for it in
  the first ten minutes.

## If the week gets away from you

Do the solo lap and nothing else. Twenty minutes, within 48 hours, and skip
the rest without guilt. The loop — checkpoint, delegate, check, checkpoint —
is the thing Session 3 builds on, and having it in your hands once alone
beats arriving with three half-done exercises and no muscle memory.
