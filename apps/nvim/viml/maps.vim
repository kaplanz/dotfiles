" File:        maps.vim
" Author:      Zakhary Kaplan <https://zakhary.dev>
" Created:     12 Sep 2020
" SPDX-License-Identifier: MIT

" --------------------------------
"               Maps
" --------------------------------

" Letter: {{{
" Write to file
nnoremap <silent> ZW <Cmd>update<CR>
nnoremap <silent> <C-s> <Cmd>update<CR>
" }}}

" Special: {{{
" Open file in vertical split
nnoremap <C-w><C-f> <C-w>vgf
" }}}

" Mapleader: {{{
" Change mapleader
let mapleader = ','
" Bypass mapleader action
nnoremap <Leader><Leader> <Leader>
" Sort Visual mode selection
vnoremap <Leader>o :sort<CR>
" Open a new terminal window
nnoremap <silent> <Leader>t <Cmd>split +terminal<CR>
" }}}

" vim:fdl=0:fdm=marker:
