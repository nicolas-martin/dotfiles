-- Treesitter configuration
require('nvim-treesitter.configs').setup {
	ensure_installed = {
		"lua",
		"vim",
		"typescript",
		"javascript",
		"go",
		"rust",
		"python",
		"json",
		"html",
		"css",
		"markdown",
		"yaml"
	},
	sync_install = false,     -- Install parsers synchronously (only applied to `ensure_installed`)
	auto_install = true,      -- Automatically install missing parsers when entering buffer
	ignore_install = {},      -- List of parsers to ignore installing (or "all")
	modules = {},             -- List of modules to ignore installing (or "all")

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
	fold = {
		enable = true,
	},
}
