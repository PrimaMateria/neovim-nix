local wk = require("which-key")

-- Overrides the global `TermOpen` autocmd that turns number/relativenumber
-- on for every terminal buffer; must be defined after it to win.
vim.api.nvim_create_autocmd("TermOpen", {
	callback = function()
		if vim.bo.filetype == "lazygit" then
			vim.opt_local.number = false
			vim.opt_local.relativenumber = false
		end
	end,
})

vim.keymap.set("n", ",gF", function()
	require("lazygit").lazygit(vim.fn.expand("~/dev/frontend-specs"))
end, { silent = true })

wk.add({
	{ ",gF", desc = "Lazygit frontend-specs" },
})
