local default_opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- General mappings
map('n', '<leader>rc', ':source $MYVIMRC<CR>', default_opts)
map('n', '<leader>n', ':noh<CR>', default_opts)
map('n', '<leader>,', ':NERDTreeToggleFind<CR>', default_opts)

-- Telescope mappings
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', default_opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', default_opts)
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', default_opts)
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', default_opts)

-- Window navigation
map('n', '<C-j>', '<C-w>j', default_opts)
map('n', '<C-k>', '<C-w>k', default_opts)
map('n', '<C-l>', '<C-w>l', default_opts)
map('n', '<C-h>', '<C-w>h', default_opts)

-- NERDTree
map('n', '<C-n>', ':NERDTreeToggle<CR>', default_opts)
