# vim: ft=vim
''
"-------------------------------------------------- 
" Hop
"-------------------------------------------------- 
lua << EOF
require"hop".setup()
local opt = { noremap = true }
vim.api.nvim_set_keymap("n", "<leader>h", ":lua require('hop').hint_char2()<CR>", opt);
EOF
''
