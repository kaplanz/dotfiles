-- File:        lspconfig.lua
-- Author:      Zakhary Kaplan <https://zakhary.dev>
-- Created:     06 Aug 2021
-- SPDX-License-Identifier: MIT

local lspconfig = require("lspconfig")
local mason     = require("mason-lspconfig")

-- Prepare capabilities, handlers, and on_attach
local capabilities, handlers, on_attach
do
  -- Style of (optional) window border. This can either be a string or
  -- an array.
  -- The string values are:
  -- • "none": No border (default).
  -- • "single": A single line box.
  -- • "double": A double line box.
  -- • "rounded": Like "single", but with rounded corners ("╭" etc.).
  -- • "solid": Adds padding by a single whitespace cell.
  -- • "shadow": A drop shadow effect by blending with the background.
  local border = "rounded"

  -- LSP settings (for overriding per client)
  handlers = {
    ["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover, {
      -- Style of (optional) window border.
      border = border,
    }),
    ["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help, {
      -- Style of (optional) window border.
      border = border,
    }),
  }

  -- Customize how diagnostics are displayed
  vim.diagnostic.config {
    -- Use virtual text for diagnostics.
    virtual_text = {
      -- Format a diagnostic as text used to display it.
      format = function(diagnostic)
        local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
        if diagnostic.lnum <= lnum and lnum <= diagnostic.end_lnum then
          return diagnostic.message
        end
      end,
    },
    -- Options for floating windows.
    float = {
      -- Style of (optional) window border.
      border = border,
      -- Enable focus by user actions.
      focusable = false,
      -- Configure the appearance of the window.
      style = "minimal",
      -- Include the diagnostic source in the message.
      source = "if_many",
    },
    -- Sort diagnostics by severity.
    severity_sort = true,
  }

  -- Change diagnostic symbols in the sign column (gutter)
  local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
  for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end

  -- Show line diagnostics in virtual text
  vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.show()]]

  -- Add additional capabilities supported by nvim-cmp
  capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  -- Use an `on_attach` function to only map the following keys...
  -- ... after the language server attaches to the current buffer
  on_attach = function(client, bufnr)
    -- Highlight symbol under cursor
    -- TODO: update to Neovim v0.8
    -- if client.server_capabilities.documentHighlightProvider then
    if client.resolved_capabilities.document_highlight then
      vim.cmd [[
        hi! LspReferenceRead cterm=bold
        hi! LspReferenceText cterm=bold
        hi! LspReferenceWrite cterm=bold
      ]]
      vim.api.nvim_create_augroup("lsp_document_highlight", {
        clear = false,
      })
      vim.api.nvim_clear_autocmds({
        buffer = bufnr,
        group = "lsp_document_highlight",
      })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        group = "lsp_document_highlight",
        buffer = bufnr,
        callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd("CursorMoved", {
        group = "lsp_document_highlight",
        buffer = bufnr,
        callback = vim.lsp.buf.clear_references,
      })
    end

    -- Enable completion triggered by <C-x><C-o>
    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Set up keymaps
    local function map(mode, lhs, rhs, opts)
      opts = opts or { noremap = true, silent = true }
      opts.buffer = bufnr
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    map("n", "<C-k>", vim.lsp.buf.signature_help)
    map("n", "<Space>D", vim.lsp.buf.type_definition)
    map("n", "<Space>ca", vim.lsp.buf.code_action)
    map("n", "<Space>e", vim.diagnostic.open_float)
    map("n", "<Space>q", vim.diagnostic.setloclist)
    map("n", "<Space>rn", vim.lsp.buf.rename)
    map("n", "<Space>so", function() require("telescope.builtin").lsp_document_symbols() end)
    map("n", "<Space>wa", vim.lsp.buf.add_workspace_folder)
    map("n", "<Space>wl", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end)
    map("n", "<Space>wr", vim.lsp.buf.remove_workspace_folder)
    map("n", "K", vim.lsp.buf.hover)
    map("n", "[d", vim.diagnostic.goto_prev)
    map("n", "]d", vim.diagnostic.goto_next)
    map("n", "gD", vim.lsp.buf.declaration)
    map("n", "gd", vim.lsp.buf.definition)
    map("n", "gi", vim.lsp.buf.implementation)
    map("n", "gr", vim.lsp.buf.references)

    -- Set some key bindings conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
      map("n", "<Space>f", vim.lsp.buf.formatting)
    end
    if client.resolved_capabilities.document_range_formatting then
      map("x", "<Space>f", vim.lsp.buf.range_formatting)
    end
  end
end

-- Override the default configuration to be applied to all servers
lspconfig.util.default_config = vim.tbl_extend(
  "force",
  lspconfig.util.default_config,
  {
    capabilities = capabilities,
    handlers = handlers,
    on_attach = on_attach,
  }
)


-- Registers the provided `handlers`, to be called by mason when an installed
-- server supported by lspconfig is ready to be setup.
mason.setup_handlers {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server) -- default handler (optional)
    lspconfig[server].setup {}
  end,
  -- Next, you can provide targeted overrides for specific servers.
  ["sumneko_lua"] = function()
    lspconfig.sumneko_lua.setup {
      settings = {
        Lua = {
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
          },
        },
      }
    }
  end,
}
