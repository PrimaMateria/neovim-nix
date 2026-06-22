local wk = require("which-key")

require("rsvp").setup({
	initial_wpm = 250,
	surrounding_word_count = 1,
	auto_run = false,
})

vim.keymap.set("n", ",R", "<cmd>Rsvp<CR>", { silent = true })
vim.keymap.set("v", ",R", ":<C-u>'<,'>Rsvp<CR>", { silent = true })

wk.add({
	{ ",R", desc = "RSVP speed read" },
})
