function get_abs_path() {
  dir_name=$(cd "$(dirname "$(dirname "$1")/$2")" && pwd)
  echo "${dir_name}/$(basename "$2")"
}

resolve_relative_path() (
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

autoload -Uz compinit && compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

### PATH
# zls
export PATH="${PATH}:${HOME}/.zls"

# llvm
export PATH="${PATH}:$(brew --prefix llvm)/bin"

source "$(get_abs_path $0 alias.zsh)" "$(get_abs_path $0 option.zsh)"
source $(resolve_relative_path $(dirname "$0")/../init/exec_init.sh)

