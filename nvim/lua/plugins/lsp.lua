local on_attach = function(client, bufnr)
	client.server_capabilities.semanticTokensProvider = nil
	local buf_opts = { noremap = true, silent = true, buffer = bufnr }

	-- vim.keymap.set('n', 'gd', vim.lsp.buf.definition, buf_opts)
	-- vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, buf_opts)
	-- vim.keymap.set('n', 'gr', vim.lsp.buf.references, buf_opts)
	vim.keymap.set('n', 'gd', "<cmd>Trouble lsp_definitions toggle<cr>", buf_opts)
	vim.keymap.set('n', 'gi', "<cmd>Trouble lsp_implementations toggle<cr>", buf_opts)
	vim.keymap.set('n', 'gr', "<cmd>Trouble lsp_references toggle<cr>", buf_opts)
	vim.keymap.set('n', 'K', vim.lsp.buf.hover, buf_opts)
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
			local util = require('lspconfig.util')

			-- Apply shared defaults to every server (unless overridden later)
			vim.lsp.config('*', {
				capabilities = capabilities,
			})

			local attach_group = vim.api.nvim_create_augroup('dotfiles-lsp-attach', { clear = true })
			vim.api.nvim_create_autocmd('LspAttach', {
				group = attach_group,
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then
						return
					end
					on_attach(client, args.buf)
				end,
			})

			-- Register all server configurations with vim.lsp.config first
			-- Custom config for circom-lsp
			-- vim.lsp.config.circom_lsp = {
			-- 	default_config = {
			-- 		name = 'circom_lsp',
			-- 		cmd = { "circom-lsp" },
			-- 		filetypes = { "circom" },
			-- 		root_dir = util.root_pattern('.git', 'package.json', 'Cargo.toml', '.'),
			-- 		single_file_support = true,
			-- 		settings = {},
			-- 	},
			-- }

			-- Configure yamlls
			vim.lsp.config.yamlls = {
				default_config = {
					name                = 'yamlls',
					cmd                 = { 'yaml-language-server', '--stdio' },
					filetypes           = { 'yaml', 'yaml.docker-compose', 'yaml.gitlab' },
					root_dir            = util.root_pattern('.git'),
					single_file_support = true,
					settings            = {
						yaml = {
							format = {
								enable = true, -- turn on the server's formatter
							},
							schemaStore = {
								enable = true, -- optional: pull schemas automatically
							},
						},
					},
				},
			}

			-- Configure eslint
			vim.lsp.config.eslint = {
				default_config = {
					name      = 'eslint',
					cmd       = { 'vscode-eslint-language-server', '--stdio' },
					filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx', 'typescript', 'typescriptreact', 'typescript.tsx', 'vue', 'svelte', 'astro' },
					root_dir  = util.root_pattern(".eslintrc.js", ".eslintrc.json", ".eslintrc", "package.json"),
					settings  = {
						format             = { enable = true },
						workingDirectories = { mode = "auto" },
					},
				},
			}

			-- Configure rust_analyzer
			vim.lsp.config.rust_analyzer = {
				default_config = {
					name      = 'rust_analyzer',
					cmd       = { 'rust-analyzer' },
					filetypes = { 'rust' },
					root_dir  = util.root_pattern('Cargo.toml', 'rust-project.json'),
					settings  = {
						['rust-analyzer'] = { checkOnSave = { command = 'clippy' } },
					},
				},
			}

			-- Configure solidity
			vim.lsp.config.solidity = {
				default_config = {
					name                = 'solidity',
					cmd                 = { 'nomicfoundation-solidity-language-server', '--stdio' },
					filetypes           = { 'solidity' },
					root_dir            = util.root_pattern('foundry.toml', 'remappings.txt', 'hardhat.config.*', '.git'),
					single_file_support = true,
					settings            = {
						solidity = {
							includePath = '',
							remappings = {},
						}
					}
				},
			}

			-- Configure lua_ls
			vim.lsp.config.lua_ls = {
				default_config = {
					name      = 'lua_ls',
					cmd       = { 'lua-language-server' },
					filetypes = { 'lua' },
					root_dir  = util.root_pattern('.luarc.json', '.luarc.jsonc', '.luacheckrc', '.stylua.toml',
						'stylua.toml', 'selene.toml', 'selene.yml', '.git'),
					settings  = {
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
				},
			}

			-- Configure taplo and bashls
			vim.lsp.config.taplo = {
				default_config = {
					name      = 'taplo',
					cmd       = { 'taplo', 'lsp', 'stdio' },
					filetypes = { 'toml' },
					root_dir  = util.root_pattern('*.toml', '.git'),
				},
			}

			vim.lsp.config.bashls = {
				default_config = {
					name      = 'bashls',
					cmd       = { 'bash-language-server', 'start' },
					filetypes = { 'sh', 'bash' },
					root_dir  = util.root_pattern('.git'),
				},
			}

			vim.lsp.config('pyright', {
				capabilities = {
					textDocument = {
						publishDiagnostics = {
							tagSupport = {
								valueSet = { 2 }, -- 1 = Unnecessary, 2 = Deprecated

							},
						},
					},
				},
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = 'workspace',
							typeCheckingMode = 'basic',
						},
					},
				},
			})

			-- Enable all configured servers
			vim.lsp.enable('yamlls')
			-- vim.lsp.enable('circom_lsp')
			vim.lsp.enable('eslint')
			vim.lsp.enable('rust_analyzer')
			vim.lsp.enable('solidity')
			vim.lsp.enable('lua_ls')
			vim.lsp.enable('taplo')
			vim.lsp.enable('bashls')
			vim.lsp.enable('pyright')
		end,
	},

	-- load lazydev.nvim for lua files
	{
		'folke/lazydev.nvim',
		ft = "lua",
		opts = {},
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
		build = ":lua require('go.install').update_all_sync()",
		dependencies = {
			'ray-x/guihua.lua',
			'neovim/nvim-lspconfig',
			'nvim-treesitter/nvim-treesitter',
		},
		config = function()
			require('go').setup({
				lsp_cfg = {
					capabilities = capabilities,
				},
				lsp_inlay_hints = { enable = false },
				lsp_keymaps = false, -- use keymaps from on_attach instead
			})

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
