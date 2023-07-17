require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
})

-- vim.api.nvim_set_option("foldmethod", "expr")
-- vim.api.nvim_set_option("foldexpr", "nvim_treesitter#foldexpr()")
vim.api.nvim_set_option("foldenable", false)
