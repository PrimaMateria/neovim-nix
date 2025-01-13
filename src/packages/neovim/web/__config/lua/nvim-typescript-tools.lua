require("typescript-tools").setup({})

vim.api.nvim_set_keymap("n", ",ai", "<cmd>TSToolsOrganizeImports<cr>", { noremap = true, desc = "Organize imports" })
vim.api.nvim_set_keymap(
	"n",
	",aI",
	"<cmd>TSToolsAddMissingImports<cr>",
	{ noremap = true, desc = "Add missing imports" }
)
