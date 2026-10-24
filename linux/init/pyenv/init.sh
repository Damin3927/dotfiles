#!/bin/bash

# pyenv is optional on Linux (uv covers most needs); anyenv sets PYENV_ROOT when it is installed.
if command -v pyenv > /dev/null; then
  eval "$(pyenv init -)"
fi
