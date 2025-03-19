return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'preservim/nerdtree'
	use 'tpope/vim-repeat'
	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'
	-- use 'ellisonleao/gruvbox.nvim'
	use 'EdenEast/nightfox.nvim'
	use 'fatih/vim-go'  -- vim-go doesn't need Lua setup
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
	-- to debug treesitter syntax
	use 'nvim-treesitter/playground'

	-- refactor
	use 'dyng/ctrlsf.vim'

	-- Collection of common configurations for the Nvim LSP client
	use 'neovim/nvim-lspconfig'

	-- LSP completion source for nvim-cmp
	-- use 'hrsh7th/cmp-nvim-lsp-signature-help'
	use 'ray-x/lsp_signature.nvim'
	-- add the nice source + completion item kind to the menu
	use {
		'onsails/lspkind.nvim',
		config = function()
			require('lspkind').init()
		end
	}

	-- Snippet completion source for nvim-cmp
	-- Autocompletion framework
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-buffer")

	-- Snippets
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")
	use("saadparwaiz1/cmp_luasnip")

	-- See hrsh7th's other useins for more completion sources!
	use 'hrsh7th/cmp-cmdline'

	-- nice icons
	use 'kyazdani42/nvim-web-devicons'

	-- Fuzzy finder
	-- Optional
	use 'nvim-lua/popup.nvim'
	use {
		'nvim-telescope/telescope.nvim',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }


	-- lua / plugin
	use 'folke/lua-dev.nvim'

	-- move syntax
	use 'rvmelkonian/move.vim'

	-- Copilot setup
	use {
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	}
	use {
		"zbirenbaum/copilot-cmp",
		after = { "copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end
	}

	-- avante / cursor ai
	use 'stevearc/dressing.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'MunifTanjim/nui.nvim'
	use({
		'MeanderingProgrammer/render-markdown.nvim',
		after = { 'nvim-treesitter' },
		requires = { 'nvim-tree/nvim-web-devicons', opt = true }, -- if you prefer nvim-web-devicons
	})
	use 'HakonHarnes/img-clip.nvim'

	-- Avante.nvim with build process
	use {
		'yetone/avante.nvim',
		branch = 'main',
		run = 'make',
		requires = {
			'nvim-treesitter/nvim-treesitter',
			'stevearc/dressing.nvim',
			'nvim-lua/plenary.nvim',
			'MeanderingProgrammer/render-markdown.nvim',
			'nvim-tree/nvim-web-devicons',
			'HakonHarnes/img-clip.nvim',
		},
		after = {
			'nvim-treesitter',
			'dressing.nvim',
			'render-markdown.nvim',
			'img-clip.nvim'
		},
		config = function()
			-- Load dependencies first
			require('render-markdown').setup({
				file_types = { "Avante" },
				inline_highlight = {
					enabled = false,
				},
			})
			require('img-clip').setup()
			require('dressing').setup()

			-- Then load Avante config
			require('avante_config')
		end
	}

	use {
		"pmizio/typescript-tools.nvim",
		requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" }
	}

	use {
		"simrat39/rust-tools.nvim",
		config = function()
			require('rust-tools').setup()
		end
	}

	use {
		"folke/neodev.nvim",
		config = function()
			require('neodev').setup()
		end
	}
end)
