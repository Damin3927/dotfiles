get_abs_path () {
  dir_name=$(cd "$(dirname "$(dirname "$1")/$2")" && pwd)
  echo "${dir_name}"
}

resolve_relative_path () (
    # If the path is a directory, we just need to 'cd' into it and print the new path.
    if [ -d "$1" ]; then
        cd "$1" || return 1
        pwd
    # If the path points to anything else, like a file or FIFO
    elif [ -e "$1" ]; then
        # Strip '/file' from '/dir/file'
        # We only change the directory if the name doesn't match for the cases where
        # we were passed something like 'file' without './'
        if [ ! "${1%/*}" = "$1" ]; then
            cd "${1%/*}" || return 1
        fi
        # Strip all leading slashes upto the filename
        echo "$(pwd)/${1##*/}"
    else
        return 1 # Failure, neither file nor directory exists.
    fi
)

append_to_path() {
  export PATH="$1:${PATH}"
}

# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/Users/damin/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

### PATH
# zls
append_to_path "${HOME}/.zls"

# brew setup
arch="$(uname -m)"
if [ "${arch}" = arm64 ]; then
  append_to_path "/opt/homebrew/bin"
fi

abs_path="$(get_abs_path $0)"
eval "$(${abs_path}/bin/dotfiles completion zsh)"
source "${abs_path}/zsh/generated_init.zsh"
source "${abs_path}/zsh/zinit.zsh"
source "${abs_path}/zsh/alias.zsh"
source "${abs_path}/zsh/option.zsh"
