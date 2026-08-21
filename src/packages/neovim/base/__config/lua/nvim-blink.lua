local blink = require("blink.cmp")

blink.setup({
	keymap = { preset = "default", ["<C-n>"] = { "show", "select_next" } },
	snippets = { preset = "luasnip" },
	sources = {
		default = { "lsp", "path", "snippets", "buffer", "emoji" },

		providers = {
			emoji = {
				module = "blink-emoji",
				name = "Emoji",
				score_offset = 15, -- Tune by preference
				opts = {
					insert = true, -- Insert emoji (default) or complete its name
					---@type string|table|fun():table
					trigger = function()
						return { ":" }
					end,
				},
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
