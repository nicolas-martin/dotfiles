-- lua/plugins.lua
return {
	-- Package manager
	{ "folke/lazy.nvim", version = "*" },

	-- Go development plugin
	{ "fatih/vim-go",    build = ":GoUpdateBinaries" },

	-- Treesitter configurations and abstraction layer
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = { enable = true },
				-- Add other configurations here
			})
		end,
	},

	-- LSP configurations
	{ "neovim/nvim-lspconfig" },

	-- LSP signature hint when you type
	{
		"ray-x/lsp_signature.nvim",
		config = function()
			require("lsp_signature").setup()
		end,
	},

	-- VSCode-like pictograms for neovim lsp completion items
	{ "onsails/lspkind.nvim" },

	-- Fuzzy finder
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = "Telescope",
		config = function()
			require("telescope").setup()
		end,
	},
}
