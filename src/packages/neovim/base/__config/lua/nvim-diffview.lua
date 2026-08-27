require("diffview").setup({
	-- Without this both panes share the same winhl, so removed lines render
	-- with DiffviewDiffAdd - the same colour as additions on the right.
	enhanced_diff_hl = true,
})

vim.keymap.set("n", ",h", "<cmd>DiffviewFileHistory %<CR>", { silent = true, desc = "Diffview file history" })

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
