" File:        mappings.vim
" Author:      Zakhary Kaplan <https://zakharykaplan.ca>
" Created:     22 Jul 2021
" Version:     0.1.0
" SPDX-License-Identifier: MIT

" --------------------------------
"             Mappings
" --------------------------------

" Special: {{{
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : parry#Return()
" }}}

" vim:fdl=0:fdm=marker:
