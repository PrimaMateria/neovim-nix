require("illuminate").configure({
	filetypes_denylist = {
		"NvimTree",
		"fugitive",
	},
	under_cursor = false,
})

vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	pattern = { "*" },
	command = "highlight IlluminatedWordText guibg=#555555 gui=NONE",
})
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	pattern = { "*" },
	command = "highlight IlluminatedWordRead guibg=#555555 gui=NONE",
})
vim.api.nvim_create_autocmd({ "ColorScheme" }, {
	pattern = { "*" },
	command = "highlight IlluminatedWordWrite guibg=#555555 gui=NONE",
})
