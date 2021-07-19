return require('packer').startup(function()
  use "preservim/nerdtree"
  use "neovim/nvim-lspconfig"
  use "nvim-telescope/telescope.nvim"
  use "nvim-treesitter/nvim-treesitter"
  use "tpope/vim-repeat"
  use "tpope/vim-surround"
  use "tpope/vim-commentary"
  use 'wbthomason/packer.nvim'
end)

