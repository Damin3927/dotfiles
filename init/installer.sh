#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

is_not_installed() {
  if command -v "$1" &>/dev/null; then
    return 1
  fi
  return 0
}

# Install brew formulae
while read -r; do
  continue
  if brew list "${REPLY}" &>/dev/null ;then
    echo "${REPLY} is already installed. Skipped."
  else
    echo "Installing ${REPLY} ..."
    brew install "${REPLY}"
    echo "Successfully installed ${REPLY}!"
  fi
done < "${SCRIPT_DIR}/brew_formulae"


exlcuded_files="exec_init.sh installer.sh brew_formulae README.md"
for target in "${SCRIPT_DIR}"/*; do
  target="$(basename "$target")"

  if [[ "${exlcuded_files}" =~ ${target} ]]; then
    continue
  fi

  if [ -d "${SCRIPT_DIR}/${target}" ] && is_not_installed "${target}" && [ -f "${SCRIPT_DIR}/${target}/install.sh" ]; then
    echo "Installing ${target} ..."
    # shellcheck disable=SC1090
    . "${SCRIPT_DIR}/${target}/install.sh"
    echo "Successfully installed ${target}!"
    continue
  elif [ -f "${SCRIPT_DIR}/${target}" ] && is_not_installed "${target}"; then
    echo "Installing ${target} ..."
    brew install "${target}"
    echo "Successfully installed ${target}!"
    continue
  fi

  echo "${target} is already installed. Skipped."
done

echo "Finished all installations."
