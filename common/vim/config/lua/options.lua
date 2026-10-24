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
  clipboard = "unnamedplus",

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

-- Over SSH there is no local clipboard tool, so copy to the client terminal via OSC 52.
-- Paste reads the unnamed register because many terminals (e.g. iTerm2) refuse OSC 52 reads.
if vim.env.SSH_TTY and not vim.env.DISPLAY then
  local osc52 = require("vim.ui.clipboard.osc52")
  local function paste()
    return { vim.fn.split(vim.fn.getreg(""), "\n"), vim.fn.getregtype("") }
  end
  vim.g.clipboard = {
    name = "OSC 52",
    copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
    paste = { ["+"] = paste, ["*"] = paste },
  }
end
