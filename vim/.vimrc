"
"  .vimrc
"  Vim configuration.
"
"  Created by Zakhary Kaplan on 2019-06-05.
"  Copyright © 2019 Zakhary Kaplan. All rights reserved.
"

" --------------------------------
"             Options
" --------------------------------

" Before: {{{
" Enable file type detection
filetype on
" Switch on syntax highlighting
syntax enable
" }}}

" Colours: {{{
packadd! palenight.vim
colorscheme palenight
set background=dark
set termguicolors
" }}}

" Commands: {{{
" Delete all registers
command! DelRegisters
  \ for i in range(34, 122)
  \ |   silent! call setreg(nr2char(i), [])
  \ | endfor
" }}}

" Completion: {{{
set belloff+=complete,ctrlg
set complete-=t
set completeopt+=menuone
set completeopt-=preview
set shortmess+=c " shut off completion messages
" }}}

" Cursor: {{{
" Change cursor shape between NORMAL, INSERT, and REPLACE mode
let &t_EI = "\e[2 q" " block in NORMAL mode
let &t_SI = "\e[5 q" " bar in INSERT mode (blink)
let &t_SR = "\e[3 q" " underline in REPLACE mode (blink)
set backspace=indent,eol,start
set cursorline
set whichwrap+=<,>,[,]
" }}}

" Encoding: {{{
set encoding=utf-8
" }}}

" Formatting: {{{
set formatoptions+=j
" }}}

" Highlight: {{{
" highlight ExtraWhitespace ctermbg=38 guibg=#89ddff
" highlight ExtraWhitespace ctermbg=59 guibg=#697098
" highlight ExtraWhitespace ctermbg=115 guibg=#c3e88d
" highlight ExtraWhitespace ctermbg=170 guibg=#c792ea
highlight ExtraWhitespace ctermbg=204 guibg=#ff5370
" match ExtraWhitespace /\s\+$/               " highlight all trailing whitespace
" match ExtraWhitespace /\v(.*%#)@!\s+$/      " don't highlight before including the cursor
match ExtraWhitespace /\v((.*%#)@!|%#)\s+$/ " don't highlight before the cursor
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

" Mapleader: {{{
let mapleader = ','
nnoremap <Leader><Leader> <Leader>
" }}}

" Mouse: {{{
set mouse=a
set ttymouse=xterm2
" }}}

" Path: {{{
set path+=**
" }}}

" Runtimepath: {{{
set runtimepath+=/usr/local/opt/fzf,~/.fzf
" }}}

" Search: {{{
set hlsearch
set ignorecase
set incsearch
set smartcase
" }}}

" User Interface: {{{
set display+=lastline
set fillchars=vert:│,fold:-
set laststatus=2
set noshowmode
set number
set scrolloff=5
set showcmd
set sidescrolloff=5
if has('patch-8.1.1564')
  set signcolumn=number
endif
set tabpagemax=50
set wildmenu
" }}}

" Various: {{{
set confirm
set directory=~/.vim/swap
set hidden
set history=1000
set shell+=\ -l
set ttimeoutlen=0
set undofile
set undodir=~/.vim/undo
set updatetime=300
" }}}

" Window: {{{
set splitbelow
set splitright
" }}}


" --------------------------------
"             Packadds
" --------------------------------

packadd! matchit


" --------------------------------
"             Runtimes
" --------------------------------

" 2nd user vimrc file
runtime vimrc

" vim:fdl=0:fdm=marker:
