vim.keymap.set("n", ",h", "<cmd>DiffviewFileHistory %<CR>", { silent = true, desc = "Diffview file history" })

vim.api.nvim_create_autocmd("FileType", {
	pattern = "Diffview*",
	callback = function(ev)
		-- close the whole Diffview tab
		vim.keymap.set("n", "gx", "<cmd>tabclose<cr>", {
			buffer = ev.buf,
			silent = true,
			desc = "Close Diffview tab",
		})
	end,
})
