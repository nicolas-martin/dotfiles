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
            },
        },
    },
})

require('lspconfig').pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

require('rust-tools').setup({
    tools = {
        inlay_hints = {
            auto = true,
            show_parameter_hints = false,
            other_hints_prefix = "",
        },
    },
    server = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            ['rust-analyzer'] = {
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
    },
})
