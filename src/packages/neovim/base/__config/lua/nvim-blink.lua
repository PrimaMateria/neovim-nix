local blink = require("blink.cmp")

blink.setup({
	keymap = { preset = "default", ["<C-n>"] = { "show", "select_next" } },
	snippets = { preset = "luasnip" },
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
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
