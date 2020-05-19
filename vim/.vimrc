"
"  .vimrc
"  Vim configuration.
"
"  Created by Zakhary Kaplan on 2019-06-05.
"  Copyright © 2019 Zakhary Kaplan. All rights reserved.
"
" Specify UTF-8 character encoding
scriptencoding utf-8

" --------------------------------
"           Preferences
" --------------------------------

" -- Autocommands --
augroup vimrc
  autocmd!
  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid, when inside an event handler
  " (happens when dropping a file on gvim) and for a commit message (it's
  " likely a different one than last time).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif
  " Override formatoptions upon entering a new buffer
  autocmd BufNewFile,BufWinEnter * setlocal formatoptions-=cro
  " Trim trailing whitespace on write
  autocmd BufWritePre * %s/\s\+$//e
  " Replace tabs with spaces on write
  autocmd BufWritePre * retab
augroup END

" -- Colours --
colorscheme jellybeans
syntax enable

" -- Completion --
set belloff+=complete,ctrlg
set complete-=t
set completeopt-=preview
set completeopt+=menuone
set shortmess+=c " shut off completion messages

" -- Cursor --
set backspace=indent,eol,start
set cursorline
set whichwrap+=<,>,[,]

" -- Folding --
set foldmethod=syntax
set nofoldenable

" -- Indentation --
filetype indent on
set autoindent
set expandtab
set shiftround
set shiftwidth=4
set smarttab
set tabstop=4

" -- Mappings --
" Set mapleader
let mapleader = ','
" Buffer overview
nnoremap gb :buffers<CR>:b<Space>
" Mark overview
nnoremap gm :marks<CR>:norm<Space>`
" Register overview
nnoremap gr :registers<CR>:norm<Space>"
" Disable Ex mode
nnoremap Q <Nop>
" Resize splits
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 4/3)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 3/4)<CR>
nnoremap <silent> <Leader>> :exe "vertical resize " . (winwidth(0) * 4/3)<CR>
nnoremap <silent> <Leader>< :exe "vertical resize " . (winwidth(0) * 3/4)<CR>
" Toggle Paste mode
nnoremap <Leader>p :set paste!<CR>
" Reload .vimrc
nnoremap <silent> <Leader>r :source $MYVIMRC<CR>
" Write to file
nnoremap <Leader>s :w<CR>
" Clear last used search pattern
nnoremap <silent> <Leader>/ :let @/ = ''<CR>
" Scroll forward/backrwards through buffers
nnoremap <Leader>[ :bprevious<CR>
nnoremap <Leader>] :bnext<CR>

" -- Search --
set hlsearch
set ignorecase
set incsearch
set smartcase

" -- Terminal --
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

" -- User Interface --
set display+=lastline
set fillchars+=vert:│
set laststatus=2
set noshowmode
set number
set wildmenu

" -- Various --
set confirm
set directory=~/.vim/swap
set hidden
set mouse=a
set shell+=\ -l
set ttimeoutlen=0

" -- Window --
set splitbelow
set splitright


" --------------------------------
"             Runtimes
" --------------------------------

" config directory
runtime before/*
" 2nd user vimrc file
runtime vimrc
