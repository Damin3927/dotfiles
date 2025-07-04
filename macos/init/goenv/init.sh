#!/bin/bash

export GOENV_ROOT="$HOME/.anyenv/envs/goenv"
prepend_to_path "${GOENV_ROOT}/bin"

eval "$(goenv init -)"

prepend_to_path "${GOROOT}/bin"
append_to_path "${GOPATH}/bin"
