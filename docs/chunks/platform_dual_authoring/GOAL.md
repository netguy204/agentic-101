---
status: ACTIVE
ticket: null
parent_chunk: null
code_paths:
- docs/trunk/PLATFORM_AUTHORING.md
- platform/README.md
- docs/trunk/DECISIONS.md
code_references:
- ref: docs/trunk/PLATFORM_AUTHORING.md
  implements: '"A new session, in order" as the four-step dual-authoring flow: room
    version, draft platform version alongside it, floor test and re-derive, promote
    after the room has proven it'
- ref: platform/README.md
  implements: 'The drafts convention: what platform/drafts/<NN>_<slug>/ holds, the
    never-listed-in-module.yaml rule, why the location needs no validator exemption,
    and the four-step promotion procedure'
- ref: docs/trunk/DECISIONS.md
  implements: "DEC-013 \u2014 dual authoring as policy, with the room-leads rationale\
    \ and the room gate on promotion"
narrative: platform_compliance
investigation: null
subsystems: []
friction_entries: []
depends_on: []
created_after:
- platform_authoring_guide
---
# Chunk Goal

## Minor Goal

The repository records dual authoring as policy. `docs/trunk/
PLATFORM_AUTHORING.md`'s "A new session, in order" describes the flow:
(1) write the session for the room — the seven files of DEC-010/DEC-011 —
with the authoring rules in mind; (2) author the DRAFT platform version
alongside it, into `platform/drafts/<NN>_<slug>/`: rubric, audio script,
recall prompts, student concept index, and a manifest fragment in the shape
of a `module.yaml` `sessions:` entry; (3) floor-test and dry-run the room
version and iterate — the platform inherits the room's quality bar; (4)
promote after the room has proven it: move the draft's files into their
served locations, add the session to `module.yaml`, run the platform
validator, cut a `platform-YYYY-MM` tag. `platform/README.md` documents the
drafts convention as the downstream mechanics: a drafted session is NEVER
listed in `module.yaml` (a session named without being served is a locked
door), drafts are exempt from the "what is not here yet" section's
one-step-at-a-time framing, and promotion is a move + manifest entry +
validation + tag with no authoring left. `docs/trunk/DECISIONS.md` DEC-013
records the policy and its rationale — the operator's operating belief,
already stated in PLATFORM_AUTHORING.md: a course iterated in a live
classroom has better pedagogical coverage when adapted to the platform than
one authored for the platform directly; drafting alongside authorship keeps
the transcription cheap while room testing keeps it honest.

The policy sits on top of rules the two documents already hold, and does
not bend them: the platform artifacts are derivatives and never forks (so
what the room changes is re-derived into a draft rather than merged with
it), `CHECKPOINT.md` is never TA knowledge, and deterministic checks freeze
handout wording. The trunk GOAL's "Two deliveries, one source" property is
what all of it serves; this chunk references that property rather than
restating it.

The manifest fragment a draft carries is a Module Contract v1.1 `sessions:`
entry — `lab.parts` included, each part's `sources` anchored into the lab
documents' `## Exercise N` headings, `estimated_minutes.lab` the sum of the
parts with the practice week in it — because that is the shape
`module.yaml` accepts at promotion.

`platform/drafts/` is safe as a location for a reason worth keeping:
`platform/module.yaml` is the only file the platform knows the name of, and
nothing globs the rest of the directory, so a file no manifest entry points
at is invisible to the validator and to ingest alike. Verified with the
platform validator (`pnpm contract:validate` from a `../learning-platform`
checkout) against a drafts directory full of deliberately invalid files:
identical clean output, exit 0. The corollary is that a draft is unchecked
by construction — its part anchors, its rubric schema and its script's
speakability are all unverified until it is promoted, which is why the
promotion procedure names that validator run as the first thing ever to
read the session.

## Success Criteria

- PLATFORM_AUTHORING.md's "A new session, in order" describes the four-step
  dual-authoring flow; an author following it for Session 4 would produce
  both versions and know promotion waits on room testing.
- platform/README.md documents `platform/drafts/`: what a draft contains,
  that drafted sessions never appear in module.yaml, and the promotion
  procedure.
- DEC-013 exists in DECISIONS.md with decision, context, alternatives
  (author for the platform directly; transcribe only after the room — the
  status quo this replaces; maintain a fork), rationale, consequences,
  revisit-if.
- The validator's behavior with a drafts directory is verified and
  recorded; `uvx --from vibe-engineer ve validate` passes.

