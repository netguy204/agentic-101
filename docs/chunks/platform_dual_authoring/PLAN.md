# Implementation Plan

## Approach

This chunk is documentation only: no code, no manifest change, no new
served files. It writes down a policy the operator already holds and the
mechanism that makes it safe, in the three places that govern it:

- **`docs/trunk/PLATFORM_AUTHORING.md`** — the upstream half. Its closing
  section "A new session, in order" currently describes the status quo the
  policy replaces (write the session, floor-test it, *then* transcribe).
  It becomes the four-step dual-authoring flow, with the draft written
  alongside the room version and promotion held until the room has proven
  the session.
- **`platform/README.md`** — the downstream half. It gains the mechanics of
  `platform/drafts/`: what a draft holds, the rule that a drafted session is
  never listed in `module.yaml`, and the promotion procedure. Its existing
  "Adding a session" section becomes the drafting procedure plus promotion,
  and "What is not here yet" is reconciled with the fact that a drafted
  session's files may exist here while the session is not served.
- **`docs/trunk/DECISIONS.md`** — DEC-013, following the existing entry
  format (Date, Status, Decision, Context, Alternatives Considered,
  Rationale, Consequences, Revisit If).

Two existing rules constrain every word written here and must not be
contradicted:

- **Derivatives, never forks** (PLATFORM_AUTHORING.md, "Two deliveries, one
  course"). A draft is a derivative written *early*, not a second copy of a
  session. If the room changes the source, the draft is re-derived, not
  reconciled.
- **The transcription rules still bind a draft**: a rubric may not say
  anything its `CHECKPOINT.md` does not; `CHECKPOINT.md` is never
  `ta_knowledge`; deterministic checks quote handout wording exactly; a
  part's `#anchor` is matched against the file's real headings.

The Contract v1.1 shape (`lab.parts[]`, `estimated_minutes.lab` as the sum
of the parts including the practice week) is what the draft's manifest
fragment must be written in, and the anchor-matching check is the specific
thing the promotion step's validator run catches. Both are stated in the
new text rather than left implicit.

The trunk GOAL's "Two deliveries, one source" property is referenced, not
restated.

## Sequence

### Step 1: Verify the validator's behavior with a drafts directory

Before writing the convention down, establish that the location is safe.
Run `pnpm contract:validate <this worktree>` from
`/Users/btaylor/Projects/learning-platform` to get a baseline, then again
with a probe `platform/drafts/03_test/` containing files that would be
*errors* if they were read as module content (a rubric with an unknown key,
a script with a table and a code fence). If the validator errors, pick a
location it ignores and record the finding; if it does not, `platform/drafts/`
stands.

**Result (recorded here as the chunk's finding):**

Baseline and probe runs are identical — `satisfies Module Contract v1:
2 sessions, 0 warnings`, exit 0. The validator walks the whole repository
into a file map but `validateModule` reads only what is reachable from
`platform/module.yaml` (`MANIFEST_PATH` in the platform's
`src/contract/types.ts` is the one path it knows by name; nothing globs
`platform/rubrics/`, `platform/audio/` or `platform/recall/`). A file under
`platform/` that no manifest entry points at is invisible to validation and
to ingest, which is the same code.

So `platform/drafts/` needs no exemption, no ignore-list entry and no
change on the platform side. The property the convention depends on is
therefore **not** "the validator tolerates a drafts directory" but the
stronger and simpler one: *the manifest is the only thing that makes a file
real.* That is what the README text should say, because it is also the
reason the "never listed in `module.yaml`" rule is load-bearing rather than
decorative — the listing is the whole difference between a draft and a
served session.

Probe files are removed before commit.

### Step 2: Rewrite "A new session, in order" in PLATFORM_AUTHORING.md

Four steps, in the narrative's order:

1. Write the session for the room — DEC-010/DEC-011's seven files — with
   this document's rules in mind (the existing step 1's content survives).
2. Author the draft platform version alongside it, into
   `platform/drafts/<NN>_<slug>/`. Written now, while the material is fresh
   and the author still remembers which sentence of the bar each criterion
   came from.
3. Floor-test and dry-run the room version, and iterate. The platform
   inherits the room's quality bar. What the room changes, the draft
   re-derives — that is cheap, and it is why the draft is not promoted yet.
4. Promote once the room has proven it: move the files into their served
   locations, add the session to `module.yaml`, validate, tag.

Also add a sentence to "Two deliveries, one course — and the classroom
leads" pointing at DEC-013 as the record of the policy, so the operating
belief paragraph and the decision are linked in both directions.

### Step 3: Document `platform/drafts/` in platform/README.md

Add a section (after "The rules", before "Adding a session") covering:

- What a draft directory holds: rubric, audio script, recall prompts,
  student concept index, and `session.yaml` — a manifest fragment in the
  shape of one `sessions:` entry, Contract v1.1, `lab.parts[]` included.
- The rule: a drafted session is **never** listed in `module.yaml`. A
  session named without being served is a locked door with a sign on it.
- Why the location is safe: the manifest is the only thing that makes a
  file real (Step 1's finding), stated so a reader knows the drafts
  directory is not a special case the validator was taught about.
- What is *not* checked while a session is in drafts — the fragment's
  anchors, the rubric's schema, the script's unspeakable content are all
  unvalidated until promotion, so the first validator run after the move is
  the real one.
- The promotion procedure: move, add the fragment to `sessions:` in
  progression order, validate, tag. No authoring left.

Update "Adding a session" so its steps produce a draft (they are otherwise
correct as written) and end at promotion rather than at "add it to
`module.yaml`" in step 2. Update "What is not here yet" so a drafted
session is described honestly: not served, and exempt from the
one-step-at-a-time framing because a draft is not a locked door — nothing
names it to a student.

### Step 4: DEC-013

Append to `docs/trunk/DECISIONS.md`, matching the existing entries' format.
Alternatives to cover, per the chunk goal: author for the platform directly;
transcribe only after the room has run the session (the status quo this
replaces); maintain a platform fork. Rationale is the operator's operating
belief, already stated in PLATFORM_AUTHORING.md. Consequences name the
files this chunk changed, the drafts convention, and what a Session 4
author now owes. Revisit-if names the condition under which drafting early
stops paying.

### Step 5: Populate `code_paths` and validate

Set `code_paths` in the chunk's GOAL.md to the three files. Run
`uvx --from vibe-engineer ve validate` and the platform validator once more,
clean.

## Dependencies

None. The three files exist; the chunk adds no code and no manifest entry.
`platform/drafts/` itself is created by the first session that drafts into
it (`platform_session_03_draft`), not by this chunk — an empty directory is
not a thing git carries, and this chunk owns the convention, not its first
use.

## Risks and Open Questions

- **Contradicting a sibling chunk.** Three chunks of this narrative run
  concurrently in other worktrees, one of which (`platform_student_index`)
  settles where the student-facing concept index lives. This chunk names
  the index as part of a draft without fixing its served path; the drafts
  text says "wherever the served index lives" rather than guessing
  `platform/index/`. Worth a re-read at merge.
- **The status quo has one data point.** Sessions 1 and 2 were transcribed
  after the fact and it worked; the claim that drafting early is cheaper is
  the operator's judgment, not a measurement. DEC-013's revisit-if is where
  that honesty lands.

## Deviations

- Step 3 planned to say the drafts directory is "tolerated" by the
  validator. Step 1's finding made that the wrong framing — the validator
  does not tolerate the directory, it cannot see it, and for a reason that
  is worth a reader knowing (the manifest is the only entry point). The
  README text states the reason instead of the tolerance.
- The chunk goal describes a draft's manifest fragment without naming the
  file. Implementation names it `session.yaml`, so a promotion is a
  mechanical paste rather than a hunt for which file holds the fragment.
- `platform/drafts/` is documented but not created (see Dependencies).
