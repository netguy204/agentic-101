<!--
This document captures HOW you'll achieve the chunk's GOAL.
It should be specific enough that each step is a reasonable unit of work
to hand to an agent.
-->

# Implementation Plan

## Approach

Edit in place, one seam at a time, and move rather than invent. Every
room-bound instruction in a participant text already has a facilitator-side
twin in the runsheet (the pairing fallback, the odd-number case, remote
delivery, the board tally, the show of hands). So the work is almost never
"write a solo version" — it is **delete the room mechanics from the
participant steps, check the runsheet already carries them, and add the
line only where the runsheet does not.** That keeps DEC-011 purity and the
runsheet-never-restates invariant simultaneously, and it is why the room
loses nothing: the facilitator runs the round *over* the individual steps.

The participant text's default reader becomes the student who is alone.
The room stays present where it is an *offer* rather than a *dependency*
("if you're working with someone, …"), which is the same shape the two
sessions already use for the canned-sheet fallback: one bolded aside after
the steps, never inside them.

Four edit classes, applied in this order:

1. **Restructure two exercises** (S1 ex. 3, S3 ex. 1) so the numbered steps
   are things one person does. S1's skeptic becomes the *question* rather
   than a partner — the exercise's own no-pair note already said the
   facilitator asks the same question, so generalizing it costs nothing and
   the outcome (at least one row changed) is unchanged. S3 ex. 1 keeps the
   three reasons in the participant text (they are the concept, and
   exercise 4 refers back to "the second reason from exercise 1") and drops
   the round: write your sentence, sort it yourself, write the reason on
   the worksheet.
2. **Sweep the three files** for the remaining room dependencies: "Stuck at
   any point? Say so — you'll be paired", "you'll be paired; it isn't fixed
   live", "Nobody runs an agent until everyone in the room has finished",
   the two "One question, hands up" wrap-ups, and S1's "Say so — you'll be
   paired". Each becomes either a solo instruction with the pairing as an
   in-room aside, or moves to the runsheet if the runsheet lacks it.
3. **Add the contract** — two or three lines at the top of each
   `EXERCISES.md`, in the student's language, naming what they will have at
   the end, matching that session's `CHECKPOINT.md` bar. This is
   PLATFORM_AUTHORING.md's "The contract comes before the work" and it goes
   *above* the "You'll need" list, because the destination should precede
   the packing list.
4. **Add the cadence clause** to S2 and S3 `PRACTICE.md` where timing is
   phrased as the working week, without touching any budget number.

Frozen surfaces, checked before and after every edit:

- **`## Exercise N — …` and `## Wrapping up` headings are byte-identical.**
  `platform/module.yaml` anchors `lab.parts[].sources` at
  `EXERCISES.md#exercise-1-brain-dump`, `#exercise-3-the-skeptic-pass`,
  `#wrapping-up` (S1) and all five S2 exercises plus `#wrapping-up`.
  Module Contract v1.1 fails loudly on a renamed anchor. Session 3 is not
  yet anchored; its headings are held stable anyway.
- **Exercise and step numbering in Sessions 2 and 3 is unchanged** — the
  runsheets, `FACILITATOR_GUIDE.md`, `FLOOR_TEST.md` and `DRY_RUN.md` all
  address steps by number.
- **A part may not say anything its exercises do not** (`module.yaml`'s own
  comment). The S1 `skeptic_pass` part's outcome — "at least one row
  changed after asking 'how would I know if it was wrong?'" — is already
  written in the solo voice and must still be true of the revised text; it
  is the target the restructure aims at, not a thing to edit.

Testing follows `docs/trunk/TESTING_PHILOSOPHY.md` for documentation
changes: no participant *command* changes, so no re-dry-run is owed. The
checks are mechanical — the DEC-011 purity greps, link integrity, heading
identity against `HEAD`, step-count identity for S2/S3, `ve validate`, and
the platform validator from `../learning-platform`.

## Subsystem Considerations

- **docs/subsystems/session_anatomy** (DOCUMENTED): this chunk **uses** the
  subsystem. Three of its invariants bind the work directly: the audience
  split (participant-only second person in `EXERCISES.md`,
  facilitator-only in `EXERCISE_RUNSHEET.md`), *the runsheet never restates
  a step* (so mechanics moving out of `EXERCISES.md` must land in the
  runsheet only if not already there — no duplication), and *participant
  text assumes only what has been taught*. Fixed filenames and handout
  column names are untouched. No new deviation is expected; if the sweep
  turns one up, it gets recorded in the subsystem's Known Deviations rather
  than fixed here.

