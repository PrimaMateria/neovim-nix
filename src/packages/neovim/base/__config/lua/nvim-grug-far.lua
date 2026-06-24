local wk = require("which-key")

require("grug-far").setup({})

vim.keymap.set("n", ",as", "<cmd>GrugFar<CR>", { silent = true })
vim.keymap.set("v", ",as", function()
	require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
end, { silent = true })

wk.add({
	{ ",as", desc = "Search & replace" },
})
