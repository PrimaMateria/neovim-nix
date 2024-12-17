require("illuminate").configure({
	filetypes_denylist = {
		"NvimTree",
		"fugitive",
	},
	under_cursor = false,
})

vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { reverse = true })
vim.api.nvim_set_hl(0, "IlluminatedWordRead", { reverse = true })
vim.api.nvim_set_hl(0, "IlluminatedWordText", { reverse = true })
