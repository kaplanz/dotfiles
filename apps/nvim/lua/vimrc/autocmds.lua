-- File:        autocmds.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     12 Sep 2020
-- SPDX-License-Identifier: MIT

-- Set up autocmds
local function augroup(name, setup)
  local group = vim.api.nvim_create_augroup(name, {})
  setup(function(event, pattern, callback)
    vim.api.nvim_create_autocmd(event, {
      group = group,
      pattern = pattern,
      callback = callback,
    })
  end)
end


---------------
-- Autocmds  --
---------------

-- Hexmode {{{
-- `vim -b`: edit binary using xxd-format!
augroup("Hexmode", function(autocmd)
  autocmd("BufReadPost", nil, function()
    vim.cmd [[if &binary | %!xxd | set ft=xxd | endif]]
  end)
  autocmd("BufWritePre", nil, function()
    vim.cmd [[if &binary | %!xxd -r | set ft=xxd | endif]]
  end)
  autocmd("BufWritePre", nil, function()
    vim.cmd [[if &binary | %!xxd | set nomod | endif]]
  end)
end)
-- }}}

-- Vimrc {{{
augroup("Vimrc", function(autocmd)
  -- Override formatoptions upon entering a new buffer
  autocmd({ "BufNewFile", "BufWinEnter" }, nil, function()
    vim.opt_local.formatoptions:remove("o")
  end)

  --  Tier foldlevel depending on how many lines are in the buffer
  autocmd({ "BufNewFile", "BufRead" }, nil, function()
    if vim.fn.line("$") < 100 then
      vim.wo.foldlevel = 99
    else
      vim.wo.foldlevel = 0
    end
  end)

  -- When editing a file, always jump to the last known cursor position. Don't
  -- do it when the position is invalid, when inside an event handler (happens
  -- when dropping a file on gvim) and for a commit message (it's likely a
  -- different one than last time).
  autocmd("BufReadPost", nil, function()
    vim.cmd [[
      if line("'\"") >= 1
      \ && line("'\"") <= line("$")
      \ && &ft !~# "commit"
      \ && &ft !~# "gitrebase"
      \ |   exe "normal! g`\""
      \ | endif
    ]]
  end)

  -- Replace tabs with spaces on write
  autocmd("BufWritePre", nil, function()
    vim.cmd [[retab]]
  end)

  -- When a terminal job is starting, configure the terminal buffer
  autocmd("TermOpen", nil, function()
    -- Disable line numbers in terminal buffers
    vim.bo.number = true
    -- Enter Terminal-mode automatically
    vim.cmd [[startinsert]]
  end)

  -- Highlight text on yank
  autocmd("TextYankPost", nil, function()
    vim.highlight.on_yank()
  end)
end)
-- }}}

-- vim:fdl=0:fdm=marker:
