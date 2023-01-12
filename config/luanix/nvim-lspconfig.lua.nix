# vim: ft=lua
{ pkgs }:
''
local capabilities = {}

local nvim_lsp = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")
capabilities = vim.tbl_extend('keep', capabilities, cmp_nvim_lsp.default_capabilities())

local lsp_status = require('lsp-status')
lsp_status.register_progress()
lsp_status.config {
  status_symbol = "",
  indicator_separator = "",
  component_separator = "",
  show_filename = false,
  diagnostics = false,
  current_function = false,
}
capabilities = vim.tbl_extend('keep', capabilities, lsp_status.capabilities)

local function lsp_highlight_document(client, bufnr)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_create_augroup("lsp_document_highlight", { clear = true })
    vim.api.nvim_clear_autocmds({ buffer = bufnr, group = "lsp_document_highlight" })
    vim.api.nvim_create_autocmd("CursorHold", {
      callback = vim.lsp.buf.document_highlight,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Document Highlight",
    })
    vim.api.nvim_create_autocmd("CursorMoved", {
      callback = vim.lsp.buf.clear_references,
      buffer = bufnr,
      group = "lsp_document_highlight",
      desc = "Clear All the References",
    })
  end
end

-- {
--  name = "jdtls",
--  setup = {
--    cmd = { "jdt-language-server" },
--  },
-- },

local servers = {
  -- { name = "pyright" },
  -- { name = "grammarly", setup = { cmd = { "grammarly-languageserver", "--stdio" } } },
  {
    name = "ltex",
    setup = {
      autostart = false,
      filetypes = { "markdown", "gitcommit", "plaintext" },
    },
  },
  {
    name = "tsserver",
    setup = {
      init_options = {
        maxTsServerMemory = 8192,
        disableAutomaticTypingAcquisition = true,
        tsserver = {
          path = "${pkgs.nodePackages.typescript}/lib/node_modules/typescript/lib",
        },
        -- preferences = {
        -- },
      },
    },
    on_attach = function(client, bufnr)
      client.server_capabilities.documentFormattingProvider = false
      client.server_capabilities.semanticTokensProvider = false
      -- vim.keymap.set("n", ",i", ":TSLspImportAll<CR>", bufopts)
      -- vim.keymap.set("n", ",o", ":TSLspOrganize<CR>", bufopts)
    end,
  },
}

for _, server in pairs(servers) do
  local setup = {
    debug=true,
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 3000, --150
    },
    on_attach = function(client, bufnr)
      --vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

      local bufopts = { noremap = true, silent = true, buffer = bufnr }
      -- vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
      -- vim.keymap.set("n", ",ar", vim.lsp.buf.rename, bufopts)
      -- vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
      -- vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)

      lsp_highlight_document(client, bufnr)
      lsp_status.on_attach(client)

      if server.on_attach then
        server.on_attach(client, bufnr)
      end
    end,
  }

  if server.setup then
    for k, v in pairs(server.setup) do
      setup[k] = v
    end
  end

  nvim_lsp[server.name].setup(setup)
end
''
