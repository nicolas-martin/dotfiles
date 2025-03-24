local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- General mappings
map('n', '<leader>rc', '<cmd>source ~/.config/nvim/init.lua<CR>')
map('n', '<leader>n', ':noh<CR>')
map('n', '<f1>', 'o<Esc>')
map('n', 'Q', '<nop>')
map('n', ']q', ':cn<CR>')
map('n', '[q', ':cp<CR>')
map('n', '<leader>)', '<cmd>set nu! rnu!<CR>') -- toggle relativenumber and numbers
map('x', 'p', 'P')                             -- xnoremap p P

-- Telescope mappings
local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, { desc = ':(Telescope find files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
map('n', '<leader>ft', builtin.lsp_dynamic_workspace_symbols, { desc = '!!Telescope document symbols' })
map('n', '<leader>fT', builtin.lsp_dynamic_workspace_symbols, { desc = 'Telescope dynamic workspace symbols' })
map('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope diagnostics' })

-- Window navigation with higher priority to override NERDTree mappings
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
map('n', '<C-h>', '<C-w>h')

-- tab navigation
map('n', '<leader>1', '1gt')
map('n', '<leader>2', '2gt')
map('n', '<leader>3', '3gt')
map('n', '<leader>4', '4gt')
map('n', '<leader>5', '5gt')
map('n', '<leader>6', '6gt')
map('n', '<leader>7', '7gt')
map('n', '<leader>8', '8gt')
map('n', '<leader>9', '9gt')

-- NvimTree
map('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = "Toggle NvimTree" })
map('n', '<leader>l', ':NvimTreeFindFile<CR>', { desc = "Focus NvimTree" })

-- Folding keymaps
map('n', 'zf', 'za', { desc = 'Toggle fold under cursor' }) -- Easier toggle fold
map('n', '<leader>z', 'za', { desc = 'Toggle fold under cursor' })
map('n', '<leader>Z', 'zR', { desc = 'Open all folds' })
map('n', '<leader>zz', 'zM', { desc = 'Close all folds' })
map('n', 'zC', 'zM', { desc = 'Close all folds' })
map('n', 'zO', 'zR', { desc = 'Open all folds' })

-- Code companion
map('n', '<leader>cc', ':CodeCompanionChat<cr>')
