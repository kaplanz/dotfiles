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
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <C-x><C-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', '<C-k>', '<Cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<Space>D', '<Cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<Space>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', '<Space>e', '<Cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', '<Space>f', '<Cmd>Format<CR>', opts)
  buf_set_keymap('n', '<Space>q', '<Cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  buf_set_keymap('n', '<Space>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<Space>so', [[<Cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  buf_set_keymap('n', '<Space>wa', '<Cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<Space>wl', '<Cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<Space>wr', '<Cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', '[d', '<Cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<Cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<Cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', opts)
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
      "clangd",
      "--background-index",
      "--header-insertion-decorators=false", -- don't prepend a dot or space before the completion label
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
