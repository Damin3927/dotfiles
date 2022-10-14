# ls
alias l='ls -1A --color'
alias ll='ls -lh --color'
alias la='ll -A --color'

# mkdir
alias mkdir='mkdir -p'

# rm
alias rm='rm -i'

# pbcopy
alias c='pbcopy'

# easy edit for zshrc
alias zshrc='vim ~/.zshrc'

# re-login
alias relogin='exec $SHELL -l'

# lazy loading of rbenv
if [ -e "${HOME}/.rbenv" ];then
  alias ruby='unalias ruby bundle gem irb && eval "$(rbenv init -)" && ruby'
  alias bundle='unalias ruby bundle gem irb && eval "$(rbenv init -)" && bundle'
  alias gem='unalias ruby bundle gem irb && eval "$(rbenv init -)" && gem'
  alias irb='unalias ruby bundle gem irb && eval "$(rbenv init -)" && irb'
fi

# lazy loading of nvm
export NVM_DIR="$HOME/.nvm"
. "${NVM_DIR}/nvm.sh"
# if [ -s "${NVM_DIR}/nvm.sh" ]; then
#   alias nvm='unalias nvm node npm yarn && . "$NVM_DIR"/nvm.sh && nvm'
#   alias node='unalias nvm node npm yarn && . "$NVM_DIR"/nvm.sh && node'
#   alias npm='unalias nvm node npm yarn && . "$NVM_DIR"/nvm.sh && npm'
#   alias yarn='unalias nvm node npm yarn && . "$NVM_DIR"/nvm.sh && yarn'
# fi
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Ruby on Rails
alias rails='bundle exec rails'
alias rspec='bundle exec rspec'

# python
alias python='python3'
alias pip='pip3'

# venv
alias venv='source .venv/bin/activate'

# NeoVim
alias vi='nvim'
alias vim='nvim'

# IP Address
alias myip='curl http://ipecho.net/plain'

# x86_64 zsh
alias x86_64='arch -x86_64 zsh'
alias arm64='arch -arm64 zsh'
