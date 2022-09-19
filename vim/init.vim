set encoding=utf-8
scriptencoding utf-8
set hidden
set nobackup
set nowritebackup

set shortmess+=c
set signcolumn=number

" enable plugin/indent by file type
filetype plugin indent on

" Auto reload of init.vim
autocmd! bufwritepost $MYVIMRC source %

" Syntax
syntax enable

" ---------
"  Letters
" ---------
set fileencoding=utf-8
set fileformats=unix,dos,mac
set ambiwidth=single

" ---------
"  Status line
" ---------
set showcmd
set ruler

" ---------
"  Tab/Indent
" ---------
set expandtab
set tabstop=2
set softtabstop=2
set autoindent
set nosmartindent
set cindent
set shiftwidth=2

" ---------
"  Search
" ---------
set incsearch
set ignorecase
set smartcase
set hlsearch
set ignorecase
set smartcase

" ---------
"  Cursor
" ---------
set number
nnoremap j gj
nnoremap k gk

" ---------
"  Parentheses
" ---------
set showmatch

" ---------
"  Leader
" ---------
let mapleader = "\<Space>"

" ---------
"  Yank
" ---------
set clipboard=unnamed


" load existing .vimrc
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" vim-plug
call plug#begin()

Plug 'antoinemadec/FixCursorHold.nvim'

Plug 'tomasr/molokai'

" fern
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'yuki-yano/fern-preview.vim'

" coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" vimspector
Plug 'puremourning/vimspector'

" fugitive
Plug 'tpope/vim-fugitive'

" CursorHold event (cuz native CursorHold event doesn't work in NeoVim)
Plug 'antoinemadec/FixCursorHold.nvim'

" sandwich
Plug 'machakann/vim-sandwich'

" lightline
" Plug 'itchyny/lightline.vim'

" emmet
Plug 'mattn/emmet-vim'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'

" tcomment
Plug 'tomtom/tcomment_vim'

" browser
Plug 'tyru/open-browser.vim'

" far.vim
Plug 'brooth/far.vim'

" markdown
Plug 'dhruvasagar/vim-table-mode'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" buffergator
Plug 'jeetsukumaran/vim-buffergator'

" endwise
Plug 'tpope/vim-endwise'

" current_word
Plug 'dominikduda/vim_current_word'

" enable :GBrowse
Plug 'tpope/vim-rhubarb'

" trailing-whitespace
Plug 'bronson/vim-trailing-whitespace'

" Rust
Plug 'rust-lang/rust.vim'

" zig
Plug 'ziglang/zig.vim'

" JavaScript
Plug 'othree/html5.vim'
Plug 'othree/yajs.vim'
Plug 'othree/es.next.syntax.vim'
Plug 'othree/javascript-libraries-syntax.vim'

" React
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'

" Svelte
Plug 'evanleck/vim-svelte', {'branch': 'main'}

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Protobuf
Plug 'uarun/vim-protobuf'

" Kotlin
Plug 'udalov/kotlin-vim'

" Snippets
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" nvim-notify
Plug 'rcarriga/nvim-notify'

" libraries
Plug 'nvim-lua/plenary.nvim'

" treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" devicons
Plug 'kyazdani42/nvim-web-devicons'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

" bufferline
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }

" scrollbar
Plug 'petertriho/nvim-scrollbar'

" color scheme
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }


call plug#end()


""" Fern
" Show hidden files
let g:fern#default_hidden=1

" Show file true with <C-n>
nnoremap <C-n> :Fern . -drawer -reveal=%<CR>

" Set fern renderer to nerdfont
let g:fern#renderer = "nerdfont"

" See a file preview with p
function! s:fern_settings() abort
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

""" Fugitive
nnoremap [fugitive] <Nop>
nmap <Leader>i [fugitive]
nnoremap <silent> [fugitive]s :G<CR><C-w>T
nnoremap <silent> [fugitive]a :Gwrite<CR>
nnoremap <silent> [fugitive]w :w<CR>
nnoremap <silent> [fugitive]c :G commit<CR>
nnoremap <silent> [fugitive]d :Gdiff<CR>
nnoremap <silent> [fugitive]h :G diff --cached<CR>
nnoremap <silent> [fugitive]m :G blame<CR>
nnoremap <silent> [fugitive]p :G push<CR>
nnoremap <silent> [fugitive]l :G pull<CR>
nnoremap <silent> [fugitive]b :GBranches<CR>
nnoremap <silent> [fugitive]g V:GBrowse<CR>


