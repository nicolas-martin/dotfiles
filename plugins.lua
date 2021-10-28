return require('packer').startup(function()
  use 'preservim/nerdtree'
  use 'neovim/nvim-lspconfig'
  use {'nvim-treesitter/nvim-treesitter'}
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'wbthomason/packer.nvim'
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use 'fatih/vim-go'
  use {'npxbr/gruvbox.nvim', requires = {'rktjmp/lush.nvim'}}
  use {
  'nvim-telescope/telescope.nvim',
  requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
}
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'
end)

