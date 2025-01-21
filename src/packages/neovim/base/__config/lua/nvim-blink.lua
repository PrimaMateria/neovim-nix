local blink = require("blink.cmp")
local luasnip = require("luasnip")

-- TODO: Luasnip is still not working
blink.setup({
	keymap = { preset = "default" },
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
		ghost_text = { enabled = true },
	},

	signature = { enabled = true, window = { border = "single" } },
})
