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

" -- Locals --
let s:sidebar_width = 31

" -- Options --
filetype plugin on

" -- Preferences --
" ale
let g:ale_fixers = ['remove_trailing_lines', 'trim_whitespace']
nnoremap <Leader>f :ALEFix<CR>
nnoremap <Leader>a :ALEToggleBuffer<CR>

" comfortable-motion.vim
let g:comfortable_motion_no_default_key_mappings = 1
nnoremap <silent> <C-d> :call comfortable_motion#flick(winheight(0) * 2)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(winheight(0) * -2)<CR>
nnoremap <silent> <C-f> :call comfortable_motion#flick(winheight(0) * 4)<CR>
nnoremap <silent> <C-b> :call comfortable_motion#flick(winheight(0) * -4)<CR>

" fzf
nnoremap <C-p> :FZF<CR>
nnoremap <Leader>p :Rg<CR>
set runtimepath+=/usr/local/opt/fzf,~/.fzf

" lightline.vim
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [['mode', 'paste'], ['fugitive', 'readonly', 'filename', 'modified']],
      \ },
      \ 'component_function': {
      \   'fugitive': 'LightlineFugitive',
      \   'filename': 'LightlineFilename',
      \   'fileformat': 'LightlineFileformat',
      \   'filetype': 'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode': 'LightlineMode',
      \ },
      \ }
function! LightlineModified()
  return &ft ==# 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
function! LightlineReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction
function! LightlineFilename()
  let fname = expand('%:t')
  return fname ==# 'ControlP' && has_key(g:lightline, 'ctrlp_item') ? g:lightline.ctrlp_item :
        \ fname =~# '^__Tagbar__\|__Gundo\|NERD_tree' ? '' :
        \ &ft ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft ==# 'unite' ? unite#get_status_string() :
        \ &ft ==# 'vimshell' ? vimshell#get_status_string() :
        \ (fname !=# '' ? fname : '[No Name]')
endfunction
function! LightlineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*FugitiveHead')
      let mark = ''  " edit here for cool mark
      let branch = FugitiveHead()
      return branch !=# '' ? mark.branch : ''
    endif
  catch
  endtry
  return ''
endfunction
function! LightlineFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction
function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction
function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction
function! LightlineMode()
  let fname = expand('%:t')
  return fname =~# '^__Tagbar__' ? 'Tagbar' :
        \ fname ==# 'ControlP' ? 'CtrlP' :
        \ fname ==# '__Gundo__' ? 'Gundo' :
        \ fname ==# '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~# 'NERD_tree' ? 'NERDTree' :
        \ &ft ==# 'unite' ? 'Unite' :
        \ &ft ==# 'vimfiler' ? 'VimFiler' :
        \ &ft ==# 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" nerdtree
autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize = s:sidebar_width
nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <Leader>N :NERDTree<CR>

" sideways
nnoremap <C-h> :SidewaysLeft<CR>
nnoremap <C-l> :SidewaysRight<CR>

" tagbar
let g:tagbar_autofocus = 1
let g:tagbar_width = s:sidebar_width
nnoremap <silent> <Leader>b :TagbarToggle<CR>
nnoremap <silent> <Leader>B :TagbarOpenAutoClose<CR>
