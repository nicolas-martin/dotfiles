local capabilities = vim.lsp.protocol.make_client_capabilities()
-- Setup capabilities for blink.cmp
capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

local on_init = function(client)
	client.server_capabilities.semanticTokensProvider = nil
end

local on_attach = function(client, bufnr)
	local buf_opts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set('n', 'gd', vim.lsp.buf.definition, buf_opts)
	vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, buf_opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, buf_opts)
	vim.keymap.set('n', 'gr', vim.lsp.buf.references, buf_opts)
	vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, buf_opts)
	vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, buf_opts)

	-- use new formatting API
	vim.keymap.set('n', '<leader>fm', function()
		vim.lsp.buf.format({ async = true })
	end, buf_opts)
end

-- Setup capabilities at module level so go.nvim can access it
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

return {
	{
		'neovim/nvim-lspconfig',
		event = { 'BufReadPre', 'BufNewFile' },
		dependencies = {
			'saghen/blink.cmp',
			'ray-x/lsp_signature.nvim',
			'onsails/lspkind.nvim',
		},
		config = function()

			require('lspconfig').yamlls.setup {
				on_init      = on_init,
				on_attach    = on_attach,
				capabilities = capabilities,
				settings     = {
					yaml = {
						format = {
							enable = true, -- turn on the server’s formatter
						},
						schemaStore = {
							enable = true, -- optional: pull schemas automatically
						},
					},
				},
			}
			require('lspconfig').eslint.setup {
				on_init      = on_init,
				on_attach    = on_attach,
				capabilities = capabilities,
				settings     = {
					format             = { enable = true },
					workingDirectories = { mode = "auto" },
				},
				root_dir     = require('lspconfig').util.root_pattern(".eslintrc.js", ".eslintrc.json", ".eslintrc", "package.json"),
			}
			require('lspconfig').rust_analyzer.setup {
				on_init      = on_init,
				on_attach    = on_attach,
				capabilities = capabilities,
				settings     = {
					['rust-analyzer'] = { checkOnSave = { command = 'clippy' } },
				},
			}
			require('lspconfig').lua_ls.setup {
				on_init      = on_init,
				on_attach    = on_attach,
				capabilities = capabilities,
				settings     = {
					Lua = {
						runtime = { version = 'LuaJIT' },
						diagnostics = { globals = { 'vim' } },
						workspace = {
							library = vim.api.nvim_get_runtime_file('', true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			}

			for _, server in ipairs({ 'taplo', 'bashls', 'pyright' }) do
				require('lspconfig')[server].setup {
					on_init      = on_init,
					on_attach    = on_attach,
					capabilities = capabilities,
				}
			end
		end,
	},

	-- load lazydev.nvim always so blink.cmp can find its integration
	{
		'folke/lazydev.nvim',
		lazy = false,
	},

	{
		'pmizio/typescript-tools.nvim',
		ft = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' },
		dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
		opts = {
			on_init      = function(client)
				client.server_capabilities.semanticTokensProvider = nil
				-- Optionally disable document formatting if you prefer to use a different formatter
				-- client.server_capabilities.documentFormattingProvider = false
			end,
			on_attach    = on_attach,
			capabilities = capabilities,
			settings     = {
				tsserver_format_options = {
					indentSize          = 4,
					tabSize             = 4,
					convertTabsToSpaces = false,
				},
				-- Increase timeout to prevent timeout errors
				tsserver_max_memory = "auto",
			},
		},
	},
	{
		'ray-x/go.nvim',
		ft = { 'go', 'gomod' },
		event = { 'CmdlineEnter' },
		build = ":lua require('go.install').update_all_sync()",
		dependencies = {
			'ray-x/guihua.lua',
			'neovim/nvim-lspconfig',
			'nvim-treesitter/nvim-treesitter',
		},
		opts = {
			lsp_inlay_hints = { enable = false },
			lsp_cfg = {
				on_init      = on_init,
				on_attach    = on_attach,
				capabilities = capabilities,
				settings     = {
					gopls = {
						gofumpt          = true,
						analyses         = {
							unusedparams   = true,
							nilness        = true,
							shadow         = false,
							unusedwrite    = true,
							useany         = true,
							unusedvariable = true,
						},
						semanticTokens   = true,
						staticcheck      = true,
						directoryFilters = {
							'-.git',
							'-.vscode',
							'-.idea',
							'-node_modules',
							'-mocks', -- top-level mocks
							'-**/mocks', -- nested mocks dir
							'-**/mocks/**', -- everything under mocks
							'-**/gen',
						},
						hints            = {
							assignVariableTypes    = true,
							compositeLiteralFields = true,
							compositeLiteralTypes  = true,
							constantValues         = true,
							functionTypeParameters = true,
							parameterNames         = true,
							rangeVariableTypes     = true,
						},
						hoverKind        = 'FullDocumentation',
						linkTarget       = 'pkg.go.dev',
						linksInHover     = true,
					},
				},
			},
		},
		config = function(_, opts)
			require('go').setup(opts)
			local grp = vim.api.nvim_create_augroup('GoFormat', { clear = true })
			vim.api.nvim_create_autocmd('BufWritePre', {
				pattern  = '*.go',
				group    = grp,
				callback = function()
					require('go.format').goimports()
				end,
			})
		end,
	},
}