""" Coc
set pumblend=30
set winblend=20

" Install default extensions
let g:coc_global_extensions = [
  \'coc-diagnostic',
  \'coc-snippets',
  \'coc-css',
  \'coc-html',
  \'coc-clangd',
  \'coc-json',
  \'coc-pyright',
  \'coc-rust-analyzer',
  \'coc-rls',
  \'coc-pairs',
  \'coc-sh',
  \'coc-css',
  \'coc-go',
  \'coc-html',
  \'coc-java',
  \'coc-kotlin',
  \'coc-groovy',
  \'coc-markdownlint',
  \'coc-solargraph',
  \'coc-solidity',
  \'coc-vetur',
  \'coc-svelte',
  \'coc-tsserver',
  \'coc-prettier' ,
  \'coc-eslint',
  \'coc-docker',
  \'coc-zig',
  \'coc-protobuf'
\]


" Recognize <CR> in coc
inoremap <silent><expr> <Enter> coc#pum#visible() ? coc#pum#confirm() : "\<Enter>"

" Set Background of floating windows
" possible options can be found by `:h cterm-colors`
highlight CocFloating ctermbg=DarkBlue

" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show docs in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

" Symbol renaming
nmap <leader>rn <Plug>(coc-rename)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
let g:cursor_hold_updatetime = 2000
autocmd CursorHold * silent call CocActionAsync('highlight')

" Formatting selected code.
vnoremap <Leader>m <Plug>(coc-format-selected)

" Add `:Format` command to format current buffer.
function! FormatBuffer()
  execute CocActionAsync('format')
  execute "CocCommand eslint.executeAutofix"
endfunction
command! -nargs=0 Format :call FormatBuffer()
nnoremap <Leader>m :Format<CR>

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" coc-diagnostic
nnoremap <silent> cd :CocDiagnostic<CR>


""" vimspector
let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_install_gadgets = [
  \'debugpy',
\]


""" Tab keybindings
" ref: https://qiita.com/wadako111/items/755e753677dd72d8036d
" Anywhere SID.
function! s:SID_PREFIX()
  return matchstr(expand('<sfile>'), '<SNR>\d\+_\zeSID_PREFIX$')
endfunction

" Set tabline.
function! s:my_tabline()  "{{{
  let s = ''
  for i in range(1, tabpagenr('$'))
    let bufnrs = tabpagebuflist(i)
    let bufnr = bufnrs[tabpagewinnr(i) - 1]  " first window, first appears
    let no = i  " display 0-origin tabpagenr.
    let mod = getbufvar(bufnr, '&modified') ? '!' : ' '
    let title = fnamemodify(bufname(bufnr), ':t')
    let title = '[' . title . ']'
    let s .= '%'.i.'T'
    let s .= '%#' . (i == tabpagenr() ? 'TabLineSel' : 'TabLine') . '#'
    let s .= no . ':' . title
    let s .= mod
    let s .= '%#TabLineFill# '
  endfor
  let s .= '%#TabLineFill#%T%=%#TabLine#'
  return s
endfunction "}}}
let &tabline = '%!'. s:SID_PREFIX() . 'my_tabline()'
set showtabline=2

" The prefix key.
nnoremap    [Tag]   <Nop>
nmap    t [Tag]
" Tab jump
for n in range(1, 9)
  execute 'nnoremap <silent> [Tag]'.n  ':<C-u>tabnext'.n.'<CR>'
endfor

map <silent> [Tag]t :tablast <bar> tabnew<CR>
" tt open a new tab
map <silent> [Tag]x :tabclose<CR>
" tx close a tab
map <silent> [Tag]n :tabnext<CR>
" tn jump to the next tab
map <silent> [Tag]p :tabprevious<CR>
" tp jump to the previous tab


""" lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

