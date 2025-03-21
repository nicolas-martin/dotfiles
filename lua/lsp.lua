local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Configure default hover handler
vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
	vim.lsp.handlers.hover, {
		border = "rounded"
	}
)

local on_attach = function(client, bufnr)
	local buf_opts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', buf_opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, buf_opts)
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
			hoverKind = "FullDocumentation",
			linkTarget = "pkg.go.dev",
			linksInHover = true,
		},
	},
})

require("typescript-tools").setup {
	on_attach = function(client, bufnr)
		-- Disable tsserver's built-in highlighting in favor of treesitter
		client.server_capabilities.semanticTokensProvider = nil
		on_attach(client, bufnr)
	end,
	capabilities = capabilities,
	settings = {
		tsserver_format_options = {
			indentSize = 4,
			tabSize = 4,
			convertTabsToSpaces = false,
		},
		-- Complete semantic features
		complete = {
			completeFunctionCalls = true,
		},
	},
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

require('lspconfig').lua_ls.setup({
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			runtime = {
				version = 'LuaJIT',
			},
			diagnostics = {
				globals = { 'vim' },
			},
			workspace = {
				library = vim.api.nvim_get_runtime_file("", true),
				checkThirdParty = false,
			},
			telemetry = {
				enable = false,
			},
		},
	},
})
