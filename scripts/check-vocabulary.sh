#!/usr/bin/env sh
# Vocabulary check for this repo's community-health docs.
#
# This repo (turbopanel/.github) has no build tooling of its own, so this is
# a plain POSIX sh scan rather than the Deno/Node checkers in the daemon,
# instance, and website repos. Keep the forbidden-phrase list in sync with:
#   - ../turbopaneld/scripts/check-vocabulary.ts
#   - ../turbopanel/scripts/check-vocabulary.mjs
#   - ../website/scripts/check-vocabulary.mjs
#
# The TurboPanel daemon is a "daemon" / "host daemon" / "turbopaneld", never
# an "agent" -- that word is reserved for coding-agent tooling (AGENTS.md
# headings, .agents/skills) and unrelated third-party terms (HTTP
# User-Agent, npm package names).
#
# Run: sh scripts/check-vocabulary.sh
set -eu

ROOT="$(CDPATH= cd -- "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

# Exact forbidden phrases (case-insensitive). Extend as new daemon-as-agent
# regressions are found; keep the sibling repo checkers aligned.
PHRASES='turbopanel agent
node agent
agent host
agent identity
agent commit
server\.daemon\.projection\.agent'

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
    echo "Forbidden daemon-as-agent phrase \"$phrase\":"
    printf '%s\n' "$matches"
    failed=1
  fi
  IFS='
'
done
IFS=$old_ifs

if [ "$failed" -ne 0 ]; then
  echo ""
  echo "Vocabulary check failed. TurboPanel's daemon is a \"daemon\" / \"host daemon\" / \"turbopaneld\", never an \"agent\"." >&2
  exit 1
fi

echo "Vocabulary check passed: no daemon-as-agent phrasing found."
