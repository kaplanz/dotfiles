-- File:        autocmds.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     12 Sep 2020
-- SPDX-License-Identifier: MIT

---------------
-- Autocmds  --
---------------

-- Hexmode {{{
-- `vim -b`: edit binary using xxd-format!
vim.cmd [[
  augroup Hexmode
    autocmd!
    autocmd BufReadPost  * if &binary
    autocmd BufReadPost  *   %!xxd
    autocmd BufReadPost  *   set ft=xxd
    autocmd BufReadPost  * endif
    autocmd BufWritePre  * if &binary
    autocmd BufWritePre  *   %!xxd -r
    autocmd BufWritePre  * endif
    autocmd BufWritePost * if &binary
    autocmd BufWritePost *   %!xxd
    autocmd BufWritePost *   set nomod
    autocmd BufWritePost * endif
  augroup end
]]
-- }}}

-- Vimrc {{{
vim.cmd [[
  augroup Vimrc
    autocmd!

    " Override formatoptions upon entering a new buffer
    autocmd BufNewFile,BufWinEnter * setlocal formatoptions-=o

    " Tier foldlevel depending on how many lines are in the buffer
    autocmd BufNewFile,BufRead *
      \ if line("$") < 100
      \ |   setlocal foldlevel=99
      \ | else
      \ |   setlocal foldlevel=0
      \ | endif

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid, when inside an event handler
    " (happens when dropping a file on gvim) and for a commit message (it's
    " likely a different one than last time).
    autocmd BufReadPost *
      \ if line("'\"") >= 1
      \ && line("'\"") <= line("$")
      \ && &ft !~# "commit"
      \ && &ft !~# "gitrebase"
      \ |   exe "normal! g`\""
      \ | endif

    " Replace tabs with spaces on write
    autocmd BufWritePre * retab

    " When a terminal job is starting, configure the terminal buffer.
    autocmd TermOpen * set nonumber " Disable line numbers in terminal buffers
    autocmd TermOpen * startinsert  " Enter Terminal-mode automatically

    " Highlight text on yank
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()

  augroup end
]]
-- }}}

-- vim:fdl=0:fdm=marker:
