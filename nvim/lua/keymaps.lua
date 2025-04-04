local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.keymap.set(mode, lhs, rhs, options)
end

-- General mappings
map('n', '<leader>n', ':noh<CR>', { desc = "Hide search highlight text" })
map('n', '<f1>', 'o<Esc>', { desc = "Add a line abaove" })
map('n', 'Q', '<nop>', { desc = "Remove the annoying Q" })
map('n', '[q', vim.cmd.cprev, { desc = 'Previous Quickfix' })
map('n', ']q', vim.cmd.cnext, { desc = 'Next Quickfix' })
map('n', '<leader>)', '<cmd>set rnu!<CR>', { desc = "toggle relativenumber and numbers" })
map('x', 'p', 'P', { desc = "xnoremap p P" })

-- Telescope mappings
local builtin = require('telescope.builtin')
map('n', '<leader>fmp', builtin.man_pages, { desc = 'Telescope man pages' })
map('n', '<leader>fG', builtin.git_status, { desc = 'Telescope git status' })
map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
map('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
map('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
map('n', '<leader>ft', builtin.lsp_document_symbols, { desc = 'Telescope document symbols' })
map('n', '<leader>fT', builtin.lsp_dynamic_workspace_symbols, { desc = 'Telescope dynamic workspace symbols' })
map('n', '<leader>fd', builtin.diagnostics, { desc = 'Telescope diagnostics' })

map('n', '<C-j>', '<C-w>j', { desc = 'Move down' })
map('n', '<C-k>', '<C-w>k', { desc = 'Move up' })
map('n', '<C-l>', '<C-w>l', { desc = 'Move right' })
map('n', '<C-h>', '<C-w>h', { desc = 'Move left' })

-- tab navigation
map('n', '<leader>1', '1gt', { desc = 'Switch to 1st tab' })
map('n', '<leader>2', '2gt', { desc = 'Switch to 2nd tab' })
map('n', '<leader>3', '3gt', { desc = 'Switch to 3rd dab' })
map('n', '<leader>4', '4gt', { desc = 'Switch to 4th tab' })
map('n', '<leader>5', '5gt', { desc = 'Switch to 5th tab' })
map('n', '<leader>6', '6gt', { desc = 'Switch to 6th tab' })
map('n', '<leader>7', '7gt', { desc = 'Switch to 7th tab' })
map('n', '<leader>8', '8gt', { desc = 'Switch to 8th tab' })
map('n', '<leader>9', '9gt', { desc = 'Switch to 9th tab' })

-- Folding keymaps
map('n', 'zf', 'za', { desc = 'Toggle fold under cursor' })
map('n', '<leader>z', 'za', { desc = 'Toggle fold under cursor' })
map('n', '<leader>Z', 'zR', { desc = 'Open all folds' })
map('n', '<leader>zz', 'zM', { desc = 'Close all folds' })
map('n', 'zC', 'zM', { desc = 'Close all folds' })
map('n', 'zO', 'zR', { desc = 'Open all folds' })

-- Move Lines
-- work around to using <alt-j/k>
map("n", "∆", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "˚", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "∆", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "˚", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "∆", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "˚", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- better indenting
-- map("v", "<", "<gv", { desc = "better indenting? <gv" })
-- map("v", ">", ">gv", { desc = "better indenting? >gv" })

map('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = "Toggle NvimTree" })
map('n', '<leader>l', ':NvimTreeFindFile<CR>', { desc = "Focus NvimTree" })

-- save
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })
-- quit
map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit All" })

map("i", "<C-n>", "<nop>", { desc = "disable the built in cmp menu thing" })
map("i", "<C-p>", "<nop>", { desc = "disable the built in cmp menu thing" })