""" fzf
command! -bang -nargs=? -complete=dir Files
    \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)
nnoremap [fzf] <Nop>
nmap <Leader>f [fzf]
" TODO: Replace with Telescope
nnoremap <silent> [fzf]h :<C-u>History<CR>
nnoremap <silent> [fzf]b :<C-u>Telescope buffers<CR>
nnoremap <silent> [fzf]f :<C-u>Files<CR>
nnoremap <silent> [fzf]g :<C-u>Telescope find_files<CR>
nnoremap <silent> [fzf]s :<C-u>GFiles?<CR>
nnoremap <silent> [fzf]c :<C-u>Commands<CR>
nnoremap <silent> [fzf]r :<C-u>Telescope live_grep<CR>
nnoremap <silent> [fzf]u :<C-u>Telescope grep_string<CR>


""" open-browser
nnoremap <Leader>o <Plug>(openbrowser-smart-search)
vnoremap <Leader>o <Plug>(openbrowser-smart-search)


""" terminal
nnoremap <silent> <Leader>d :<C-u>sp <CR> :wincmd j <CR> :term<CR>
nnoremap <silent> <Leader>D :<C-u>vsp<CR> :wincmd l <CR> :term<CR>
nnoremap <silent> <Leader>s :term<CR>
tnoremap <C-[> <C-\><C-n>
autocmd TermOpen * startinsert


""" far.vim
let g:far#source = "rgnvim"
let g:far#enable_undo = 1
nnoremap [far-replace] <Nop>
nmap <Leader>r [far-replace]
nnoremap <silent> [far-replace]  :Farr<cr>
vnoremap <silent> [far-replace]  :Farr<cr>


""" current_word
let g:vim_current_word#highlight_only_in_focusted_window = 1
hi CurrentWord ctermbg=53
hi CurrentWordTwins ctermbg=237


""" JavaScript
" Setup used libraries
let g:used_javascript_libs = 'react,vue'
let b:javascript_lib_use_react = 1
let b:javascript_lib_use_vue = 1

""" nvim-notify
lua << EOF

local coc_status_record = {}

function coc_status_notify(msg, level)
  local notify_opts = { title = "LSP Status", timeout = 500, hide_from_history = true, on_close = reset_coc_status_record }
  -- if coc_status_record is not {} then add it to notify_opts to key called "replace"
  if coc_status_record ~= {} then
    notify_opts["replace"] = coc_status_record.id
  end
  coc_status_record = vim.notify(msg, level, notify_opts)
end

function reset_coc_status_record(window)
  coc_status_record = {}
end

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
EOF

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

function! s:StatusNotify() abort
  let l:status = get(g:, 'coc_status', '')
  let l:level = 'info'
  if empty(l:status) | return '' | endif
  call v:lua.coc_status_notify(l:status, l:level)
endfunction

function! s:InitCoc() abort
  execute "lua vim.notify('Initialized coc.nvim for LSP support', 'info', { title = 'LSP Status' })"
endfunction

" notifications
autocmd User CocNvimInit call s:InitCoc()
autocmd User CocDiagnosticChange call s:DiagnosticNotify()
autocmd User CocStatusChange call s:StatusNotify()


""" nvim-treesitter
lua << EOF
require'nvim-treesitter.configs'.setup {
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
}
EOF


""" devicons
lua << EOF
require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {};
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}
EOF


""" bufferline
set termguicolors
lua << EOF
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
EOF


""" scrollbar
lua require("scrollbar").setup()


""" color scheme
" Color scheme
colorscheme tokyonight-night
