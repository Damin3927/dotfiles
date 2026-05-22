#!/bin/bash

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

append_init_script_to_zshrc() {
  local abs_path source_template_str
  # `common/zsh/template.zsh` is the entry point; it defines `append_to_path` /
  # `get_abs_path` and then sources the OS-specific `linux/zsh/template.zsh`.
  # Sourcing `linux/zsh/template.zsh` directly fails because those helpers are
  # not yet defined at that point.
  abs_path="$(cd "${SCRIPT_DIR}/../common/zsh" && pwd)/template.zsh"
  source_template_str="source ${abs_path}"

  touch "${HOME}/.zshrc"

  # Remove any previously-written line that pointed at the wrong template
  # (linux/zsh/template.zsh) so re-running this script self-heals old installs.
  if grep -q 'source .*/linux/zsh/template\.zsh' "${HOME}/.zshrc"; then
    grep -v 'source .*/linux/zsh/template\.zsh' "${HOME}/.zshrc" > "${HOME}/.zshrc.tmp"
    mv "${HOME}/.zshrc.tmp" "${HOME}/.zshrc"
  fi

  if ! grep -qF "$source_template_str" "${HOME}/.zshrc"; then
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
