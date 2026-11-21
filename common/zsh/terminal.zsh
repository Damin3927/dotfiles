# A TUI on a remote host (e.g. Claude Code) leaves mouse tracking and other
# input modes on when the ssh connection drops, so every mouse move makes zle beep.
_reset_terminal_input_modes() {
  [[ -t 1 ]] || return
  printf '\e[?1000l\e[?1002l\e[?1003l\e[?1006l\e[?1015l\e[?1004l\e[=0u\e[>4m\e[?25h'
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _reset_terminal_input_modes
