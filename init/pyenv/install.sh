#!/bin/bash

git clone https://github.com/pyenv/pyenv.git "${HOME}/.pyenv"

pushd "${HOME}/.pyenv" || exit 1
git checkout v2.3.4
popd || exit 1
