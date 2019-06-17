"
"  .vimrc
"  My vim configuration.
"
"  Created by Zakhary Kaplan on 2019-06-05.
"  Copyright © 2019 Zakhary Kaplan. All rights reserved.
"

" --------------------------------
"           Preferences
" --------------------------------

" -- Colours --
colorscheme jellybeans
syntax enable

" -- Indentation --
filetype indent on
set autoindent
set expandtab
set shiftround
set shiftwidth=4
set smarttab
set tabstop=4

" -- Plugins --
" lightline.vim
let g:lightline = {
            \ 'colorscheme': 'jellybeans',
            \ }

" -- Search --
set hlsearch
set ignorecase
set incsearch
set smartcase

" -- User Interface --
set display+=lastline
set laststatus=2
set mouse=a
set noshowmode
set number
set wildmenu

" -- Various --
set backspace=indent,eol,start
set confirm
set directory=~/.vim/swap
set hidden
