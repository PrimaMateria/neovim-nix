vim.lsp.config("pyright", {
	cmd = { "pyright-langserver", "--stdio" },
	filetypes = { "python" },
	root_dir = vim.fs.dirname,
})
vim.lsp.enable("pyright")
