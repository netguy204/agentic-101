# Drift audit — Sessions 1 and 2, 2026-08-23

<!-- Chunk: docs/chunks/platform_drift_audit - The audit record: what was checked, with what command, and what it said -->

The record the GOAL asks for: every string a deterministic check quotes,
every path and anchor the manifest names, every rubric row against its
checkpoint, with the command that verified it. Paths are relative to the
repository root. Anything marked **verified** was checked against the file
as it stands today, not against memory of it.

---

## 0. The premise, checked first

The narrative says the transcriptions were written before the 2026-08-22
material changes. **They were not**, and this reframes the whole audit. The
material commits run from 11:00 to 13:02 on 2026-08-22 — `5dd3d5c` the
revert walkthrough and the CRLF fix, `9f33b91` the exercise split, `0485ddd`
the CRLF-warning row, `aa3a157` course-update and DEC-012, `146c924` the
supplier-email example, `ee28120` Session 3 — while every transcription in
`platform/` was committed at 14:12 the same day (`16ac3e5` the manifest,
`fa1de00` the rubrics, `9245a43` the scripts and recall, `41ee811` the
README). Two of the changes the GOAL names are older still: the inventory
header rename (`3a53f79`) and the smoke-test output (`505bb14`) are
2026-08-08.

    $ git log --format='%h %ad %s' --date=iso \
        --since='2026-08-22 14:00' -- curriculum/ env/ setup/
    (no output)

Nothing in the material has changed since the transcriptions were written.
So the expected finding — a rubric quoting a header that has since been
reworded — cannot exist, which is what the greps below found, and it is why
the two fixes this chunk made are about something else.

## 1. Validator, before and after

Same command both times, from the sibling checkout — `pnpm contract:validate
<this worktree>`, run in `../learning-platform`:

    agentic-101 (Agentic 101) satisfies Module Contract v1: 2 sessions, 0 warnings.
      01_mental_models: 5 criteria, 2 artifacts, 4 audio segments
      02_meeting_the_harness: 4 criteria, 4 artifacts, 4 audio segments

Clean before the fixes and clean after: no errors, no warnings, nothing to
record as accepted-with-a-reason. Worth being clear about what that does and
does not mean — a rubric that quotes a handout header the handout no longer
prints parses perfectly and validates clean. The validator cannot see this
chunk's subject, which is why the rest of this file exists.

## 2. Every string a deterministic check quotes

| # | Rubric / check | Quoted string | Read from | Verified |
|---|---|---|---|---|
| Q-1 | `01_mental_models.yaml` `judgeability_marked` → `column:` | `In or out of my judgment boundary?` | `handouts/toil-inventory.md` line 22 (and 35, 45, 70) | **verified**, character for character including the question mark |
| Q-2 | `01_mental_models.yaml` `check_column_filled` → `column:` | `How I'd check` | same file, same four tables | **verified**, including the typographic apostrophe |
| Q-3 | all three `01_mental_models.yaml` checks → `table:` | `The sheet` | `## The sheet`, line 18 | **verified**; the two worked examples sit under their own `###` headings, so "heading above the table" resolves to those and not to `The sheet` — the rubric's comment is accurate |
| Q-4 | the *old* header, repository-wide | `Could I tell good from bad?` | everywhere | **no hits** outside git history — `3a53f79`'s rename left nothing stale |
| Q-5 | `02_meeting_the_harness.yaml` `used_revert` → `phrases[0]` | `Your checkpoints, newest first:` | `env/bin/revert` lines 113 and 174 | **verified** |
| Q-6 | `02_meeting_the_harness.yaml` `used_revert` → `phrases[1]` | `Back to:` | `env/bin/revert` line 227, the message it commits | **verified**; it is the record `revert` writes rather than a prompt it prints, so no 2026-08-22 rewording touches it |
| Q-7 | `02_meeting_the_harness.yaml` `ran_delegation` → `tools:` | `[write, edit, bash]` | `handouts/terminal-card.md` § "The four tools" | **verified**; `read` is correctly excluded — bar item 1 is "an agent **changed** a real file" |
| Q-8 | `setup.yaml` `phrases[0]` | `the course environment is healthy` | `setup/bin/course-smoke-test` line 144 | **verified** |
| Q-9 | `setup.yaml` `phrases[1]` | `your key is saved` | line 220 ("…and only readable by you"), also 227, 229 | **verified** on every PASS branch |
| Q-10 | `setup.yaml` `phrases[2]` | `the agent did a real task: it created a file when asked` | line 300 | **verified** |
| Q-11 | `setup.yaml` `phrases[3]` | `PASS — you are ready for the course.` | line 330 | **verified**, em dash included |

