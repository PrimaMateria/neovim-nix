require("nvim-treesitter").setup({})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	callback = function()
		-- skip special buffers
		if vim.bo.buftype ~= "" or vim.bo.filetype == "" then
			return
		end

		-- try to start tree-sitter; not all filetypes have parsers (e.g. fugitiveblame)
		local ok = pcall(vim.treesitter.start, 0)
		if ok then
			-- folds, provided by Neovim tree-sitter
			vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
			vim.wo.foldmethod = "expr"
			-- start with folds open
			vim.wo.foldlevel = 99
			-- indentation, provided by nvim-treesitter
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		else
			-- fallback for buffers without a parser
			vim.wo.foldexpr = ""
			vim.wo.foldmethod = "manual"
			-- optional: clear indentexpr if previously set
			if vim.bo.indentexpr == "v:lua.require'nvim-treesitter'.indentexpr()" then
				vim.bo.indentexpr = ""
			end
		end
	end,
})

vim.api.nvim_set_option("foldenable", false)
