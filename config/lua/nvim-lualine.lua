require("lualine").setup({
	options = {
		theme = "gruvbox-material",
		globalstatus = true,
		disabled_filetypes = {
			winbar = { "NvimTree", "fugitive", "no-neck-pain" },
		},
	},
	sections = {
		lualine_c = { "require'lsp-status'.status()" },
	},

	winbar = {
		lualine_c = { "filename" },
	},
	inactive_winbar = {
		lualine_c = { "filename" },
	},
	tabline = {
		lualine_a = { {
			"tabs",
			mode = 2,
		} },
	},
})
