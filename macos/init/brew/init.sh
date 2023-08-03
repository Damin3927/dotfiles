#!/bin/bash

# brew zsh compinit
FPATH="${BREW_PREFIX}/share/zsh/site-functions:${FPATH}"

eval "$(brew shellenv)"
