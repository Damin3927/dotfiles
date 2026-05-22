# install zinit if not installed
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
  bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"
fi

# Load zinit itself before using the `zinit` command below. The installer also
# appends its own source line at the bottom of ~/.zshrc, but that runs after
# this file is sourced from common/zsh/template.zsh, so we source it here too.
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"


# p10k
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Syntax Highlighting
zinit light zsh-users/zsh-syntax-highlighting

# completions
zinit light zsh-users/zsh-completions
