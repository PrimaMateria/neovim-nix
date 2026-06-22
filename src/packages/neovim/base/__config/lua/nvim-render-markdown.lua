local wk = require("which-key")
local markview = require("markview")

markview.setup({
	preview = {
		enable = false,
		modes = { "n", "no", "c" },
		hybrid_modes = {},
	},
})

vim.keymap.set("n", ",m", "<cmd>Markview toggle<CR>", { silent = true })

wk.add({
	{ ",m", desc = "Toggle markdown" },
})
