require("neogen").setup({
	languages = {
		typescript = {
			template = {
				annotation_convention = "tsdoc",
			},
		},

		typescriptreact = {
			template = {
				annotation_convention = "tsdoc",
			},
		},
	},
})

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", ",dd", ":lua require('neogen').generate({ type = 'func' })<CR>", opts)
vim.api.nvim_set_keymap("n", ",dc", ":lua require('neogen').generate({ type = 'class' })<CR>", opts)
vim.api.nvim_set_keymap("n", ",df", ":lua require('neogen').generate({ type = 'file' })<CR>", opts)
vim.api.nvim_set_keymap("n", ",dt", ":lua require('neogen').generate({ type = 'type' })<CR>", opts)
