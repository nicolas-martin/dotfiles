return {
	{ "tpope/vim-repeat" },
	{ "tpope/vim-surround" },
	{ "tpope/vim-commentary" },
	{ "onsails/lspkind.nvim" },
	-- { "fatih/vim-go",        build = ":GoUpdateBinaries" },
	{
		"tpope/vim-fugitive",
		enabled = false,
		cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" }
	},
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		event = "VeryLazy",
		opts = {
			options = {
				-- theme = "catppuccin"
				theme = "auto"
			},
			sections = {
				lualine_a = { "mode" },
				lualine_b = { "diff", "diagnostics" },
				lualine_c = { "filename" },
				lualine_x = { "filetype" },
				lualine_y = { "progress" },
				lualine_z = { "location" }
			},
		}
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {
			flavour = "auto",
			integrations = {
				blink_cmp = true,
				nvimtree = true,
				treesitter = true,
			}
		},
	},
	{
		"MeanderingProgrammer/render-markdown.nvim",
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		opts = {
			completions = { blink = { enabled = true } },
		},

	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {},
	},
	-- high-performance color highlighter
	{
		"catgoose/nvim-colorizer.lua",
		event = 'BufReadPre',
		config = function()
			require('colorizer').setup()
		end,
	},
	{
	  "rafamadriz/friendly-snippets",
	  -- add blink.compat to dependencies
	  {
		"saghen/blink.compat",
		optional = true, -- make optional so it's only enabled if any extras need it
		opts = {},
		version = not vim.g.lazyvim_blink_main and "*",
	  },
	}
}
