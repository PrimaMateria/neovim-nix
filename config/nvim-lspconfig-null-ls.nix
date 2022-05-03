# vim: ft=vim
''
lua << EOF
local null_ls = require("null-ls")
null_ls.setup({
  sources = {
      null_ls.builtins.diagnostics.eslint_d, -- eslint or eslint_d
      null_ls.builtins.code_actions.eslint_d, -- eslint or eslint_d
      null_ls.builtins.formatting.prettierd -- prettier, eslint, eslint_d, or prettierd
  },
})
EOF
''
