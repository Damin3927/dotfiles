local opts = {
  noremap = true,
  silent = true,
}

local keymap = vim.api.nvim_set_keymap

keymap("n", "j", "gj", opts)
keymap("n", "k", "gk", opts)

-- Remap Space as Leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
