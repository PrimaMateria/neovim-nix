require("lspconfig.configs").vtsls = require("vtsls").lspconfig
require("lspconfig").vtsls.setup({
	typescript = {
		preferences = {
			autoImportSpecifierExcludeRegexes = { "@mui\\/system" },
		},
	},
})

vim.api.nvim_set_keymap("n", ",ai", "<cmd>VtsExec add_missing_imports<cr>", { noremap = true, desc = "TS Add imports" })

vim.api.nvim_set_keymap(
	"n",
	",ao",
	"<cmd>VtsExec organize_imports<cr>",
	{ noremap = true, desc = "TS Organize imports" }
)
