require("render-markdown").setup({
	opts = {
		file_types = { "markdown", "Avante" },
	},
	ft = { "markdown", "Avante" },
})

vim.keymap.set("n", ",m", "<cmd>lua require('render-markdown').toggle()<CR>", { silent = true })
