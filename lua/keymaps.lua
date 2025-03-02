local default_opts = { noremap = true, silent = true }
local map = vim.keymap.set

-- General mappings
map('n', '<leader>rc', ':source $MYVIMRC<CR>', default_opts)
map('n', '<leader>n', ':noh<CR>', default_opts)
map('n', '<f1>', 'o<Esc>', default_opts)
map('n', 'Q', '<nop>', default_opts)
map('n', ']q', ':cn<CR>')                                    -- quickfix navigatio, default_optsn map('n', '[q', ':cp<CR>', default_opts)
map('n', '<leader>)', '<cmd>set nu! rnu!<CR>', default_opts) -- toggle relativenumber and numbers
map('x', 'p', 'P', default_opts)                             -- xnoremap p P

-- Telescope mappings
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', default_opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', default_opts)
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', default_opts)
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', default_opts)
map('n', '<leader>ft', '<cmd>Telescope lsp_document_symbols<cr>', default_opts)
map('n', '<leader>fT', '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>', default_opts)
map('n', '<leader>fd', '<cmd>Telescope diagnostics<CR>', default_opts)


-- Window navigation
map('n', '<C-j>', '<C-w>j', default_opts)
map('n', '<C-k>', '<C-w>k', default_opts)
map('n', '<C-l>', '<C-w>l', default_opts)
map('n', '<C-h>', '<C-w>h', default_opts)

-- tab navigation
map('n', '<leader>1', '1gt', default_opts)
map('n', '<leader>2', '2gt', default_opts)
map('n', '<leader>3', '3gt', default_opts)
map('n', '<leader>4', '4gt', default_opts)
map('n', '<leader>5', '5gt', default_opts)
map('n', '<leader>6', '6gt', default_opts)
map('n', '<leader>7', '7gt', default_opts)
map('n', '<leader>8', '8gt', default_opts)
map('n', '<leader>9', '9gt', default_opts)

-- NERDTree
map('n', '<C-n>', ':NERDTreeToggle<CR>', default_opts)
map('n', '<leader>l', ':NERDTreeFind<cr>', default_opts)

-- Folding keymaps
map('n', 'zf', 'za', { noremap = true, desc = 'Toggle fold under cursor' }) -- Easier toggle fold
map('n', '<leader>z', 'za', { noremap = true, desc = 'Toggle fold under cursor' })
map('n', '<leader>Z', 'zR', { noremap = true, desc = 'Open all folds' })
map('n', '<leader>zz', 'zM', { noremap = true, desc = 'Close all folds' })
map('n', 'zC', 'zM', { noremap = true, desc = 'Close all folds' })
map('n', 'zO', 'zR', { noremap = true, desc = 'Open all folds' })
