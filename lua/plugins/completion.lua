---@diagnostic disable: undefined-field
local source_mapping = {
	nvim_lsp = "[LSP]",
	nvim_lua = "[LUA]",
	luasnip = "[SNIP]",
	buffer = "[BUF]",
	path = "[PATH]",
	treesitter = "[TREE]",
}

local config = function()
	local cmp = require("cmp")
	local cmp_tailwind = require("cmp-tailwind-colors")
	local lspkind = require("lspkind")

	cmp.setup({
		preselect = cmp.PreselectMode.Item,
		keyword_length = 2,
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
		mapping = {
			["<CR>"] = cmp.mapping(
				cmp.mapping.confirm({
					select = true,
					behavior = cmp.ConfirmBehavior.Insert,
				}),
				{ "i", "c" }
			),
			["<C-n>"] = cmp.mapping.select_next_item({
				behavior = cmp.ConfirmBehavior.Insert,
			}),
			["<C-p>"] = cmp.mapping.select_prev_item({
				behavior = cmp.ConfirmBehavior.Insert,
			}),
			["<C-b>"] = cmp.mapping.scroll_docs(-5),
			["<C-f>"] = cmp.mapping.scroll_docs(5),
			["<C-q>"] = cmp.mapping.abort(),
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
					require("util").log("luasnip entry_filter: " .. tostring(ok))
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
			format = lspkind.cmp_format({
				mode = "symbol_text",
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
return {
	{
		"hrsh7th/nvim-cmp",
		-- config = config_debug,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-emoji",
			"L3MON4D3/LuaSnip",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			"ray-x/cmp-treesitter",
			"saadparwaiz1/cmp_luasnip",
			"js-everts/cmp-tailwind-colors",
		},
		opts = config

	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = {
			"zbirenbaum/copilot.lua",
		},
		config = function()
			require("copilot").setup({
				require("copilot").setup({})
			})
			require("copilot_cmp").setup()
		end,
	},

}