## Implementation Steps

### Step 1: Session 1 — exercise 3 becomes a solo skeptic pass

In `curriculum/session_01_mental_models/EXERCISES.md`:

- Keep the heading `## Exercise 3 — The skeptic pass` byte-identical.
- Replace "In pairs. Four minutes each way; two or three tasks each is
  plenty." with a solo frame naming the same budget (about eight minutes,
  two or three tasks) — the participant plays their own skeptic.
- Rewrite steps 1–4 as individual actions: pick a task and say (to
  yourself, in writing if it helps) whether you marked it in, out or not
  sure; ask the question — the blockquote *"How would you know if it was
  wrong?"* stays exactly as it is, it is the concept; ask it of your own
  answer again, and again, until the answer is concrete enough that you'd
  bet on it, or you concede "…actually, I couldn't tell"; then the next
  task. Drop step 4 ("Swap.") into the same last step as "then do the next
  task" so the step count stays sensible; S1's steps are not
  number-referenced by the runsheet (it says "Steps: `EXERCISES.md`,
  exercise 3" only), so renumbering here is safe — verified by grep before
  editing.
- Keep the "actually, I couldn't tell" paragraph and the "expect to change
  at least one row" sentence verbatim: they carry the exercise's outcome
  and the part's declared outcome in `module.yaml`.
- Replace the two room-only asides (**No pair, or you'd rather not talk
  about your work aloud?** and **Remote?**) with one **Working with
  someone?** aside offering the pair version: one names a task, the other
  asks the question until they'd bet on it, then swap — four minutes each
  way. This is the in-room framing, phrased as an option.
- Delete "Stuck at any point? Say so — you'll be paired." from the intro
  (a room dependency in a file whose reader may have no room); confirm the
  runsheet's **Fallback** already carries the odd-number, no-pair,
  won't-say-it-aloud and remote cases. It does — no runsheet edit needed
  beyond Step 2's.

### Step 2: Session 1 runsheet — carry the pairing as the room's form

In `curriculum/session_01_mental_models/EXERCISE_RUNSHEET.md`, exercise 3:

- Update **What participants do.** so it describes what the room does over
  the individual steps: the participant asks themselves the question; in
  the room you pair them and the partner asks it, four minutes each way,
  then swap. This is a summary for the facilitator, not a restatement of
  steps — the existing paragraph is already that shape.
- Add one sentence making the relationship explicit ("the exercise is
  written so it works alone; pairing is how we run it here"), so a
  facilitator reading only the runsheet is not surprised by the
  participant text.
- Leave **Say it like this.**, **Observable output.**, **Most common
  misfire.**, **Fallback.** and **Remote delivery.** as they are — they are
  already the room mechanics and already the right voice.

### Step 3: Session 3 — exercise 1 becomes individual steps

In `curriculum/session_03_anatomy_of_a_delegation/EXERCISES.md`:

- Keep the heading `## Exercise 1 — Your worst one` byte-identical and keep
  four numbered steps (the runsheet says "Steps: `EXERCISES.md`, exercise
  1"; `FACILITATOR_GUIDE.md`/`DRY_RUN.md` are checked for step references
  before editing).
- Replace the opening line "Everybody brought a delegation that went badly.
  The room goes round once, one sentence each, and sorts them." with the
  individual frame: you brought one that went badly; you are going to say
  what happened in one sentence and sort it into one of three kinds.
- Steps become: (1) worksheet and sentence in front of you; (2) write the
  sentence down — what you asked for, what went wrong, one sentence, no
  explaining and no defending; (3) sort it against the three reasons — the
  three bolded definitions stay exactly as they are; (4) write which of the
  three it was at the top of your worksheet, with the **out of bounds**
  clause unchanged.
- Keep **What you should see:** unchanged.
- Add a **Working with others?** aside: the round — one sentence each,
  sorted out loud, a tally as you go — as the in-room form over the same
  steps.
- The board tally, the four-word bucket naming, the worked placements
  table and the "run the round fast" timing are already in the runsheet
  (exercise 1) — verify, do not duplicate.

### Step 4: Session 3 sweep and wrap-up

Same file:

- Intro: "Stuck at any point? Say so — you'll be paired. A pair runs every
  exercise at full value; the person without the laptop holds the
  keyboard." → make the pairing conditional rather than the answer to being
  stuck ("If you're working with someone, …"), preserving the
  keyboard-holder rule, and give the solo reader a real next move (the
  session's own troubleshooting notes / the Priya briefs).
- Exercise 3's **In a pair?** aside stays (it is already an aside, already
  conditional).
- `## Wrapping up`: "One question, hands up: **who has a brief that ran
  twice…**" becomes a self-check in the same words ("Check: do you have a
  brief that ran twice, and can you say in one sentence why the second run
  was better?"), keeping the pointer to the sentence at the bottom of the
  brief and to the checkpoint round. The runsheet's **Wrapping the block**
  already owns the hands-up move — no runsheet edit.

### Step 5: Session 2 sweep

In `curriculum/session_02_meeting_the_harness/EXERCISES.md`, with **no
exercise renumbering and no step renumbering**:

- Intro: same treatment as Session 3's "Stuck at any point?" line.
- Exercise 1's failure table: "Put your hand up — you'll be paired; it
  isn't fixed live." → an instruction that works alone (don't try to fix it
  now; use a working machine / say so if someone is running the session) —
  the runsheet row already tells the facilitator to pair them and not fix
  it live, so the room behaviour is unchanged.
- Exercise 2's opener: "Nobody runs an agent until everyone in the room has
  finished this exercise, pairs included." → the rule stated for the reader
  ("Do this one before you run an agent at all"), which is what the
  sentence is actually for; the room's gating sentence is already in the
  runsheet ("Nobody in the room starts pi until … pairs included").
- Exercise 2's and exercise 3's **In a pair?** asides stay.
- Exercise 4's "That's the most useful run in the room." → "the most useful
  run there is" (harmless room reference, but it is inside a sentence a
  solo student reads about themselves).
