-- General settings
vim.g.mapleader = ',' -- Set leader key

-- Folding settings
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99 -- Start with all folds open
vim.opt.foldenable = true   -- Enable folding
vim.opt.foldnestmax = 10    -- Maximum nesting of folds
vim.opt.foldminlines = 3    -- Minimum lines needed for a fold

vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.clipboard = "unnamedplus"
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.showmatch = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Colorscheme
vim.cmd [[colorscheme nordfox]]

-- Disable unused built-in plugins
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- avante
-- views can only be fully collapsed with the global statusline
vim.opt.laststatus = 3


-- vim go because it's old
-- Disable vim-go documentation lookup in favor of LSP
vim.g.go_doc_keywordprg_enabled = 0
