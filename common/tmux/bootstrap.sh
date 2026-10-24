#!/bin/bash

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "${HOME}/.config/tmux"
ln -fns "${SCRIPT_DIR}/tmux.conf" "${HOME}/.config/tmux/tmux.conf"
echo "Symlinked .config/tmux/tmux.conf"
