local capabilities = require('cmp_nvim_lsp').default_capabilities()

local on_attach = function(client, bufnr)
        local buf_opts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', buf_opts)
        vim.keymap.set('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', buf_opts)
        vim.keymap.set('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', buf_opts)
        vim.keymap.set('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', buf_opts)
        vim.keymap.set('n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', buf_opts)
        vim.keymap.set('n', '<leader>fm', '<Cmd>lua vim.lsp.buf.formatting()<CR>', buf_opts)
end

-- LSP servers
require('lspconfig').gopls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
                gopls = {
                        gofumpt = true,
                        analyses = {
                                unusedparams = true,
                                nilness = true,
                                shadow = true,
                                unusedwrite = true,
                                useany = true,
                                unusedvariable = true,
                        },
                        semanticTokens = true,
                        staticcheck = true,
                        directoryFilters = { "-.git", "-.vscode", "-.idea", "-node_modules" },
                        hints = {
                                assignVariableTypes = true,
                                compositeLiteralFields = true,
                                compositeLiteralTypes = true,
                                constantValues = true,
                                functionTypeParameters = true,
                                parameterNames = true,
                                rangeVariableTypes = true,
                        },
                },
        },
})

require("typescript-tools").setup {
        on_attach = on_attach,
        capabilities = capabilities,
}

require('lspconfig').pyright.setup({
        on_attach = on_attach,
        capabilities = capabilities,
})

require('lspconfig').rust_analyzer.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
                ['rust-analyzer'] = {
                        checkOnSave = {
                                command = "clippy",
                        },
                },
        },
})

-- Lua Language Server (lua_ls)
require('lspconfig').lua_ls.setup({
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
                Lua = {
                        runtime = {
                                -- Tell the language server which version of Lua you're using (most likely LuaJIT in Neovim)
                                version = 'LuaJIT',
                        },
                        diagnostics = {
                                -- Get the language server to recognize the `vim` global
                                globals = { 'vim' },
                        },
                        workspace = {
                                -- Make the server aware of Neovim runtime files
                                library = vim.api.nvim_get_runtime_file("", true),
                                checkThirdParty = false, -- Disable third-party library checks
                        },
                        telemetry = {
                                enable = false, -- Disable telemetry
                        },
                },
        },
})
