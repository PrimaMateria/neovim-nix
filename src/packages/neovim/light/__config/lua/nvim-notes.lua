-- Floating scratch note, backed by a single markdown file in ~/Documents so
-- the notes persist on disk and are shared across every neovim instance.
-- <C-n> toggles the float; edits are written on leave so other instances
-- pick them up, and are re-read (checktime) every time the float is opened.
local note_path = vim.fn.expand("~/Documents/notes.md")

local state = { win = nil, buf = nil }

local function save_note()
	if state.buf and vim.api.nvim_buf_is_valid(state.buf) and vim.bo[state.buf].modified then
		vim.api.nvim_buf_call(state.buf, function()
			vim.cmd("silent write")
		end)
	end
end

local function open_note()
	-- Make sure the notes directory exists before editing the file
	local dir = vim.fn.fnamemodify(note_path, ":h")
	if vim.fn.isdirectory(dir) == 0 then
		vim.fn.mkdir(dir, "p")
	end

	-- Reuse a single buffer bound to the note file across toggles
	if not (state.buf and vim.api.nvim_buf_is_valid(state.buf)) then
		state.buf = vim.fn.bufadd(note_path)
		vim.fn.bufload(state.buf)
		vim.bo[state.buf].buflisted = false

		-- Persist on leave so a sibling instance sees the latest note
		vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
			buffer = state.buf,
			callback = save_note,
		})
	end

	-- Pull in edits made by other neovim instances since we last looked
	vim.api.nvim_buf_call(state.buf, function()
		vim.cmd("checktime")
	end)

	local width = math.floor(vim.o.columns * 0.6)
	local height = math.floor(vim.o.lines * 0.6)
	state.win = vim.api.nvim_open_win(state.buf, true, {
		relative = "editor",
		width = width,
		height = height,
		row = math.floor((vim.o.lines - height) / 2),
		col = math.floor((vim.o.columns - width) / 2),
		border = "rounded",
		title = " notes ",
		title_pos = "center",
		style = "minimal",
	})
	vim.wo[state.win].number = true
	vim.wo[state.win].relativenumber = true
	vim.wo[state.win].wrap = true
end

local function close_note()
	save_note()
	if state.win and vim.api.nvim_win_is_valid(state.win) then
		vim.api.nvim_win_close(state.win, true)
	end
	state.win = nil
end

local function toggle_note()
	if state.win and vim.api.nvim_win_is_valid(state.win) then
		close_note()
	else
		open_note()
	end
end

vim.keymap.set("n", "<C-n>", toggle_note, { silent = true, desc = "Toggle floating note" })
