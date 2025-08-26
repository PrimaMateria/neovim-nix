require("oil").setup({
	buf_options = {
		buflisted = true,
		-- bufhidden = "",
	},
	cleanup_delay_ms = false,
	skip_confirm_for_simple_edits = true,
})

local wk = require("which-key")

vim.keymap.set("n", ",o", "<cmd>Oil<CR>", { silent = true })

wk.add({
	{ ",o", desc = "Oil" },
})
