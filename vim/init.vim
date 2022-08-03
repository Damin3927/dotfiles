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

" Color scheme
colorscheme hybrid

" Syntax
syntax enable

" ---------
"  Letters
" ---------
set fileencoding=utf-8
set fileformats=unix,dos,mac
set ambiwidth=double

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
Plug 'itchyny/lightline.vim'

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

" Svelte
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte', {'branch': 'main'}


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
" Install default extensions
let g:coc_global_extensions = [
  \'coc-diagnostic',
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
  \'coc-markdownlint',
  \'coc-solargraph',
  \'coc-solidity',
  \'coc-vetur',
  \'coc-svelte',
  \'coc-tsserver',
  \'coc-prettier' ,
  \'coc-eslint',
  \'coc-docker',
  \'coc-zig'
\]


" Recognize <CR> in coc
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

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
nnoremap <silent> [fzf]h :<C-u>History<CR>
nnoremap <silent> [fzf]b :<C-u>Buffers<CR>
nnoremap <silent> [fzf]f :<C-u>Files<CR>
nnoremap <silent> [fzf]g :<C-u>GFiles<CR>
nnoremap <silent> [fzf]s :<C-u>GFiles?<CR>
nnoremap <silent> [fzf]c :<C-u>Commands<CR>
nnoremap <silent> [fzf]r :<C-u>Rg<CR>


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
