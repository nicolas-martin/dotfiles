-- lua/plugins.lua
return {
	-- Package manager
	{ "folke/lazy.nvim",       version = "*" },

	-- File explorer
	{ "preservim/nerdtree" },

	-- Repeat plugin
	{ "tpope/vim-repeat" },

	-- Surround plugin
	{ "tpope/vim-surround" },

	-- Commenting utility
	{ "tpope/vim-commentary" },

	-- Colorschemes
	{ "EdenEast/nightfox.nvim" },

	-- Go development plugin
	{ "fatih/vim-go",          build = ":GoUpdateBinaries" },

	-- Treesitter configurations and abstraction layer
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				-- Add other configurations here
			})
		end,
	},

	-- LSP configurations
	{ "neovim/nvim-lspconfig" },

	-- LSP signature hint when you type
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup()
		end,
	},

	-- VSCode-like pictograms for neovim lsp completion items
	{ "onsails/lspkind.nvim" },

	-- Autocompletion framework
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
			{ "hrsh7th/cmp-buffer" },
			-- Snippet engine and sources
			{ "L3MON4D3/LuaSnip" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				sources = {
					{ name = "nvim_lsp" },
					{ name = "path" },
					{ name = "buffer" },
					{ name = "luasnip" },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
			})
		end,
	},

	-- Fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "Telescope",
		config = function()
			require("telescope").setup()
		end,
	},

	-- Git integration
	{ "tpope/vim-fugitive" },

	-- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		event = "VeryLazy",
		config = function()
			require("lualine").setup({
				options = { theme = "auto" },
				-- Add other configurations here
			})
		end,
	},

	-- Additional plugins can be added here
}
