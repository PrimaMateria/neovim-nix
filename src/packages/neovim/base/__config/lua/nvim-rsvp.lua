local wk = require("which-key")

require("rsvp").setup({
	initial_wpm = 300,
	surrounding_word_count = 0,
	auto_run = false,

	-- beta
	complexity_scaling = { enabled = true },
	breather = { enabled = true },
	paragraph_pause_ms = 800,
	autostop = "paragraph",
})

vim.keymap.set("n", ",R", "<cmd>Rsvp<CR>", { silent = true })
vim.keymap.set("v", ",R", ":<C-u>'<,'>Rsvp<CR>", { silent = true })

wk.add({
	{ ",R", desc = "RSVP speed read" },
})
