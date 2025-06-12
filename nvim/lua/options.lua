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

-- folding
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldminlines = 3 -- Minimum lines needed for a fold

-- vim go because it's old
-- Disable vim-go LSP features in favor of native LSP
vim.g.go_doc_keywordprg_enabled = 0
vim.g.go_def_mapping_enabled = 0
vim.g.go_gopls_enabled = 0           -- Disable vim-go gopls
vim.g.go_code_completion_enabled = 0 -- Disable vim-go code completion
vim.g.go_hover_enabled = 0           -- Disable vim-go hover
vim.g.go_implements_enabled = 0      -- Disable vim-go implements
vim.g.go_rename_command = 0          -- Disable vim-go rename
vim.g.go_textobj_enabled = 0         -- Disable vim-go text objects

-- colorscheme catppuccin " catppuccin-latte, catppuccin-frappe, catppuccin-macchiato, catppuccin-mocha
vim.opt.termguicolors = true
-- vim.cmd.colorscheme "catppuccin-macchiato"
vim.cmd.colorscheme "catppuccin-latte"

-- looks for editorconfig shit... idk
vim.g.editorconfig = false

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function()
		vim.diagnostic.config({
			-- only override the gutter icons:
			signs            = {
				text   = {
					[vim.diagnostic.severity.ERROR] = "✘",
					[vim.diagnostic.severity.WARN]  = "▲",
					[vim.diagnostic.severity.INFO]  = "",
					[vim.diagnostic.severity.HINT]  = "⚑",
				},
				-- you can omit linehl or numhl if you don’t need them:
				linehl = nil,
				numhl  = nil,
			},
			virtual_text     = true,
			underline        = true,
			update_in_insert = false,
		})
	end
})
vim.g.diagnostic_signs = {
	[vim.diagnostic.severity.ERROR] = { text = "✘", texthl = "DiagnosticSignError" },
	[vim.diagnostic.severity.WARN]  = { text = "▲", texthl = "DiagnosticSignWarn" },
	[vim.diagnostic.severity.INFO]  = { text = "", texthl = "DiagnosticSignInfo" },
	[vim.diagnostic.severity.HINT]  = { text = "⚑", texthl = "DiagnosticSignHint" },
}
vim.diagnostic.config({
	virtual_text = true,
	-- virtual_lines = true,
	signs = true
})
