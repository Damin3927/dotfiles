#!/bin/bash

export PYENV_ROOT="${HOME}/.pyenv"
append_to_path "${PYENV_ROOT}/bin"

_pyenv_init() {
  eval "$(pyenv init -)"
}

# if POETRY_ACTIVE=1, eval pyenv init immediately
# otherwise, lazy load pyenv init
if [[ "${POETRY_ACTIVE}" == "1" ]]; then
  _pyenv_init
  unset -f _pyenv_init
else
  eval "$(lazyenv.load _pyenv_init pyenv python python3 pip poetry)"
fi
