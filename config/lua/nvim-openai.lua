require("chatgpt").setup({
	welcome_message = "ChatGPT",
})

vim.api.nvim_set_keymap("n", ",sa", "<cmd>ChatGPT<cr>", { noremap = true })
vim.api.nvim_set_keymap("v", ",sf", "<cmd>ChatGPTRun grammar_correction<cr>", { noremap = true })
