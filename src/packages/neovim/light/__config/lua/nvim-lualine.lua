require("lualine").setup({
	options = {
		theme = "gruvbox-material",
		globalstatus = true,
		disabled_filetypes = {
			winbar = { "NvimTree", "fugitive", "no-neck-pain" },
		},
	},
	sections = {
		lualine_a = { "mode" },
		lualine_b = { { "filename", path = 2 } },
		lualine_c = {},

		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	tabline = {
		lualine_a = { {
			"tabs",
			mode = 2,
			cond = function()
				return vim.fn.tabpagenr("$") > 1
			end,
		} },
	},
	winbar = {
		lualine_a = {},
		lualine_b = { { "filename", path = 0 } },
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	inactive_winbar = {
		lualine_b = { { "filename", path = 0 } },
		lualine_z = {},
	},
})
