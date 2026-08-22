---
status: ACTIVE
ticket: null
parent_chunk: null
code_paths:
- platform/module.yaml
- platform/rubrics/setup.yaml
- platform/rubrics/01_mental_models.yaml
- platform/rubrics/02_meeting_the_harness.yaml
- platform/recall/01_mental_models.yaml
- platform/recall/02_meeting_the_harness.yaml
- platform/audio/01_mental_models.md
- platform/audio/02_meeting_the_harness.md
- platform/pronunciation.yaml
- platform/README.md
code_references:
- ref: platform/module.yaml
  implements: "The manifest: module identity and budgets, the setup gate, and per session the concept/lab/ta_knowledge split of DEC-010 and DEC-011's seven fixed filenames, the artifacts a student submits, the rubric, and time estimates"
- ref: platform/rubrics/setup.yaml
  implements: "The gate before Session 1, over pasted course-smoke-test output, quoting only phrases that no pin interpolates"
- ref: platform/rubrics/01_mental_models.yaml
  implements: "Session 1's CHECKPOINT.md as criteria: three rows, judgeability marked and the check column filled (read off the four-column sheet), the spoken boundary claim, and the named check — with all five near-miss rows and their corrective questions"
- ref: platform/rubrics/02_meeting_the_harness.yaml
  implements: "Session 2's CHECKPOINT.md as criteria, split the way the checkpoint splits itself: ran a delegation and used revert are decided by machine, reading the tool calls and naming the check are judged — with all six near-miss rows and their corrective questions"
- ref: platform/recall/01_mental_models.yaml
  implements: "The four recall prompts and model answers that close Session 1's audio segments"
- ref: platform/recall/02_meeting_the_harness.yaml
  implements: "The four recall prompts and model answers that close Session 2's audio segments, asking about the why rather than the steps"
- ref: platform/audio/01_mental_models.md
  implements: "Session 1's concept track for the ear: why the moment matters, agent versus chatbot, judgment versus expertise and the boundary, and the inventory"
- ref: platform/audio/02_meeting_the_harness.md
  implements: "Session 2's concept track for the ear, carrying only the why — the terminal, why undo is taught first, watching something act, and why the agent's paragraph is not evidence — with commands handed to lab cards"
- ref: platform/pronunciation.yaml
  implements: "How the TTS voice says the course's domain terms, pi above all"
- ref: platform/README.md
  implements: "What platform/ is, the rule that CHECKPOINT.md stays the source, the handout-wording hazard, and how to add a session"
narrative: null
investigation: null
subsystems: []
friction_entries: []
depends_on: []
created_after: ["fluency_session_03"]
---

# Chunk Goal

## Minor Goal

This course is going to be delivered a second way. Alongside the live
cohort, a self-paced platform will serve the same sessions to students who
never sit in the room: it reads the concept material aloud, hands out the
lab, collects what the student made, and runs the checkpoint conversation
that a facilitator runs in the last ten minutes. That platform owns no
course content. It ingests this repository at a git tag and asks it, in
machine-readable form, three questions the curriculum has so far only
answered in prose:

1. **Which files are what?** Which are concept material, which are lab,
   which are the facilitator's private notes that a virtual TA may read but
   a student may not.
2. **What is the bar, exactly?** Not "the participant can say why a task is
   inside their judgment boundary" — the criteria, the evidence that
   satisfies each one, what a pass sounds like, what each near-miss sounds
   like, and the corrective question to ask when it does.
3. **What does the concept material sound like?** Sessions 1 and 2 are
   written to be read at a desk. The platform's students listen on a
   commute, with no screen.

This chunk answers all three, in a new top-level `platform/` directory:

- `platform/module.yaml` — the manifest. Module identity, per-student
  budget, the setup gate (the student pastes the output of
  `course-smoke-test`), and per session the concept sources, lab sources,
  handouts, the artifacts a student submits, the rubric, the TA's private
  knowledge sources, and time estimates. The file mapping is DEC-010 and
  DEC-011's seven fixed filenames, stated once.
- `platform/rubrics/setup.yaml`, `platform/rubrics/01_mental_models.yaml`,
  `platform/rubrics/02_meeting_the_harness.yaml` — each session's
  `CHECKPOINT.md` structured by hand. Every criterion traces to a sentence
  of the bar; every row of the "What a near-miss sounds like, and what to
  say" table appears with the facilitator's exact words; the facts a
  machine can see (three rows on the sheet, a `write` in the session log,
  a `Back to:` line in `revert --list`) carry a deterministic check.
- `platform/recall/01_mental_models.yaml`,
  `platform/recall/02_meeting_the_harness.yaml` — the question-and-answer
  beat that closes each audio segment, with model answers in the course's
  voice.
- `platform/audio/01_mental_models.md`,
  `platform/audio/02_meeting_the_harness.md` — the concept tracks written
  for the ear. Segments of three to six minutes, nothing in them that
  cannot be spoken, and every command, table and screen handed to a
  `> Lab card:` line. Session 2's terminal card and the mechanics of
  `commit` and `revert` stay at the desk; *why* the safety net is taught
  before the first delegation is exactly the sort of thing that survives a
  commute.
- `platform/pronunciation.yaml` — how the voice says pi, Ghostty,
  OpenRouter, JSONL and the rest.
- `platform/README.md` — what the directory is, for the next author, and
  the rule that makes it maintainable.

**`CHECKPOINT.md` stays the source.** The rubric is a derivative, not a
replacement: it is what a machine can apply, transcribed from what a
facilitator applies. A change to a checkpoint's bar or its near-miss table
is not finished until the matching rubric is re-read. That is why
`platform/` lives here rather than in the platform's repository — the two
files land in the same review.

The schema is Module Contract v1, defined and validated in the delivery
platform's repository, and this chunk is authored against it as a peer:
that repository's `docs/chunks/contract_agentic101_dir` is the platform's
side of the same work.

## Success Criteria

- The platform's validator reports **zero errors** for this repository, and
  every warning it reports has been read and is intended.
- Every rubric criterion traces to a sentence in that session's
  `CHECKPOINT.md`, and every row of both near-miss tables appears with its
  corrective question, in the facilitator's words rather than a paraphrase.
- No deterministic check quotes a heading or column header that is not
  printed, exactly, in the handout it reads.
- The listenable scripts contain no table, no code fence, and no command
  line; each segment closes with its recall prompt; one segment of each has
  been read aloud against a clock.
- `uvx --from vibe-engineer ve validate` is clean.
- The repository carries a tag whose tree contains `platform/`, so the
  platform can ingest a fixed version of the course rather than whatever
  `main` says today.

## Rejected Ideas

### Generate the rubrics from `CHECKPOINT.md` at ingest

The checkpoint documents are consistently structured — a bar, a pass
section, a near-miss table — and a model could plausibly turn them into
rubric YAML on the fly. Rejected: the near-miss table is the most
carefully written text in the course, and the whole value of a rubric is
that a human decided which sentence is a criterion and which is context.
Generation would also make the bar unreviewable — nobody could see, before
a cohort ran, what a student was about to be judged against.

### Ship only sessions 1 and 2 of six, but describe six in the manifest

Rejected: the manifest names the sessions the platform serves, and a
session named without a rubric is a locked door with a sign on it. Later
sessions arrive by extending this directory, in the chunk that writes them.
