local wk = require("which-key")
local gs = require("gitsigns")

gs.setup({
	signs = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "" },
		topdelete = { text = "" },
		changedelete = { text = "▎" },
		untracked = { text = "▎" },
	},
	current_line_blame = false,
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol",
		delay = 500,
	},
})

vim.keymap.set("n", "]h", function() gs.next_hunk() end, { silent = true })
vim.keymap.set("n", "[h", function() gs.prev_hunk() end, { silent = true })

vim.keymap.set("n", ",gs", function() gs.stage_hunk() end, { silent = true })
vim.keymap.set("v", ",gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { silent = true })
vim.keymap.set("n", ",gu", function() gs.undo_stage_hunk() end, { silent = true })
vim.keymap.set("n", ",gr", function() gs.reset_hunk() end, { silent = true })
vim.keymap.set("v", ",gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { silent = true })
vim.keymap.set("n", ",gS", function() gs.stage_buffer() end, { silent = true })
vim.keymap.set("n", ",gR", function() gs.reset_buffer() end, { silent = true })
vim.keymap.set("n", ",gp", function() gs.preview_hunk() end, { silent = true })
vim.keymap.set("n", ",gb", function() gs.blame_line({ full = true }) end, { silent = true })
vim.keymap.set("n", ",gB", function() gs.toggle_current_line_blame() end, { silent = true })
vim.keymap.set("n", ",gd", function() gs.diffthis() end, { silent = true })

wk.add({
	{ ",g", group = "Git" },
	{ "]h", desc = "Next hunk" },
	{ "[h", desc = "Prev hunk" },
	{ ",gs", desc = "Stage hunk" },
	{ ",gu", desc = "Undo stage hunk" },
	{ ",gr", desc = "Reset hunk" },
	{ ",gS", desc = "Stage buffer" },
	{ ",gR", desc = "Reset buffer" },
	{ ",gp", desc = "Preview hunk" },
	{ ",gb", desc = "Blame line" },
	{ ",gB", desc = "Toggle blame" },
	{ ",gd", desc = "Diff this" },
})
