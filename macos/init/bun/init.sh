#!/bin/bash

export BUN_INSTALL="${HOME}/.bun"

# bun completions
# shellcheck disable=SC1091
[ -s "${HOME}/.bun/_bun" ] && source "${HOME}/.bun/_bun"

# bun
append_to_path "${BUN_INSTALL}/bin"
