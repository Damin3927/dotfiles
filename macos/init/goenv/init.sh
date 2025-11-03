#!/bin/bash

export GOENV_ROOT="$HOME/.anyenv/envs/goenv"
prepend_to_path "${GOENV_ROOT}/bin"

goenv() {
  unset -f goenv
  eval "$(command goenv init -)"
  goenv "$@"
}

go() {
  unset -f go
  eval "$(command goenv init -)"
  go "$@"
}

prepend_to_path "${GOROOT}/bin"
append_to_path "${GOPATH}/bin"
