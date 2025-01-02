require("colorizer").setup()
local wk = require("which-key")

local opt = { noremap = true }
vim.api.nvim_set_keymap("n", ",c", ":ColorizerToggle<CR>", opt)

wk.add({
	{ ",c", desc = "Colorizer toggle" },
})
