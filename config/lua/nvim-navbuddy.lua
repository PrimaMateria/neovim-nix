-- navbuddy is attached to lsp servers in nvim-lspconfig.lua.nix
local keymap = vim.keymap.set

keymap("n", "<leader>n", "<cmd>:lua require('nvim-navbuddy').open()<CR>", { silent = true })
