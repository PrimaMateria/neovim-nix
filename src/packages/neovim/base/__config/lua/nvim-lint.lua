local lint = require("lint")

lint.linters_by_ft = {
	nix = { "nix" },
}

local augroup = vim.api.nvim_create_augroup("linting", {})
vim.api.nvim_clear_autocmds({ group = augroup })
vim.api.nvim_create_autocmd({ "BufEnter", "TextChanged" }, {
	group = augroup,
	callback = function()
		lint.try_lint()
	end,
})
