local wk = require("which-key")

require("lspsaga").setup({
	lightbulb = {
		enable = false,
		virtual_text = false,
	},
	symbol_in_winbar = {
		enable = false,
	},
	finder = {
		layout = "float",
		max_height = 0.8,
		left_width = 0.4,
		right_width = 0.4,
	},
})

-- Fix lspsaga not showing diagnostics
vim.diagnostic.config({
	severity_sort = true,
	virtual_text = false,
	virtual_lines = false,
})

vim.keymap.set({ "n", "t" }, "<C-t>", "<cmd>Lspsaga term_toggle<CR>", { silent = true })
vim.keymap.set("n", ",ep", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
vim.keymap.set("n", ",en", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })
vim.keymap.set("n", ",ar", "<cmd>Lspsaga rename<CR>", { silent = true })
vim.keymap.set({ "n", "v" }, ",aa", "<cmd>Lspsaga code_action<CR>", { silent = true })
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
vim.keymap.set("n", ",ee", "<cmd>Lspsaga show_cursor_diagnostics<CR>", { silent = true })
vim.keymap.set(
	"n",
	",eE",
	"<cmd>lua vim.diagnostic.config({ virtual_text = not vim.diagnostic.config().virtual_text })<CR>",
	{ silent = true }
)

wk.add({
	{ ",ee", desc = "Under cursor" },
	{ ",eE", desc = "Toggle inline" },
	{ ",ep", desc = "Go to previous" },
	{ ",en", desc = "Go to next" },
	{ ",ar", desc = "Rename" },
	{ ",aa", desc = "Actions" },
})
