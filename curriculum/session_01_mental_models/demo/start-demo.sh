#!/usr/bin/env bash
# Chunk: docs/chunks/fluency_session_01 - Northwind Coffee demo working directory
#
# Sets up a fresh working directory for the Session 1 Northwind Coffee demo
# (FACILITATOR_GUIDE.md, Beats 3 and 4) and prints the crib you need on
# screen while you run it.
#
# Safe to run as many times as you like — every run resets the folder to a
# pristine headcount.csv, so you can rehearse, wipe, and do it again in
# front of the room.
#
#   bash start-demo.sh              # default: ~/northwind-demo
#   bash start-demo.sh /some/where  # somewhere else

set -eu

SRC_DIR=$(cd "$(dirname "$0")" && pwd)
WORK_DIR=${1:-$HOME/northwind-demo}

BOLD=''; DIM=''; RESET=''
if [ -t 1 ]; then BOLD=$(printf '\033[1m'); DIM=$(printf '\033[2m'); RESET=$(printf '\033[0m'); fi

if [ -e "$WORK_DIR" ] && [ ! -d "$WORK_DIR" ]; then
    echo "start-demo.sh: $WORK_DIR exists and is not a directory." >&2
    exit 1
fi

mkdir -p "$WORK_DIR"
cp "$SRC_DIR/headcount.csv" "$WORK_DIR/headcount.csv"
# Anything the agent produced on a previous run: gone, so the room never
# sees last rehearsal's output.
rm -f "$WORK_DIR"/headcount.csv.bak "$WORK_DIR"/*.md 2>/dev/null || true

cat <<EOF

${BOLD}Northwind Coffee demo — ready${RESET}
${DIM}$WORK_DIR/headcount.csv restored to its original 9 rows${RESET}

${BOLD}1. Before you touch the keyboard (60 seconds)${RESET}
   Put these two facts on the board and make the room say them back:

     • Brand is NOT part of Marketing here. Brand sits under Product.
     • "Field" means the retail store teams, not sales.

${BOLD}2. Start the agent${RESET}

     cd $WORK_DIR
     pi

${BOLD}3. Send exactly this${RESET}

     headcount.csv has department names written inconsistently.
     Standardize them to one clean name per department, and tell me what
     you chose and why.

   Narrate what scrolls past in plain language. Do not explain tool calls,
   the terminal, or anything mechanical — "Session 2, I promise."

${BOLD}4. Let it land, then ask the question${RESET}

     "How would you check this?"

   Write every answer on the board. Then: "All of those pass. Every one of
   them passes on this file. Is it right?"

${BOLD}5. The reveal${RESET}

   ${BOLD}Grace${RESET} — "Brand & Mktg" folded into Marketing. Right at almost every
   company on earth, wrong at Northwind. No mechanical check catches it.

   ${BOLD}Backup, if the agent gets Grace right:${RESET} ${BOLD}Hank and Ivy${RESET} — "Field" and
   "Field Sales" folded together, or Field mapped to Sales. Both wrong at
   Northwind. Same reveal, same conclusion.

${DIM}Reset between runs: bash start-demo.sh${RESET}
${DIM}Full script and timings: ../FACILITATOR_GUIDE.md (Beats 3 and 4)${RESET}

EOF
