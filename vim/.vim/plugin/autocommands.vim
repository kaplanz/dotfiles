" File:        autocommands.vim
" Author:      Zakhary Kaplan <https://zakharykaplan.ca>
" Created:     12 Sep 2020
" SPDX-License-Identifier: MIT

" --------------------------------
"           Autocommands
" --------------------------------

" Vimrc: {{{
augroup vimrc
  autocmd!

  " Override formatoptions upon entering a new buffer
  autocmd BufNewFile,BufWinEnter * setlocal formatoptions-=cro

  " For very long files, set foldmethod to indent to avoid long folding times
  autocmd BufNewFile,BufRead *
    \ if line('$') < 1000
    \ |   setlocal foldmethod=syntax
    \ | else
    \ |   setlocal foldmethod=indent
    \ | endif
  " Tier foldlevel depending on how many lines are in the buffer
  autocmd BufNewFile,BufRead *
    \ if line('$') < 100
    \ |   setlocal foldlevel=99
    \ | else
    \ |   setlocal foldlevel=0
    \ | endif

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid, when inside an event handler
  " (happens when dropping a file on gvim) and for a commit message (it's
  " likely a different one than last time).
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \                                                 && &ft !~# 'gitrebase'
    \ |   exe "normal! g`\""
    \ | endif

  " Replace tabs with spaces on write
  autocmd BufWritePre * retab

  " Don't screw up folds when inserting text that might affect them, until
  " leaving insert mode. Foldmethod is local to the window. Protect against
  " screwing up folding when switching between windows.
  autocmd InsertEnter *
    \ if !exists('w:foldmethod')
    \ |   let w:foldmethod=&foldmethod
    \ |   setlocal foldmethod=manual
    \ | endif
  autocmd InsertLeave,WinLeave *
    \ if exists('w:foldmethod')
    \ |   let &l:foldmethod=w:foldmethod
    \ |   unlet w:foldmethod
    \ | endif

  " Disable line numbers in terminal buffers
  if exists('##TerminalWinOpen')
    autocmd TerminalWinOpen * set nonumber
  endif

augroup END
" }}}

" vim:fdl=0:fdm=marker:
