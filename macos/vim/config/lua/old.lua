vim.cmd([[
let g:arch = system('uname -m')

" vim-plug
call plug#begin()

" libraries
Plug 'nvim-lua/plenary.nvim'

" test runner
Plug 'vim-test/vim-test'

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


""" terminal
nnoremap <silent> <Leader>d :<C-u>sp <CR> :wincmd j <CR> :term<CR>
nnoremap <silent> <Leader>D :<C-u>vsp<CR> :wincmd l <CR> :term<CR>
nnoremap <silent> <Leader>s :term<CR>
tnoremap <C-[> <C-\><C-n>
autocmd TermOpen * startinsert


""" test runner
" nnoremap <silent> <leader>t :<C-u>TestNearest<CR>
nnoremap <silent> <leader>T :<C-u>TestFile<CR>
nnoremap <silent> <leader>a :<C-u>TestSuite<CR>
nnoremap <silent> <leader>l :<C-u>TestLast<CR>
nnoremap <silent> <leader>g :<C-u>TestVisit<CR>


""" python location
let g:python3_host_prog = '~/.pyenv/shims/python3'


"""volar
" set - as a keyword in vue file
autocmd Filetype vue setlocal iskeyword+=-


let g:chat_gpt_key=""
]])
