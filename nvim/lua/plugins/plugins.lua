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
				theme = "auto"
			}
		}
	},
	{
		"EdenEast/nightfox.nvim",
		enabled = false,
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme nightfox]])
		end
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = {
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
