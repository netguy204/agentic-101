# Welcome Email Template

<!-- Chunk: docs/chunks/onboarding_setup_guide - Pre-cohort participant setup guide -->

The email every student gets when they enrol, including students enrolled
on the platform (`PRE_COHORT_CHECKLIST.md`, section 3). One email per
student.

**Placeholders:** `<NAME>`, `<COURSE PAGE>`, `<KEY>`, `<INSTRUCTOR NAME>`.

**The key block.** A student enrolled on the platform gets their setup
command, with a key, on the platform's setup page. For that student, delete
the block marked **[KEY]**. Keep it only for a student who sets up without the
platform's setup page.

**Before sending:**

1. If you keep the key block: issue the OpenRouter key with a per-key spend
   limit, and note the rotation date. The key lands in shell history, so
   treat it as disclosed once used.
2. If you keep the key block: send the email to yourself, copy the curl line
   out of it, and paste it into a terminal. If your mail client wraps the
   line, the end of the key becomes a second command and the student sees
   `unknown option`. Plain text or an attached `.txt` copy both survive.
3. The block marked **[TEST STUDENT]** is for a student whose run is also the
   clean-machine dry run (checklist item 1), the `setup/DRY_RUN.md` record,
   and, if they match the audience floor, the human floor test
   (`env/FLOOR_TEST.md`). Ask them the observer questions from that protocol
   afterwards. For any other student, delete the block.

---

**Subject: Welcome to Agentic 101 — set up your laptop first (~30 minutes)**

Hi \<NAME\>,

Welcome to Agentic 101.

In this course you hand repetitive parts of your own work to an AI agent and
learn to check what it gives back. You supply the judgment: what is worth
doing, and whether the result is right. By the end you will have automated a
task you now do by hand.

The course is self-paced. Your course page is here:
**\<COURSE PAGE\>**

**First, set up your laptop.** It takes about 30 minutes, most of it waiting
for downloads. Each step is a line to copy and paste, followed by what your
screen should show. The guide is here:
**https://github.com/netguy204/agentic-101/blob/main/setup/README.md**

**[KEY]**

At **Step 3**, the guide asks for your setup command. Here it is, with your
personal key in it. Copy the whole line:

```
curl -fsSL https://raw.githubusercontent.com/netguy204/agentic-101/main/setup/install-pi.sh | bash -s -- --key <KEY>
```

If it appears split across two lines, copy it from the attachment instead. It
has to be pasted as one line.

**[END KEY]**

**Cost:** none to you. Your key pays for everything you do on the course, and
it has a spending limit. There is no account to create and no card to enter.
If anything asks you for payment details, stop.

**[TEST STUDENT]**

You are among the first people to go through this course, and your run is
how we find out whether the instructions work.

- If your screen doesn't match the guide, the guide needs fixing. Send me a
  copy of the whole terminal window and the step you were on.
- If you can, note roughly how long each step took and where you hesitated,
  and reply to this email with your notes when you finish.

**[END TEST STUDENT]**

The guide ends with a check that prints **PASS**. Run it once more by typing
`course-smoke-test`; the AI checks don't give the same result every time, and
I want to see it pass twice. Then paste the result into your course page, and
Session 1 opens.

If you get stuck at any step, stop and ask: on your course setup page, under
"Stuck on any step?", choose "Ask the TA". The first answer is automated. I
see anything it can't resolve, and you hear from me within a day.

\<INSTRUCTOR NAME\>
