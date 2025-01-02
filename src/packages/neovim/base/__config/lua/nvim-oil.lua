require("oil").setup()
local wk = require("which-key")

vim.keymap.set("n", ",o", "<cmd>Oil<CR>", { silent = true })

wk.add({
	{ ",o", desc = "Oil" },
})
