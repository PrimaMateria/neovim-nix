local nvim_lsp = require("lspconfig")
local blink = require("blink.cmp")

local capabilities = {}
capabilities = vim.tbl_extend("keep", capabilities, blink.get_lsp_capabilities())

nvim_lsp["ts_ls"].setup({ capabilities = capabilities })
