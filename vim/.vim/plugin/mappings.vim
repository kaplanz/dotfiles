"
"  mappings.vim
"  Vim mappings.
"
"  Created by Zakhary Kaplan on 2020-09-12.
"  Copyright © 2020 Zakhary Kaplan. All rights reserved.
"

" --------------------------------
"             Mappings
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
" }}}

" Mapleader: {{{
" Generate helptags
nnoremap <Leader>H :helptags ALL<CR>
" Toggle Paste mode
nnoremap <Leader>P :set paste!<CR>
" Reload .vimrc
nnoremap <Leader>R :source $MYVIMRC<CR>
" Sort Visual mode selection
vnoremap <Leader>o :sort<CR>
" Start a shell
nnoremap <silent> <Leader>s :shell<CR>
" Open a new terminal window
nnoremap <silent> <Leader>t :terminal<CR>
" Clear last used search pattern
nnoremap <silent> <Leader>/ :let @/ = ''<CR>
" Resize splits
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 4/3)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 3/4)<CR>
nnoremap <silent> <Leader>> :exe "vertical resize " . (winwidth(0) * 4/3)<CR>
nnoremap <silent> <Leader>< :exe "vertical resize " . (winwidth(0) * 3/4)<CR>
" }}}

" vim:fdl=0:fdm=marker:
