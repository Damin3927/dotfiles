#!/bin/bash

set -eu

arch="$(uname -m)"
case "${arch}" in
  aarch64) arch=arm64 ;;
esac

prefix="${HOME}/.local/opt/nvim"
tmp_dir="$(mktemp -d)"
trap 'rm -rf "${tmp_dir}"' EXIT

curl -fsSL "https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${arch}.tar.gz" \
  | tar -xz -C "${tmp_dir}" --strip-components=1

rm -rf "${prefix}"
mkdir -p "$(dirname "${prefix}")" "${HOME}/.local/bin"
mv "${tmp_dir}" "${prefix}"
ln -fns "${prefix}/bin/nvim" "${HOME}/.local/bin/nvim"
