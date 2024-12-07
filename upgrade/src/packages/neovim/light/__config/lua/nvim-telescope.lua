local opt = { noremap = true }
local telescope = require("telescope")

telescope.setup({
	defaults = {
		layout_strategy = "vertical",
		path_display = {
			"truncate",
		},
		file_ignore_patterns = { "^.git/" },
	},
	pickers = {
		find_files = {
			hidden = true,
		},
	},
	extensions = {
		frecency = {
			db_safe_mode = false,
			show_scores = false,
			show_unindexed = true,
			default_workspace = "CWD",
			ignore_patterns = { "*.git/*", "*node_modules/*", "*dist/*", "*build/*" },
			sorter = require("telescope.config").values.file_sorter(),
		},
		fzf = {
			fuzzy = true,
			override_generic_sorter = true,
			override_file_sorter = true,
			case_mode = "smart_case",
		},
	},
})

telescope.load_extension("frecency")
telescope.load_extension("fzf")

vim.api.nvim_set_keymap("n", "gd", ":lua require('telescope.builtin').lsp_definitions()<cr>", opt)
vim.api.nvim_set_keymap("n", "<leader><tab>", ":lua require('telescope.builtin').find_files()<CR>", opt)
vim.api.nvim_set_keymap("n", "<leader>`", ":lua require('telescope.builtin').live_grep()<CR>", opt)
vim.api.nvim_set_keymap("n", "<leader>~", ":lua require('telescope.builtin').grep_string()<CR>", opt)
vim.api.nvim_set_keymap("n", "<leader><backspace>", ":lua require('telescope').extensions.recent_files.pick()<CR>", opt)
vim.api.nvim_set_keymap("n", "<leader><leader>", ":lua require('telescope').extensions.frecency.frecency()<CR>", opt)
