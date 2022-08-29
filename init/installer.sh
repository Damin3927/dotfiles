#! /bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

is_not_installed() {
  if command -v "$1" &>/dev/null; then
    return 1
  fi
  return 0
}

# Install brew formulae
while read -r formula; do
  if grep -q "${formula}" "${SCRIPT_DIR}/.installignore"; then
    echo "${formula} is marked to be skipped."
    continue
  fi

  if brew list "${formula}" &>/dev/null ;then
    echo "${formula} is already installed. Skipped."
    continue
  fi

  echo "Installing ${formula} ..."
  echo brew install "${formula}" | bash
  echo "Successfully installed ${formula}!"
done < "${SCRIPT_DIR}/brew_formulae"


exlcuded_files="installer.sh brew_formulae README.md scaffold_tool_script.sh .gitignore .installignore .installignore.example"
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
