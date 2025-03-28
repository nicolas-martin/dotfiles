return {
	{ "tpope/vim-repeat" },
	{ "tpope/vim-surround" },
	{ "tpope/vim-commentary" },
	{ "onsails/lspkind.nvim" },
	{ "fatih/vim-go",        build = ":GoUpdateBinaries" },
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
		config = {
			flavour = "auto",
			integrations = {
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
}
