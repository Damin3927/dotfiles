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


-- terminal
keymap("n", "<Leader>d", ":<C-u>sp <CR> :wincmd j <CR> :term<CR>", opts)
keymap("n", "<Leader>D", ":<C-u>vsp <CR> :wincmd l <CR> :term<CR>", opts)
keymap("n", "<Leader>s", ":term<CR>", opts)
keymap("t", "<C-[>", "<C-\\><C-n>", opts)
vim.api.nvim_create_autocmd("TermOpen", {
  pattern = "*",
  command = "startinsert",
})


-- chatgpt
vim.g.chat_gpt_key = ""


-- python location
vim.g.python3_host_prog = "~/.pyenv/shims/python3"
