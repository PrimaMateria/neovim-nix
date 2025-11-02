# vim: ft=lua 
{ extraPackages, pkgs, }: ''

  local gheUrl = "https://finapi.ghe.com";

  -- copilot-lsp
  vim.g.copilot_nes_debounce = 500
  vim.lsp.enable("copilot_ls")
  vim.keymap.set("n", "<tab>", function()
  	local bufnr = vim.api.nvim_get_current_buf()
  	local state = vim.b[bufnr].nes_state
  	if state then
  		-- Try to jump to the start of the suggestion edit.
  		-- If already at the start, then apply the pending suggestion and jump to the end of the edit.
  		local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
  			or (require("copilot-lsp.nes").apply_pending_nes() and require("copilot-lsp.nes").walk_cursor_end_edit())
  		return nil
  	else
  		-- Resolving the terminal's inability to distinguish between `TAB` and `<C-i>` in normal mode
  		return "<C-i>"
  	end
  end, { desc = "Accept Copilot NES suggestion", expr = true })

  -- copilot-lua
  -- Run :Copilot auth
  require("copilot").setup({
  	nes = { enabled = false }, --TODO: try later
  	auth_provider_url = gheUrl,
    -- nixpkgs node
  	copilot_node_command = "${pkgs.nodejs_22}/bin/node",
  })

  -- codecompanion
  require("codecompanion").setup({
    adapters = {
      http = {
        copilot_enterprise = function()
          local adapter = require 'codecompanion.adapters.http.copilot_enterprise'
          adapter.opts.provider_url = gheUrl
          return adapter
        end,
      },
    },
    strategies = {
      chat = {
        -- Setup the custom adapter for each strategy. You can change default models as usual.
        -- See https://codecompanion.olimorris.dev/configuration/adapters.html#changing-the-default-adapter
        -- and https://codecompanion.olimorris.dev/configuration/adapters.html#changing-a-model
        adapter = {
          name = "copilot_enterprise",
          model = "claude-sonnet-4",
        },
      },
      inline = {
        adapter = "copilot_enterprise",
      },
      cmd = {
        adapter = "copilot_enterprise",
      },
    },
  })
''

