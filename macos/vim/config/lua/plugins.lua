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

  -- easymotion
  use {
    'easymotion/vim-easymotion',
    config = function()
      local keymap = vim.api.nvim_set_keymap

      vim.g.EasyMotion_do_mapping = 0 -- disable default mappings
      vim.g.EasyMotion_smartcase = 1
      keymap("n", "<Leader>j", "<Plug>(easymotion-j)", { noremap = true })
      keymap("n", "<Leader>k", "<Plug>(easymotion-k)", { noremap = true })

      keymap("n", "/", "<Plug>(easymotion-sn)", { noremap = true })
    end
  }

  -- dentaku
  use 'rapan931/dentaku.nvim'

  -- GitHub Copilot
  use 'github/copilot.vim'
end)
