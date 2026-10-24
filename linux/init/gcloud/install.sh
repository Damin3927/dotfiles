#!/bin/bash

set -eu

arch="$(uname -m)"
case "${arch}" in
  aarch64) arch=arm ;;
esac

prefix="${HOME}/.local/opt"
mkdir -p "${prefix}"
curl -fsSL "https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-linux-${arch}.tar.gz" \
  | tar -xz -C "${prefix}"
"${prefix}/google-cloud-sdk/install.sh" --quiet --usage-reporting=false --path-update=false --command-completion=false
