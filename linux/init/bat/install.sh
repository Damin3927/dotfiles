#!/bin/bash

set -eu

# Ubuntu ships the binary as `batcat` to avoid a name clash.
sudo apt install -y bat
mkdir -p "${HOME}/.local/bin"
ln -fns "$(command -v batcat)" "${HOME}/.local/bin/bat"
