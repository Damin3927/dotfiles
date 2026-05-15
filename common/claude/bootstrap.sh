#!/bin/bash

function get_abs_path() {
  dir_name=$(cd "$(dirname "$(dirname "$0")/$1")" && pwd)
  echo "${dir_name}/$(basename "$1")"
}

mkdir -p "${HOME}/.claude"
ln -fs "$(get_abs_path "../common/claude/settings.json")" "${HOME}/.claude/settings.json"
echo "Symlinked .claude/settings.json"
ln -fs "$(get_abs_path "../common/claude/CLAUDE.md")" "${HOME}/.claude/CLAUDE.md"
echo "Symlinked .claude/CLAUDE.md"
