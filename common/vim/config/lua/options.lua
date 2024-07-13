local options = {
  encoding = "utf-8",
  hidden = true,
  backup = false,
  writebackup = false,
  signcolumn = "number",

  -- Letters
  fileencoding = "utf-8",
  fileformats = { "unix", "dos", "mac" },
  ambiwidth = "single",

  -- Status line
  showcmd = true,
  ruler = true,

  -- Tab / Indent
  expandtab = true,
  tabstop = 2,
  softtabstop = 2,
  autoindent = true,
  smartindent = false,
  cindent = true,
  shiftwidth = 2,

  -- Search
  incsearch = true,
  ignorecase = true,
  smartcase = true,
  hlsearch = true,

  -- Cursor
  number = true,

  -- Parentheses
  showmatch = true,

  -- Yank
  clipboard = "unnamed",

  -- popup
  pumblend = 30,
  winblend = 20,

  -- CursorHold
  updatetime = 200,

  -- Color
  termguicolors = true,
}

vim.opt.shortmess:append("c")

for k, v in pairs(options) do
	vim.opt[k] = v
end
