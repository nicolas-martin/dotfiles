return require('packer').startup(function()
  use 'preservim/nerdtree'
  use 'neovim/nvim-lspconfig'
  use 'nvim-treesitter/nvim-treesitter'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'wbthomason/packer.nvim'
  use 'fatih/vim-go'
  use {'npxbr/gruvbox.nvim', requires = {'rktjmp/lush.nvim'}}
  use {
  'nvim-telescope/telescope.nvim',
  requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
}
end)

