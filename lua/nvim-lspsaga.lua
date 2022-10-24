local keymap = vim.keymap.set
local saga = require("lspsaga")

saga.init_lsp_saga()

keymap("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", { silent = true })
keymap("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", { silent = true })

keymap("n", ",ar", "<cmd>Lspsaga rename<CR>", { silent = true })
keymap({ "n", "v" }, ",aa", "<cmd>Lspsaga code_action<CR>", { silent = true })

keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })

keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })

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

keymap("n", "<A-g>", "<cmd>Lspsaga open_floaterm lazygit<CR>", { silent = true })
keymap("t", "<A-g>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], { silent = true })
