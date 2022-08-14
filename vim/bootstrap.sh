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


# install neovim dependencies
brew tap homebrew/cask-fonts && brew install --cask font-ubuntu-mono-nerd-font


# install https://github.com/junegunn/vim-plug

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' > /dev/null

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

# Install color scheme
mkdir -p ~/.config/nvim/colors
curl https://raw.githubusercontent.com/w0ng/vim-hybrid/master/colors/hybrid.vim -o ~/.config/nvim/colors/hybrid.vim > /dev/null

yes | "$(brew --prefix)/opt/fzf/install" > /dev/null

# install pynvim into python
pi pynvim

# Install rust-analyzer
if ! command -v rust-analyzer &> /dev/null; then
  git clone https://github.com/rust-lang/rust-analyzer.git
  cd rust-analyzer || exit
  cargo xtask install --server
  cd ..
  rm -rf rust-analyzer
fi

# Install zls
if ! command -v zls &> /dev/null; then
  zls_version=0.9.0
  mkdir "${HOME}/.zls" && cd "${HOME}/.zls" && curl -L "https://github.com/zigtools/zls/releases/download/${zls_version}/x86_64-macos.tar.xz" | tar -xJ --strip-components=1 -C . && chmod +x zls
fi

# Configure rustup
rustup component add rls rust-analysis rust-src
