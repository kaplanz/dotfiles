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

" -- Cursor --
set backspace=indent,eol,start
set whichwrap+=<,>,[,]

" -- Folding --
set foldmethod=indent
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
nnoremap gb :ls<CR>:b<Space>
" Disable Ex mode
nnoremap Q <Nop>
" Write to file
nnoremap <Leader>s :w<CR>
" Clear last used search pattern
nnoremap <silent> <Leader>/ :let @/ = ''<CR>

" -- Plugins --
filetype plugin on
" fzf
nnoremap <C-p> :FZF<CR>
set runtimepath+=/usr/local/opt/fzf
" lightline.vim
let g:lightline = {
            \ 'colorscheme': 'jellybeans',
            \ }
" nerdtree
let NERDTreeShowHidden = 1
nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <Leader>N :NERDTree<CR>
" vim-mucomplete
let g:mucomplete#enable_auto_at_startup = 1
nnoremap <silent> <Leader>m :MUcompleteAutoToggle<CR>
set completeopt-=preview
set completeopt+=menuone,noselect
set shortmess+=c " shut off completion messages
set belloff+=complete,ctrlg

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
set confirm
set directory=~/.vim/swap
set hidden
set shell+=\ -l
set ttimeoutlen=0

" -- Window --
set splitbelow
set splitright
