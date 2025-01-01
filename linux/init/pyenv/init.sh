#!/bin/bash

export PYENV_ROOT="${HOME}/.pyenv"
append_to_path "${PYENV_ROOT}/bin"

eval "$(pyenv init -)"
