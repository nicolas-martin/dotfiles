return {

  -- Essential editing plugins
  { "tpope/vim-repeat" },
  { "tpope/vim-surround" },
  { "tpope/vim-commentary" },

	-- File explorer
	{
		"preservim/nerdtree",
		init = function()
			-- Disable netrw completely
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			vim.g.loaded_netrwSettings = 1
			vim.g.loaded_netrwFileHandlers = 1

			-- Auto open NERDTree when opening a directory
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) > 0 then
						vim.cmd("NERDTree " .. vim.fn.argv(0))
					end
				end,
			})
		end,
		cmd = { "NERDTree", "NERDTreeToggle", "NERDTreeFind" },
	},
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