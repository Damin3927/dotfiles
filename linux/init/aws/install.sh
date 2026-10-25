#!/bin/bash

set -eu

tmp_dir="$(mktemp -d)"
trap 'rm -rf "${tmp_dir}"' EXIT

curl -fsSL "https://awscli.amazonaws.com/awscli-exe-linux-$(uname -m).zip" -o "${tmp_dir}/awscliv2.zip"
unzip -q "${tmp_dir}/awscliv2.zip" -d "${tmp_dir}"
mkdir -p "${HOME}/.local/bin"
"${tmp_dir}/aws/install" --install-dir "${HOME}/.local/opt/aws-cli" --bin-dir "${HOME}/.local/bin" --update
