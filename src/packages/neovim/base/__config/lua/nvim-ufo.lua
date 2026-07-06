local wk = require("which-key")
local ufo = require("ufo")

-- All folds open on file open
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true
vim.o.foldcolumn = "1"
vim.api.nvim_set_hl(0, "FoldColumn", { fg = vim.g.base16_gui02 })

local function providerSelector(bufnr)
	local function fallback(err, provider)
		if type(err) == "string" and err:match("UfoFallbackException") then
			return ufo.getFolds(bufnr, provider)
		end
		return require("promise").reject(err)
	end
	return ufo.getFolds(bufnr, "lsp")
		:catch(function(err) return fallback(err, "treesitter") end)
		:catch(function(err) return fallback(err, "indent") end)
end

ufo.setup({
	provider_selector = function(bufnr, filetype, buftype)
		if buftype ~= "" or filetype == "" then
			return ""
		end
		return providerSelector
	end,
	-- virtual text showing folded line count
	fold_virt_text_handler = function(virtText, lnum, endLnum, width, truncate)
		local newVirtText = {}
		local suffix = ("  %d lines"):format(endLnum - lnum)
		local sufWidth = vim.fn.strdisplaywidth(suffix)
		local targetWidth = width - sufWidth
		local curWidth = 0
		for _, chunk in ipairs(virtText) do
			local chunkText = chunk[1]
			local chunkWidth = vim.fn.strdisplaywidth(chunkText)
			if targetWidth > curWidth + chunkWidth then
				table.insert(newVirtText, chunk)
			else
				chunkText = truncate(chunkText, targetWidth - curWidth)
				local hlGroup = chunk[2]
				table.insert(newVirtText, { chunkText, hlGroup })
				chunkWidth = vim.fn.strdisplaywidth(chunkText)
				if curWidth + chunkWidth < targetWidth then
					suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
				end
				break
			end
			curWidth = curWidth + chunkWidth
		end
		table.insert(newVirtText, { suffix, "MoreMsg" })
		return newVirtText
	end,
})

vim.keymap.set("n", "zR", ufo.openAllFolds, { silent = true })
vim.keymap.set("n", "zM", ufo.closeAllFolds, { silent = true })
vim.keymap.set("n", "zr", ufo.openFoldsExceptKinds, { silent = true })
vim.keymap.set("n", "zm", ufo.closeFoldsWith, { silent = true })
vim.keymap.set("n", "K", function()
	local winid = ufo.peekFoldedLinesUnderCursor()
	if not winid then
		vim.cmd("Lspsaga hover_doc")
	end
end, { silent = true })

wk.add({
	{ "zR", desc = "Open all folds" },
	{ "zM", desc = "Close all folds" },
	{ "zr", desc = "Open folds except kinds" },
	{ "zm", desc = "Close folds with level" },
})
