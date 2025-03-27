-- lua/plugins.lua
return {
	-- Go development plugin
	{ "fatih/vim-go",        build = ":GoUpdateBinaries" },

	-- VSCode-like pictograms for neovim lsp completion items
	{ "onsails/lspkind.nvim" },
}
