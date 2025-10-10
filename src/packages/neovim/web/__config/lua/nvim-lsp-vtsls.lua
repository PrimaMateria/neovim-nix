local baseConfig = require("vtsls").lspconfig
local customConfig = {
	typescript = {
		preferences = {
			autoImportSpecifierExcludeRegexes = { "@mui\\/system" },
		},
	},
}
local config = vim.tbl_deep_extend("force", baseConfig, customConfig)

vim.lsp.config("vtsls", config)
vim.lsp.enable("vtsls")

vim.api.nvim_set_keymap("n", ",ai", "<cmd>VtsExec add_missing_imports<cr>", { noremap = true, desc = "TS Add imports" })
vim.api.nvim_set_keymap(
	"n",
	",ao",
	"<cmd>VtsExec organize_imports<cr>",
	{ noremap = true, desc = "TS Organize imports" }
)
