local on_attach = function(client, bufnr)
	client.server_capabilities.semanticTokensProvider = nil
	local buf_opts = { noremap = true, silent = true, buffer = bufnr }

	vim.keymap.set("n", "gd", "<cmd>Trouble lsp_definitions toggle<cr>", buf_opts)
	vim.keymap.set("n", "gi", "<cmd>Trouble lsp_implementations toggle<cr>", buf_opts)
	vim.keymap.set("n", "gr", "<cmd>Trouble lsp_references toggle<cr>", buf_opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, buf_opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, buf_opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, buf_opts)

	vim.keymap.set("n", "<leader>fm", function()
		vim.lsp.buf.format({ async = true })
	end, buf_opts)
end

-- Setup capabilities at module level so go.nvim can access it
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

return {
	-- Mason: portable package manager for LSP servers, linters, formatters
	{
		"mason-org/mason.nvim",
		opts = {},
	},

	-- Bridge between mason and lspconfig: auto-install + auto-enable servers
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			"mason-org/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"lua_ls",
				"rust_analyzer",
				"pyright",
				"bashls",
				"yamlls",
				"eslint",
				"taplo",
				"solidity_ls",
			},
			-- Automatically call vim.lsp.enable() for installed servers.
			-- Servers managed by wrapper plugins are excluded.
			automatic_enable = {
				exclude = {
					"ts_ls", -- managed by typescript-tools.nvim
				},
			},
		},
	},

	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"saghen/blink.cmp",
			"ray-x/lsp_signature.nvim",
			"onsails/lspkind.nvim",
		},
		config = function()
			-- Apply shared defaults to every server
			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			local attach_group = vim.api.nvim_create_augroup("dotfiles-lsp-attach", { clear = true })
			vim.api.nvim_create_autocmd("LspAttach", {
				group = attach_group,
				callback = function(args)
					local client = vim.lsp.get_client_by_id(args.data.client_id)
					if not client then
						return
					end
					on_attach(client, args.buf)
				end,
			})

			-- Server-specific settings (mason-lspconfig handles cmd, filetypes, root_dir)
			vim.lsp.config("yamlls", {
				settings = {
					yaml = {
						format = { enable = true },
						schemaStore = { enable = true },
					},
				},
			})

			vim.lsp.config("eslint", {
				settings = {
					format = { enable = true },
					workingDirectories = { mode = "auto" },
				},
			})

			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = { checkOnSave = { command = "clippy" } },
				},
			})

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						diagnostics = { globals = { "vim" } },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			})

			vim.lsp.config("pyright", {
				capabilities = {
					textDocument = {
						publishDiagnostics = {
							tagSupport = {
								valueSet = { 2 },
							},
						},
					},
				},
				settings = {
					python = {
						analysis = {
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
							diagnosticMode = "workspace",
							typeCheckingMode = "basic",
						},
					},
				},
			})

			vim.lsp.config("solidity_ls", {
				settings = {
					solidity = {
						includePath = "",
						remappings = {},
					},
				},
			})

			-- taplo and bashls work fine with defaults, no custom settings needed
		end,
	},

	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {},
	},

	{
		"pmizio/typescript-tools.nvim",
		ft = { "typescript", "javascript", "typescriptreact", "javascriptreact" },
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {
			on_init = function(client)
				client.server_capabilities.semanticTokensProvider = nil
			end,
			capabilities = capabilities,
			settings = {
				tsserver_format_options = {
					indentSize = 4,
					tabSize = 4,
					convertTabsToSpaces = false,
				},
				tsserver_max_memory = "auto",
			},
		},
	},
	{
		"nvim-flutter/flutter-tools.nvim",
		lazy = false,
		dependencies = {
			"nvim-lua/plenary.nvim",
			"stevearc/dressing.nvim",
		},
		opts = {
			lsp = {
				capabilities = capabilities,
				on_attach = on_attach,
				settings = {
					showTodos = true,
					completeFunctionCalls = true,
					renameFilesWithClasses = "prompt",
					enableSnippets = true,
				},
			},
		},
	},
	{
		"ray-x/go.nvim",
		ft = { "go", "gomod" },
		build = ":lua require('go.install').update_all_sync()",
		dependencies = {
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
		},
		config = function()
			require("go").setup({
				lsp_cfg = {
					capabilities = capabilities,
					settings = {
						gopls = {
							analyses = {
								ST1000 = false,
							},
						},
					},
				},
				diagnostic = false,
				lsp_inlay_hints = { enable = false },
				lsp_keymaps = false,
			})

			local grp = vim.api.nvim_create_augroup("GoFormat", { clear = true })
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				group = grp,
				callback = function()
					require("go.format").goimports()
				end,
			})
		end,
	},
}
