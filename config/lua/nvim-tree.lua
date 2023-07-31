vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	renderer = {
		root_folder_label = false,
	},
	view = {
		adaptive_size = true,
		number = true,
		relativenumber = true,
	},
	git = {
		ignore = false,
	},
})

local opt = { noremap = true }
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeFindFileToggle<CR>", opt)
