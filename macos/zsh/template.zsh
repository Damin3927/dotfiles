### PATH
# JetBrains Toolbox
append_to_path "${HOME}/Library/Application Support/JetBrains/Toolbox/scripts"

# brew setup
arch="$(uname -m)"
if [ "${arch}" = arm64 ]; then
  prepend_to_path "/opt/homebrew/bin"
fi
BREW_PREFIX="$(brew --prefix)"

abs_path="$(get_abs_path $0)"
source "${abs_path}/zsh/generated_init.zsh"