- `## Wrapping up` (heading byte-identical): "One question, hands up: …
  That is the session's outcome in one show of hands." → the same question
  as a self-check, with the outcome sentence kept. The runsheet's
  **Wrapping the block** owns the show of hands.

### Step 6: The contract before the work, in all three files

Insert two or three lines at the top of each `EXERCISES.md`, immediately
after the HTML backreference comments and before the existing "Three/Five/
Four exercises…" paragraph, in second person and matching the session's
`CHECKPOINT.md` bar:

- **S1** — a toil inventory with at least three rows marked **in** that
  have a real check written next to them, and being able to say for one of
  your own tasks why it sits inside or outside your judgment boundary.
- **S2** — a `sample.csv` in `~/course-practice` that an agent made and
  then cleaned, a filled-in `what-did-it-do.md` you can answer from the
  evidence rather than the agent's summary, and having used `revert`
  yourself to recover a change.
- **S3** — a delegation brief that ran twice with one change between the
  runs, the one sentence naming the box you changed and why, and box 5
  filled in.

Wording is drawn from the checkpoint bars, in the student's voice, without
quoting the facilitator-facing framing ("Every participant leaves the room
having…").

### Step 7: Practice cadence tolerance

- `curriculum/session_02_meeting_the_harness/PRACTICE.md` line 104 ("When
  each task next comes round:") and
- `curriculum/session_03_anatomy_of_a_delegation/PRACTICE.md` lines 9, 23,
  56, 76, 84, 139 (the "when the task next comes round" family, including
  the time-budget table row and the "If the real task doesn't come round
  this week" note)

get the self-paced clause — "or the next time you do this task, whenever
that is" — added once per distinct place where the phrase sets *when* work
happens, not every occurrence (repeating it six times is the prose bloat
PLATFORM_AUTHORING.md warns against). Minimum: the S2 heading line, the S3
opening paragraph, the S3 budget-table row, and the S3 "doesn't come round
this week" note. **No minute figure changes**, and the table's total is
re-read after the edit.

### Step 8: Verify

Run from the worktree root; all must pass:

1. **Headings frozen** — for each of the three `EXERCISES.md`,
   `diff <(git show HEAD:<file> | grep '^## ') <(grep '^## ' <file>)` is
   empty.
2. **Numbering frozen (S2, S3)** — the numbered-step count per exercise
   (`grep -c '^[0-9]\+\. '` within each `## Exercise` block) matches
   `HEAD`, and the exercise headings' numbers are unchanged (covered by 1).
3. **Audience purity** — `grep -c -E "Say it like this|Observable
   output|misfire|Fallback\.|minutes\)"` is 0 in each `EXERCISES.md`;
   `grep -c '^[0-9]\+\. '` is 0 in each `EXERCISE_RUNSHEET.md`.
4. **Room-dependency sweep** — `grep -n "you'll be paired\|hands up\|show
   of hands\|everyone in the room\|In pairs\|the room goes round"` in the
   three `EXERCISES.md` returns only conditional in-room asides, and each
   remaining hit is justified in the chunk's completion notes.
5. **Link integrity** — every `](…)` relative link in `curriculum/**/*.md`
   resolves (the loop from `fluency_exercise_split` Step 5).
6. `uvx --from vibe-engineer ve validate`.
7. **Platform validator** — `pnpm contract:validate <this worktree>` from
   `/Users/btaylor/Projects/learning-platform`, clean (warnings read).
8. **Derivative grep** — `grep -rn` in `platform/` for each distinctive
   phrase changed (the wrap-up questions, "you'll be paired", the skeptic
   question, the three reasons, the practice cadence phrases). Record the
   result in the chunk. Fix only what a changed source forces; a sibling
   chunk is auditing `platform/` concurrently.
9. `bash env/tests/test-commands.sh` as a no-collateral-damage canary (no
   `env/` change expected).

## Dependencies

None beyond the repository and the sibling `../learning-platform` checkout
for `pnpm contract:validate`. `fluency_session_01/02/03` are ACTIVE and
stay ACTIVE; their `code_references` descriptions are only touched if a
file's role changed, which this chunk does not do.

## Risks and Open Questions

- **Anchor breakage is silent-ish.** A renamed `## Exercise N` heading
  fails `contract:validate` loudly, but a *reordered* one would still
  validate while pointing a part at the wrong content. Neither reorder nor
  rename anything; Step 8 check 1 is the guard.
- **Purity greps are keyword-based, not semantic.** "you'll be paired" is
  catchable; "as the others go" is not. The sweep is a read of all three
  files, with the greps as the backstop rather than the method.
- **Removing the room can flatten the teaching.** S3 exercise 1's round is
  pedagogy, not logistics — the tally *is* the lesson that there are only
  three reasons. The mitigation is that the three reasons stay in the
  participant text and the sort is still the participant's own act; the
  tally's job (showing the reasons are few) is carried by the text saying
  so. If in review the solo version reads thinner than the round, the fix
  is one sentence in the participant text, not restoring the round.
- **The runsheet must not gain restatements.** Steps 2's edit is the one
  place a step could leak into the facilitator file. Keep it a summary in
  the facilitator's voice, ending in the existing "Steps: `EXERCISES.md`,
  exercise 3" pointer.
- **`estimated_minutes` is a promise.** Nothing here changes an exercise's
  duration, so `module.yaml`'s part minutes and the S1/S2 lab sums stay
  correct. If the S1 restructure changed the eight-minute shape, the part
  would need re-reading — it does not.
- **Concurrent platform audit.** Another chunk is editing `platform/`.
  Keep platform-side edits to the minimum a source change forces, and name
  them explicitly so the merge is reviewable.

## Deviations

- **Step 5 (S2 setup-failure row).** The first draft replaced "Put your hand
  up — you'll be paired; it isn't fixed live" with "go back and run the
  setup again". That contradicts the course's own standing instruction in
  `PREWORK.md` ("**Do not try to fix it.** … don't lose an evening to it"),
  which is a deliberate stance, not an accident of the room. Changed to
  point at `course-smoke-test` and the prework's send-it-on rule, which is
  what a solo student actually does and what the room does too.
- **Steps 4 and 5 (the "stuck" line).** Planned as a pointer to each
  session's troubleshooting notes; the first draft named them as an "if it
  goes wrong table", which only Session 2 exercise 1 has. Reworded to
  describe them without naming a structure that isn't uniform.
- **Step 7 (S3 practice cadence).** Two of the six planned sites needed no
  edit: section 2's heading already carries "or the next day, on the same
  material", and the week-gets-away section already says "the real task if
  it comes round, the made-up material if not". Adding the clause there
  would have been the prose bloat the plan warned against. Four sites
  edited (S3 opening, budget-table row, doesn't-come-round note; S2's
  heading line).
- **Step 8 check 8 (derivative fix).** One `platform/` edit was forced: the
  comment above `lab.parts[skeptic_pass]` in `platform/module.yaml` said the
  solo reading was "what the exercise's own no-pair note already says". The
  no-pair note is gone — the exercise is solo-first now and the pairing is
  the aside — so the comment's justification was inverted. Comment text
  only; no key, minute, anchor or outcome changed. Nothing else in
  `platform/` quotes wording this chunk touched.
