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
set cursorline
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
" Mark overview
nnoremap gm :marks<CR>:norm<Space>`
" Disable Ex mode
nnoremap Q <Nop>
" Write to file
nnoremap <Leader>s :w<CR>
" Clear last used search pattern
nnoremap <silent> <Leader>/ :let @/ = ''<CR>

" -- Plugins --
filetype plugin on
" ale
let g:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']
nnoremap <Leader>f :ALEFix<CR>
" comfortable-motion.vim
let g:comfortable_motion_no_default_key_mappings = 1
nnoremap <silent> <C-d> :call comfortable_motion#flick(winheight(0) * 2)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(winheight(0) * -2)<CR>
nnoremap <silent> <C-f> :call comfortable_motion#flick(winheight(0) * 4)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(winheight(0) * -4)<CR>
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
set complete-=t
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
