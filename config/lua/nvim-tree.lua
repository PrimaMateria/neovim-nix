vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
	view = {
		adaptive_size = true,
		hide_root_folder = true,
		number = true,
		relativenumber = true,
	},
	git = {
		ignore = false,
	},
})

local opt = { noremap = true }
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeFindFileToggle<CR>", opt)
