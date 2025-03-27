local source_mapping = {
	nvim_lsp = "[LSP]",
	nvim_lua = "[LUA]",
	luasnip = "[SNIP]",
	buffer = "[BUF]",
	path = "[PATH]",
	treesitter = "[TREE]",
	copilot = "[CO]",
}

return {
	{
		enabled = false,
		"hrsh7th/nvim-cmp",
		-- config = config_debug,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-emoji",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"ray-x/cmp-treesitter",
			"js-everts/cmp-tailwind-colors",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		opts = function()
			local cmp = require("cmp")
			local cmp_tailwind = require("cmp-tailwind-colors")
			local lspkind = require("lspkind")

			return cmp.setup({
				preselect = cmp.PreselectMode.Item,
				keyword_length = 2,
				-- completion = {
				-- 	completeopt = "menu,menuone,noinsert",
				-- 	-- complete the word
				-- 	autocomplete = true,
				-- },
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				view = {
					entries = {
						name = "custom",
						selection_order = "near_cursor",
						follow_cursor = true,
					},
				},
				-- TODO: Move this to @keybinds.lua
				mapping = {
					["<CR>"] = cmp.mapping(
						cmp.mapping.confirm({
							select = true,
							behavior = cmp.ConfirmBehavior.Insert,
						}),
						{ "i", "c" }
					),
					-- disable these because the (built-in) menu still
					-- works
					-- ["<C-n>"] = "<nop>",
					-- ["<C-p>"] = "<nop>",
					["<C-j>"] = cmp.mapping.select_next_item({
						behavior = cmp.ConfirmBehavior.Insert,
					}),
					["<C-k>"] = cmp.mapping.select_prev_item({
						behavior = cmp.ConfirmBehavior.Insert,
					}),
					["<C-b>"] = cmp.mapping.scroll_docs(-5),
					["<C-f>"] = cmp.mapping.scroll_docs(5),
					["<C-q>"] = cmp.mapping.abort(),
					-- ['<C-Space>'] = cmp.mapping.complete(),
				},
				sources = cmp.config.sources({
					{ name = "copilot",    group_index = 1 },
					{
						name = "luasnip",
						group_index = 2,
						option = { use_show_condition = true },
						entry_filter = function()
							local context = require("cmp.config.context")
							local ok = not context.in_treesitter_capture("string")
								and not context.in_syntax_group("String")
							return ok
						end,
					},
					{ name = "nvim_lsp",   group_index = 3 },
					{ name = "nvim_lua",   group_index = 4 },
					{ name = "treesitter", group_index = 5, keyword_length = 4 },
					{ name = "path",       group_index = 5, keyword_length = 4 },
					{
						name = "buffer",
						keyword_length = 3,
						group_index = 6,
						option = {
							get_bufnrs = function()
								local bufs = {}
								for _, win in ipairs(vim.api.nvim_list_wins()) do
									bufs[vim.api.nvim_win_get_buf(win)] = true
								end
								return vim.tbl_keys(bufs)
							end,
						},
					},
				}),
				---@diagnostic disable-next-line: missing-fields
				formatting = {

					-- 'abbr' | 'kind' | 'menu'
					-- [LS] icon
					fields = { "kind", "abbr" },
					format = lspkind.cmp_format({
						symbol_map = { Copilot = "" },
						mode = "symbol",
						ellipsis_char = "...",
						before = function(entry, item)
							cmp_tailwind.format(entry, item)
							return item
						end,
						menu = source_mapping,
					}),
				},
				sorting = {
					priority_weight = 2,
					comparators = {
						-- test
						-- require("copilot_cmp.comparators").prioritize,
						-- test
						cmp.config.compare.offset,
						cmp.config.compare.exact,
						cmp.config.compare.score,
						cmp.config.compare.recently_used,
						cmp.config.compare.kind,
						cmp.config.compare.sort_text,
						cmp.config.compare.length,
						cmp.config.compare.order,
					},
				},
			})
		end


	},
	{
		enabled = false,
		"zbirenbaum/copilot-cmp",
		dependencies = {
			"zbirenbaum/copilot.lua",
		},
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	-- LSP signature hint when you type
	{
		enabled = true,
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup({
				hint_enable = false, -- virtual hint enable
				handler_opts = {
					border = "rounded" -- double, rounded, single, shadow, none, or a table of borders
				},
			})
		end,
	}, {
	"L3MON4D3/LuaSnip",
	build = "make install_jsregexp",
	-- TODO: Do I need this?
	dependencies = {
		'nvim-treesitter/nvim-treesitter',
	},
	version = 'v2.*',
	lazy = false,
	init = function()
		local ls = require('luasnip')
		ls.setup({
			-- Required to automatically include base snippets, like "c" snippets for "cpp"
			load_ft_func = require('luasnip_snippets.common.snip_utils').load_ft_func,
			ft_func = require('luasnip_snippets.common.snip_utils').ft_func,
			-- To enable auto expansin
			enable_autosnippets = true,
			-- Uncomment to enable visual snippets triggered using <c-x>
			-- store_selection_keys = '<c-x>',
		})
	end,
	keys = {
		{
			-- TODO: KEYS DON"T WORK
			"<leader>n",
			function() require("luasnip").jump(1) end,
			-- 	function() if ls.expand_or_jumpable() then ls.expand_or_jump() else vim.api.nvim_input('<C-V><Tab>') end end,
			desc = "Jump forward a snippet placement",
			mode = "i",
			noremap = true,
			silent = true
		},
		{
			"<leader>p",
			function() require("luasnip").jump(-1) end,
			-- vim.keymap.set({ "i", "s" }, "<S-Tab>", function() ls.jump(-1) end, { silent = true })
			desc = "Jump backward a snippet placement",
			mode = "i",
			noremap = true,
			silent = true
		}
		-- vim.keymap.set({ "i", "s" }, "<C-E>", function() if ls.choice_active() then ls.change_choice(1) end end,
	},
	-- custom path
	-- config = function()
	-- 	require("luasnip.loaders.from_lua").load({ paths = "~/.snippets" })
	-- end
},
	{
		-- (snipMate & UltiSnip Snippets) converted to native luasnip snippets
		'mireq/luasnip-snippets',
		dependencies = { 'L3MON4D3/LuaSnip' },
		init = function()
			-- Mandatory setup function
			require('luasnip_snippets.common.snip_utils').setup()
		end

	},

}
