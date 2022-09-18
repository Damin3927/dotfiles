#! /bin/bash

function get_abs_path() {
  dir_name=$(cd "$(dirname "$(dirname "$0")/$1")" && pwd)
  echo "${dir_name}/$(basename "$1")"
}

# pip install
function pi() {
  pip3 show "$1" > /dev/null || pip3 install "$1"
}

# if the given package is installed into pip or not
function is_installed_into_pip() {
  result=0
  pip3 show "$1" > /dev/null || result=$?
  return $result
}


# install https://github.com/junegunn/vim-plug
if [ ! -e "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim ]; then
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
         https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' > /dev/null
fi

config_path=${HOME}/.config/nvim
config_file_path=${config_path}/init.vim
if [ ! -e "$config_file_path" ]; then
	mkdir -p "${config_path}"
	ln -s "$(get_abs_path "init.vim")" "${config_file_path}"
fi

coc_config_file_path=${config_path}/coc-settings.json
if [ ! -e "$coc_config_file_path" ]; then
  ln -s "$(get_abs_path "coc-settings.json")" "${coc_config_file_path}"
fi

# install pynvim into python
pi pynvim

# Configure rustup
rustup component add rls rust-analysis rust-src
