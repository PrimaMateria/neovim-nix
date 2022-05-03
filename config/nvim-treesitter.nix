# vim: ft=vim
''
"-------------------------------------------------- 
" Treesitter
"-------------------------------------------------- 
lua <<EOF
require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
  },
}
EOF
''
