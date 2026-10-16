local wk = require("which-key")
local terminals = require("primamateria.terminals")

require("diffview").setup({
	-- Without this both panes share the same winhl, so removed lines render
	-- with DiffviewDiffAdd - the same colour as additions on the right.
	enhanced_diff_hl = true,
	hooks = {

		-- Open claude in the footer window so I can directly discuss the review
		view_opened = function(view)
			local dummy_buf = vim.api.nvim_create_buf(false, true)
			local footer_win = vim.api.nvim_open_win(dummy_buf, true, { split = "below", win = -1, height = 15 })
			local claude_buf = terminals.claude_buf()

			vim.api.nvim_win_set_buf(footer_win, claude_buf)
			vim.wo[footer_win][0].winfixheight = true
		end,
	},
})

wk.add({
	{ ",d", group = "Diffview" },
})

vim.keymap.set("n", ",do", "<cmd>DiffviewOpen<CR>", { silent = true, desc = "Diffview open" })
vim.keymap.set("n", ",dh", "<cmd>DiffviewFileHistory %<CR>", { silent = true, desc = "Diffview file history" })
vim.keymap.set("n", ",dl", "<cmd>DiffviewOpen HEAD^1..HEAD<CR>", { silent = true, desc = "Diffview last commit" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "Diffview*",
	callback = function(ev)
		-- close the whole Diffview tab
		vim.keymap.set("n", "gq", "<cmd>tabclose<cr>", {
			buffer = ev.buf,
			silent = true,
			desc = "Close Diffview tab",
		})
	end,
})
