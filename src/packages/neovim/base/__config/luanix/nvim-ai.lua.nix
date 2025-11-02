# vim: ft=lua 
{ extraPackages, pkgs, }: ''

  local gheUrl = "https://finapi.ghe.com";

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

