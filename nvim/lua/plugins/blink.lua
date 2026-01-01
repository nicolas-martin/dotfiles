return {
	'saghen/blink.cmp',
	-- optional: provides snippets for the snippet source
	dependencies = {
		"rafamadriz/friendly-snippets",
		"nvim-tree/nvim-web-devicons", -- Optional for file icons
		"onsails/lspkind.nvim",  --optional icons
	},
	-- use a release tag to download pre-built binaries
	version = '1.*',
	opts = {
		signature = { enabled = true },
		term = {},
		cmdline = {},
		completion = {
			ghost_text = {
				enabled = true,
				show_with_menu = false,
			},
			-- (Default) Only show the documentation popup when manually triggered
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 300,
			},
			menu = {
				auto_show = true,
				draw = {
					-- use tree sitter to label
					treesitter = { "lsp" },
					columns = {
						{ "kind_icon" },
						{ "label" },
						{ "source_name" },
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
		keymap = {
			preset = 'super-tab',
			['<C-k>'] = { 'select_prev', 'fallback_to_mappings' },
			['<C-j>'] = { 'select_next', 'fallback_to_mappings' },
			['<A-y>'] = require('minuet').make_blink_map(),
		},
		appearance = {
			nerd_font_variant = 'mono'
		},
		sources = {
			providers = {
				minuet = {
					name = 'minuet',
					module = 'minuet.blink',
					async = true,
					-- Should match minuet.config.request_timeout * 1000,
					-- since minuet.config.request_timeout is in seconds
					timeout_ms = 3000,
					score_offset = 50, -- Gives minuet higher priority among suggestions
				},
				markdown = {
					name = "markdown",
					module = "render-markdown.integ.blink",
					enabled = true,
					fallbacks = { "lsp" },
				},
				lazydev = {
					name = "LazyDev",
					module = "lazydev.integrations.blink",
					-- make lazydev completions top priority (see `:h blink.cmp`)
					score_offset = 100,
				},
				buffer = { max_items = 5 },
			},

			default = { 'lsp', 'path', 'snippets', 'buffer', 'cmdline', 'lazydev', 'minuet' },
		},
		fuzzy = { implementation = "prefer_rust_with_warning" }
	},
	opts_extend = { "sources.default" }
}
