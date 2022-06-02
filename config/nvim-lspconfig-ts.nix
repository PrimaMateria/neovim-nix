# vim: ft=vim
''
lua << EOF
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

local nvim_lsp = require('lspconfig')
nvim_lsp.tsserver.setup {
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    --Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- disable tsserver formatting if you plan on formatting via null-ls
    client.resolved_capabilities.document_formatting = false
    -- define an alias
    vim.cmd("command! -buffer Formatting lua vim.lsp.buf.formatting()")
    vim.cmd("command! -buffer FormattingSync lua vim.lsp.buf.formatting_sync()")
    -- format on save
    vim.cmd("autocmd! BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")

    local ts_utils = require("nvim-lsp-ts-utils")
    -- defaults
    ts_utils.setup {
        debug = false,
        disable_commands = false,
        enable_import_on_completion = true,

        -- import all
        import_all_timeout = 5000, -- ms
        import_all_priorities = {
            buffers = 4, -- loaded buffer names
            buffer_content = 3, -- loaded buffer content
            local_files = 2, -- git files or files with relative path markers
            same_file = 1, -- add to existing import statement
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
        inlay_hints_priority = 200, -- priority of the hint extmarks
        inlay_hints_throttle = 150, -- throttle the inlay hint request
        inlay_hints_format = { -- format options for individual hint kind
            Type = {},
            Parameter = {},
            Enum = {},
            -- Example format customization for `Type` kind:
            -- Type = {
            --     highlight = "Comment",
            --     text = function(text)
            --         return "->" .. text:sub(2)
            --     end,
            -- },
        },

        -- update imports on file move
        update_imports_on_move = false,
        require_confirmation_on_move = false,
        watch_dir = nil,
    }
    
    -- required to fix code action ranges
    ts_utils.setup_client(client)

    -- Mappings
    local opts = { noremap=true, silent=true }

    buf_set_keymap("n", ",i", ":TSLspImportAll<CR>", opts)
    buf_set_keymap("n", ",o", ":TSLspOrganize<CR>", opts)

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', ',e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', ',ar', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', ',af', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
  end,
  flags = {
    debounce_text_changes = 150,
  }
}
EOF
''

