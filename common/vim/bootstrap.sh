#!/bin/bash

function get_abs_path() {
  dir_name=$(cd "$(dirname "$(dirname "$0")/$1")" && pwd)
  echo "${dir_name}/$(basename "$1")"
}

# pip install
function pi() {
  pip3 show "$1" > /dev/null || pip3 install "$1" --break-system-packages
}

config_path=${HOME}/.config/nvim
ln -fs "$(get_abs_path "../common/vim/config")" "${config_path}"
echo "Symlinked .config/nvim"

# install pynvim, openai into python
pi pynvim
pi openai

# Configure rustup
rustup component add rls rust-analysis rust-src
