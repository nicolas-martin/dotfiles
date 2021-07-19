local cmd = vim.cmd -- to execute Vim commands e.g. cmd('pwd')
local fn = vim.fn -- to call Vim functions e.g. fn.bufnr()
local g = vim.g -- a table to access global variables
local opt = vim.opt -- to set options

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
require('plugins')

g.mapleader = ","

require'lspconfig'.gopls.setup{
    on_attach=on_attach,
    cmd = {"gopls", "serve"},
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
}

require('telescope').setup{}
map('n', '<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>')
map('<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
map('<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>')
map('<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>')

require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true
    },
}

  map('n', '<C-n>', ':NERDTreeToggle<CR>') 
  map('n', '<leader>l', ':NERDTreeFind<cr>')
  map('n', '<leader>1', '1gt')
  map('n', '<leader>2', '2gt')
  map('n', '<leader>3', '3gt')
  map('n', '<leader>4', '4gt')
  map('n', '<leader>5', '5gt')
  map('n', '<leader>6', '6gt')
  map('n', '<leader>7', '7gt')
  map('n', '<leader>8', '8gt')
  map('n', '<leader>9', '9gt')
map('n', '<f1>', 'o<Esc>')
map('n', '<leader>n', ':noh<CR>')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
map('n', '<C-h>', '<C-w>h')
-- get rid of the evil ex mode
map('n', 'Q', '<nop>')

-- Default settings
  opt.cmdheight = 2
  opt.expandtab = true                -- tabs are tabs vs expandtab tabs are space
  opt.showcmd = true                     -- show command in bottom bar
  opt.lazyredraw = true                  -- redraw only when we need to.
  opt.showmatch = true                 -- highlight matching [{()}]
  opt.incsearch = true                   -- search as characters are entered
  opt.hlsearch = true                    -- highlight matches
  -- opt.noshowmode = true                  -- don't show modes (use airline instead)"
  opt.relativenumber = true
  opt.autowrite = true
  -- opt.clipboard = unnamedplus
  opt.scrolloff = 5                 -- Keep some distance from the bottom
  opt.sidescrolloff = 5             -- Keep some distance while side scrolling
  opt.backup = false                    -- No backup file
  opt.swapfile = false                  -- NOTE: Experimental No swap file
  opt.writebackup = false
  -- opt.foldmethod = syntax           -- Code folding
  opt.foldlevelstart = 20           -- Opens X amount of fold at the start - Can't use nofoldenable
  -- opt.splitright = true                  -- Split window appears right the current one.
  opt.autoread = true                    -- Auto reloads the file when modifications were made
  opt.ignorecase = true
  -- opt.encoding = utf-8

cmd 'autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab'
cmd 'autocmd Filetype python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab  autoindent'
cmd 'autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2  expandtab'
cmd 'autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab  autoindent'
cmd 'autocmd Filetype typescriptreact setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab  autoindent'
cmd 'autocmd Filetype proto setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab'
 

local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<space>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<space>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {"gopls", "pyright", "rust_analyzer", "tsserver" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
