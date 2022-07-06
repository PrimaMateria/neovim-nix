local nvim_lsp = require("lspconfig")

local cmp_nvim_lsp = require("cmp_nvim_lsp")
local client_capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = cmp_nvim_lsp.update_capabilities(client_capabilities)

-- {
-- 	name = "jdtls",
-- 	setup = {
-- 		cmd = { "jdt-language-server" },
-- 	},
-- },

local servers = {
	{ name = "pyright" },
	-- { name = "grammarly", setup = { cmd = { "grammarly-languageserver", "--stdio" } } },
	{ name = "ltex" },
	{
		name = "tsserver",
		on_attach = function(client, bufnr)
			local ts_utils = require("nvim-lsp-ts-utils")
			ts_utils.setup_client(client)

			ts_utils.setup({
				debug = false,
				disable_commands = false,
				enable_import_on_completion = true,

				import_all_timeout = 5000,
				import_all_priorities = {
					buffers = 4,
					buffer_content = 3,
					local_files = 2,
					same_file = 1,
				},
				import_all_scan_buffers = 100,
				import_all_select_source = false,
				always_organize_imports = true,

				-- filter diagnostics
				filter_out_diagnostics_by_severity = {},
				filter_out_diagnostics_by_code = {},

				-- inlay hints
				auto_inlay_hints = true,
				inlay_hints_highlight = "Comment",
				inlay_hints_priority = 200,
				inlay_hints_throttle = 150,
				inlay_hints_format = {
					Type = {},
					Parameter = {},
					Enum = {},
				},

				-- update imports on file move
				update_imports_on_move = false,
				require_confirmation_on_move = false,
				watch_dir = nil,
			})

			client.resolved_capabilities.document_formatting = false
			vim.keymap.set("n", ",i", ":TSLspImportAll<CR>", bufopts)
			vim.keymap.set("n", ",o", ":TSLspOrganize<CR>", bufopts)
		end,
	},
}

for _, server in pairs(servers) do
	local setup = {
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 150,
		},
		on_attach = function(client, bufnr)
			--vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

			local bufopts = { noremap = true, silent = true, buffer = bufnr }
			vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
			vim.keymap.set("n", ",ar", vim.lsp.buf.rename, bufopts)
			vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, bufopts)
			vim.keymap.set("n", "]d", vim.diagnostic.goto_next, bufopts)
			vim.keymap.set("n", ",e", vim.diagnostic.open_float, bufopts)

			if server.on_attach then
				server.on_attach(client, bufnr)
			end
		end,
	}

	if server.setup then
		for k, v in pairs(server.setup) do
			setup[k] = v
		end
	end

	nvim_lsp[server.name].setup(setup)
end
