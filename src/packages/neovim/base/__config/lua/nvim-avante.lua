require("avante_lib").load()
require("avante").setup({
	provider = "openai",
	mappings = {
		ask = ",sd",
		edit = ",sf",
		refresh = nil,
		--- @class AvanteConflictMappings
		diff = {
			ours = "co",
			theirs = "ct",
			none = "c0",
			both = "cb",
			next = "]x",
			prev = "[x",
		},
		jump = {
			next = "]]",
			prev = "[[",
		},
		submit = {
			normal = "<CR>",
			insert = "<C-s>",
		},
	},
})
