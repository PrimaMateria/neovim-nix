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

-- <C-n> was rebound to the floating note (see nvim-notes.lua).
local opt = { noremap = true }
vim.api.nvim_set_keymap("n", "<leader>n", ":NvimTreeFindFileToggle<CR>", opt)
