require("diffview").setup()

local bufopts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>gf", "<cmd>DiffviewFileHistory %<CR>", bufopts)
vim.keymap.set("n", "<leader>gq", "<cmd>DiffviewClose<CR>", bufopts)
