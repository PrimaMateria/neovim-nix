local keymap = vim.keymap.set
require("lspsaga").setup({
	lightbulb = {
		virtual_text = false,
	},
	symbol_in_winbar = {
		enable = false,
	},
})

keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

keymap("n", ",ar", "<cmd>Lspsaga rename<CR>", { silent = true })
keymap({ "n", "v" }, ",aa", "<cmd>Lspsaga code_action<CR>", { silent = true })

keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

keymap("n", "gh", "<cmd>Lspsaga finder<CR>", { silent = true })

keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", { silent = true })

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = false,
})
-- keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", { silent = true })
keymap("n", ",e", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
keymap(
	"n",
	",E",
	"<cmd>lua vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })<CR>",
	{ silent = true }
)
keymap({ "n", "t" }, "<C-t>", "<cmd>Lspsaga term_toggle<CR>", { silent = true })
