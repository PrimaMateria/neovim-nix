vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	renderer = {
		root_folder_label = false,
		symlink_destination = false,
	},
	view = {
		number = true,
		relativenumber = true,
		width = {
			max = -1,
		},
	},
	git = {
		ignore = false,
	},
})

local opt = { noremap = true }
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeFindFileToggle<CR>", opt)
