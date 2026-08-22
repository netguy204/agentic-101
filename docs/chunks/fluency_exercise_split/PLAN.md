<!--
This document captures HOW you'll achieve the chunk's GOAL.
It should be specific enough that each step is a reasonable unit of work
to hand to an agent.
-->

# Implementation Plan

## Approach

Split by seam, not by rewrite. Both existing `EXERCISES.md` files already
mark the facilitator voice with bold lead-ins (**Say it like this.**,
**Observable output.**, **Most common misfire.**, **If someone stalls.**,
**Fallback.**, **Work … live before they start.**, **Remote delivery.**,
**Before starting, say this out loud:**, **Wrapping the block**) and the
participant voice with numbered steps (Session 2) or a **What participants
do.** paragraph (Session 1). Every facilitator paragraph moves verbatim into
`EXERCISE_RUNSHEET.md`; every participant step stays in `EXERCISES.md` and is
re-addressed to "you". Where Session 1's participant instructions are prose
inside **What participants do**, they become short numbered steps with the
same content. Nothing is reworded for style beyond the change of address.

One source for shared facts: commands, prompts, the `revert` answers table,
and "what you should see" live only in `EXERCISES.md`; the runsheet says
"`EXERCISES.md`, exercise 2, step 6" and adds the facilitator's reason to
care. This is what stops the two files drifting the way the 2026-08-07 dry
run and the 2026-08-22 Windows run both caught.

Convention first, then content, then references — so the new filename has
a documented home (`curriculum/README.md`, SPEC.md Repository Layout,
DEC-011 amending DEC-010) before any session uses it, and every link is
fixed in one sweep at the end with a checker rather than by memory.

Testing follows `docs/trunk/TESTING_PHILOSOPHY.md` for documentation
changes: the participant steps do not change, so no re-dry-run; the checks
are mechanical — link integrity, "nothing lost" (every old bold lead-in
appears in a runsheet, every old numbered step in an `EXERCISES.md`), the
preserved Session 2 corrections, `ve validate`, and `env/tests/test-commands.sh`
as a no-collateral-damage canary.

## Sequence

### Step 1: Amend the convention

- `curriculum/README.md` — "Required files": the table gains a row
  `EXERCISE_RUNSHEET.md | Per-exercise running order for the facilitator:
  timing, what to say, observable output, misfires, fallbacks | Facilitator`;
  `EXERCISES.md`'s audience becomes `Participant` and its description "The
  in-session steps the participant follows, with the canned fallback";
  "these six files" → seven; the sentence "The five names other than
  `README.md` map one-to-one onto the Session Anatomy list" → the Session
  Anatomy "in-session exercises" element maps to two files, one per reader,
  and the other four map one-to-one. Add one bullet under "Rules that cross
  sessions": the runsheet references `EXERCISES.md` by exercise and step and
  never restates a step — commands and on-screen text have one source.
- `docs/trunk/SPEC.md` Repository Layout (the `curriculum/` bullet): list
  seven fixed filenames with `EXERCISE_RUNSHEET.md` after `EXERCISES.md`,
  and say "one per Session Anatomy element, the exercises element split by
  reader".
- `docs/trunk/DECISIONS.md`: add **DEC-011 — In-session exercise material is
  split by reader** via the `decision-create` skill (decision, context,
  alternatives = the GOAL's Rejected Ideas, rationale, consequences:
  seven fixed names; runsheet never restates steps; later sessions author
  both files). Under DEC-010's `**Status**: ACCEPTED` add a line
  `**Amended**: DEC-011 (2026-08-22) — the exercise element is two files,
  `EXERCISES.md` (participant) and `EXERCISE_RUNSHEET.md` (facilitator);
  seven fixed filenames.` so the six-file statement does not stand
  uncorrected.

### Step 2: Split Session 1

