# add snap to path
append_to_path "/snap/bin"

abs_path="$(get_abs_path $0)"
source "${abs_path}/zsh/generated_init.zsh"
