require("todo-comments").setup({
	signs = true,
	highlight = {
		before = "",
		keyword = "wide_bg",
		after = "",
	},
	keywords = {
		MTODO = { icon = " ", color = "info" },
	},
})

vim.keymap.set("n", ",t", "<cmd>TodoQuickFix keywords=MTODO<CR>", { silent = true, desc = "List TODOs" })

-- TODO: test
