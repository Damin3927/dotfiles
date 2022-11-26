#!/bin/bash

# brew zsh compinit
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

eval "$(brew shellenv)"
