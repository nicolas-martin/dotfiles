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

	-- VSCode-like pictograms for neovim lsp completion items
	{ "onsails/lspkind.nvim" },
}
