#!/bin/bash

set -eu

sudo apt update

# chsh if bash
if [ "$(basename "${SHELL}")" = "bash" ]; then
  # if not installed, install from apt
  if ! command -v zsh > /dev/null; then
    sudo apt install -y zsh
  fi
  chsh -s "$(which zsh)"
fi

function get_abs_path() {
  dir_name=$(cd "$(dirname "$(dirname "$0")/$1")" && pwd)
  echo "${dir_name}/$(basename "$1")"
}

function append_init_script_to_zshrc() {
  local abs_path source_template_str
  abs_path=$(get_abs_path "zsh/template.zsh")
  source_template_str="source ${abs_path}"

  touch "${HOME}/.zshrc"
  if ! grep -q "$source_template_str" "${HOME}/.zshrc"; then
    printf "%s\n\n# load zshrc template\n%s\n" "$(cat "${HOME}"/.zshrc)" "${source_template_str}" > "${HOME}/.zshrc"
  fi
}

append_init_script_to_zshrc


# neovim setup
. ../common/vim/bootstrap.sh

# Claude Code setup
. ../common/claude/bootstrap.sh

# Sibling private dotfiles (../dotfiles-priv) — clone if missing, then run its bootstrap if any.
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
priv_dir="$(cd "$script_dir/../.." && pwd)/dotfiles-priv"
if [ ! -d "$priv_dir" ]; then
  git clone git@github.com:Damin3927/dotfiles-priv.git "$priv_dir" \
    || echo "[warn] could not clone dotfiles-priv; continuing without it"
fi
if [ -x "$priv_dir/bootstrap.sh" ]; then
  ( cd "$priv_dir" && bash bootstrap.sh ) || echo "[warn] dotfiles-priv bootstrap failed"
fi
