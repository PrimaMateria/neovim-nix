local wk = require("which-key")

vim.keymap.set("n", ",gF", function()
	require("lazygit").lazygit(vim.fn.expand("~/dev/frontend-specs"))
end, { silent = true })

wk.add({
	{ ",gF", desc = "Lazygit frontend-specs" },
})
