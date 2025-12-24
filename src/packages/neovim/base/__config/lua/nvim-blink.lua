local blink = require("blink.cmp")

blink.setup({
	keymap = { preset = "default", ["<C-n>"] = { "show", "select_next" } },
	snippets = { preset = "luasnip" },
	sources = {
		default = { "lsp", "path", "snippets", "copilot", "buffer" },

		providers = {
			copilot = {
				name = "copilot",
				module = "blink-copilot",
				score_offset = 100,
				async = true,
			},
		},
	},

	completion = {
		menu = { border = "single" },
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500,
			window = { border = "single" },
		},
		ghost_text = { enabled = false },
		accept = { auto_brackets = { enabled = false } },
	},

	signature = { enabled = true, window = { border = "single" } },
})
