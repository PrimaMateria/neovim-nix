require("lsp-lens").setup({
	enable = true,
	include_declaration = false, -- Reference include declaration
	sections = { -- Enable / Disable specific request, formatter example looks 'Format Requests'
		definition = false,
		references = true,
		implements = false,
		git_authors = false,
	},
})
