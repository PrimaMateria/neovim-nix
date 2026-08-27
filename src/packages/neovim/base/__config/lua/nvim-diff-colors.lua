-- base16-nvim derives its diff backgrounds by blending base0B/base08 85-90%
-- toward base00, which on gruvbox-dark-hard collapses DiffAdd (#343721) and
-- DiffDelete (#332422) into two dark olives that differ only in the green
-- channel. It also ends up with DiffTextAdd darker than DiffAdd, so the
-- char-level highlight is dimmer than the line it sits on.
--
-- These replace them with tints that read as red/green against #1d2021.
-- guifg is deliberately left unset: pinning a foreground flattens syntax
-- highlighting across the whole hunk.
local colors = {
	add = "#223a29", -- added line
	add_text = "#265030", -- added chars    (diffopt inline:char)
	delete = "#43262a", -- removed line
	delete_text = "#6d2b2f", -- removed chars
	neutral = "#2b2f3a", -- changed line, where there is no side to infer
	neutral_text = "#35435c",
	filler_fg = "#4a4340", -- the empty region opposite a hunk
	filler_bg = "#191b1c",
}

local group = vim.api.nvim_create_augroup("primamateria-diff-colors", { clear = true })

local function set_diff_highlights()
	local hl = vim.api.nvim_set_hl

	hl(0, "DiffAdd", { bg = colors.add })
	hl(0, "DiffDelete", { bg = colors.delete })
	hl(0, "DiffTextAdd", { bg = colors.add_text, bold = true })
	-- Plain :diffthis and fugitive give no way to tell which side a changed
	-- line belongs to, so these stay direction-neutral. Diffview gets the
	-- per-pane treatment below.
	hl(0, "DiffChange", { bg = colors.neutral })
	hl(0, "DiffText", { bg = colors.neutral_text, bold = true })

	hl(0, "DiffviewDiffAdd", { bg = colors.add })
	hl(0, "DiffviewDiffChange", { bg = colors.neutral })
	hl(0, "DiffviewDiffText", { bg = colors.neutral_text, bold = true })
	hl(0, "DiffviewDiffAddAsDelete", { bg = colors.delete })
	hl(0, "DiffviewDiffDelete", { fg = colors.filler_fg, bg = colors.filler_bg })
	hl(0, "DiffviewDiffDeleteDim", { fg = colors.filler_fg, bg = colors.filler_bg })

	-- Targets for the per-pane winhl below.
	hl(0, "PrimaDiffChangeDelete", { bg = colors.delete })
	hl(0, "PrimaDiffTextDelete", { bg = colors.delete_text, bold = true })
	hl(0, "PrimaDiffChangeAdd", { bg = colors.add })
	hl(0, "PrimaDiffTextAdd", { bg = colors.add_text, bold = true })
end

-- Diffview's enhanced_diff_hl splits DiffAdd/DiffDelete per pane, but both
-- panes still map DiffChange and DiffText to the same group. Nearly every line
-- of a branch diff is a modification rather than a pure add or delete, so
-- without this the whole view renders in the one neutral colour.
--
-- This has to go through winhl rather than a window highlight namespace:
-- winhl resolves its target groups against the global namespace, so per-window
-- namespace overrides of DiffviewDiffChange are never consulted.
local sides = {
	{ "DiffChange:PrimaDiffChangeDelete", "DiffText:PrimaDiffTextDelete", "DiffTextAdd:PrimaDiffTextDelete" },
	{ "DiffChange:PrimaDiffChangeAdd", "DiffText:PrimaDiffTextAdd", "DiffTextAdd:PrimaDiffTextAdd" },
}

local function set_side_winhl(win, entries)
	local kept = {}

	for entry in tostring(vim.wo[win].winhl):gmatch("[^,]+") do
		local from = entry:match("^([^:]+):")
		if from ~= "DiffChange" and from ~= "DiffText" and from ~= "DiffTextAdd" then
			kept[#kept + 1] = entry
		end
	end

	vim.list_extend(kept, entries)
	vim.wo[win].winhl = table.concat(kept, ",")
end

local function apply_side_winhl()
	local wins = {}

	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		if vim.wo[win].diff then
			wins[#wins + 1] = win
		end
	end

	-- Merge conflicts and diff3 layouts have no single removal side, so they
	-- keep the neutral colours.
	if #wins ~= 2 then
		return
	end

	table.sort(wins, function(a, b)
		local pa, pb = vim.api.nvim_win_get_position(a), vim.api.nvim_win_get_position(b)
		if pa[2] ~= pb[2] then
			return pa[2] < pb[2]
		end
		return pa[1] < pb[1]
	end)

	for i, win in ipairs(wins) do
		set_side_winhl(win, sides[i])
	end
end

set_diff_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
	group = group,
	pattern = "*",
	callback = set_diff_highlights,
})

vim.api.nvim_create_autocmd("User", {
	group = group,
	pattern = { "DiffviewDiffBufWinEnter", "DiffviewViewPostLayout", "DiffviewViewEnter" },
	callback = vim.schedule_wrap(apply_side_winhl),
})
