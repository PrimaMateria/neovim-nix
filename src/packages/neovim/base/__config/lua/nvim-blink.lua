local blink = require("blink.cmp")
local luasnip = require("luasnip")

-- TODO: Luasnip is still not working
blink.setup({
	keymap = { preset = "default" },

	snippets = {
		expand = function(snippet)
			luasnip.lsp_expand(snippet)
		end,

		active = function(filter)
			if filter and filter.direction then
				return luasnip.jumpable(filter.direction)
			end
			return luasnip.in_snippet()
		end,

		jump = function(direction)
			luasnip.jump(direction)
		end,
	},

	sources = {
		default = { "lsp", "path", "luasnip", "buffer" },
	},

	completion = {
		documentation = {
			auto_show = true,
			auto_show_delay_ms = 500,
		},
		ghost_text = { enabled = true },
	},

	signature = { enabled = true },
})
