vim.g.tmux_navigator_no_mappings = 1

vim.keymap.set("n", "<C-w>h", "<cmd>TmuxNavigateLeft<cr>", { silent = true })
vim.keymap.set("n", "<C-w>j", "<cmd>TmuxNavigateDown<cr>", { silent = true })
vim.keymap.set("n", "<C-w>k", "<cmd>TmuxNavigateUp<cr>", { silent = true })
vim.keymap.set("n", "<C-w>l", "<cmd>TmuxNavigateRight<cr>", { silent = true })
