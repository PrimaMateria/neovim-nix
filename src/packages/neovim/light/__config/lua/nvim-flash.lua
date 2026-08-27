local wk = require("which-key")
local flash = require("flash")

flash.setup({
	modes = {
		-- don't hijack f/F/t/T
		char = {
			enabled = false,
		},
		-- don't hijack / and ?
		search = {
			enabled = false,
		},
	},
})

vim.keymap.set({ "n", "x", "o" }, "<C-s>", function() flash.jump() end, { desc = "Flash jump" })

wk.add({
	{ "<C-s>", desc = "Flash jump" },
})
