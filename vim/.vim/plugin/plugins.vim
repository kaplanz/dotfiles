"
"  plugins.vim
"  Vim plugins configuration.
"
"  Created by Zakhary Kaplan on 2020-04-24.
"  Copyright © 2020 Zakhary Kaplan. All rights reserved.
"

" --------------------------------
"             Plugins
" --------------------------------

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

" deoplete.nvim
if has('python3')
  let g:deoplete#enable_at_startup = 1
endif
nnoremap <Leader>d :call deoplete#toggle()<CR>

" fzf
nnoremap <C-p> :FZF<CR>
set runtimepath+=/usr/local/opt/fzf,~/.fzf

" lightline.vim
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }

" nerdtree
autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeShowHidden = 1
nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <Leader>N :NERDTree<CR>

" tagbar
let g:tagbar_autofocus = 1
nnoremap <silent> <Leader>b :TagbarToggle<CR>
nnoremap <silent> <Leader>B :TagbarOpenAutoClose<CR>
