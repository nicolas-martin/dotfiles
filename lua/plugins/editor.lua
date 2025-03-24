return {
  -- File explorer
  {
    "preservim/nerdtree",
    keys = {
      { "<leader>e", ":NERDTreeToggle<CR>", desc = "Toggle NERDTree" },
    },
  },

  -- Essential editing plugins
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  { "tpope/vim-commentary" },

  -- Git integration
  {
    "tpope/vim-fugitive",
    cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" },
  },

  -- Status line
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "kyazdani42/nvim-web-devicons" },
    event = "VeryLazy",
    opts = {
      options = { theme = "auto" },
    },
  },

  -- Colorschemes
  {
    "EdenEast/nightfox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme nightfox]])
    end,
  },
} 