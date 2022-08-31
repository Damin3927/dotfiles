setopt auto_cd
setopt auto_pushd

# correct the spell of commands
setopt correct

# share histories of multiple terminals
setopt share_history

# display completion results in packed way
setopt list_packed

# display completion results colorfully
autoload colors
zstyle ':completion:*' list-colors ''
