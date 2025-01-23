local nvim_lsp = require("lspconfig")
local blink = require("blink.cmp")

local capabilities = {}
capabilities = vim.tbl_extend("keep", capabilities, blink.get_lsp_capabilities())

nvim_lsp["ccls"].setup({
	capabilities = capabilities,
	init_options = {
		compilationDatabaseDirectory = "build",
		index = {
			threads = 0,
		},
		clang = {
			excludeArgs = { "-frounding-math" },
		},
	},
})
