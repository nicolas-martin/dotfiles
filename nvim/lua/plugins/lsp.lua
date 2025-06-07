local capabilities = vim.lsp.protocol.make_client_capabilities()

local on_init = function(client)
	-- disable semantic tokens (we let Treesitter handle this)
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
	vim.keymap.set('n', '<leader>fm', vim.lsp.buf.formatting, buf_opts)
end

return {
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"saghen/blink.cmp",
			"ray-x/lsp_signature.nvim",
			"onsails/lspkind.nvim",
		},
		config = function()
			require('lspconfig').yamlls.setup {
				on_init      = on_init,
				on_attach    = on_attach,
				capabilities = capabilities,
			}
			require('lspconfig').rust_analyzer.setup {
				on_init      = on_init,
				on_attach    = on_attach,
				capabilities = capabilities,
				settings     = {
					['rust-analyzer'] = {
						checkOnSave = { command = "clippy" },
					},
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
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			}
			local servers = { 'taplo', 'bashls', 'pyright' }
			for _, lsp in ipairs(servers) do
				require('lspconfig')[lsp].setup {
					on_init      = on_init,
					on_attach    = on_attach,
					capabilities = capabilities,
				}
			end
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
		opts = {
			on_init      = on_init,
			on_attach    = on_attach,
			capabilities = capabilities,
			settings     = {
				tsserver_format_options = {
					indentSize          = 4,
					tabSize             = 4,
					convertTabsToSpaces = false,
				},
			},
		},
	},
	{
		"ray-x/go.nvim",
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		ft = { "go", "gomod" },
		event = { "CmdlineEnter" },
		build = ":lua require('go.install').update_all_sync()",
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
							"-.git",
							"-.vscode",
							"-.idea",
							"-node_modules",
							"-**/mocks",
							"-**/gen",
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
						hoverKind        = "FullDocumentation",
						linkTarget       = "pkg.go.dev",
						linksInHover     = true,
					},
				},
			},
		},
		config = function(_, opts)
			require("go").setup(opts)
			-- goimports on save
			local grp = vim.api.nvim_create_augroup("GoFormat", { clear = true })
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern  = "*.go",
				group    = grp,
				callback = function()
					require("go.format").goimports()
				end,
			})
		end,
	},
}
