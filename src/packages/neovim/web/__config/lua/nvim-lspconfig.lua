local nvim_lsp = require("lspconfig")
local cmp_nvim_lsp = require("cmp_nvim_lsp")

local capabilities = {}
capabilities = vim.tbl_extend("keep", capabilities, cmp_nvim_lsp.default_capabilities())

nvim_lsp["ts_ls"].setup({ capabilities = capabilities })
