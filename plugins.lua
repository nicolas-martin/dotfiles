
return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'preservim/nerdtree'
	use 'tpope/vim-repeat'
	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'
	use 'ellisonleao/gruvbox.nvim'
	use 'fatih/vim-go'
	use 'nvim-treesitter/nvim-treesitter'
	-- to debug treesitter syntax
	use 'nvim-treesitter/playground'

	-- refactor
  use 'dyng/ctrlsf.vim'

	-- Collection of common configurations for the Nvim LSP client
	use 'neovim/nvim-lspconfig'

	-- LSP completion source for nvim-cmp
	use 'hrsh7th/cmp-nvim-lsp-signature-help'
	-- add the nice source + completion item kind to the menu
	use "onsails/lspkind-nvim"

	-- Snippet completion source for nvim-cmp
  -- Autocompletion framework
  use("hrsh7th/nvim-cmp")
  use({
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-vsnip",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-buffer",
    after = { "hrsh7th/nvim-cmp" },
    requires = { "hrsh7th/nvim-cmp" },
  })
  -- See hrsh7th other plugins for more great completion sources!
  -- Snippet engine
  use('hrsh7th/vim-vsnip')
	use 'SirVer/ultisnips'
	use 'quangnguyen30192/cmp-nvim-ultisnips'

	-- See hrsh7th's other useins for more completion sources!
	use 'hrsh7th/cmp-cmdline'

	-- nice icons
	use 'kyazdani42/nvim-web-devicons'

	-- Fuzzy finder
	-- Optional
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

	use("simrat39/rust-tools.nvim")

end)


