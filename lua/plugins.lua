return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'preservim/nerdtree'
	use 'tpope/vim-repeat'
	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'
	-- use 'ellisonleao/gruvbox.nvim'
	use 'EdenEast/nightfox.nvim'
	use 'fatih/vim-go' -- vim-go doesn't need Lua setup
	use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }

	-- Collection of common configurations for the Nvim LSP client
	use 'neovim/nvim-lspconfig'

	-- LSP completion source for nvim-cmp
	use {
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup()
		end
	}
	-- add the nice source + completion item kind to the menu
	use {
		'onsails/lspkind.nvim',
		-- config = function()
		-- 	require('lspkind').init()
		-- end
	}

	-- Autocompletion framework
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/nvim-cmp")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-buffer")

	-- Snippets
	use("L3MON4D3/LuaSnip")
	use("rafamadriz/friendly-snippets")

	-- use 'hrsh7th/cmp-cmdline'

	-- nice icons
	use 'kyazdani42/nvim-web-devicons'

	-- Fuzzy finder
	use {
		'nvim-telescope/telescope.nvim',
		requires = { { 'nvim-lua/plenary.nvim' } }
	}
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

	use {
		"pmizio/typescript-tools.nvim",
		requires = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" }
	}
end)
