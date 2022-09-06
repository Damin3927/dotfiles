#!/bin/bash

# bun completions
[ -s "${HOME}/.bun/_bun" ] && source "${HOME}/.bun/_bun"

# bun
append_to_path "${BUN_INSTALL}/bin"
