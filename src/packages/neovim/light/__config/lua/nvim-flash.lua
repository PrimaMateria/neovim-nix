local wk = require("which-key")
local flash = require("flash")

flash.setup({
	modes = {
		char = {
			keys = { "f", "F", "t", "T" },
		},
	},
})

vim.keymap.set({ "n", "x", "o" }, "s", function() flash.jump() end, { desc = "Flash jump" })
vim.keymap.set({ "n", "x", "o" }, "S", function() flash.treesitter() end, { desc = "Flash treesitter" })
vim.keymap.set("o", "r", function() flash.remote() end, { desc = "Flash remote" })
vim.keymap.set({ "o", "x" }, "R", function() flash.treesitter_search() end, { desc = "Flash treesitter search" })

wk.add({
	{ "s", desc = "Flash jump" },
	{ "S", desc = "Flash treesitter" },
})
