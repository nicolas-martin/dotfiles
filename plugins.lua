return require('packer').startup(function()
  use 'preservim/nerdtree'
  use 'neovim/nvim-lspconfig'
  use { 'nvim-treesitter/nvim-treesitter', branch = '0.5-compat', run = ':TSUpdate' }
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-commentary'
  use 'wbthomason/packer.nvim'
  use 'hrsh7th/nvim-compe'
  use 'SirVer/ultisnips'
  use 'honza/vim-snippets'
  use 'fatih/vim-go'
  use {'npxbr/gruvbox.nvim', requires = {'rktjmp/lush.nvim'}}
  use {
  'nvim-telescope/telescope.nvim',
  requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
}
end)

