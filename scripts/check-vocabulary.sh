#!/usr/bin/env sh
# SPDX-License-Identifier: Apache-2.0
# Vocabulary check for this repo's community-health docs.
#
# This repo (turbopanel/.github) has no build tooling of its own, so this is
# a plain POSIX sh scan rather than the Deno/Node checkers in the daemon,
# instance, and website repos. Keep the forbidden-phrase list in sync with:
#   - ../turbopaneld/scripts/check-vocabulary.ts
#   - ../turbopanel/scripts/check-vocabulary.mjs
#   - ../website/scripts/check-vocabulary.mjs
#   - ../ui/src/lib/vocabulary.ts
#
# The TurboPanel daemon is a "daemon" / "host daemon" / "turbopaneld", never
# an "agent" -- that word is reserved for coding-agent tooling (AGENTS.md
# headings, .agents/skills) and unrelated third-party terms (HTTP
# User-Agent, npm package names). Shell chrome is "frosted chrome", never
# Apple-associated glass product copy.
#
# Run: sh scripts/check-vocabulary.sh
set -eu

ROOT="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

# Exact forbidden phrases (case-insensitive). Extend as new daemon-as-agent
# or Apple-associated chrome regressions are found; keep the sibling repo
# checkers aligned.
PHRASES='turbopanel agent
node agent
agent host
agent identity
agent commit
server\.daemon\.projection\.agent
liquid glass
liquid-glass
seamless
effortless
empower
revolutioniz
supercharg
game-chang
next-generation
all-in-one'

# Human-authored community-health docs only; skip git metadata and this
# script's own source (it necessarily names the forbidden phrases).
FILES=$(find . \
  -path './.git' -prune -o \
  -path './scripts/check-vocabulary.sh' -prune -o \
  \( -name '*.md' -o -name '*.yml' -o -name '*.yaml' \) -print)

failed=0
old_ifs=$IFS
IFS='
'
for phrase in $PHRASES; do
  IFS=$old_ifs
  # shellcheck disable=SC2086
  matches=$(printf '%s\n' "$FILES" | xargs grep -inE -- "$phrase" 2>/dev/null || true)
  # Allow legitimate coding-agent references (AGENTS.md headings, User-Agent).
  matches=$(printf '%s\n' "$matches" | grep -viE 'user-agent|agent conventions|agent maintenance|\.agents/skills' || true)
  if [ -n "$matches" ]; then
    echo "Forbidden phrase \"$phrase\":"
    printf '%s\n' "$matches"
    failed=1
  fi
  IFS='
'
done
IFS=$old_ifs

# Warn mode (not blocking). The terminology page on the website names one word
# for each part: control plane, app / web app, daemon, server, administrator.
# These retired words are reported as warnings so new copy can be corrected
# before the list is promoted to PHRASES. Keep the sibling checkers aligned.
WARN_PHRASES='the console
instance owner
Instance CA
hosted instance
remote nodes?
\bfleet\b'
warn_count=0
old_ifs=$IFS
IFS='
'
for phrase in $WARN_PHRASES; do
  IFS=$old_ifs
  # shellcheck disable=SC2086
  hits=$(printf '%s\n' "$FILES" | xargs grep -inE -- "$phrase" 2>/dev/null || true)
  # Real tool or identifier names are fine (dev console, console.log, ./console).
  hits=$(printf '%s\n' "$hits" | grep -viE 'console\.(log|error|warn|info)|\./console|dev console|developer console|terminology\.mdx' || true)
  if [ -n "$hits" ]; then
    printf '%s\n' "$hits" | sed "s/^/  ! says \"$phrase\" (see the terminology page): /"
    warn_count=$((warn_count + $(printf '%s\n' "$hits" | wc -l)))
  fi
  IFS='
'
done
IFS=$old_ifs
if [ "$warn_count" -gt 0 ]; then
  echo "check-vocabulary: $warn_count terminology warning(s) (warn mode, not blocking)."
fi

if [ "$failed" -ne 0 ]; then
  echo ""
  echo "Vocabulary check failed. TurboPanel's daemon is a \"daemon\" / \"host daemon\" / \"turbopaneld\", never an \"agent\". Shell chrome is \"frosted chrome\", never Apple-associated glass product copy." >&2
  exit 1
fi

echo "Vocabulary check passed: no forbidden phrasing found."
