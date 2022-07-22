# ls
alias l='ls -1A'
alias ll='ls -lh'
alias la='ll -A'

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

# Ruby on Rails
alias rails='bundle exec rails'
alias rspec='bundle exec rspec'

# python
alias python='python3'
alias pip='pip3'

# venv
alias venv='source .venv/bin/activate'

# poetry
alias poact='source $(poetry env info --path)/bin/activate'

# NeoVim
alias vi='nvim'
alias vim='nvim'