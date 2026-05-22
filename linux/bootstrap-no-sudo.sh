#!/bin/bash

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

append_init_script_to_zshrc() {
  local abs_path source_template_str
  abs_path="${SCRIPT_DIR}/zsh/template.zsh"
  source_template_str="source ${abs_path}"

  touch "${HOME}/.zshrc"
  if ! grep -q "$source_template_str" "${HOME}/.zshrc"; then
    printf "%s\n\n# load zshrc template\n%s\n" "$(cat "${HOME}/.zshrc")" "${source_template_str}" > "${HOME}/.zshrc"
  fi
}

append_init_script_to_zshrc

# Claude Code setup
bash "${SCRIPT_DIR}/../common/claude/bootstrap.sh"

# Sibling private dotfiles (../dotfiles-priv) — clone if missing, then run its bootstrap if any.
priv_dir="$(cd "${SCRIPT_DIR}/../.." && pwd)/dotfiles-priv"
if [ ! -d "$priv_dir" ]; then
  git clone git@github.com:Damin3927/dotfiles-priv.git "$priv_dir" \
    || echo "[warn] could not clone dotfiles-priv; continuing without it"
fi
if [ -x "$priv_dir/bootstrap.sh" ]; then
  ( cd "$priv_dir" && bash bootstrap.sh ) || echo "[warn] dotfiles-priv bootstrap failed"
fi
