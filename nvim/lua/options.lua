vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.clipboard = "unnamedplus"
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.showmatch = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.completeopt = { 'menuone' }
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Disable built-in plugins
-- are these needed?
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
-- test

-- avante
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3

-- folding - treesitter folding with region-folding plugin support
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
vim.opt.termguicolors = true
-- vim.cmd.colorscheme "catppuccin-macchiato"
vim.cmd.colorscheme "catppuccin-latte"

-- looks for editorconfig shit... idk
vim.g.editorconfig = false

-- Configure diagnostics with custom signs
vim.diagnostic.config({
	virtual_text = true,
	active = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚",
			[vim.diagnostic.severity.WARN] = "󰀪",
			[vim.diagnostic.severity.INFO] = "󰋽",
			[vim.diagnostic.severity.HINT] = "󰌶",
		},
		texthl = {
			[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
			[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
			[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
			[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
		},
	},
	underline = true,
	update_in_insert = false,
})