Q-8 to Q-11 were compared by script rather than by eye, against both the
program and the sample output a student sees in `setup/README.md`; all four
phrases are present in both.

**Environment 1.1.0.** The GOAL asks whether the setup rubric matches env
1.1.0's output. It does, and it does so by *not* quoting the version. The
string `Course environment 1.1.0` appears in `setup/README.md` line 100 —
but that is `course-check`'s banner in the Step 1 install transcript, not
`course-smoke-test`'s PASS path, and `course-smoke-test` captures
`course-check`'s output into a variable it prints only on failure. A rubric
quoting the banner would have broken at 1.0.0 → 1.0.1 (the CRLF fix) and
again at 1.0.1 → 1.1.0 (`course-update`, DEC-012). All four quoted phrases
come from parts of their lines that interpolate no pin and no version, which
is what the file's own header comment claims and what this audit confirms.

## 3. Rubric beside checkpoint, end to end

This pass had never been done since the exercise split (`9f33b91`). It has
now been done for both sessions, reading each rubric next to its
`CHECKPOINT.md` in full.

**Coverage of the bar.** Session 1: bar item 1 → `three_entries` +
`judgeability_marked`; bar item 2 → `boundary_claim` + `named_check`;
`bar: all`, matching "Both halves are required… The session's outcome is the
pair." Session 2: four numbered items → four criteria in the checkpoint's
order, and the deterministic/judged split is the checkpoint's own sentence
("The first and fourth are facts you can see; the second and third are the
ones you have to hear").

**Every near-miss row, mechanically.** Each row of both tables was extracted
from the checkpoint and searched for in the rubric text:

| Checkpoint row | Session | Rubric criterion | Present |
|---|---|---|---|
| "It's in because I do it every week." | 1 | `boundary_claim` | yes, with the facilitator's corrective |
| "It's out because I couldn't do it myself." | 1 | `boundary_claim` | yes, "most common near-miss by far" kept |
| "I'd just read it over and I'd know." | 1 | `named_check` | yes |
| "It's in because the agent could definitely do it." | 1 | `boundary_claim` | yes |
| "It's in, but I'd have to check every line." | 1 | `named_check` | yes — the row the checkpoint prints and then says to accept, kept as a row |
| "It standardised all my statuses and tidied the dates." | 2 | `read_tool_calls` | yes |
| "It looked fine." | 2 | `named_check` | yes |
| "I checked it against what it said it did." | 2 | `named_check` | yes |
| "It used all four tools." | 2 | `read_tool_calls` | yes |
| "I didn't need to revert, mine went fine." | 2 | `used_revert` | yes, re-voiced for a student who is not in the room, with the comment saying so |
| "It only used one tool, so I don't think it really did anything." | 2 | `read_tool_calls` | yes |

Eleven rows, eleven present. The only textual differences are backticks
dropped from `write` and `revert` (a rubric string is not markdown) and the
Session 1 "accept it" row's *What's missing* cell, which the rubric expands
into the reason the row is kept — both already explained in comments beside
them.

**Pass exemplars.** Session 1's two are quoted whole. Session 2's two are
split across `read_tool_calls` and `named_check` — the checkpoint's first
quote supplies the tool-call half and the check half, and its second (the one
the checkpoint calls the better answer) sits under `named_check` with the
commentary instruction preserved in a comment. Verified against the
checkpoint's "What a pass sounds like" section.

**Two places a rubric carries more than the numbered bar**, both deliberate,
both pre-existing, both re-read and left alone — see N-3 and N-2 below.

## 4. Every path and anchor in `module.yaml`

Scripted: each `curriculum/`, `setup/`, `platform/` reference in the manifest
was checked for file existence, and each `#anchor` slugified against the real
headings of the file it names.

- 47 references, **all resolve**. This includes the four `ta_knowledge`
  anchors the GOAL names — `FACILITATOR_GUIDE.md#anticipated-failure-points-and-recovery-moves`
  and `#faq-questions-you-will-be-asked`, in both sessions — which survived
  the exercise split intact, and both sessions' `EXERCISE_RUNSHEET.md`,
  which the split created and which the manifest names as whole documents.
- Both sessions' `lab.parts` anchors resolve to real `## Exercise N` and
  practice-lap headings. A part anchor that matches nothing is an **error**
  in the validator (unlike a `ta_knowledge` anchor, which degrades to a
  warning), because it is a place a student is sent.
- Minutes: Session 1 `25 + 12 + 20 + 15 + 20 = 92` = `estimated_minutes.lab`;
  Session 2 `25 + 15 + 25 + 20 + 30 + 10 = 125` = `estimated_minutes.lab`.
  Both exact, and both include the practice week as Contract v1.1 requires.
- Practice-lap minutes against their source: Session 1's 5 x 4, 15 and 20,
  total 55, match `PRACTICE.md` § "The time budget"; Session 2's 20, 15 each
  and 10, total 60, match its own budget table exactly.
- Each part's `outcome` was read against the exercise it points at (Session
  1's "at least four rows" is exercise 1's own "when you're done" line;
  Session 2's `where_am_i` outcome is exercises 1 and 2's; `two_real_ones`'
  "passed all four questions" is `PRACTICE.md`'s four-question gate). No
  part asserts anything its exercise does not.

## 5. The Session 2 material changes, against script and recall

| Change | Old wording | Grep of `platform/` | Result |
|---|---|---|---|
| revert prompt (`5dd3d5c`) | `2 things have changed` | no hits | nothing to fix |
| revert lead-in (`5dd3d5c`) | `four things` | no hits | nothing to fix |
| revert lead-in, new wording | `four questions`, `three numbered` | one hit, unrelated: `module.yaml`'s `two_real_ones` outcome says "passed all four questions", which is `PRACTICE.md`'s delegation gate and not `revert`'s prompts | correct as written |
| pull-request example (`146c924`) | `pull request`, `merged`, `deployed` | no hits in the derivatives; `merged` appears once inside a checkpoint pass exemplar, "Mine **merged** two statuses", which is the checkpoint's own word | nothing to fix |

The reason the scripts are untouched by the revert rewording is structural
and worth recording: **the Session 2 script never names a command and never
quotes a prompt.** Segment 2 says "you learn two commands. One saves a
snapshot… The other puts the folder back", and describes the confirmation as
"if you have changed something since your last snapshot, it stops and asks
you about it before it goes anywhere" — true of both the old and the new
prompt text. That is `platform/README.md`'s "the audio carries the why; the
lab card carries the how" doing exactly what it is for: the wording that
churns lives in the room's documents, and the track does not quote it.

**Recall prompts.** All eight (four per session) were read against their
segments. Each asks about something its segment actually says, and no prompt
quotes a handout header, a command, or a prompt string. Session 1's fourth
prompt asks which column decides an entry's quality and answers "the last
one — how you would check", which is the current column 4 name in the
handout's own words. Nothing to fix.

**Segment lengths**, re-measured with the validator's own rule (about 150
words a minute, 450–900 per segment): Session 1 638 / 648 / 679 / 757;
Session 2 652 / 635 / 630 / 705 after this chunk's edit. All inside the band.

