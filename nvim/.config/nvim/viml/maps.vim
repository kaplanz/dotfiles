" File:        maps.vim
" Author:      Zakhary Kaplan <https://zakharykaplan.ca>
" Created:     12 Sep 2020
" SPDX-License-Identifier: MIT

" --------------------------------
"               Maps
" --------------------------------

" Letter: {{{
" Yank from cursor to end of line
nnoremap Y y$
" Write to file
nnoremap <silent> ZW :update<CR>
nnoremap <silent> <C-s> :update<CR>
" Buffer overview
nnoremap gb :buffers<CR>:b<Space>
" Mark overview
nnoremap gm :marks<CR>:norm<Space>`
" Register overview
nnoremap gr :registers<CR>:norm<Space>"
" Undolist overview
nnoremap gu :undolist<CR>:u<Space>
" }}}

" Special: {{{
" Open file in vertical split
nnoremap <C-w><C-f> <C-w>vgf
" Redraw the screen and removes any search highlighting
nnoremap <silent> <C-l> :nohlsearch<CR><C-l>
" }}}

" Mapleader: {{{
" Change mapleader
let mapleader = ','
" Bypass mapleader action
nnoremap <Leader><Leader> <Leader>
" Toggle Paste mode
nnoremap <Leader>P :set paste!<CR>
" Reload .vimrc
nnoremap <Leader>R :source $MYVIMRC<CR>
" Sort Visual mode selection
vnoremap <Leader>o :sort<CR>
" Open a new terminal window
nnoremap <silent> <Leader>t :split +terminal<CR>
" }}}

" vim:fdl=0:fdm=marker:
