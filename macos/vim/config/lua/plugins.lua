local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

-- Auto-compile plugins.lua
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

vim.cmd [[packadd packer.nvim]]

return require("packer").startup(function (use)
  use 'wbthomason/packer.nvim'

  -- color scheme
  use 'tomasr/molokai'

  -- fern
  use 'lambdalisue/nerdfont.vim'
  use 'lambdalisue/fern.vim'
  use 'lambdalisue/fern-git-status.vim'
  use 'lambdalisue/fern-renderer-nerdfont.vim'
  use 'lambdalisue/fern-hijack.vim'
  use 'yuki-yano/fern-preview.vim'

  -- coc.nvim
  use {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function()
      -- default extensions
      vim.g.coc_global_extensions = {
        '@yaegassy/coc-astro',
        '@yaegassy/coc-tailwindcss3',
        '@yaegassy/coc-volar',
        '@yaegassy/coc-volar-tools',
        'coc-clangd',
        'coc-css',
        'coc-css',
        'coc-deno',
        'coc-diagnostic',
        'coc-docker',
        'coc-eslint',
        'coc-go',
        'coc-groovy',
        'coc-html',
        'coc-html',
        'coc-java',
        'coc-json',
        'coc-kotlin',
        'coc-markdownlint',
        'coc-pairs',
        'coc-prettier' ,
        'coc-protobuf',
        'coc-pyright',
        'coc-rust-analyzer',
        'coc-sh',
        'coc-snippets',
        'coc-solargraph',
        'coc-solidity',
        'coc-sourcekit',
        'coc-sql',
        'coc-svelte',
        'coc-tsserver',
        'coc-typos',
        'coc-zig',
        'coc-zls',
      }

      local keymap = vim.api.nvim_set_keymap
      local opts = {
        noremap = true,
        silent = true,
        expr = true,
        replace_keycodes = false,
      }
      -- Recognize <CR> in coc.nvim
      keymap("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],  opts)
      -- Set Background of floating windows
      -- possible options can be found by `:h cterm-colors`
      vim.cmd([[highlight CocFloating ctermbg=DarkBlue]])

      -- navigation
      local opts = {
        silent = true,
      }
      keymap("n", "gd", "<Plug>(coc-definition)", opts)
      keymap("n", "gy", "<Plug>(coc-type-definition)", opts)
      keymap("n", "gi", "<Plug>(coc-implementation)", opts)
      keymap("n", "gr", "<Plug>(coc-references)", opts)

      -- preview window in K
      function _G.show_docs()
          local cw = vim.fn.expand('<cword>')
          if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
              vim.api.nvim_command('h ' .. cw)
          elseif vim.api.nvim_eval('coc#rpc#ready()') then
              vim.fn.CocActionAsync('doHover')
          else
              vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
          end
      end
      keymap("n", "K", "<CMD>lua _G.show_docs()<CR>", { silent = true })

      -- Renaming
      keymap("n", "<Leader>rn", "<Plug>(coc-rename)", { silent = true })

      -- AutoFix on the current line
      keymap("n", "<Leader>af", "<Plug>(coc-fix-current)", { silent = true })

      -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
      vim.api.nvim_create_augroup("CocGroup", {})
      vim.api.nvim_create_autocmd("CursorHold", {
          group = "CocGroup",
          command = "silent call CocActionAsync('highlight')",
          desc = "Highlight symbol under cursor on CursorHold"
      })

      -- Format
      keymap("v", "<Leader>m", "<Plug>(coc-format-selected)", { silent = true, noremap = true })
      keymap("n", "<Leader>m", ":<C-u>Format<CR>", { silent = true, noremap = true })
      -- Add `:Format` command to format current buffer
      vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

      -- outline
      keymap("n", "<Leader>v", ":<C-u>CocList outline<CR>", { silent = true, nowait = true })

      -- Remap <C-f> and <C-b> for scroll float windows/popups.
      vim.cmd [[
        if has('nvim-0.4.0') || has('patch-8.2.0750')
          nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
          nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
          inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
          inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
          vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
          vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
      endif
      ]]

      -- coc-diagnostic
      keymap("n", "<silent>cd", ":<C-u>CocDiagnostic<CR>", { silent = true, noremap = true })
    end
  }

  -- denops.vim
  use 'vim-denops/denops.vim'

  -- hop
  use {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      local hop = require('hop')
      hop.setup {
        keys = 'etovxqpdygfblzhckisuran'
      }
      vim.keymap.set('', 'f', ':HopWord<CR>', { noremap = true })
    end
  }

  -- dentaku
  use 'rapan931/dentaku.nvim'

  -- GitHub Copilot
  use 'github/copilot.vim'

  -- ChatGPT
  use 'CoderCookE/vim-chatgpt'

  use({
    "jackMort/ChatGPT.nvim",
      config = function()
        require("chatgpt").setup()
      end,
      requires = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope.nvim"
      }
  })

  -- mini.nvim
  use({
    "echasnovski/mini.nvim",
    config = function()
      require("mini.ai").setup({})
    end
  })

  -- dap
  use {
    'mfussenegger/nvim-dap',
    config = function()
      vim.api.nvim_set_keymap('n', '<F5>', ':DapContinue<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<F10>', ':DapStepOver<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<F11>', ':DapStepInto<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<F12>', ':DapStepOut<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<leader>b', ':DapToggleBreakpoint<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<leader>B', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Breakpoint condition: "))<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<leader>lp', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<leader>gr', ':lua require("dap").repl.open()<CR>', { silent = true })
      vim.api.nvim_set_keymap('n', '<leader>gl', ':lua require("dap").run_last()<CR>', { silent = true })
    end
  }
  use {
    'rcarriga/nvim-dap-ui',
    requires = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      require("dapui").setup()
      vim.api.nvim_set_keymap('n', '<leader>G', ':lua require("dapui").toggle()<CR>', {})
    end
  }
  use {
    'mfussenegger/nvim-dap-python',
    requires = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      require("dap-python").setup('~/.pyenv/shims/python3')
    end
  }

  -- sandwich
  use 'machakann/vim-sandwich'

  -- status line
  use {
    'nvim-lualine/lualine.nvim',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('lualine').setup {
        options = {
          theme = 'material'
        }
      }
    end
  }

  -- emmet
  use {
    'mattn/emmet-vim',
    config = function()
      vim.g.user_emmet_settings = {
        typescript = {
          extends = 'jsx'
        }
      }
    end
  }

  -- treesitter
  use {
      'numToStr/Comment.nvim',
      config = function()
          require('Comment').setup()
      end
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    requires = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require('nvim-treesitter.configs').setup {
        -- A list of parser names, or "all"
        ensure_installed = "all",

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = false,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        -- List of parsers to ignore installing (for "all")
        ignore_install = { "phpdoc" },

        ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
        -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

        highlight = {
          -- `false` will disable the whole extension
          enable = true,

          -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
          -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
          -- the name of the parser)
          -- list of language that will be disabled
          disable = {},

          -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
          -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
          -- Using this option may slow down your editor, and you may see some duplicate highlights.
          -- Instead of true it can also be a list of languages
          additional_vim_regex_highlighting = false,
        },

        rainbow = {
          enable = true,
          extended_mode = true,
        },

        matchup = {
          enable = true,
        },

        indent = {
          enable = true,
        },

        context_commentstring = {
          enable = true,
        },
      }
    end
  }

  -- browser
  use {
    'tyru/open-browser.vim',
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>o', '<Plug>(openbrowser-smart-search)', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('v', '<leader>o', '<Plug>(openbrowser-smart-search)', { silent = true, noremap = true })
    end
  }

  -- UltiSnips
  use {
    "SirVer/ultisnips",
    config = function()
      vim.g.UltiSnipsExpandTrigger = "<tab>"
      vim.g.UltiSnipsJumpForwardTrigger = "<c-j>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<c-k>"
      vim.g.UltiSnipsEditSplit = "vertical"
    end,
  }
  use 'honza/vim-snippets'
  use {
    'mlaursen/vim-react-snippets',
    run = 'rm -rf UltiSnips/javascript*' -- javascript snippets conflicts with typescript ones
  }
end)
