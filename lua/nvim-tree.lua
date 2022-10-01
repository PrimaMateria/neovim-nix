vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup()

local opt = { noremap = true }
vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeFindFileToggle<CR>", opt)
