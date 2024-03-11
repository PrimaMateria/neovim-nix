require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		javascript = { "eslint_d" },
		javascriptreact = { "eslint_d" },
		typescript = { "eslint_d" },
		typescriptreact = { "eslint_d" },
		nix = { "alejandra" },
		markdown = { "prettier" },
		rust = { "rustfmt" },
	},
	format_on_save = {
		timeout_ms = 5000,
		lsp_fallback = true,
	},
})
