#!/bin/bash

pet-select() {
  BUFFER=$(pet search --query "${LBUFFER}")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
bindkey '^e' pet-select
