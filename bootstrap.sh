#! /bin/bash

set -eu


function get_abs_path() {
  dir_name=$(cd "$(dirname "$(dirname "$0")/$1")" && pwd)
  echo "${dir_name}/$(basename "$1")"
}

function append_init_script_to_zshrc() {
  local abs_path source_template_str
  abs_path=$(get_abs_path "zsh/template.zsh")
  source_template_str="source ${abs_path}"

  if ! grep -q "$source_template_str" "${HOME}/.zshrc"; then
    printf "# load zshrc template\n%s\n\n%s" "${source_template_str}" "$(cat "${HOME}"/.zshrc)" > "${HOME}/.zshrc"
  fi
}

append_init_script_to_zshrc

# NeoVim setup
. vim/bootstrap.sh

# Exec installer
. init/installer.sh
