#!/bin/bash

append_to_path "/opt/homebrew/bin"

# brew zsh compinit
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

eval "$(/opt/homebrew/bin/brew shellenv)"
