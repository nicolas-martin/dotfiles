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
	pattern = { "rust", "javascript", "typescript", "typescriptreact", "proto", "yaml", "lua", "javascriptreact" },
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.expandtab = false
		vim.opt_local.signcolumn = "yes"
	end,
})

-- Format on save
autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})
