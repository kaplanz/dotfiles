"
"  .vimrc
"  Vim configuration.
"
"  Created by Zakhary Kaplan on 2019-06-05.
"  Copyright © 2019 Zakhary Kaplan. All rights reserved.
"

" --------------------------------
"           Preferences
" --------------------------------

" -- Autocmds --
" Remove trailing whitespace
autocmd BufWritePre * %s/\s\+$//e
" Replace tabs with spaces
autocmd BufWritePre * retab
" Override formatoptions
autocmd BufNewFile,BufWinEnter * setlocal formatoptions-=cro

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
" Toggle Paste mode
nnoremap <Leader>p :set paste!<CR>
" Reload .vimrc
nnoremap <silent> <Leader>r :source $MYVIMRC<CR>
" Write to file
nnoremap <Leader>s :w<CR>
" Clear last used search pattern
nnoremap <silent> <Leader>/ :let @/ = ''<CR>

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
"             Sources
" --------------------------------

" 2nd user vimrc file
try
  source ~/.vim/vimrc
catch
  " file not found
endtry
