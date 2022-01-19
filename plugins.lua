return require('packer').startup(function()
	use 'wbthomason/packer.nvim'
	use 'preservim/nerdtree'
	-- use 'nvim-treesitter/nvim-treesitter'
	use 'tpope/vim-repeat'
	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'
	use {'npxbr/gruvbox.nvim', requires = {'rktjmp/lush.nvim'}}
	use 'fatih/vim-go'
	use 'nvim-treesitter/nvim-treesitter'
	-- Collection of common configurations for the Nvim LSP client
	use 'neovim/nvim-lspconfig'

	-- Completion framework
	use 'hrsh7th/nvim-cmp'

	-- LSP completion source for nvim-cmp
	use 'hrsh7th/cmp-nvim-lsp'

	-- Snippet completion source for nvim-cmp
	use 'hrsh7th/cmp-vsnip'

	-- Other usefull completion sources
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-buffer'

	-- See hrsh7th's other useins for more completion sources!
	use 'hrsh7th/cmp-cmdline'

	-- To enable more of the features of rust-analyzer, such as inlay hints and more!
	use 'simrat39/rust-tools.nvim'

	-- Snippet engine
	use 'hrsh7th/vim-vsnip'

	-- Fuzzy finder
	-- Optional
	use 'nvim-lua/popup.nvim'
	use 'nvim-lua/plenary.nvim'
	use 'nvim-telescope/telescope.nvim'
end)

