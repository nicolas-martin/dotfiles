
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

	-- Completion framework
	use 'hrsh7th/nvim-cmp'

	-- LSP completion source for nvim-cmp
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-nvim-lsp-signature-help'
	-- add the nice source + completion item kind to the menu
	use "onsails/lspkind-nvim"

	-- Snippet completion source for nvim-cmp
	-- failed to download?
	-- use 'hrsh7th/cmp-vsnip'
	use 'SirVer/ultisnips'
	use 'quangnguyen30192/cmp-nvim-ultisnips'

	-- Other usefull completion sources
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-buffer'
	-- See hrsh7th's other useins for more completion sources!
	use 'hrsh7th/cmp-cmdline'

	-- nice icons
	use 'kyazdani42/nvim-web-devicons'
	use 'lewis6991/gitsigns.nvim'

	-- Fuzzy finder
	-- Optional
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
	use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

end)


