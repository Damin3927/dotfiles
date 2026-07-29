#!/bin/bash
# Symlink Claude Code config into ~/.claude.
# Works whether sourced from a parent bootstrap script or executed directly
# (e.g. `make claude`), because paths are resolved relative to this file
# via BASH_SOURCE rather than $0.

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "${HOME}/.claude/hooks" "${HOME}/.claude/rules"

ln -fs "${SCRIPT_DIR}/settings.json" "${HOME}/.claude/settings.json"
echo "Symlinked .claude/settings.json"

ln -fs "${SCRIPT_DIR}/CLAUDE.md" "${HOME}/.claude/CLAUDE.md"
echo "Symlinked .claude/CLAUDE.md"

ln -fs "${SCRIPT_DIR}/hooks/notify.sh" "${HOME}/.claude/hooks/notify.sh"
echo "Symlinked .claude/hooks/notify.sh"

for rule in "${SCRIPT_DIR}"/rules/*.md; do
  ln -fs "${rule}" "${HOME}/.claude/rules/$(basename "${rule}")"
  echo "Symlinked .claude/rules/$(basename "${rule}")"
done
