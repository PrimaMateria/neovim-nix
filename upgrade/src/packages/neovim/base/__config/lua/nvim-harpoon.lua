require("harpoon").setup()

local opt = { noremap = true }
vim.api.nvim_set_keymap("n", "<leader>tt", ":lua require('harpoon.term').gotoTerminal(1)<CR>", opt)
vim.api.nvim_set_keymap("n", "<leader>tq", ":lua require('harpoon.term').gotoTerminal(2)<CR>", opt)
vim.api.nvim_set_keymap("n", "<leader>tw", ":lua require('harpoon.term').gotoTerminal(3)<CR>", opt)
vim.api.nvim_set_keymap("n", "<leader>te", ":lua require('harpoon.term').gotoTerminal(4)<CR>", opt)
vim.api.nvim_set_keymap("n", "<leader>tr", ":lua require('harpoon.term').gotoTerminal(5)<CR>", opt)
