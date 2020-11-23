"
"  plugins.vim
"  Vim plugins configuration.
"
"  Created by Zakhary Kaplan on 2020-04-24.
"  Copyright © 2020 Zakhary Kaplan. All rights reserved.
"

" --------------------------------
"             Options
" --------------------------------

" Locals: {{{
let s:sidebar_width = 31
" }}}

" Options: {{{
filetype plugin on
" }}}

" --------------------------------
"             Plugins
" --------------------------------

" Coc: {{{
" Global extension names to install when they aren't installed.
let g:coc_global_extensions = ['coc-git', 'coc-snippets'] + get(g:, 'coc_global_extensions', [])
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation
nmap <silent> <Leader>gd <Plug>(coc-definition)
nmap <silent> <Leader>gy <Plug>(coc-type-definition)
nmap <silent> <Leader>gi <Plug>(coc-implementation)
nmap <silent> <Leader>gr <Plug>(coc-references)
" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim', 'help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming
nmap <Leader>rn <Plug>(coc-rename)
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
" Apply QuickFix to problem on the current line
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

" EasyMotion: {{{
" Change leader key
map s <Plug>(easymotion-prefix)
" }}}

" FZF: {{{
" Define fzf-leader key
nmap \ <Plug>(fzf-leader)
" Leader mappings
nmap <Plug>(fzf-leader)f :Files<CR>
nmap <Plug>(fzf-leader)F :GFiles<CR>
nmap <Plug>(fzf-leader)c :Colors<CR>
nmap <Plug>(fzf-leader)l :Lines<CR>
nmap <Plug>(fzf-leader)L :BLines<CR>
nmap <Plug>(fzf-leader)w :Windows<CR>
nmap <Plug>(fzf-leader)y :History<CR>
nmap <Plug>(fzf-leader); :History:<CR>
nmap <Plug>(fzf-leader)/ :History/<CR>
nmap <Plug>(fzf-leader)g :Commits<CR>
nmap <Plug>(fzf-leader)G :BCommits<CR>
nmap <Plug>(fzf-leader): :Commands<CR>
nmap <Plug>(fzf-leader)m :Maps<CR>
nmap <Plug>(fzf-leader)h :Helptags<CR>
nmap <Plug>(fzf-leader)t :Filetypes<CR>
" Other mappings
nnoremap <C-p> :FZF<CR>
nnoremap gM :Marks<CR>
nnoremap gB :Buffers<CR>
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
" }}}

" NERDTree: {{{
autocmd bufenter * if (winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()) | q | endif
let g:NERDTreeShowHidden = 1
let g:NERDTreeWinSize = s:sidebar_width
nnoremap <silent> <Leader>n :NERDTreeToggle<CR>
nnoremap <silent> <Leader>N :NERDTree<CR>
" }}}

" Tagbar: {{{
let g:tagbar_sort = 0
let g:tagbar_width = s:sidebar_width
nnoremap <silent> <Leader>m :TagbarToggle<CR>
nnoremap <silent> <Leader>M :TagbarOpenAutoClose<CR>
" }}}

" VisualMulti: {{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" vim-visual-multi configuration

let g:VM_default_mappings           = 1
let g:VM_mouse_mappings             = 1
let g:VM_reselect_first             = 0
let g:VM_case_setting               = "smart"
let g:VM_disable_syntax_in_imode    = 0
let g:VM_exit_on_1_cursor_left      = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:VM_mouse_mappings    = 1
let g:VM_theme             = 'default'
let g:VM_maps = {}
let g:VM_maps["Undo"]      = 'u'
let g:VM_maps["Redo"]      = '<C-r>'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" }}}

" vim:fdl=0:fdm=marker:
