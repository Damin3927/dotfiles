#! /bin/bash

function is_not_installed() {
  if command -v "$1" &>/dev/null; then
    return 1
  fi
  return 0
}


exlcuded_files="exec_init.sh installer.sh brew_formulae README.md"
for target in *; do
  if [[ "${exlcuded_files}" =~ ${target} ]]; then
    continue
  fi

  if [ -d "${target}" ]; then
    if is_not_installed "${target}"; then
      echo "Installing ${target}..."
      # shellcheck disable=SC1091
      . "${target}/install.sh"
      echo "Successfully installed ${target}!"
    fi
  elif [ -f "${target}" ]; then
    if is_not_installed "${target}"; then
      echo "Installing ${target}..."
      brew install "${target}"
      echo "Successfully installed ${target}!"
    fi
  fi
done
