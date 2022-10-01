require("lualine").setup({
	options = {
		theme = "gruvbox-material",
		globalstatus = true,
		disabled_filetypes = {
			winbar = { "fern", "fugitive" },
		},
	},
	sections = {
		lualine_c = {},
	},

	winbar = {
		lualine_c = { "filename" },
	},
	inactive_winbar = {
		lualine_c = { "filename" },
	},
})
