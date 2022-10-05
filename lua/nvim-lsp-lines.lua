require("lsp_lines").setup()

vim.diagnostic.config({
	virtual_text = false,
	virtual_lines = false,
})

local bufopts = { noremap = true, silent = true }
vim.keymap.set("n", ",e", require("lsp_lines").toggle, bufopts)
