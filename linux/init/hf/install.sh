#!/bin/bash

set -eu

if ! command -v uv > /dev/null; then
  curl -LsSf https://astral.sh/uv/install.sh | env UV_NO_MODIFY_PATH=1 sh
fi
"${HOME}/.local/bin/uv" tool install huggingface_hub
