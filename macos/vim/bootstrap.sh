#!/bin/bash

function get_abs_path() {
  dir_name=$(cd "$(dirname "$(dirname "$0")/$1")" && pwd)
  echo "${dir_name}/$(basename "$1")"
}

# pip install
function pi() {
  pip3 show "$1" > /dev/null || pip3 install "$1"
}

config_path=${HOME}/.config/nvim
if [ ! -e "$config_path" ]; then
	ln -s "$(get_abs_path "config")" "${config_path}"
  echo "Symlinked .config/nvim"
fi

# install pynvim, openai into python
pi pynvim
pi openai

# Configure rustup
rustup component add rls rust-analysis rust-src
