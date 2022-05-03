# vim: ft=vim
''
"-------------------------------------------------- 
" Telescope
"-------------------------------------------------- 
lua <<EOF
local opt = { noremap = true }

vim.api.nvim_set_keymap("n", "<leader><leader>", ":lua require('telescope.builtin').find_files()<CR>", opt);
vim.api.nvim_set_keymap("n", "<leader><tab>", ":lua require('telescope.builtin').buffers()<CR>", opt);
vim.api.nvim_set_keymap("n", "<leader>`", ":lua require('telescope.builtin').live_grep()<CR>", opt);
vim.api.nvim_set_keymap("n", "<leader>~", ":lua require('telescope.builtin').grep_string()<CR>", opt);

-- Git
vim.api.nvim_set_keymap("n", "<leader>gb", ":lua require('telescope.builtin').git_branches()<cr>", opt);
vim.api.nvim_set_keymap("n", "<leader>gs", ":lua require('telescope.builtin').git_status()<cr>", opt);
--vim.api.nvim_set_keymap("n", "<leader>gc", ":lua require('telescope.builtin').git_commits()<cr>", opt);
--vim.api.nvim_set_keymap("n", "<leader>gf", ":lua require('telescope.builtin').git_bcommits()<cr>", opt);

-- LSP
vim.api.nvim_set_keymap("n", ",aa", ":lua require('telescope.builtin').lsp_code_actions()<cr>", opt);
vim.api.nvim_set_keymap("n", ",d", ":lua require('telescope.builtin').lsp_document_diagnostics()<cr>", opt);
vim.api.nvim_set_keymap("n", "gr", ":lua require('telescope.builtin').lsp_references()<cr>", opt);
vim.api.nvim_set_keymap("n", "gd", ":lua require('telescope.builtin').lsp_definitions()<cr>", opt);
--vim.api.nvim_set_keymap("n", "go", ":lua require('telescope.builtin').lsp_document_symbols()<cr>", opt);
EOF
''
