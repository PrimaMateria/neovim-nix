require("no-neck-pain").setup({
	-- your custom config goes here
})

vim.api.nvim_create_augroup("OnVimEnter", { clear = true })
vim.api.nvim_create_autocmd({ "VimEnter" }, {
	group = "OnVimEnter",
	pattern = "*",
	callback = function()
		vim.schedule(function()
			require("no-neck-pain").enable()
		end)
	end,
})
