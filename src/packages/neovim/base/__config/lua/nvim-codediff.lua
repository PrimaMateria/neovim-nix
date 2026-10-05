require("codediff").setup({})

vim.keymap.set("n", ",dd", "<cmd>CodeDiff<CR>", { silent = true, desc = "CodeDiff status" })
vim.keymap.set("n", ",dh", "<cmd>CodeDiff history %<CR>", { silent = true, desc = "CodeDiff file history" })
vim.keymap.set("x", ",dh", ":CodeDiff history<CR>", { silent = true, desc = "CodeDiff selection history" })
vim.keymap.set("n", ",dl", "<cmd>CodeDiff HEAD^1 HEAD<CR>", { silent = true, desc = "CodeDiff last commit" })
