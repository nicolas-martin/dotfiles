
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.clipboard = "unnamedplus"
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.showmatch = true
vim.opt.relativenumber = true
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true

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
-- Disable vim-go LSP features in favor of native LSP
vim.g.go_doc_keywordprg_enabled = 0
vim.g.go_def_mapping_enabled = 0
vim.g.go_gopls_enabled = 0           -- Disable vim-go gopls
vim.g.go_code_completion_enabled = 0 -- Disable vim-go code completion
vim.g.go_hover_enabled = 0           -- Disable vim-go hover
vim.g.go_implements_enabled = 0      -- Disable vim-go implements
vim.g.go_rename_command = 0          -- Disable vim-go rename
vim.g.go_textobj_enabled = 0         -- Disable vim-go text objects
