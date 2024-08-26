require("chatgpt").setup({
	welcome_message = "ChatGPT",
})

vim.api.nvim_set_keymap("n", "<leader>aa", "<cmd>ChatGPT<cr>", { noremap = true })
vim.api.nvim_set_keymap("v", ",ag", "<cmd>ChatGPTRun grammar_correction<cr>", { noremap = true })
