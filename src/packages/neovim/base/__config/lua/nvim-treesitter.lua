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
			-- indentation, provided by nvim-treesitter
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		else
			-- optional: clear indentexpr if previously set
			if vim.bo.indentexpr == "v:lua.require'nvim-treesitter'.indentexpr()" then
				vim.bo.indentexpr = ""
			end
		end
	end,
})

vim.keymap.set("n", "[p", function()
	local node = vim.treesitter.get_node()
	if not node then
		return
	end

	local parent = node:parent()
	if not parent then
		return
	end

	local row, col = parent:start()
	vim.api.nvim_win_set_cursor(0, { row + 1, col })
end, { silent = true, desc = "Jump to parent syntax node" })

vim.keymap.set("n", "]p", function()
	local node = vim.treesitter.get_node()
	if not node then
		return
	end

	local child = node:child(0)
	if not child then
		return
	end

	local row, col = child:start()
	vim.api.nvim_win_set_cursor(0, { row + 1, col })
end, { silent = true, desc = "Jump to first child syntax node" })

