setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_silent
setopt pushd_to_home
setopt cdable_vars
setopt always_to_end
setopt auto_menu
setopt interactive_comments
setopt auto_param_slash
setopt auto_param_keys

# correct the spell of commands
setopt correct

# share histories of multiple terminals
setopt share_history

# display completion results in packed way
setopt list_packed

# display completion results colorfully
autoload colors
zstyle ':completion:*' list-colors ''

# histsize
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
setopt extended_history

# do not record commands if the user is root
if [ $UID = 0 ]; then
  unset HISTFILE
  SAVEHIST=0
fi
