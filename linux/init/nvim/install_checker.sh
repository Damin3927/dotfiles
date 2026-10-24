#!/bin/bash

# The apt package is too old for the config (denops and nvim-treesitter main need >= 0.11.3).
is_nvim_installed() {
  [ -x "${HOME}/.local/opt/nvim/bin/nvim" ]
}
