function get_abs_path() {
  dir_name=$(cd "$(dirname "$(dirname "$1")/$2")" && pwd)
  echo "${dir_name}/$(basename "$2")"
}

autoload -Uz compinit && compinit

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# PATH
export PATH="${PATH}:${HOME}/.zls"

source "$(get_abs_path $0 alias.zsh)" "$(get_abs_path $0 option.zsh)"
