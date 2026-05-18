return {
  -- color scheme
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      vim.cmd [[colorscheme tokyonight]]
    end,
  },

  -- fern
  {
    'lambdalisue/fern.vim',
    dependencies = {
      'lambdalisue/nerdfont.vim',
      'lambdalisue/fern-git-status.vim',
      'lambdalisue/fern-renderer-nerdfont.vim',
      'lambdalisue/fern-hijack.vim',
      'yuki-yano/fern-preview.vim',
    },
    config = function()
      vim.g['fern#default_hidden'] = 1
      vim.g['fern#renderer'] = 'nerdfont'
      vim.api.nvim_set_keymap('n', '<C-n>', ':Fern . -drawer -reveal=%<CR>', { silent = true, noremap = true })
    end,
  },

  -- coc.nvim
  {
    'neoclide/coc.nvim',
    branch = 'release',
    config = function()
      vim.g.coc_global_extensions = {
        '@yaegassy/coc-astro',
        '@yaegassy/coc-tailwindcss3',
        '@yaegassy/coc-volar',
        '@yaegassy/coc-volar-tools',
        'coc-biome',
        'coc-clangd',
        'coc-css',
        'coc-deno',
        'coc-diagnostic',
        'coc-docker',
        'coc-eslint',
        'coc-flutter',
        'coc-go',
        'coc-groovy',
        'coc-html',
        'coc-java',
        'coc-json',
        'coc-kotlin',
        'coc-markdownlint',
        'coc-pairs',
        'coc-prettier',
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
      keymap("i", "<CR>", [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]], opts)
      vim.cmd([[highlight CocFloating ctermbg=DarkBlue]])

      local silent = { silent = true }
      keymap("n", "gd", "<Plug>(coc-definition)", silent)
      keymap("n", "gy", "<Plug>(coc-type-definition)", silent)
      keymap("n", "gi", "<Plug>(coc-implementation)", silent)
      keymap("n", "gr", "<Plug>(coc-references)", silent)

      function _G.show_docs()
        local cw = vim.fn.expand('<cword>')
        if vim.fn.index({ 'vim', 'help' }, vim.bo.filetype) >= 0 then
          vim.api.nvim_command('h ' .. cw)
        elseif vim.api.nvim_eval('coc#rpc#ready()') then
          vim.fn.CocActionAsync('doHover')
        else
          vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
        end
      end
      keymap("n", "K", "<CMD>lua _G.show_docs()<CR>", silent)
      keymap("n", "<Leader>rn", "<Plug>(coc-rename)", silent)
      keymap("n", "<Leader>af", "<Plug>(coc-fix-current)", silent)

      vim.api.nvim_create_augroup("CocGroup", {})
      vim.api.nvim_create_autocmd("CursorHold", {
        group = "CocGroup",
        command = "silent call CocActionAsync('highlight')",
        desc = "Highlight symbol under cursor on CursorHold",
      })

      keymap("v", "<Leader>m", "<Plug>(coc-format-selected)", { silent = true, noremap = true })
      keymap("n", "<Leader>m", ":<C-u>Format<CR>", { silent = true, noremap = true })
      vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

      keymap("n", "<Leader>v", ":<C-u>CocList outline<CR>", { silent = true, nowait = true })

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

      keymap("n", "<silent>cd", ":<C-u>CocDiagnostic<CR>", { silent = true, noremap = true })
    end,
  },

  -- denops.vim
  'vim-denops/denops.vim',

  -- hop (phaazon/hop.nvim is gone; smoka7 fork is the active replacement)
  {
    'smoka7/hop.nvim',
    config = function()
      require('hop').setup { keys = 'etovxqpdygfblzhckisuran' }
      vim.keymap.set('', 'f', ':HopWord<CR>', { noremap = true })
    end,
  },

  -- dentaku
  'rapan931/dentaku.nvim',

  -- GitHub Copilot
  'github/copilot.vim',

  -- Gp.nvim
  {
    'robitx/gp.nvim',
    config = function()
      local persona = "You are a general AI assistant.\n\n"
        .. "The user provided the additional info about how they would like you to respond:\n\n"
        .. "- If you're unsure don't guess and say you don't know instead.\n"
        .. "- Ask question if you need clarification to provide better answer.\n"
        .. "- Think deeply and carefully from first principles step by step.\n"
        .. "- Zoom out first to see the big picture and then zoom in to details.\n"
        .. "- Use Socratic method to improve your thinking and coding skills.\n"
        .. "- Don't elide any code from your output if the answer requires coding.\n"
        .. "- Take a deep breath; You've got this!\n"
      local code_persona = "You are an AI working as a code editor.\n\n"
        .. "Please AVOID COMMENTARY OUTSIDE OF THE SNIPPET RESPONSE.\n"
        .. "START AND END YOUR ANSWER WITH:\n\n```"
      require('gp').setup {
        agents = {
          { name = "ChatGPT-4o",  chat = true,  command = false, model = { model = "gpt-4o",                 temperature = 1.1, top_p = 1 }, system_prompt = persona },
          { name = "ChatGPT4",    chat = true,  command = false, model = { model = "gpt-4-1106-preview",     temperature = 1.1, top_p = 1 }, system_prompt = persona },
          { name = "ChatGPT3-5",  chat = true,  command = false, model = { model = "gpt-3.5-turbo-1106",     temperature = 1.1, top_p = 1 }, system_prompt = persona },
          { name = "CodeGPT-4o",  chat = false, command = true,  model = { model = "gpt-4o",                 temperature = 0.8, top_p = 1 }, system_prompt = code_persona },
          { name = "CodeGPT4",    chat = false, command = true,  model = { model = "gpt-4-1106-preview",     temperature = 0.8, top_p = 1 }, system_prompt = code_persona },
          { name = "CodeGPT3-5",  chat = false, command = true,  model = { model = "gpt-3.5-turbo-1106",     temperature = 0.8, top_p = 1 }, system_prompt = code_persona },
        },
      }
    end,
  },

  -- mini.nvim
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup({})
    end,
  },

  -- dap
  {
    'mfussenegger/nvim-dap',
    config = function()
      local map = vim.api.nvim_set_keymap
      map('n', '<F5>',  ':DapContinue<CR>', { silent = true })
      map('n', '<F10>', ':DapStepOver<CR>', { silent = true })
      map('n', '<F11>', ':DapStepInto<CR>', { silent = true })
      map('n', '<F12>', ':DapStepOut<CR>',  { silent = true })
      map('n', '<leader>b',  ':DapToggleBreakpoint<CR>', { silent = true })
      map('n', '<leader>B',  ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Breakpoint condition: "))<CR>', { silent = true })
      map('n', '<leader>lp', ':lua require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>', { silent = true })
      map('n', '<leader>gr', ':lua require("dap").repl.open()<CR>', { silent = true })
      map('n', '<leader>gl', ':lua require("dap").run_last()<CR>', { silent = true })
    end,
  },
  {
    'rcarriga/nvim-dap-ui',
    dependencies = { 'mfussenegger/nvim-dap', 'nvim-neotest/nvim-nio' },
    config = function()
      require('dapui').setup()
      vim.api.nvim_set_keymap('n', '<leader>G', ':lua require("dapui").toggle()<CR>', {})
    end,
  },
  {
    'mfussenegger/nvim-dap-python',
    dependencies = { 'mfussenegger/nvim-dap' },
    config = function()
      require('dap-python').setup('~/.pyenv/shims/python3')
    end,
  },

  -- sandwich
  'machakann/vim-sandwich',

  -- status line
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup { options = { theme = 'tokyonight' } }
    end,
  },

  -- emmet
  {
    'mattn/emmet-vim',
    config = function()
      vim.g.user_emmet_settings = { typescript = { extends = 'jsx' } }
    end,
  },

  -- Comment
  {
    'numToStr/Comment.nvim',
    dependencies = { 'JoosepAlviste/nvim-ts-context-commentstring' },
    config = function()
      require('Comment').setup()
    end,
  },

  -- treesitter (main branch)
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    lazy = false,
    build = ':TSUpdate',
    dependencies = { 'andymass/vim-matchup' },
    config = function()
      require('nvim-treesitter').setup()

      local ensure = {
        'astro', 'bash', 'c', 'comment', 'cpp', 'css', 'dart', 'diff',
        'dockerfile', 'gitcommit', 'gitignore', 'go', 'gomod', 'gosum',
        'graphql', 'groovy', 'hcl', 'html', 'java', 'javascript', 'jsdoc',
        'json', 'kotlin', 'lua', 'luadoc', 'make', 'markdown',
        'markdown_inline', 'proto', 'python', 'query', 'regex', 'ruby',
        'rust', 'scss', 'solidity', 'sql', 'svelte', 'swift', 'terraform',
        'toml', 'tsx', 'typescript', 'vim', 'vimdoc', 'vue', 'yaml', 'zig',
      }
      pcall(function() require('nvim-treesitter').install(ensure) end)

      -- Activate highlight + indent on FileType. Falls back silently if a
      -- parser isn't installed yet (user can :TSInstall <lang> on demand).
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local bufnr = args.buf
          local ft = vim.bo[bufnr].filetype
          local lang = vim.treesitter.language.get_lang(ft)
          if not lang then return end
          local installed = require('nvim-treesitter.config').get_installed('parsers')
          if not vim.list_contains(installed, lang) then return end
          if pcall(vim.treesitter.start, bufnr, lang) then
            vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })
    end,
  },

  -- treesitter satellites
  'JoosepAlviste/nvim-ts-context-commentstring',
  'andymass/vim-matchup',

  -- browser
  {
    'tyru/open-browser.vim',
    config = function()
      vim.api.nvim_set_keymap('n', '<leader>o', '<Plug>(openbrowser-smart-search)', { silent = true, noremap = true })
      vim.api.nvim_set_keymap('v', '<leader>o', '<Plug>(openbrowser-smart-search)', { silent = true, noremap = true })
    end,
  },

  -- UltiSnips
  {
    'SirVer/ultisnips',
    config = function()
      vim.g.UltiSnipsExpandTrigger = "<tab>"
      vim.g.UltiSnipsJumpForwardTrigger = "<c-j>"
      vim.g.UltiSnipsJumpBackwardTrigger = "<c-k>"
      vim.g.UltiSnipsEditSplit = "vertical"
    end,
  },
  'honza/vim-snippets',
  {
    'mlaursen/vim-react-snippets',
    build = 'rm -rf UltiSnips/javascript*', -- javascript snippets conflict with typescript ones
  },

  -- markdown
  'dhruvasagar/vim-table-mode',
  {
    'iamcco/markdown-preview.nvim',
    build = 'cd app && yarn install',
  },

  -- buffergator
  {
    'jeetsukumaran/vim-buffergator',
    config = function()
      vim.g.buffergator_suppress_keymaps = 1
    end,
  },

  -- fugitive
  {
    'tpope/vim-fugitive',
    dependencies = { 'tpope/vim-rhubarb' },
    config = function()
      local map = vim.api.nvim_set_keymap
      map('n', '[fugitive]', '<Nop>', { silent = true, noremap = true })
      map('n', '<Leader>i',  '[fugitive]', { noremap = false })
      map('n', '[fugitive]s', ':G<CR><C-w>T',     { silent = true, noremap = true })
      map('n', '[fugitive]a', ':Gwrite<CR>',      { silent = true, noremap = true })
      map('n', '[fugitive]w', ':w<CR>',           { silent = true, noremap = true })
      map('n', '[fugitive]c', ':G commit<CR>',    { silent = true, noremap = true })
      map('n', '[fugitive]d', ':Gdiff<CR>',       { silent = true, noremap = true })
      map('n', '[fugitive]h', ':G diff --cached<CR>', { silent = true, noremap = true })
      map('n', '[fugitive]m', ':G blame<CR>',     { silent = true, noremap = true })
      map('n', '[fugitive]p', ':G push<CR>',      { silent = true, noremap = true })
      map('n', '[fugitive]l', ':G pull<CR>',      { silent = true, noremap = true })
      map('n', '[fugitive]b', ':Telescope git_branches<CR>', { silent = true, noremap = true })
      map('n', '[fugitive]g', 'V:GBrowse<CR>',    { silent = true, noremap = true })
    end,
  },

  -- telescope
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
      require('telescope').setup {
        pickers = {
          live_grep = {
            additional_args = function() return { "--hidden", "--glob", "!**/.git/*" } end,
          },
        },
      }
      local map = vim.api.nvim_set_keymap
      map('n', '[telescope]', '<Nop>', { silent = true, noremap = true })
      map('n', '<Leader>f',   '[telescope]', { noremap = false })
      map('n', '[telescope]f', ':Telescope find_files<CR>',  { silent = true, noremap = true })
      map('n', '[telescope]r', ':Telescope live_grep<CR>',   { silent = true, noremap = true })
      map('n', '[telescope]b', ':Telescope buffers<CR>',     { silent = true, noremap = true })
      map('n', '[telescope]h', ':Telescope oldfiles<CR>',    { silent = true, noremap = true })
      map('n', '[telescope]g', ':Telescope git_files<CR>',   { silent = true, noremap = true })
      map('n', '[telescope]c', ':Telescope git_commits<CR>', { silent = true, noremap = true })
      map('n', '[telescope]s', ':Telescope git_status<CR>',  { silent = true, noremap = true })
      map('n', '[telescope]l', ':Telescope git_bcommits<CR>',{ silent = true, noremap = true })
      map('n', '[telescope]t', ':Telescope treesitter<CR>',  { silent = true, noremap = true })
      map('n', '[telescope]w', ':Telescope grep_string<CR>', { silent = true, noremap = true })
      map('n', '[telescope]s', ':Telescope<CR>',             { silent = true, noremap = true })
    end,
  },

  -- trailing whitespace
  'bronson/vim-trailing-whitespace',

  -- Rust
  'rust-lang/rust.vim',
  {
    'saecki/crates.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function() require('crates').setup() end,
  },

  -- Go
  {
    'fatih/vim-go',
    build = ':GoUpdateBinaries',
  },

  -- protobuf
  'uarun/vim-protobuf',

  -- nvim-notify
  {
    'rcarriga/nvim-notify',
    config = function()
      vim.notify = require('notify')

      local coc_diag_record = {}
      function _G.coc_diag_notify(msg, level)
        local notify_opts = { title = "LSP Diagnostics", timeout = 500, on_close = _G.reset_coc_diag_record }
        if coc_diag_record ~= {} then
          notify_opts.replace = coc_diag_record.id
        end
        coc_diag_record = vim.notify(msg, level, notify_opts)
      end
      function _G.reset_coc_diag_record() coc_diag_record = {} end
      function _G.coc_notify(msg, level)
        vim.notify(msg, level, { title = "LSP Message", timeout = 500 })
      end

      vim.cmd [[
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
            call add(l:msgs, ' Errors: ' . l:info['error'])
          endif
          if get(l:info, 'warning', 0)
            call add(l:msgs, ' Warnings: ' . l:info['warning'])
          endif
          if get(l:info, 'information', 0)
            call add(l:msgs, ' Infos: ' . l:info['information'])
          endif
          if get(l:info, 'hint', 0)
            call add(l:msgs, ' Hints: ' . l:info['hint'])
          endif
          let l:msg = join(l:msgs, "\n")
          if empty(l:msg) | let l:msg = ' All OK' | endif
          call v:lua.coc_diag_notify(l:msg, l:level)
        endfunction

        function! s:InitCoc() abort
          runtime! autoload/coc/ui.vim
          execute "lua vim.notify('Initialized coc.nvim for LSP support', 'info', { title = 'LSP Statuses' })"
        endfunction

        autocmd User CocNvimInit call s:InitCoc()
        autocmd User CocDiagnosticChange call s:DiagnosticNotify()
      ]]
    end,
  },

  -- bufferline
  {
    'akinsho/bufferline.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('bufferline').setup {
        options = {
          offsets = {
            { filetype = "fern", text = "File Explorer", text_align = "left", separator = true },
          },
          separator_style = "slant",
        },
      }
    end,
  },

  -- scrollbar
  {
    'petertriho/nvim-scrollbar',
    config = function() require('scrollbar').setup() end,
  },

  -- gitsigns
  {
    'lewis6991/gitsigns.nvim',
    dependencies = { 'petertriho/nvim-scrollbar' },
    config = function()
      require('gitsigns').setup { word_diff = true, current_line_blame = true }
      require('scrollbar.handlers.gitsigns').setup()
    end,
  },

  -- transparent
  'xiyaowong/nvim-transparent',

  -- color code colorizer
  {
    'norcalli/nvim-colorizer.lua',
    config = function() require('colorizer').setup() end,
  },

  -- dashboard
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('alpha').setup(require('alpha.themes.startify').config)
    end,
  },

  -- devicons
  {
    'nvim-tree/nvim-web-devicons',
    config = function()
      require('nvim-web-devicons').setup { default = true }
    end,
  },

  -- bclose
  'rbgrouleff/bclose.vim',

  -- uuid
  'kburdett/vim-nuuid',

  -- terraform
  'hashivim/vim-terraform',

  -- Quickrun
  'thinca/vim-quickrun',

  -- Astro
  {
    'wuelnerdotexe/vim-astro',
    init = function() vim.g.astro_typescript = 'enable' end,
  },

  -- test runner
  {
    'vim-test/vim-test',
    config = function()
      local map = vim.api.nvim_set_keymap
      map('n', '<Leader>t', ':TestNearest<CR>', { silent = true, noremap = true })
      map('n', '<Leader>T', ':TestFile<CR>',    { silent = true, noremap = true })
      map('n', '<Leader>l', ':TestLast<CR>',    { silent = true, noremap = true })
      map('n', '<Leader>a', ':TestSuite<CR>',   { silent = true, noremap = true })
    end,
  },

  -- octo
  {
    'pwntester/octo.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('octo').setup({ suppress_missing_scope = { projects_v2 = true } })
    end,
  },
}
