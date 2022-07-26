#! /bin/bash

set -eu


function get_abs_path() {
  dir_name=$(cd "$(dirname "$(dirname "$0")/$1")" && pwd)
  echo "${dir_name}/$(basename "$1")"
}

abs_path=$(get_abs_path "zsh/template.zsh")
source_template_str="source ${abs_path}"

if ! grep -q "$source_template_str" "${HOME}/.zshrc"; then
  printf "# load zshrc template\n%s\n\n%s" "${source_template_str}" "$(cat "${HOME}"/.zshrc)" > "${HOME}/.zshrc"
fi

# Install brew formulae
while read -r; do brew list "${REPLY}" &> /dev/null || brew install "${REPLY}"; done < init/brew_formulae

# NeoVim setup
bash "$(get_abs_path "vim/bootstrap.sh")"

# Exec installer
. init/installer.sh
