"
"  .vimrc
"  Vim configuration.
"
"  Created by Zakhary Kaplan on 2019-06-05.
"  Copyright © 2019 Zakhary Kaplan. All rights reserved.
"

" --------------------------------
"           Autocommands
" --------------------------------

" Vimrc: {{{
augroup vimrc
  autocmd!

  " Override formatoptions upon entering a new buffer
  autocmd BufNewFile,BufWinEnter * setlocal formatoptions-=cro

  " For very long files, set foldmethod to indent to avoid long folding times
  autocmd BufNewFile,BufRead *
    \ if line('$') < 1000
    \ |   setlocal foldmethod=syntax
    \ | else
    \ |   setlocal foldmethod=indent
    \ | endif
  " Tier foldlevel depending on how many lines are in the buffer
  autocmd BufNewFile,BufRead *
    \ if line('$') < 100
    \ |   setlocal foldlevel=99
    \ | else
    \ |   setlocal foldlevel=0
    \ | endif

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid, when inside an event handler
  " (happens when dropping a file on gvim) and for a commit message (it's
  " likely a different one than last time).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif

  " Trim trailing whitespace on write
  autocmd BufWritePre * %s/\s\+$//e
  " Replace tabs with spaces on write
  autocmd BufWritePre * retab

  " Don't screw up folds when inserting text that might affect them, until
  " leaving insert mode. Foldmethod is local to the window. Protect against
  " screwing up folding when switching between windows.
  autocmd InsertEnter *
    \ if !exists('w:foldmethod')
    \ |   let w:foldmethod=&foldmethod | setlocal foldmethod=manual
    \ | endif
  autocmd InsertLeave,WinLeave *
    \ if exists('w:foldmethod')
    \ |   let &l:foldmethod=w:foldmethod
    \ |   unlet w:foldmethod
    \ | endif

augroup END
" }}}


" --------------------------------
"             Mappings
" --------------------------------

" Mapleader: {{{
let mapleader = ','
nnoremap <Leader><Leader> <Leader>
" }}}

" Normal: {{{
" Disable Ex mode
nnoremap Q <Nop>
" Yank from cursor to end of line
nnoremap Y y$
" Write to file
nnoremap <silent> ZW :update<CR>
nnoremap <silent> <C-S> :update<CR>
" Buffer overview
nnoremap gb :buffers<CR>:b<Space>
" Mark overview
nnoremap gm :marks<CR>:norm<Space>`
" Register overview
nnoremap gr :registers<CR>:norm<Space>"
" Clear last used search pattern
nnoremap <silent> <Leader>/ :let @/ = ''<CR>
" Resize splits
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 4/3)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 3/4)<CR>
nnoremap <silent> <Leader>> :exe "vertical resize " . (winwidth(0) * 4/3)<CR>
nnoremap <silent> <Leader>< :exe "vertical resize " . (winwidth(0) * 3/4)<CR>
" Toggle Paste mode
nnoremap <Leader>P :set paste!<CR>
" Reload .vimrc
nnoremap <Leader>R :source $MYVIMRC<CR>
" }}}

" Visual and Select: {{{
" Sort Visual mode selection
vnoremap <Leader>o :sort<CR>
" }}}


" --------------------------------
"             Options
" --------------------------------

" Colours: {{{
colorscheme iceberg
set background=dark
syntax enable
" }}}

" Commands: {{{
" Delete all registers
command! DelRegisters for i in range(34, 122) | silent! call setreg(nr2char(i), []) | endfor
" }}}

" Completion: {{{
set belloff+=complete,ctrlg
set complete-=t
set completeopt-=preview
set completeopt+=menuone
set shortmess+=c " shut off completion messages
" }}}

" Cursor: {{{
set backspace=indent,eol,start
set cursorline
set whichwrap+=<,>,[,]
" Change cursor shape between NORMAL, INSERT, and REPLACE mode
if exists('$TMUX')
    let &t_EI = "\ePtmux;\e\e[2 q\e\\"
    let &t_SI = "\ePtmux;\e\e[5 q\e\\"
    let &t_SR = "\ePtmux;\e\e[3 q\e\\"
else
    let &t_EI = "\e[2 q" " block in NORMAL mode
    let &t_SI = "\e[5 q" " bar in INSERT mode (blink)
    let &t_SR = "\e[3 q" " underline in REPLACE mode (blink)
endif
" }}}

" Encoding: {{{
scriptencoding utf-8
" }}}

" Font: {{{
highlight Comment cterm=italic
" }}}

" Indentation: {{{
filetype indent on
set autoindent
set expandtab
set shiftround
set shiftwidth=4
set smarttab
set tabstop=4
" }}}

" Mouse: {{{
set mouse=a
set ttymouse=xterm2
" }}}

" Search: {{{
set hlsearch
set ignorecase
set incsearch
set smartcase
" }}}

" Terminal: {{{
if exists('##TerminalOpen')
  " Disable line numbers in terminal buffers
  autocmd TerminalOpen * set nonumber
endif
if exists(':terminal')
  " Open a new terminal window
  nnoremap <silent> <Leader>t :terminal<CR>
  " Enter Terminal-Normal mode
  tnoremap <Esc><Esc> <C-w>N
endif
" }}}

" User Interface: {{{
set display+=lastline
set fillchars+=vert:│
set laststatus=2
set noshowmode
set number
set showcmd
if has('patch-8.1.1564')
  set signcolumn=number
endif
set wildmenu
" }}}

" Various: {{{
set confirm
set directory=~/.vim/swap
set hidden
set shell+=\ -l
set ttimeoutlen=0
set updatetime=300
" }}}

" Window: {{{
set splitbelow
set splitright
" }}}


" --------------------------------
"             Runtimes
" --------------------------------

" before directory
runtime! before/**/*.vim
" 2nd user vimrc file
runtime vimrc

" vim: foldmethod=marker
