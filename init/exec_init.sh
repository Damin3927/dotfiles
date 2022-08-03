#! /bin/bash

contains () {
  local el match="$1"
  shift
  for el; do
    [[ "$el" == "$match" ]] && return 0
  done
  return 1
}

excluded_files=(
  "exec_init.sh"
  "installer.sh"
  "brew_formulae"
  "README.md"
)
for target in "$(dirname "$0")"/*; do
  if contains "$(basename "$target")" "${excluded_files[@]}"; then
    continue
  fi

  if [ -d "${target}" ] && [ -f "${target}/init.sh" ]; then
    # shellcheck disable=SC1091
    . "${target}/init.sh"
  elif [ -f "${target}" ]; then
    # shellcheck disable=SC1090
    . "${target}"
  fi
done
