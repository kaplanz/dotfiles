" File:        tree.vim
" Author:      Zakhary Kaplan <https://zakharykaplan.ca>
" Created:     08 Aug 2021
" SPDX-License-Identifier: MIT

let g:nvim_tree_add_trailing = 1
let g:nvim_tree_auto_close = 1
let g:nvim_tree_disable_netrw = 0
let g:nvim_tree_follow = 1
let g:nvim_tree_gitignore = 1
let g:nvim_tree_group_empty = 1
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_hijack_cursor = 1
let g:nvim_tree_hijack_netrw = 0
let g:nvim_tree_icons = {
    \ 'default':        '',
    \ 'symlink':        '',
    \ }
let g:nvim_tree_ignore = ['.git', 'node_modules']
let g:nvim_tree_symlink_arrow = ' -> '

nnoremap <Leader>n <Cmd>NvimTreeToggle<CR>
nnoremap <Leader>N <Cmd>NvimTreeRefresh<CR>
