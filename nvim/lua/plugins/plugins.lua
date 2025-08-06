return {
	{ "tpope/vim-repeat",     keys = { "." } },
	{
		"kylechui/nvim-surround",
		version = "^3.0.0", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end
	},
	{
		'numToStr/Comment.nvim',
		opts = {
			-- add any options here
		}
	},
	{ "onsails/lspkind.nvim", lazy = true },
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
		ft = { 'css', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'html', 'lua', 'vue', 'svelte' },
		cmd = { 'ColorizerToggle', 'ColorizerAttachToBuffer' },
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
