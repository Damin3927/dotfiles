#!/bin/bash

set -eu

# Ubuntu ships the binary as `fdfind` to avoid a name clash.
sudo apt install -y fd-find
mkdir -p "${HOME}/.local/bin"
ln -fns "$(command -v fdfind)" "${HOME}/.local/bin/fd"
