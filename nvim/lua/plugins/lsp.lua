local capabilities = vim.lsp.protocol.make_client_capabilities()

local on_init = function(client)
	-- NOTE:: DIABLE ALL SYNTAX FROM LSP.. LET TREESITTER HANDLE IT
	-- Should be on_init instead of on_attach?
	client.server_capabilities.semanticTokensProvider = nil
end

local on_attach = function(client, bufnr)
	local buf_opts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', buf_opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, buf_opts)
	vim.keymap.set('n', 'gr', '<Cmd>lua vim.lsp.buf.references()<CR>', buf_opts)
	vim.keymap.set('n', '<leader>rn', '<Cmd>lua vim.lsp.buf.rename()<CR>', buf_opts)
	vim.keymap.set('n', '<leader>ca', '<Cmd>lua vim.lsp.buf.code_action()<CR>', buf_opts)
	vim.keymap.set('n', '<leader>fm', '<Cmd>lua vim.lsp.buf.formatting()<CR>', buf_opts)
end
return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			-- "hrsh7th/cmp-nvim-lsp",
			"saghen/blink.cmp",
			"ray-x/lsp_signature.nvim",
			"onsails/lspkind.nvim",
		},
		config = function()
			require('lspconfig').gopls.setup {
				on_init = on_init,
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
			}

			-- NOTE: a bit annoying
			require('lspconfig').yamlls.setup {
				on_init = on_init,
				on_attach = on_attach,
				capabilities = capabilities,
			}

			require('lspconfig').rust_analyzer.setup {
				on_init = on_init,
				on_attach = on_attach,
				capabilities = capabilities,
				settings = {
					['rust-analyzer'] = {
						checkOnSave = {
							command = "clippy",
						},
					},
				},
			}

			require('lspconfig').lua_ls.setup {
				on_init = on_init,
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
			}

			-- Simple LSP setups
			local servers = { 'taplo', 'bashls', 'pyright' }
			for _, lsp in ipairs(servers) do
				require('lspconfig')[lsp].setup {
					on_init = on_init,
					on_attach = on_attach,
					capabilities = capabilities,
				}
			end
		end
	},
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
	},
	-- TypeScript Tools
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
		opts = {
			on_init = on_init,
			capabilities = capabilities,
			on_attach = on_attach,
			settings = {
				tsserver_format_options = {
					indentSize = 4,
					tabSize = 4,
					convertTabsToSpaces = false, -- use tabs
				},
			},
		},
	},
}
