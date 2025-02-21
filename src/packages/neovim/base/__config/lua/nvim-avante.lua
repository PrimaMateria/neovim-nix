require("avante_lib").load()
require("avante").setup({
	provider = "openai",
	-- provider = "deepseek",
	vendors = {
		deepseek = {
			__inherited_from = "openai",
			api_key_name = "DEEPSEEK_API_KEY",
			endpoint = "https://api.deepseek.com",
			model = "deepseek-coder",
		},
	},
	mappings = {
		ask = ",sd",
		edit = ",ss",
		refresh = nil,

		diff = {
			ours = "co",
			theirs = "ct",
			all_theirs = "ca",
			both = "cb",
			cursor = "cc",
			next = "]x",
			prev = "[x",
		},

		suggestion = {
			accept = "<M-l>",
			next = "<M-]>",
			prev = "<M-[>",
			dismiss = "<C-]>",
		},

		jump = {
			next = "]]",
			prev = "[[",
		},

		submit = {
			normal = "<CR>",
			insert = "<C-s>",
		},

		sidebar = {
			apply_all = "A",
			apply_cursor = "a",
			switch_windows = "<Tab>",
			reverse_switch_windows = "<S-Tab>",
		},
	},
	hints = { enabled = true },
})
