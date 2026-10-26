# Test-student protocol — Session 1

<!-- Chunk: docs/chunks/fluency_session_01 - Session 1 floor test protocol and results -->

A session is proven by a test student working through it (DEC-014): one
person at the audience floor (DEC-004: comfortable with everyday computer
use, **no programming or terminal background**) takes the session on the
platform, self-paced, with you available as their instructor. What they
hit is fixed in the material. Findings go to
`docs/trunk/FRICTION.md` and the results log below.

Session 1 has no software in it. What is being tested is
**comprehension**: whether the written and spoken material produces the
right thinking in someone who has never met these ideas, with nobody
explaining it to them.

## Preconditions

- A test student at the floor who has **not** seen the material and does
  not know the course's thesis. Someone who already agrees with the
  leverage argument tests nothing.
- The session published on the platform at a tag, exactly as a student
  receives it.
- You do not explain anything before they start. Help only through the
  normal route ("Stuck on this session?", then "Send to your instructor"),
  and log every time they use it.

## How the test runs

1. **The student works alone on the platform**, prework through submission.
   Ask them to note, per step, how long it took and anything that made
   them stop.
2. **You answer threads as you would for any student**, and copy each
   question into the results log verbatim. Every thread is a finding: the
   material, the course assistant or the checkpoint conversation didn't
   resolve something.
3. **Read the checkpoint result**, including any near-miss rounds and
   escalations.
4. **Hold a debrief call** of 20–30 minutes after they submit. Ask the
   questions under "Watch-fors". Then ask: "Pick one task and tell me
   whether it's inside or outside your judgment boundary, and why", cold,
   without using the phrase first yourself.

If you can, sit in silently on one sitting (exercise 2 is the one to
watch) and say nothing except "what are you thinking?" when they go quiet
for more than ~30 seconds.

## What to record

- **Time per step**, against the claims in `platform/index/01_mental_models.md`:
  prework 10 min, concept track 15, fill the sheet 25, skeptic pass 12,
  daily pass 5 × 4, check test 15, consolidate and submit 20.
- Words they misread or asked about. Suspects: "judgment boundary",
  "toil", "judgeability", "harness".
- Every question they asked, verbatim, and where they asked it: course
  assistant, checkpoint conversation, or you.
- Wrong guesses: what they wrote where we didn't expect it.
- **Defect** = they could not proceed without a person, or reached an
  outcome they didn't intend. **Observation** = friction that didn't block.
  Log both; defects block the next student until fixed.

## Watch-fors specific to this session

1. **"I can't do it" vs "I can't check it."** Does the student mark tasks
   *out* because they lack the expertise? The practice week has nobody in
   it, so the handout and the exercise text have to prevent this alone.
2. **Does the concept track read as argument or as flattery?** Ask: "Did
   any of it feel like it was buttering you up?" A student who felt
   flattered didn't believe it.
3. **Frequency in column 3.** Does the student write "every week" or
   "often" as the reason a row is *in*?
4. **Vague checks.** How many rows say "I'd read it over" or similar? If
   it's most of them, the handout's filled-in rows aren't doing enough.
5. **Blank-page freeze on the prework.** How long before the first line?
   Over two minutes means the prompts need to come first.
6. **Is the sheet fillable on paper?** Column widths, room for a real
   sentence in column 4.
7. **Did they know when to ask for help, and how?** Did they find "Stuck
   on this session?" Did they know the course assistant is automated and
   the instructor is a person?

## Demo dry run (separate, technical)

The Northwind demo in [`FACILITATOR_GUIDE.md`](FACILITATOR_GUIDE.md) runs
only in live sessions, and it is the only executable thing in Session 1.
Agentic steps are run at least twice, because model behaviour varies
(`docs/trunk/TESTING_PHILOSOPHY.md`, Exercise Dry-Runs).

- Run the `headcount.csv` demo **at least three times** on the pinned
  model, from a clean folder each time.
- Record, per run: did the agent fold `Brand & Mktg` into Marketing? Did it
  fold `Field`/`Field Sales`? Did it ask a clarifying question? Anything
  else worth a recovery move?
- If the reveal row comes out wrong-as-expected in fewer than two of three
  runs, the demo file needs a more reliably ambiguous row.
- Check that the appendix transcript still resembles what the model
  produces.

## Results log

### First test student

The first test student went through the course one to one with the
operator. It produced the outcome the course is built for, and showed that
the self-paced material was too verbose and not actionable enough for a
student working alone (DEC-014). Session 1's platform version was
rewritten on 2026-10-10 in response.

### Second test student

**PENDING** — the first test of the 2026-10-10 rewrite, self-paced on the
platform.

### Demo dry run

**PENDING** — needs a working pi install on the pinned model
(`setup/pins.env`) and three runs of the `headcount.csv` demo.
