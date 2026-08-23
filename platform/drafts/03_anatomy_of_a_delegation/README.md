# Session 3's platform version, drafted

<!-- Chunk: docs/chunks/platform_session_03_draft - The promotion note: what is here, what promotion is, and what it waits on -->

This directory is Session 3's platform version, written alongside the
session itself and **staged, not served**. Nothing in here is read by
anything: `platform/module.yaml` is the only file the platform knows the
name of and everything else is found *through* it, so a file no manifest
entry points at is invisible to the validator and to ingest alike. Session 3
does not appear in `module.yaml`, and that listing is the entire difference
between a draft and a served session.

Why it is written now rather than at promotion time: DEC-013, and
`docs/trunk/PLATFORM_AUTHORING.md` § "A new session, in order", step 2. The
transcription is cheap while the material is warm — you remember which
sentence of the bar each criterion came from and which handout header a
check now depends on — and expensive six months later from documents you
have to re-read to trust.

## What is here

| File | Promoted to | Transcribed from |
|---|---|---|
| `session.yaml` | one entry under `sessions:` in `platform/module.yaml` | the session's seven files, divided by audience; Contract v1.1, so `lab.parts` included |
| `rubric.yaml` | `platform/rubrics/03_anatomy_of_a_delegation.yaml` | `CHECKPOINT.md` |
| `audio.md` | `platform/audio/03_anatomy_of_a_delegation.md` | `PREWORK.md` part 1 and `README.md`'s teaching spine |
| `recall.yaml` | `platform/recall/03_anatomy_of_a_delegation.yaml` | the script, one prompt per segment |
| `index.md` | `platform/index/03_anatomy_of_a_delegation.md` | `README.md` and `PREWORK.md`, rewritten for the student |
| this file | nothing — it stays behind and the directory goes | — |

`session.yaml`'s `rubric:` key already names the *served* path, so promotion
is a paste rather than a translation.

## Promotion waits on the floor test

**Do not promote yet.** `curriculum/session_03_anatomy_of_a_delegation/FLOOR_TEST.md`
records every result as **PENDING**: the human floor test, the Windows pass,
the interactive TUI pass and the first teach. The dry run
(`DRY_RUN.md`) establishes that the three Priya briefs behave as the
material claims; it explicitly cannot tell you whether a non-programmer can
write a brief from the handout or find the box that failed, which is
Session 3's central claim and the thing the platform would be selling.

The platform inherits the room's quality bar and does not get to serve a
session the room has not survived. What the room changes — a reworded bar
item, a re-timed block, a near-miss nobody anticipated — is **re-derived**
into this draft rather than reconciled with it. Re-deriving a draft is
cheap; that is the point of having written it.

Three specific things a floor test is likely to move, and what each one
touches here:

- **Exercise 3's twenty-four minutes.** `FLOOR_TEST.md` names it as the
  number most likely to change in either direction. It is the `the_two_runs`
  part's `minutes:` and a term of `estimated_minutes.lab`, and the lab total
  is quoted to the student in `index.md`. All three move together.
- **The wording of a bar item.** `rubric.yaml` is a transcription and may
  not say anything `CHECKPOINT.md` does not, so a reworded bar item or a
  new near-miss row is not finished until this file has been re-read.
- **The four box headings of `handouts/delegation-brief.md`.** A
  deterministic check quotes them exactly. Reword one and the check does not
  error — it fails every student silently. The rubric lists the frozen
  strings and where they are printed, in comments.

## Promotion, when the room has proven it

The mechanics are `platform/README.md` § "Drafting a session before it is
served". In short:

1. Move the five files to their served locations per the table above, and
   remove this directory (this note included).
2. Paste `session.yaml`'s entry into `sessions:` in `module.yaml`, after
   `02_meeting_the_harness`, indented two spaces to sit under that key. The
   numeric prefixes have to agree with the list order. Everything from
   `- id:` down travels, comments included — the header comment above it is
   about the *draft* and stays behind with this directory.
3. Run the validator from a checkout of the platform:
   `pnpm contract:validate /path/to/agentic-101`. Read every error **and**
   every warning.
4. Cut the `platform-YYYY-MM` tag and tell the platform's instructor surface
   to ingest it.

No step in that list is authoring. If promotion turns into writing, this
draft was not finished — finish it here and promote again.

**One edit step 2 does carry**, and it is upkeep rather than authoring:
Session 2's `where_am_i` part in `module.yaml` has a comment calling itself
"the one part in either session that opens at the top of its document".
Session 3's `worst_one_and_brief` part opens the same way and for the same
reason — DEC-012's `course-update` is a "Before exercise 1" paragraph above
the first heading of `EXERCISES.md` — so at promotion that comment is
describing three sessions and needs a word changed. It is flagged here
rather than left to be discovered cold.

## What the first validator run will be checking

That run is the first time anything has read this session at all, so it is
worth knowing what it looks at and what has already been done by hand.

The validator will check: the rubric against its schema and against the
artifacts `session.yaml` declares (every criterion answerable from a
declared artifact, every declared artifact asked about by some criterion);
every part `sources` anchor against the real headings of `EXERCISES.md` and
`PRACTICE.md`; that every lab source is named by some part; the parts'
minutes against `estimated_minutes.lab`; the script for tables, code fences
and command lines, and each segment's word count; each segment's
`> Recall:` id against `recall.yaml`; and every `ta_knowledge` anchor.

Done by hand while drafting, because nothing here is checked (2026-08-23,
`docs/chunks/platform_session_03_draft`):

- **Anchors.** Every anchor in `session.yaml` was slugged with the
  platform's own rule (`src/contract/validate.ts`, `slugify`) and matched
  against the real headings of `EXERCISES.md`, `PRACTICE.md` and
  `FACILITATOR_GUIDE.md`.
- **Quoted wording.** The four box headings, the three checkpoint names, and
  `revert`'s two printed strings were grepped against the handout,
  `EXERCISES.md` and `env/bin/revert`; the rubric's comments name the files
  and the lines.
- **The script.** Segment word counts measured with the platform's own count
  (450–900 each), no tables, no fences, no command lines, one `> Recall:`
  per segment and nothing after it.
- **A dry promotion.** The whole promotion — move, paste, validate — was
  rehearsed in a scratch copy of this repository, and the validator reported
  three sessions and zero warnings there. That rehearsal is evidence that
  promotion needs no authoring; it is **not** a substitute for step 3, which
  has to run against the real tree after the floor test's changes have
  landed.

None of that makes the draft verified. It narrows what the first real run is
likely to find to the things the room changes, which is the only thing that
should be finding them.
