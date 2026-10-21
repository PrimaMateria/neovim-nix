local wk = require("which-key")

-- Persistent terminal buffers per slot, reused across invocations.
-- Swaps the current window's buffer to the slot's terminal instead of
-- opening a new split, mirroring the old harpoon.term.gotoTerminal().
local bufs = {}

local function find_named(name)
	local target = vim.fn.fnamemodify(name, ":p")
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_get_name(buf) == target then
			return buf
		end
	end
end

-- A buffer may already hold the slot's name: either the slot's terminal from
-- before a config reload (adopt it), or an empty placeholder left over by a
-- restored session (wipe it). Without this, naming the fresh terminal fails
-- with E95, the slot is never registered, and every press spawns another one.
local function claim_name(name)
	local buf = find_named(name)
	-- if no buf is addigned to the name, return the name only
	if not buf then
		return name
	end
	-- if we have buf and it is the terminal, as expected, return the name and the buf
	if vim.bo[buf].buftype == "terminal" then
		return name, buf
	end
	-- if it is not terminal, and it is possible to safely get rid of it, the delete buf and pretend there was none - return only name
	if not vim.bo[buf].modified and vim.fn.filereadable(vim.api.nvim_buf_get_name(buf)) == 0 then
		vim.api.nvim_buf_delete(buf, { force = true })
		return name
	end
	-- a real file goes by that name; leave the terminal unnamed rather than clash
	return nil
end

local function get_buf(id, cmd, name)
	-- if buf is set return it
	local buf = bufs[id]
	if buf and vim.api.nvim_buf_is_valid(buf) then
		return buf
	end

	-- if buf is not set first claim the name
	local existing
	if name then
		name, existing = claim_name(name)
		-- if we found the buf by name, return it
		if existing then
			bufs[id] = existing
			return existing
		end
	end

	-- otherwise use the current buf as new host for the terminal and return it
	local current = vim.api.nvim_get_current_buf()
	vim.cmd(cmd and ("terminal " .. cmd) or "terminal")
	buf = vim.api.nvim_get_current_buf()
	vim.bo[buf].buflisted = false
	vim.bo[buf].bufhidden = "hide"
	if name then
		pcall(vim.api.nvim_buf_set_name, buf, name)
	end
	if vim.api.nvim_buf_is_valid(current) then
		vim.api.nvim_set_current_buf(current)
	end
	bufs[id] = buf
	return buf
end

local function goto_terminal(id, cmd, name)
	vim.api.nvim_set_current_buf(get_buf(id, cmd, name))
end

local function is_terminal_win(win)
	local buf = vim.api.nvim_win_get_buf(win)
	return vim.bo[buf].buftype == "terminal"
end

local group = vim.api.nvim_create_augroup("TermHideInInactiveTabs", { clear = true })

local static_bufs = {
	placeholder = nil,
	error = nil,
}

local function get_static_buf(buf_name, message)
	local static_buf = static_bufs[buf_name]
	if static_buf and vim.api.nvim_buf_is_loaded(static_buf) then
		return static_buf
	end

	static_buf = vim.api.nvim_create_buf(false, true)
	vim.api.nvim_buf_set_lines(static_buf, 0, -1, false, { message })
	vim.bo[static_buf].modifiable = false
	static_bufs[buf_name] = static_buf

	return static_buf
end

local function get_placeholder()
	return get_static_buf("placeholder", "<terminal hidden>")
end

local function get_error_buf()
	return get_static_buf("error", "<terminal was not possible to restore>")
end

vim.api.nvim_create_autocmd("TabLeave", {
	group = group,
	callback = function()
		local tab = vim.api.nvim_get_current_tabpage()
		local tab_wins = vim.api.nvim_tabpage_list_wins(tab)

		for _, tab_win in ipairs(tab_wins) do
			if not is_terminal_win(tab_win) then
				goto continue_hide
			end

			local original_buf = vim.api.nvim_win_get_buf(tab_win)
			vim.w[tab_win].pm_hid_terminal = original_buf
			vim.api.nvim_win_set_buf(tab_win, get_placeholder())

			::continue_hide::
		end
	end,
})

vim.api.nvim_create_autocmd("TabEnter", {
	group = group,
	callback = function()
		local tab = vim.api.nvim_get_current_tabpage()
		local tab_wins = vim.api.nvim_tabpage_list_wins(tab)

		for _, tab_win in ipairs(tab_wins) do
			local hid_terminal = vim.w[tab_win].pm_hid_terminal
			if hid_terminal == nil then
				goto continue_unhide
			end

			vim.w[tab_win].pm_hid_terminal = nil

			local is_still_valid = vim.api.nvim_buf_is_valid(hid_terminal)
			if not is_still_valid then
				vim.api.nvim_win_set_buf(tab_win, get_error_buf())
				goto continue_unhide
			end

			vim.api.nvim_win_set_buf(tab_win, hid_terminal)

			::continue_unhide::
		end
	end,
})

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

local M = {
	claude_buf = function()
		return get_buf("claude", "claude", "claude")
	end,
}
package.loaded["primamateria.terminals"] = M
