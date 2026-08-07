# Welcome Email Template

<!-- Chunk: docs/chunks/onboarding_setup_guide - Pre-cohort participant setup guide -->

The per-participant email the pre-cohort checklist tells you to prepare
(`PRE_COHORT_CHECKLIST.md`, section 3). One email per participant — the
Step 3 command carries their personal key.

**Placeholders to fill per participant:** `<NAME>`, `<SESSION DATE>` (twice),
`<KEY>`.

**Before sending — all from the checklist, repeated here because this is
where the mistakes happen:**

1. Issue the OpenRouter key with a per-key spend limit first; note the
   rotation date (the key lands in shell history — treat it as disclosed
   once used).
2. Send the email to yourself, copy the curl line out of it, and paste it
   into a terminal. If your mail client soft-wraps the line, the key's tail
   becomes a second command and the participant sees `unknown option`.
   Plain text or an attached `.txt` copy both survive wrapping.
3. The section marked **[ALPHA — delete for later cohorts]** is for the
   first-ever participant, whose run doubles as the clean-machine dry-run
   (checklist item 1), the `setup/DRY_RUN.md` record, and — if they match
   the audience floor — the human floor test (`env/FLOOR_TEST.md`). Ask
   them the observer questions from that protocol afterward, not just
   "did it work?". For a normal cohort, delete the section and the
   "run it once more / PASS x2" sentence stands on its own as the
   run-twice sampling the checklist requires.

---

**Subject: Welcome to Agentic 101 — one setup task before we meet (~30 minutes)**

Hi \<NAME\>,

Welcome — I'm glad you're in.

One idea underneath everything we'll do: you already know your job deeply —
the edge cases, the tedious reports, the workarounds you've built in
spreadsheets. This course is about turning that knowledge into a new kind of
leverage. The AI does the typing; you supply the judgment about what's worth
doing and whether the result is right. You'll leave with a working
automation of something you currently do by hand.

**Before our first session on \<SESSION DATE\>, there's one thing to do:**
set up your laptop. It takes about 30 minutes, most of which is waiting for
downloads, and you don't need to understand any of it — every step is copy,
paste, and check that your screen matches the picture.

The guide is here:
**https://github.com/netguy204/agentic-101/blob/main/setup/README.md**

When the guide reaches **Step 3**, it will ask for a command from this
email. Here is yours, with your personal key already filled in — copy the
whole line exactly as it is:

```
curl -fsSL https://raw.githubusercontent.com/netguy204/agentic-101/main/setup/install-pi.sh | bash -s -- --key <KEY>
```

(If that appears split across two lines in your email app, copy it from the
attachment instead — it has to be pasted as one line.)

**About cost: there isn't one for you.** That key pays for everything you do
on this course. There's no account to create, no credit card to enter, and
no bill coming to you. It has a spending limit on it and it is not yours to
worry about. If anything ever asks you for payment details during setup,
stop — you've wandered somewhere the instructions don't go.

**[ALPHA — delete for later cohorts]**

**One honest thing you should know: you're the first person through this.**
The instructions have been tested by machines, but you are the first human
to walk them start to finish — which makes you, genuinely, the most useful
person in this course right now. So:

- If anything on the page doesn't match what's on your screen, that's a
  defect in **my instructions**, not a mistake by you. There is no step
  where "I must have done it wrong" is the right conclusion.
- When something looks off, take a screenshot of the whole window and email
  it to me. That's not you asking for help — that's you doing the job I
  need you to do.
- If you can, jot down roughly how long each step took and anywhere you
  hesitated, even for a moment. Those notes are gold to me.

**[END ALPHA]**

The guide ends with a check that prints **PASS**. When you see it, run it
once more (just type `course-smoke-test` again) — the AI parts aren't
perfectly repeatable and I want to see it pass twice. Then you're done:
reply with "PASS x2" and your notes, and bring the same laptop to the first
session.

If you get stuck anywhere at all, stop and email me — don't burn your
evening on it. A screenshot and "it stopped here" is all I need.

See you on \<SESSION DATE\>,
Brian
