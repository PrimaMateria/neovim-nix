# vim: ft=vim
''
"-------------------------------------------------- 
" Harpoon
"-------------------------------------------------- 
lua << EOF
require"harpoon".setup()

local opt = { noremap = true }
vim.api.nvim_set_keymap("n", "<leader>tt", ":lua require('harpoon.term').gotoTerminal(1)<CR>", opt);
vim.api.nvim_set_keymap("n", "<leader>tq", ":lua require('harpoon.term').gotoTerminal(2)<CR>", opt);
vim.api.nvim_set_keymap("n", "<leader>tw", ":lua require('harpoon.term').gotoTerminal(3)<CR>", opt);
vim.api.nvim_set_keymap("n", "<leader>te", ":lua require('harpoon.term').gotoTerminal(4)<CR>", opt);
vim.api.nvim_set_keymap("n", "<leader>tr", ":lua require('harpoon.term').gotoTerminal(5)<CR>", opt);
vim.api.nvim_set_keymap("n", "<leader>a", ":lua require('harpoon.mark').add_file()<CR>", opt);
vim.api.nvim_set_keymap("n", "<leader>f", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", opt);
vim.api.nvim_set_keymap("n", "<leader>q", ":lua require('harpoon.ui').nav_file(1)<CR>", opt);
vim.api.nvim_set_keymap("n", "<leader>w", ":lua require('harpoon.ui').nav_file(2)<CR>", opt);
vim.api.nvim_set_keymap("n", "<leader>e", ":lua require('harpoon.ui').nav_file(3)<CR>", opt);
vim.api.nvim_set_keymap("n", "<leader>r", ":lua require('harpoon.ui').nav_file(4)<CR>", opt);
EOF
''
