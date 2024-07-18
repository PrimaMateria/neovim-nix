require("spectre").setup({})

vim.keymap.set("n", ",as", "<cmd>lua require('spectre').toggle()<CR>", { silent = true })
