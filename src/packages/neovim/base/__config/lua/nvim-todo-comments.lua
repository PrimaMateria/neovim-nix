require("todo-comments").setup({
	signs = false,
	highlight = {
		before = "bg",
		keyword = "bg",
		after = "bg",
	},
})

vim.keymap.set("n", ",t", "<cmd>TodoTelescope<CR>", { silent = true, desc = "List TODOs" })
