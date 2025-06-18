require("render-markdown").setup({
	enabled = false,
	file_types = { "markdown", "Avante" },
	code = {
		sign = "none",
	},
})

vim.keymap.set("n", ",m", "<cmd>lua require('render-markdown').toggle()<CR>", { silent = true })
