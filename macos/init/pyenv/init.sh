#!/bin/bash

export PYENV_ROOT="${HOME}/.pyenv"
append_to_path "${PYENV_ROOT}/bin"

_pyenv_init() {
  eval "$(pyenv init -)"
}

eval "$(lazyenv.load _pyenv_init pyenv python python3 pip poetry)"
