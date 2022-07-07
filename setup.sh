#! /bin/bash

set -eu


abs_path=$(readlink -f .zshrc.template)
source_template_str="source ${abs_path}"

if ! grep -q "$source_template_str" "${HOME}/.zshrc"; then
  printf "# load zshrc template\n%s\n\n%s" "${source_template_str}" "$(cat "${HOME}"/.zshrc)" > "${HOME}/.zshrc"
fi

# NeoVim setup
bash "$(pwd)/vim/bootstrap"
