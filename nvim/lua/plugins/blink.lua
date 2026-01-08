return {
	'saghen/blink.cmp',
	dependencies = {
		"rafamadriz/friendly-snippets",
		"nvim-tree/nvim-web-devicons", -- Optional for file icons
		"onsails/lspkind.nvim",  --optional icons
		{
			"supermaven-inc/supermaven-nvim",
			opts = {
				disable_inline_completion = false, -- enables inline ghost text, suppresses nvim-cmp warning
				disable_keymaps = false,
			}
		},
		"huijiro/blink-cmp-supermaven",
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
		},
		appearance = {
			nerd_font_variant = 'mono'
		},
		sources = {
			providers = {
				supermaven = {
					name = 'supermaven',
					module = "blink-cmp-supermaven",
					async = true,
					score_offset = 3,
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
			default = { 'lsp', 'path', 'snippets', 'buffer', 'cmdline', 'lazydev', "supermaven" },

		},
		fuzzy = { implementation = "prefer_rust_with_warning" }
	},
	opts_extend = { "sources.default" }
}
