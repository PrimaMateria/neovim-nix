# vim: ft=vim
''
"-------------------------------------------------- 
" Compe
"-------------------------------------------------- 
lua << EOF
vim.o.completeopt = "menuone,noselect"
require('compe').setup {
  enabled = true;
  autocomplete = true;
  debug = true;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = true;
  source = {
    nvim_lsp = true;
    path = true;
    buffer = false;
    calc = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
  };
}
--This line is important for auto-import
vim.api.nvim_set_keymap('i', '<cr>', 'compe#confirm("<cr>")', { expr = true })
EOF
''
