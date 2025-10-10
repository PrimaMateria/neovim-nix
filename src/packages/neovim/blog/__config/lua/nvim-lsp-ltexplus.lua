local blink = require("blink.cmp")

local capabilities = {}
capabilities = vim.tbl_extend("keep", capabilities, blink.get_lsp_capabilities())

vim.lsp.config("ltex_plus", {
	autostart = false,
	filetypes = { "markdown" },
	capabilities = capabilities,
	settings = {
		ltex = {
			language = "en-US",
		},
	},
})
vim.lsp.enable("ltext_plus")

vim.keymap.set(
	"n",
	",l",
	"<cmd>LspStart ltex_plus<cr>",
	{ noremap = true, silent = true, desc = "Start LTeX Plus LSP" }
)
vim.keymap.set("n", ",L", "<cmd>LspStop ltex_plus<cr>", { noremap = true, silent = true, desc = "Stop LTeX Plus LSP" })