Source: `curriculum/session_01_mental_models/EXERCISES.md` (three exercises,
27 min). Create `EXERCISE_RUNSHEET.md` with: the block overview (first
paragraph: three exercises, 27 minutes, the checkpoint they produce), the
handout/canned-toil paragraph's facilitator half (who uses which sheet),
**Before starting, say this out loud**, then per exercise a heading with the
minutes, **What participants do** (the one-paragraph summary + "steps:
`EXERCISES.md`, exercise N"), **Work one live before they start**,
**Say it like this**, **Observable output**, **If someone stalls**, the
misfires, **Fallback**, **Remote delivery**, and **Wrapping the block**.

Rewrite `EXERCISES.md` participant-only: short intro ("Three exercises, one
after another, on your inventory sheet — or on the canned sheet if you can't
use your own work"), then per exercise a heading without minutes and the
numbered steps in "you" voice taken from **What participants do** (e.g.
exercise 1: "1. Copy the five things from your prework onto the sheet, one
per row, filling in only the first two columns… 2. Keep going: add anything
else from the last month that repeats…"), what the sheet should look like
when done (from **Observable output**, re-addressed: "Every row has in, out
or not sure"), and the participant side of the fallback ("Using the canned
set? Answer for Priya; …"). End with one line: "Stuck? Say so — you'll be
paired."

Both files carry the session chunk backreference and
`<!-- Chunk: docs/chunks/fluency_exercise_split - Exercise material split by reader -->`.

### Step 3: Split Session 2

Source: `curriculum/session_02_meeting_the_harness/EXERCISES.md` (five
exercises, 59 min). Same mechanics. Specifics to get right:

- The `revert` table (exercise 2, step 6) and its lead-in ("four questions,
  one at a time — the first offers three numbered choices…") stay in
  `EXERCISES.md` verbatim. The runsheet's "third misfire — typing `1`" says
  "the answer is in `EXERCISES.md`, exercise 2, step 6" and keeps the
  "read the names, not the numbers" rule.
- Exercise 5's **Why this prompt and not "delete everything"** and the
  exact prompt: the prompt is a participant step (stays); the rationale
  is facilitator (runsheet).
- The intro's "Every written exercise targets named files in
  `~/course-practice`… not a security boundary" is both readers': the
  participant version keeps the one-sentence reassurance ("everything
  today happens in `~/course-practice`, and exercise 2 teaches you how to
  undo it"); the runsheet keeps the full framing and the **Before starting,
  say this out loud** preamble.
- Headings in `EXERCISES.md` drop the "(11 minutes)" suffixes; the runsheet
  headings keep them.
- Hand-out references (terminal-card, what-did-it-do, toil inventory,
  canned-toil) stay in `EXERCISES.md` as the participant's "you'll need";
  the runsheet's intro lists what to print.

### Step 4: Fix every reference

- Session READMEs: file tables — `EXERCISES.md` → "Participant | The
  exercise block, step by step"; new row `EXERCISE_RUNSHEET.md` →
  "Facilitator | Running the exercise block: timing, cues, misfires".
  Reading-order prose: "runs the five exercises on their own machine from
  `EXERCISES.md`" stays (that is what they type) and gains "with
  `EXERCISE_RUNSHEET.md` beside it".
- `session_01_mental_models/FACILITATOR_GUIDE.md:28` and
  `session_02_meeting_the_harness/FACILITATOR_GUIDE.md:27` — "Read …
  `EXERCISES.md`" → both files. `…FACILITATOR_GUIDE.md:176` "Run it from
  `EXERCISES.md`" → `EXERCISE_RUNSHEET.md`. `…:286` "both in `EXERCISES.md`"
  (the two failure shapes) → `EXERCISE_RUNSHEET.md`.
- `session_02_meeting_the_harness/FLOOR_TEST.md:56` ("`EXERCISES.md`,
  exercise 1, unaided") — participant steps, unchanged target; confirm the
  exercise numbering still matches.
- `session_02_meeting_the_harness/DRY_RUN.md:6` — unchanged target; add a
  fifth item to "Deviations from a true participant environment" (or a
  line in the 2026-08-22 addendum): "2026-08-22: `EXERCISES.md` was split
  into participant steps and a facilitator runsheet after this run; the
  steps themselves are unchanged and were not re-run."
- `session_01_mental_models/handouts/canned-toil.md:154` — follow the link;
  if it points at participant material it stays; if at facilitator
  material, retarget to the runsheet.
- `docs/chunks/fluency_session_01/GOAL.md` and
  `docs/chunks/fluency_session_02/GOAL.md`: add `EXERCISE_RUNSHEET.md` to
  `code_paths`; update the `code_references` `implements:` text for
  `EXERCISES.md` ("The participant steps for the three-exercise block…" /
  "…five-exercise block…") and add one for the runsheet carrying the
  previous description's facilitator half.

### Step 5: Verify

Run from the repo root; all must pass before completion:

1. `uvx --from vibe-engineer ve validate`.
2. Link integrity — for every `](…)` relative link in `curriculum/**/*.md`,
   the target file exists (a ten-line shell loop; keep it in the chunk
   directory as `check_links.sh` if it is worth keeping).
3. Nothing lost — for each session: every `**…**` lead-in line from
   `git show HEAD:curriculum/<session>/EXERCISES.md` appears (first 30
   chars) in the new `EXERCISE_RUNSHEET.md` or, for **What participants
   do**, in `EXERCISES.md`; the number of numbered steps in Session 2's
   new `EXERCISES.md` ≥ the old file's.
4. Audience purity — `grep -c` for "Say it like this|Observable output|
   misfire|Fallback\.|minutes\)" in each new `EXERCISES.md` is 0; `grep -c
   '^[0-9]\+\. '` in each runsheet is 0.
5. Preserved corrections — both exact phrases "Wait — 1 thing in this
   folder has changed" and "four questions, one at a time" are present in
   Session 2's `EXERCISES.md`; the CRLF failure-point row is still in the
   facilitator guide.
6. `bash env/tests/test-commands.sh` passes (no env/ change expected).

## Dependencies

None beyond what is in the repository. `fluency_session_01` and
`fluency_session_02` are ACTIVE; their GOAL.md files are edited in Step 4,
which is allowed for reference upkeep and does not reopen them.

## Risks and Open Questions

- **Session 1 prose → steps.** Turning **What participants do** prose into
  numbered "you" steps is the one place the text is restructured, not just
  moved. Keep each step a sentence from the original; resist improving it.
- **Participant text that quietly assumed a facilitator reader.** Phrases
  like "the room", "participants", "pairs do this twice" inside steps must
  become second person or move to the runsheet. Watch exercise 3 (Session 1,
  the skeptic pass) and exercise 3's pair fallback (Session 2).
- **Facilitator-guide cross-references by exercise number.** The guide
  refers to "exercise 2", "exercise 5" throughout; numbering must not
  change in either new file.
- **DRY_RUN quotes.** It quotes the old text in places (e.g. the "Third
  and most important correction"); those quotes are historical and stay
  as-is — only the forward links need to resolve.
- **DEC-011 wording.** DECISIONS.md has no prior amendment; the "Amended"
  line on DEC-010 is new practice — keep it to one line so it reads as a
  pointer, not a rewrite.

## Deviations

<!--
POPULATE DURING IMPLEMENTATION, not at planning time.
-->
