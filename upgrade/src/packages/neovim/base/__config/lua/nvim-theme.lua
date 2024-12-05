-- vim.api.nvim_set_hl(0, "SignColumn", { bg = "#1d2021" })
-- vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#222222" })
-- vim.api.nvim_set_hl(0, "CursorColumn", { bg = "#151515" })
-- vim.api.nvim_set_hl(0, "CursorLine", { bg = "#151515" })
-- vim.api.nvim_set_hl(0, "LineNr", { fg = "#fabd2f" })
-- vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#86817e" })
-- vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#86817e" })
-- vim.api.nvim_set_hl(0, "Pmenu", { bg = "#1d2021", fg = "#ebdbb2" })
-- vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#ebdbb2" })
-- vim.api.nvim_set_hl(0, "Comment", { fg = "#aaaaaa" })
-- vim.api.nvim_set_hl(0, "TSComment", { fg = "#aaaaaa" })

require("base16-colorscheme").with_config({
	telescope = false,
})
vim.cmd.colorscheme("base16-gruvbox-dark-hard")
