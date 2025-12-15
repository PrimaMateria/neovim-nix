# vim: ft=lua 
{ extraPackages, pkgs, }: ''

  -- ENDPOINT HACK
  -- Force CC Copilot Enterprise traffic to routed GHE endpoint
  _G.__cc_copilot_enterprise_url = nil

  do
    local http = require("codecompanion.http")

    -- keep original function CC captured
    local orig_post = http.static.methods.post.default

    http.static.methods.post.default = function(opts)
      if opts
        and opts.url == "https://api.githubcopilot.com/chat/completions"
        and _G.__cc_copilot_enterprise_url
      then
        opts = vim.tbl_deep_extend("force", opts, {
          url = _G.__cc_copilot_enterprise_url,
        })
      end
      return orig_post(opts)
    end
  end
  -- END


  local adapters = require("codecompanion.adapters")
  local gheUrl = "https://finapi.ghe.com"

  -- copilot-lua
  -- Run :Copilot auth
  require("copilot").setup({
    nes = { enabled = false }, -- TODO: try later
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
  -- Available models:
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
    opts = { log_level = "TRACE" },

    adapters = {
      http = {
        copilot_enterprise = function()
          return adapters.extend("copilot_enterprise", {
            opts = {
              provider_url = "finapi.ghe.com",
              -- prevents the model-picker / schema refresh that resets url
              show_model_choices = false,
            },
          })
        end,
      },
    },
    strategies = {
      chat = { adapter = { name = "copilot_enterprise", model = "gpt-5" } },
      inline = { adapter = "copilot_enterprise", model = "gpt-4.1" },
      cmd = { adapter = "copilot_enterprise", model = "gpt-4.1" },
    },
  })





  -- CodeCompanion keymaps
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

