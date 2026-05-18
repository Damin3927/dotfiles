-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local out = vim.fn.system({
    "git", "clone", "--filter=blob:none", "--branch=stable",
    "https://github.com/folke/lazy.nvim.git", lazypath,
  })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("base")
require("options")
require("keymaps")

require("lazy").setup(require("plugins"), {
  defaults = { lazy = false },
  install = { colorscheme = { "tokyonight", "habamax" } },
  ui = { border = "rounded" },
  checker = { enabled = false },
  performance = {
    rtp = { disabled_plugins = { "netrwPlugin", "tohtml", "tutor" } },
  },
})
