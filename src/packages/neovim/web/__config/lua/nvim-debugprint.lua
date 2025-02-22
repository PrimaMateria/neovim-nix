local debugprint = require("debugprint")
local js_like = {
	left = 'console.info("',
	right = '")',
	mid_var = '", ',
	right_var = ")",
}

debugprint.setup({
	display_counter = false,
	filetypes = {
		["javascript"] = js_like,
		["javascriptreact"] = js_like,
		["typescript"] = js_like,
		["typescriptreact"] = js_like,
	},
})

vim.api.nvim_set_keymap("n", ",ad", "<cmd>DeleteDebugPrints<cr>", { noremap = true, desc = "Delete debug prints" })
