#!/bin/bash

set -eu

uv_bin="$(command -v uv || true)"
if [ -z "${uv_bin}" ]; then
  curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 sh
  uv_bin="${HOME}/.local/bin/uv"
fi
"${uv_bin}" tool install huggingface_hub
