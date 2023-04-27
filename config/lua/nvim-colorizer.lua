require("colorizer").setup()

local opt = { noremap = true }
vim.api.nvim_set_keymap("n", ",c", ":ColorizerToggle<CR>", opt)
