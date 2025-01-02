local wk = require("which-key")
wk.setup({
	preset = "helix",
})
wk.add({
	{ ",", group = "Code" },
	{ ",e", group = "Diagnostic" },
	{ ",a", group = "Refactoring" },
})
