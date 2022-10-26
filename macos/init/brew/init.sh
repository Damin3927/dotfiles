#!/bin/bash

arch="$(uname -m)"
if [ "${arch}" = arm64 ]; then
  append_to_path "/opt/homebrew/bin"
fi

# brew zsh compinit
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

eval "$(brew shellenv)"
