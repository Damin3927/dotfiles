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
  use {
    'folke/tokyonight.nvim',
    config = function()
      vim.cmd[[colorscheme tokyonight]]
    end
  }

  -- fern
  use {
    'lambdalisue/fern.vim',
    config = function()
      -- show hidden files
      vim.g['fern#default_hidden'] = 1

      vim.api.nvim_set_keymap('n', '<C-n>', ':Fern . -drawer -reveal=%<CR>', { silent = true, noremap = true })
    end
  }
  use {
    'lambdalisue/nerdfont.vim',
    requires = {
      'lambdalisue/fern.vim',
    },
    config = function()
      vim.g['fern#renderer'] = 'nerdfont'
    end
  }
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
        'coc-biome',
        'coc-clangd',
        'coc-css',
        'coc-css',
        'coc-deno',
        'coc-diagnostic',
        'coc-docker',
        'coc-eslint',
        'coc-flutter',
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

  -- Gp.nvim
  use {
    'robitx/gp.nvim',
    config = function()
      local config = {
        agents = {
          {
            name = "ChatGPT-4o",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = "gpt-4o", temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are a general AI assistant.\n\n"
              .. "The user provided the additional info about how they would like you to respond:\n\n"
              .. "- If you're unsure don't guess and say you don't know instead.\n"
              .. "- Ask question if you need clarification to provide better answer.\n"
              .. "- Think deeply and carefully from first principles step by step.\n"
              .. "- Zoom out first to see the big picture and then zoom in to details.\n"
              .. "- Use Socratic method to improve your thinking and coding skills.\n"
              .. "- Don't elide any code from your output if the answer requires coding.\n"
              .. "- Take a deep breath; You've got this!\n",
          },
          {
            name = "ChatGPT4",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = "gpt-4-1106-preview", temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are a general AI assistant.\n\n"
              .. "The user provided the additional info about how they would like you to respond:\n\n"
              .. "- If you're unsure don't guess and say you don't know instead.\n"
              .. "- Ask question if you need clarification to provide better answer.\n"
              .. "- Think deeply and carefully from first principles step by step.\n"
              .. "- Zoom out first to see the big picture and then zoom in to details.\n"
              .. "- Use Socratic method to improve your thinking and coding skills.\n"
              .. "- Don't elide any code from your output if the answer requires coding.\n"
              .. "- Take a deep breath; You've got this!\n",
          },
          {
            name = "ChatGPT3-5",
            chat = true,
            command = false,
            -- string with model name or table with model name and parameters
            model = { model = "gpt-3.5-turbo-1106", temperature = 1.1, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are a general AI assistant.\n\n"
              .. "The user provided the additional info about how they would like you to respond:\n\n"
              .. "- If you're unsure don't guess and say you don't know instead.\n"
              .. "- Ask question if you need clarification to provide better answer.\n"
              .. "- Think deeply and carefully from first principles step by step.\n"
              .. "- Zoom out first to see the big picture and then zoom in to details.\n"
              .. "- Use Socratic method to improve your thinking and coding skills.\n"
              .. "- Don't elide any code from your output if the answer requires coding.\n"
              .. "- Take a deep breath; You've got this!\n",
          },
          {
            name = "CodeGPT-4o",
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = "gpt-4o", temperature = 0.8, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are an AI working as a code editor.\n\n"
              .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
              .. "START AND END YOUR ANSWER WITH:\n\n```",
          },
          {
            name = "CodeGPT4",
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = "gpt-4-1106-preview", temperature = 0.8, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are an AI working as a code editor.\n\n"
              .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
              .. "START AND END YOUR ANSWER WITH:\n\n```",
          },
          {
            name = "CodeGPT3-5",
            chat = false,
            command = true,
            -- string with model name or table with model name and parameters
            model = { model = "gpt-3.5-turbo-1106", temperature = 0.8, top_p = 1 },
            -- system prompt (use this to specify the persona/role of the AI)
            system_prompt = "You are an AI working as a code editor.\n\n"
              .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
              .. "START AND END YOUR ANSWER WITH:\n\n```",
          },
        }
      }
      require('gp').setup(config)
    end
  }

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
      'nvim-neotest/nvim-nio',
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
          theme = 'tokyonight'
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
      'andymass/vim-matchup',
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
        ignore_install = { "phpdoc", "ipkg" },

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

        matchup = {
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

  -- markdown
  use 'dhruvasagar/vim-table-mode'
  use {
    'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
  }

  -- buffergator
  use {
    'jeetsukumaran/vim-buffergator',
    config = function()
      vim.g.buffergator_suppress_keymaps = 1
    end
  }

  -- fugitive
  use {
    'tpope/vim-fugitive',
    requires = {
      'tpope/vim-rhubarb',
    },
    config = function()
      vim.api.nvim_set_keymap('n', '[fugitive]', '<Nop>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<Leader>i', '[fugitive]', { noremap = false })
      vim.api.nvim_set_keymap('n', '[fugitive]s', ':G<CR><C-w>T', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '[fugitive]a', ':Gwrite<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '[fugitive]w', ':w<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '[fugitive]c', ':G commit<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '[fugitive]d', ':Gdiff<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '[fugitive]h', ':G diff --cached<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '[fugitive]m', ':G blame<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '[fugitive]p', ':G push<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '[fugitive]l', ':G pull<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '[fugitive]b', ':Telescope git_branches<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '[fugitive]g', 'V:GBrowse<CR>', { silent = true, noremap = true })
    end
  }

  -- telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require("telescope").setup{
        pickers = {
          live_grep = {
            additional_args = function(opts)
              return {
                "--hidden",
                "--glob",
                "!**/.git/*",
              }
            end
          },
        },
      }

      vim.api.nvim_set_keymap('n', '[telescope]', '<Nop>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<Leader>f', '[telescope]', { noremap = false })
      vim.api.nvim_set_keymap('n', '[telescope]f', ':Telescope find_files<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '[telescope]r', ':Telescope live_grep<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '[telescope]b', ':Telescope buffers<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '[telescope]h', ':Telescope oldfiles<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '[telescope]g', ':Telescope git_files<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '[telescope]c', ':Telescope git_commits<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '[telescope]s', ':Telescope git_status<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '[telescope]l', ':Telescope git_bcommits<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '[telescope]t', ':Telescope treesitter<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '[telescope]w', ':Telescope grep_string<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '[telescope]s', ':Telescope<CR>', { silent = true, noremap = true })
    end
  }

  -- trailing whitespace
  use 'bronson/vim-trailing-whitespace'

  -- Rust
  use 'rust-lang/rust.vim'
  use {
    'saecki/crates.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('crates').setup()
    end,
  }

  -- Go
  use {
    'fatih/vim-go',
    run = ':GoUpdateBinaries'
  }

  -- protobuf
  use 'uarun/vim-protobuf'

  -- nvim-notify
  use {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require("notify")

      -- ref: https://github.com/rcarriga/nvim-notify/wiki/Usage-Recipes#cocnvim-integration---status-and-diagnostics
      local coc_diag_record = {}

      function coc_diag_notify(msg, level)
        local notify_opts = { title = "LSP Diagnostics", timeout = 500, on_close = reset_coc_diag_record }
        -- if coc_diag_record is not {} then add it to notify_opts to key called "replace"
        if coc_diag_record ~= {} then
          notify_opts["replace"] = coc_diag_record.id
        end
        coc_diag_record = vim.notify(msg, level, notify_opts)
      end

      function reset_coc_diag_record(window)
        coc_diag_record = {}
      end

      function coc_notify(msg, level)
        local notify_opts = { title = "LSP Message", timeout = 500 }
        vim.notify(msg, level, notify_opts)
      end
      vim.cmd([[
        function! s:DiagnosticNotify() abort
          let l:info = get(b:, 'coc_diagnostic_info', {})
          if empty(l:info) | return '' | endif
          let l:msgs = []
          let l:level = 'info'
           if get(l:info, 'warning', 0)
            let l:level = 'warn'
          endif
          if get(l:info, 'error', 0)
            let l:level = 'error'
          endif

          if get(l:info, 'error', 0)
            call add(l:msgs, ' Errors: ' . l:info['error'])
          endif
          if get(l:info, 'warning', 0)
            call add(l:msgs, ' Warnings: ' . l:info['warning'])
          endif
          if get(l:info, 'information', 0)
            call add(l:msgs, ' Infos: ' . l:info['information'])
          endif
          if get(l:info, 'hint', 0)
            call add(l:msgs, ' Hints: ' . l:info['hint'])
          endif
          let l:msg = join(l:msgs, "\n")
          if empty(l:msg) | let l:msg = ' All OK' | endif
          call v:lua.coc_diag_notify(l:msg, l:level)
        endfunction

        function! s:InitCoc() abort
          runtime! autoload/coc/ui.vim
          execute "lua vim.notify('Initialized coc.nvim for LSP support', 'info', { title = 'LSP Statuses' })"
        endfunction

        autocmd User CocNvimInit call s:InitCoc()
        autocmd User CocDiagnosticChange call s:DiagnosticNotify()
      ]])
    end
  }

  -- bufferline
  use {
    'akinsho/bufferline.nvim',
    config = function()
      require("bufferline").setup{
        options = {
          offsets = {
            {
              filetype = "fern",
              text = "File Explorer",
              text_align = "left",
              separator = true,
            }
          },
          separator_style = "slant",
        }
      }
    end
  }

  -- scrollbar
  use {
    'petertriho/nvim-scrollbar',
    config = function()
      require("scrollbar").setup()
    end
  }

  -- gitsigns
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'petertriho/nvim-scrollbar'
    },
    config = function()
      require('gitsigns').setup {
        word_diff = true,
        current_line_blame = true,
      }
      require("scrollbar.handlers.gitsigns").setup()
    end
  }

  -- transparent
  use 'xiyaowong/nvim-transparent'

  -- color code colorizer
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  }

  -- dashboard
  use {
    'goolord/alpha-nvim',
    requires = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function ()
      require'alpha'.setup(require'alpha.themes.startify'.config)
    end
  }

  -- devicons
  use {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require'nvim-web-devicons'.setup {
        default = true;
      }
    end
  }

  -- bclose
  use 'rbgrouleff/bclose.vim'

  -- uuid
  use 'kburdett/vim-nuuid'

  -- terraform
  use 'hashivim/vim-terraform'

  -- Quickrun
  use 'thinca/vim-quickrun'

  -- Astro
  use {
    'wuelnerdotexe/vim-astro',
    config = function()
      vim.g.astro_typescript = 'enable'
    end
  }

  -- test runner
  use {
    'vim-test/vim-test',
    config = function()
      vim.api.nvim_set_keymap('n', '<Leader>t', ':TestNearest<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<Leader>T', ':TestFile<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<Leader>l', ':TestLast<CR>', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('n', '<Leader>a', ':TestSuite<CR>', { silent = true, noremap = true })
    end
  }

  -- octo
  use {
  'pwntester/octo.nvim',
  requires = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function ()
    require('octo').setup({
      suppress_missing_scope = {
        projects_v2 = true,
      },
    })
  end
}
end)
