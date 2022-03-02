-- File:        packer.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     05 Aug 2021
-- SPDX-License-Identifier: MIT

local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  execute 'packadd packer.nvim'
end
