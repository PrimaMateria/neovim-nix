require("fzf-lua").setup({
	"telescope",
	winopts = {
		preview = {
			layout = "vertical",
		},
	},
})

vim.keymap.set("n", "gh", "<cmd>lua require('fzf-lua').lsp_references()<CR>", { silent = true })
