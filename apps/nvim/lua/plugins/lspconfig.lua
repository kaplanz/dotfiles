-- File:        lspconfig.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
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
local on_attach = function(client, _)
  -- Enable completion triggered by <C-x><C-o>
  vim.bo.omnifunc = 'v:lua.vim.lsp.omnifunc'

  -- Set up keymaps
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.keymap.set('n', '<Space>D', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.keymap.set('n', '<Space>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.keymap.set('n', '<Space>e', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.keymap.set('n', '<Space>q', '<Cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  vim.keymap.set('n', '<Space>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.keymap.set('n', '<Space>so', [[<Cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.keymap.set('n', '<Space>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.keymap.set('n', '<Space>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.keymap.set('n', '<Space>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.keymap.set('n', '[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.keymap.set('n', ']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.keymap.set('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.keymap.set('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.keymap.set('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)

  -- Set some key bindings conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    vim.keymap.set('n', '<Space>f', '<Cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end
  if client.resolved_capabilities.document_range_formatting then
    vim.keymap.set('x', '<Space>f', '<Cmd>lua vim.lsp.buf.range_formatting()<CR>', opts)
  end
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