## 6. What was fixed

### F-1 — `module.yaml`: Session 2's first part opened past the step DEC-012 requires

`lab.parts[where_am_i].sources` began at
`EXERCISES.md#exercise-1-where-am-i`. The validator's own comment says a
part anchor is "a place a STUDENT is sent — the session page opens the part
at that heading". But `EXERCISES.md` carries the session-start command in a
**Before exercise 1** paragraph *above* the first heading:

> **Before exercise 1:** in the course terminal, type `course-update` and
> press Enter. It fetches any course fixes published since you set up …

DEC-012 makes that the opening of every session from Session 2 onward ("in
the prework's run-the-commands step and as the first line of `EXERCISES.md`"),
and it is not decoration: environment 1.0.1 is what silences the Windows CRLF
warning a participant would otherwise hit in this very exercise. In the room
a facilitator says it out loud; a student alone has only where the part opens.

**Fix:** the unanchored document is now the part's first source, so the
sitting opens at the top of `EXERCISES.md` and the two exercise anchors still
say which exercises the part covers. No part was re-timed, re-split, renamed
or reordered. Session 1 needs no equivalent — its `EXERCISES.md` preamble is
materials and pairing, not a step, and the cross-session rule starts at
Session 2.

### F-2 — `audio/02_meeting_the_harness.md`: the concept track now hands off `course-update`

The question the GOAL poses: the script was written from PREWORK, and
PREWORK § 3 now runs `course-update` before `course-smoke-test`. Must the
script mention it?

**Decision: not in the speech, yes as a lab-card hand-off.** The reasoning,
against the three rules that bear on it:

- *A script is written FROM the concept sources.* PREWORK § 3 is already in
  segment 1 — its **why** ("if your setup is broken, say so and let it be
  fixed properly… do not lose an evening to it"). What was missing was the
  new half of § 3, which is an instruction rather than an idea.
- *The audio carries the why; the lab card carries the how.* A command is
  the lab card's business, and `platform/README.md` is explicit that
  anything a listener would have to look at "goes out to a `> Lab card:`
  line, said once and moved on from". A `$ ` command line in a script is a
  validator error, and the track's house style names no command at all —
  which is why the hand-off describes the command rather than spelling it.
- *A recall prompt has to ask about what its segment actually said.* A lab
  card line is not speech, so **no recall prompt changed** — adding one
  would have broken the rule this chunk is enforcing.

The hand-off is a second `> Lab card:` line in segment 1, beside the terminal
card it points at: the card really does carry it ("Get the latest course
fixes (start of every session)", `handouts/terminal-card.md` line 46). The
segment's speech is unchanged in substance and stays inside the word band.

## 7. What was found and deliberately not changed

- **N-1 — Session 2's part minutes run above the runsheet's blocks.**
  `first_delegation` is 15 against a runsheet block of 14 (and a comment that
  says 14); `read_and_break` is 25 against 13 + 7 + 1. The exercise parts sum
  to 65 where the runsheet's block timings sum to 60. Session 1 does the same
  thing and says why ("with a few more minutes for the second half, which has
  no facilitator watching the clock"); Session 2's comments cite the runsheet
  without stating the allowance. This is `platform_lab_parts`' authorship
  (`f29a15b`, ACTIVE, 2026-08-23), it postdates every material change this
  chunk audits, and `estimated_minutes.lab` is the honest sum of the parts as
  written. Re-timing is restructuring rather than drift-fixing, so it is
  recorded here for whoever next touches those parts.
- **N-2 — Session 2's `used_revert` asks for evidence the room never asks
  for.** The rubric collects a pasted `revert --list`; Session 2's material
  never has a participant run `revert --list` (Session 3's does). The
  checkpoint's bar item 4 is "used `revert` at least once", and `revert`
  leaves no trace in the session log because the participant types it. The
  rubric's own comment argues this out and the checkpoint's remote-cohort
  note already accepts written evidence. Verified as a deliberate
  transcription decision, not drift.
- **N-3 — Session 1's `check_column_filled` is stricter than the numbered
  bar.** The bar's item 1 is three entries annotated with judgeability; the
  filled check column comes from the checkpoint's Recovery section ("Entries
  but no checks") and DEC-010, both cited in the rubric's comment. It makes
  the platform's bar harder than the room's for a student with annotated rows
  and an empty column 4. Re-read beside the checkpoint and left as authored
  (`platform_module_contract`, ACTIVE); flagged here because it is the one
  place where the two deliveries can disagree about a pass.

## 8. Scope

No file under `curriculum/`, `env/` or `setup/` was modified by this chunk.
Both fixes are in `platform/`. `concept.sources` and `platform/index/` were
not touched — a sibling chunk owns them — and the `module.yaml` edit is
confined to one part's `sources` list inside the `lab.parts` block.
