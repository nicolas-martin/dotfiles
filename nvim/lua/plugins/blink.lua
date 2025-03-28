return {
	'saghen/blink.cmp',
	-- optional: provides snippets for the snippet source
	dependencies = {
		"rafamadriz/friendly-snippets",
		"nvim-tree/nvim-web-devicons", -- Optional for file icons
		"onsails/lspkind.nvim",  --optional icons
		"giuxtaposition/blink-cmp-copilot",
		"L3MON4D3/LuaSnip",
	},

	-- use a release tag to download pre-built binaries
	version = '1.*',

	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		-- --- @field enabled boolean
		-- --- @field trigger blink.cmp.SignatureTriggerConfig
		-- --- @field window blink.cmp.SignatureWindowConfig
		---@type blink.cmp.SignatureConfigPartial
		signature = { enabled = true },
		--- @type blink.cmp.TermConfigPartial
		term = {},
		--- @type blink.cmp.CmdlineConfigPartial
		cmdline = {},
		--- @type blink.cmp.SnippetsConfigPartial
		snippets = {
			preset = "luasnip",
		},
		--- @type blink.cmp.CompletionConfigPartial
		completion = {
			ghost_text = {
				enabled = vim.g.ai_cmp,
			},
			-- (Default) Only show the documentation popup when manually triggered
			---@type blink.cmp.CompletionDocumentationConfigPartial
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 200,
			},
			---@type blink.cmp.CompletionMenuConfigPartial
			menu = {
				auto_show = true,
				draw = {
					-- use tree sitter to label
					treesitter = { "lsp" },
					columns = {
						{ "kind_icon" },
						{ "label" },
						{ "kind",     "source_name" },
					},
					components = {
						kind_icon = {
							ellipsis = false,
							text = function(ctx)
								local icon = ctx.kind_icon
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
									if dev_icon then
										icon = dev_icon
									end
								else
									icon = require("lspkind").symbolic(ctx.kind, {
										mode = "symbol",
									})
								end

								return icon .. ctx.icon_gap
							end,
						},
					},
				},
			},
		},

		-- See :h blink-cmp-config-keymap for defining your own keymap
		-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
		-- 'super-tab' for mappings similar to vscode (tab to accept)
		-- 'enter' for enter to accept
		-- 'none' for no mappings
		--- @type blink.cmp.KeymapConfig
		keymap = {
			preset = 'super-tab',
			['<C-k>'] = { 'select_prev', 'fallback_to_mappings' },
			['<C-j>'] = { 'select_next', 'fallback_to_mappings' },
		},
		--- @type blink.cmp.AppearanceConfigPartial
		appearance = {
			-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = 'mono'
		},

		-- Default list of enabled providers defined so that you can extend it
		-- elsewhere in your config, without redefining it, due to `opts_extend`
		--- @type blink.cmp.SourceConfigPartial
		sources = {
			--- @type table<string, blink.cmp.SourceProviderConfigPartial>		
			providers = {
				copilot = {
					enabled = false,
					name = "copilot",
					module = "blink-cmp-copilot",
					score_offset = 100,
					async = true,
					transform_items = function(ctx, items)
						for _, item in ipairs(items) do
							item.kind_icon = ''
							item.kind_name = 'Copilot'
						end
						return items
					end
				},
				-- I don't actually know what it does
				markdown = {
					name = "markdown",
					module = "render-markdown.integ.blink",
					enabled = true,
					fallbacks = { "lsp" },
				},
				buffer = { max_items = 5 },
			},
			default = { 'lsp', 'path', 'snippets', 'buffer', 'cmdline', 'lazydev', 'copilot' },
		},

		--- @type blink.cmp.FuzzyConfigPartial
		fuzzy = { implementation = "prefer_rust_with_warning" }
	},
	opts_extend = { "sources.default" }
}
