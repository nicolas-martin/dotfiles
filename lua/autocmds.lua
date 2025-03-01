local autocmd = vim.api.nvim_create_autocmd

-- FileType specific settings
autocmd("FileType", {
        pattern = "go",
        callback = function()
                vim.opt_local.tabstop = 4
                vim.opt_local.shiftwidth = 4
                vim.opt_local.softtabstop = 4
                vim.opt_local.expandtab = false
                vim.opt_local.signcolumn = "yes"
        end,
})

autocmd("FileType", {
        pattern = { "rust", "javascript", "typescript", "proto", "yaml" },
        callback = function()
                vim.opt_local.tabstop = 2
                vim.opt_local.shiftwidth = 2
                vim.opt_local.softtabstop = 2
                vim.opt_local.expandtab = true
                vim.opt_local.signcolumn = "yes"
        end,
})

-- Format on save
autocmd("BufWritePre", {
        callback = function()
                vim.lsp.buf.format({ async = false })
        end,
})
