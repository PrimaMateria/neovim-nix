local wk = require("which-key")

require("diffview").setup({
	-- Without this both panes share the same winhl, so removed lines render
	-- with DiffviewDiffAdd - the same colour as additions on the right.
	enhanced_diff_hl = true,
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
