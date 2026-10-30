#!/bin/bash

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "${HOME}/.config/mise"
ln -fns "${SCRIPT_DIR}/config.toml" "${HOME}/.config/mise/config.toml"
echo "Symlinked .config/mise/config.toml"
