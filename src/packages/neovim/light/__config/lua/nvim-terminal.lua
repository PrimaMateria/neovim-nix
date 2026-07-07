local wk = require("which-key")

-- Persistent terminal buffers per slot, reused across invocations.
-- Swaps the current window's buffer to the slot's terminal instead of
-- opening a new split, mirroring the old harpoon.term.gotoTerminal().
local bufs = {}

local function get_buf(id, cmd, name)
	local buf = bufs[id]
	if buf and vim.api.nvim_buf_is_valid(buf) then
		return buf
	end
	local current = vim.api.nvim_get_current_buf()
	vim.cmd(cmd and ("terminal " .. cmd) or "terminal")
	buf = vim.api.nvim_get_current_buf()
	vim.bo[buf].buflisted = false
	vim.bo[buf].bufhidden = "hide"
	if name then
		vim.api.nvim_buf_set_name(buf, name)
	end
	vim.api.nvim_set_current_buf(current)
	bufs[id] = buf
	return buf
end

local function goto_terminal(id, cmd, name)
	vim.api.nvim_set_current_buf(get_buf(id, cmd, name))
end

-- 5 general-purpose terminals, named with greek letters so the winbar
-- (filename component) tells them apart at a glance
local slots = {
	{ key = "t", id = 1, symbol = "α" },
	{ key = "q", id = 2, symbol = "β" },
	{ key = "w", id = 3, symbol = "γ" },
	{ key = "e", id = 4, symbol = "δ" },
	{ key = "r", id = 5, symbol = "ε" },
}
for _, slot in ipairs(slots) do
	vim.keymap.set("n", "<leader>t" .. slot.key, function()
		goto_terminal(slot.id, nil, slot.symbol)
	end, { silent = true })
end

-- Dedicated terminal always running the claude CLI
vim.keymap.set("n", "<leader>tg", function()
	goto_terminal("claude", "claude", "claude")
end, { silent = true })

-- Quick floating scratch terminal, independent of the slots above
vim.keymap.set({ "n", "t" }, "<C-t>", function()
	Snacks.terminal(nil, {
		count = 0,
		start_insert = false,
		auto_insert = false,
		win = {
			position = "float",
			border = "rounded",
			wo = { number = true, relativenumber = true },
		},
	})
end, { silent = true })

wk.add({
	{ "<leader>t", group = "Terminals" },
	{ "<leader>tt", desc = "Terminal α" },
	{ "<leader>tq", desc = "Terminal β" },
	{ "<leader>tw", desc = "Terminal γ" },
	{ "<leader>te", desc = "Terminal δ" },
	{ "<leader>tr", desc = "Terminal ε" },
	{ "<leader>tg", desc = "Claude" },
})
