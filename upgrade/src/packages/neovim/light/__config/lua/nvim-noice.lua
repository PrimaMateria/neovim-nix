require("noice").setup({
	lsp = {
		-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
		override = {
			["vim.lsp.util.convert_input_to_markdown_lines"] = true,
			["vim.lsp.util.stylize_markdown"] = true,
			["cmp.entry.get_documentation"] = true,
		},
	},
	-- you can enable a preset for easier configuration
	presets = {
		bottom_search = false, -- use a classic bottom cmdline for search
		command_palette = false, -- position the cmdline and popupmenu together
		long_message_to_split = true, -- long messages will be sent to a split
		inc_rename = false, -- enables an input dialog for inc-rename.nvim
		lsp_doc_border = false, -- add a border to hover docs and signature help
	},
	messages = {
		enabled = true, -- enables the Noice messages UI
		view = "mini", -- default view for messages
		view_error = "mini", -- view for errors
		view_warn = "mini", -- view for warnings
		view_history = "messages", -- view for :messages
		view_search = false, -- view for search count messages. Set to `false` to disable
	},
	views = {
		cmdline_popup = {
			position = {
				row = 30,
				col = "50%",
			},
			size = {
				width = 150,
				height = "auto",
			},
			border = {
				style = "single",
			},
		},
		popupmenu = {
			relative = "editor",
			position = {
				row = 33,
				col = "50%",
			},
			size = {
				width = 150,
				height = 10,
			},
			border = {
				style = "single",
				padding = { 0, 1 },
			},
			win_options = {
				winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
			},
		},
	},
})
