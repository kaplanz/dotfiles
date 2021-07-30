" File:        plugins.vim
" Author:      Zakhary Kaplan <https://zakharykaplan.ca>
" Created:     24 Apr 2020
" SPDX-License-Identifier: MIT

" --------------------------------
"             Options
" --------------------------------

" Locals: {{{
let s:sidebar_width = 32
" }}}


" --------------------------------
"             Plugins
" --------------------------------

" Coc: {{{
" Global extension names to install when they aren't installed
let g:coc_global_extensions = ['coc-highlight', 'coc-json', 'coc-snippets'] +
  \ get(g:, 'coc_global_extensions', [])
" Use `[d` and `]d` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)
" GoTo code navigation
nmap <silent> <Leader>gd <Plug>(coc-definition)
nmap <silent> <Leader>gy <Plug>(coc-type-definition)
nmap <silent> <Leader>gi <Plug>(coc-implementation)
nmap <silent> <Leader>gr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'h ' . expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming
nmap <Leader>rn <Plug>(coc-rename)
" Import organizing
nnoremap <silent> <Plug>(coc-organize-import) :<C-u>call CocActionAsync('organizeImport')<CR>
nmap <Leader>oi <Plug>(coc-organize-import)
" Formatting selected code
nmap <Leader>f <Plug>(coc-format-selected)
xmap <Leader>f <Plug>(coc-format-selected)
nmap <Leader>F <Plug>(coc-format)
" Applying codeAction to the selected region
" Example: `<Leader>aap` for current paragraph
xmap <Leader>a <Plug>(coc-codeaction-selected)
nmap <Leader>a <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer
nmap <Leader>ac <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line
nmap <Leader>qf <Plug>(coc-fix-current)
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server
omap if <Plug>(coc-funcobj-i)
xmap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
xmap af <Plug>(coc-funcobj-a)
omap ic <Plug>(coc-classobj-i)
xmap ic <Plug>(coc-classobj-i)
omap ac <Plug>(coc-classobj-a)
xmap ac <Plug>(coc-classobj-a)
" Add `:Format` command to format current buffer
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)
" Add `:OrganizeImports` command for organize imports of the current buffer
command! -nargs=0 OrganizeImports :call CocAction('runCommand', 'editor.action.organizeImport')
" Mappings for CocList
" Show all lists
nnoremap <silent><nowait> <Space>l :<C-u>CocList<CR>
" Show all diagnostics
nnoremap <silent><nowait> <Space>a :<C-u>CocList diagnostics<CR>
" Manage extensions
nnoremap <silent><nowait> <Space>e :<C-u>CocList extensions<CR>
" Show commands
nnoremap <silent><nowait> <Space>c :<C-u>CocList commands<CR>
" Find symbol of current document
nnoremap <silent><nowait> <Space>o :<C-u>CocList outline<CR>
" Search workspace symbols
nnoremap <silent><nowait> <Space>s :<C-u>CocList -I symbols<CR>
" Do default action for next item
nnoremap <silent><nowait> <Space>j :<C-u>CocNext<CR>
" Do default action for previous item
nnoremap <silent><nowait> <Space>k :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent><nowait> <Space>p :<C-u>CocListResume<CR>
" }}}

" FZF: {{{
nnoremap <C-p> :FZF<CR>
nnoremap <leader>h :Helptags<CR>
" }}}

" GitGutter: {{{
" Disable default mappings
let g:gitgutter_map_keys = 0
" Hunk operations
nmap ghp <Plug>(GitGutterPreviewHunk)
nmap ghs <Plug>(GitGutterStageHunk)
nmap ghu <Plug>(GitGutterUndoHunk)
" Hunk jumping
nmap ]c <Plug>(GitGutterNextHunk)
nmap [c <Plug>(GitGutterPrevHunk)
" Hunk text objects
omap ic <Plug>(GitGutterTextObjectInnerPending)
omap ac <Plug>(GitGutterTextObjectOuterPending)
xmap ic <Plug>(GitGutterTextObjectInnerVisual)
xmap ac <Plug>(GitGutterTextObjectOuterVisual)
" Use floating/popup windows for hunk previews
let g:gitgutter_preview_win_floating = 1
" }}}

" Goyo: {{{
let g:goyo_width = '70%'
nnoremap <Leader>y :Goyo<CR>
" Custom routine upon GoyoEnter
function! s:goyo_enter()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status off
    silent !tmux list-panes -F '\#F' | grep -q Z || tmux resize-pane -Z
  endif
  set noshowcmd
  Limelight
  " ...
endfunction
" Custom routine upon GoyoLeave
function! s:goyo_leave()
  if executable('tmux') && strlen($TMUX)
    silent !tmux set status on
    silent !tmux list-panes -F '\#F' | grep -q Z && tmux resize-pane -Z
  endif
  set showcmd
  Limelight!
  " ...
endfunction
" Set autocmds to trigger custom routines
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
" }}}

" Gutentags: {{{
let g:gutentags_enabled = filereadable('tags')
let g:gutentags_define_advanced_commands = 1
" }}}

" Lightline: {{{
let g:lightline = {
      \ 'colorscheme': g:colors_name,
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
        \ fname =~# '^__Tagbar__\|__Mundo\|NERD_tree' ? '' :
        \ &ft ==# 'vimfiler' ? vimfiler#get_status_string() :
        \ &ft ==# 'unite' ? unite#get_status_string() :
        \ &ft ==# 'vimshell' ? vimshell#get_status_string() :
        \ (fname !=# '' ? fname : '[No Name]')
endfunction
function! LightlineFugitive()
  try
    if expand('%:t') !~? 'Tagbar\|Mundo\|NERD' && &ft !~? 'vimfiler' && exists('*FugitiveHead')
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
        \ fname ==# '__Mundo__' ? 'Mundo' :
        \ fname ==# '__Mundo_Preview__' ? 'Mundo Preview' :
        \ fname =~# 'NERD_tree' ? 'NERDTree' :
        \ &ft ==# 'unite' ? 'Unite' :
        \ &ft ==# 'vimfiler' ? 'VimFiler' :
        \ &ft ==# 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction
" }}}

" Limelight: {{{
nnoremap <Leader>l :Limelight!!<CR>
" }}}

" Mundo: {{{
let g:mundo_width = s:sidebar_width
nnoremap <silent> <Leader>m :MundoToggle<CR>
" }}}

" NERDTree: {{{
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter *
  \ if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()
  \ |   quit
  \ | endif
let g:NERDTreeIgnore = ['.git']
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize = s:sidebar_width
nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <Leader>N :NERDTree<CR>
" }}}

" Tagbar: {{{
let g:tagbar_sort = 0
let g:tagbar_width = s:sidebar_width
nnoremap <silent> <Leader>b :TagbarToggle<CR>
nnoremap <silent> <Leader>B :TagbarOpenAutoClose<CR>
" }}}

" VisualMulti: {{{
let g:VM_leader = '\'
" }}}

" vim:fdl=0:fdm=marker:
