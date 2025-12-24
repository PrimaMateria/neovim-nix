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

    suggestion = { enabled = false },
    panel = { enabled = false },
    filetypes = {
      markdown = true,
      help = true,
    },
  })


  -- codecompanion

  -- "claude-sonnet-4"
  -- "gemini-2.5-pro"
  -- "grok-code-fast-1"
  -- "claude-3.5-sonnet"
  -- "gpt-5-codex"
  -- "gpt-4o"
  -- "gpt-5"
  -- "claude-sonnet-4.5"
  -- "gpt-4.1"
  -- "gpt-5-mini"

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
        adapter = "copilot_enterprise",
        model = "gpt-4.1",
      },
      inline = {
        adapter = "copilot_enterprise",
        model = "grok-code-fast-1",
      },
      cmd = {
        adapter = "copilot_enterprise",
        model = "gpt-4.1",
      },
    },
  })

  vim.keymap.set("n", "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle CodeCompanion Chat" })
  vim.keymap.set("v", "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", { desc = "Toggle CodeCompanion Chat" })
  vim.keymap.set("n", "<leader>aa", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanion Actions" })
  vim.keymap.set("v", "<leader>aa", "<cmd>CodeCompanionActions<cr>", { desc = "CodeCompanion Actions" })
  vim.keymap.set("n", "<leader>ai", "<cmd>CodeCompanion<cr>", { desc = "CodeCompanion Inline" })
  vim.keymap.set("v", "<leader>ai", "<cmd>CodeCompanion<cr>", { desc = "CodeCompanion Inline" })
  vim.keymap.set("n", "<leader>an", "<cmd>CodeCompanionChat<cr>", { desc = "New CodeCompanion Chat" })
  vim.keymap.set("n", "<leader>ar", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add to CodeCompanion Chat" })
  vim.keymap.set("v", "<leader>ar", "<cmd>CodeCompanionChat Add<cr>", { desc = "Add selection to CodeCompanion Chat" })
''

