require("chatgpt").setup({
	-- optional configuration
})

vim.api.nvim_set_keymap("n", "<leader>aa", "<cmd>ChatGPT<cr>", { noremap = true })
