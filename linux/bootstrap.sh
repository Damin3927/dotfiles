#!/bin/bash

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

sudo apt update

# chsh if bash
if [ "$(basename "${SHELL}")" = "bash" ]; then
  # if not installed, install from apt
  if ! command -v zsh > /dev/null; then
    sudo apt install -y zsh
  fi
  chsh -s "$(which zsh)"
fi

# neovim setup
. "${SCRIPT_DIR}/../common/vim/bootstrap.sh"

bash "${SCRIPT_DIR}/bootstrap-no-sudo.sh"
