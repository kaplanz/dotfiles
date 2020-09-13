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

" Normal: {{{
" Buffer overview
nnoremap gb :buffers<CR>:b<Space>
" Mark overview
nnoremap gm :marks<CR>:norm<Space>`
" Register overview
nnoremap gr :registers<CR>:norm<Space>"
" Toggle Paste mode
nnoremap <Leader>P :set paste!<CR>
" Disable Ex mode
nnoremap Q <Nop>
" Reload .vimrc
nnoremap <Leader>R :source $MYVIMRC<CR>
" Open a new terminal window
if exists(':terminal')
  nnoremap <silent> <Leader>t :terminal<CR>
endif
" Yank from cursor to end of line
nnoremap Y y$
" Write to file
nnoremap <silent> ZW :update<CR>
nnoremap <silent> <C-s> :update<CR>
" Clear last used search pattern
nnoremap <silent> <Leader>/ :let @/ = ''<CR>
" Resize splits
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 4/3)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 3/4)<CR>
nnoremap <silent> <Leader>> :exe "vertical resize " . (winwidth(0) * 4/3)<CR>
nnoremap <silent> <Leader>< :exe "vertical resize " . (winwidth(0) * 3/4)<CR>
" }}}

" Terminal: {{{
if exists(':terminal')
  " Enter Terminal-Normal mode
  tnoremap <Esc><Esc> <C-w>N
endif
" }}}

" Visual and Select: {{{
" Sort Visual mode selection
vnoremap <Leader>o :sort<CR>
" }}}

" vim: foldmethod=marker
