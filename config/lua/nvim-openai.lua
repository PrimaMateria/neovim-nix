require("chatgpt").setup({
	welcome_message = "ChatGPT",
})

vim.api.nvim_set_keymap("n", "<leader>aa", "<cmd>ChatGPT<cr>", { noremap = true })
