-- File:        lspconfig.lua
-- Author:      Zakhary Kaplan <https://zakharykaplan.ca>
-- Created:     06 Aug 2021
-- SPDX-License-Identifier: MIT

require('lspconfig')
require('lspkind').init {}

-- UI customization
-- {{{
-- Highlights
vim.cmd [[autocmd ColorScheme * highlight link FloatBorder NormalFloat]]

-- Borders
local border = 'rounded'

-- LSP settings (for overriding per client)
local handlers = {
  ['textDocument/hover'] =  vim.lsp.with(
    vim.lsp.handlers.hover, {
      -- Use a sharp border with `FloatBorder` highlights
      border = border,
    }
  ),
  ['textDocument/signatureHelp'] =  vim.lsp.with(
    vim.lsp.handlers.signature_help, {
      -- Use a sharp border with `FloatBorder` highlights
      border = border,
    }
  ),
}

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

--- Customize how diagnostics are displayed
vim.diagnostic.config {
  virtual_text = {
    format = function(diagnostic)
      local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
      if diagnostic.lnum <= lnum and lnum <= diagnostic.end_lnum then
        return diagnostic.message
      end
    end,
  },
  severity_sort = true,
}

-- Show line diagnostics in virtual text
vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.show()]]
-- }}}

-- Add additional capabilities supported by nvim-cmp
-- {{{
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
-- }}}

-- Use an `on_attach` function to only map the following keys...
-- ... after the language server attaches to the current buffer
-- {{{
local on_attach = function(_, bufnr)
  -- TODO: Update to Nvim 0.7.0
  local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function set(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <C-x><C-o>
  set('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  map('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  map('n', '<Space>D', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  map('n', '<Space>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  map('n', '<Space>e', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)
  map('n', '<Space>q', '<Cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  map('n', '<Space>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
  map('n', '<Space>so', [[<Cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  map('n', '<Space>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  map('n', '<Space>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  map('n', '<Space>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  map('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  map('n', '[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  map('n', ']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  map('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  map('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  map('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.cmd [[command! -nargs=0 Format execute 'lua vim.lsp.buf.formatting()']]
end
-- }}}

-- Register a handler that will be called for all installed servers
-- Alternatively, you may also register handlers on specific server...
-- ... instances instead (see example below)
-- {{{
require('nvim-lsp-installer').on_server_ready(function(server)
  local opts = {}

  -- Configure capabilities, on_attach, flags
  opts.capabilities = capabilities
  opts.handlers = handlers
  opts.on_attach = on_attach
  opts.flags = {
    debounce_text_changes = 150,
  }

  -- (optional) Customize the options passed to the server
  -- if server.name == 'tsserver' then
  --     opts.root_dir = function() ... end
  -- end
  if server.name == 'clangd' then
    opts.cmd = {
      'clangd',
      '--background-index',
      '--header-insertion-decorators=false', -- don't prepend a dot or space before the completion label
    }
  elseif server.name == 'sumneko_lua' then
    opts.settings = {
      Lua = {
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = vim.api.nvim_get_runtime_file('', true),
        },
      },
    }
  end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)
-- }}}

-- vim:fdl=0:fdm=marker:
