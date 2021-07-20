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
-- vim.g.gruvbox_contrast_dark = "hard"
-- vim.cmd("let g:gruvbox_colors = { 'dark0_hard': ['#000000', 0] }")
vim.o.background = "dark"
cmd [[colorscheme gruvbox]]
g.mapleader = ','

 require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    ultisnips = true;
  };
}  
-- ?
cmd [[ let g:python3_host_prog = '/Users/nmartin/.pyenv/versions/py3nvim/bin/python' ]]
-- capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = {
--     'documentation',
--     'detail',
--     'additionalTextEdits',
--   }
-- }

require'lspconfig'.gopls.setup{
  -- capabilities = capabilities,
}

vim.cmd([[
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
]])

-- ?
local default_opts = { noremap = true, silent = true, expr = true }
vim.api.nvim_set_keymap('i', '<C-Space>', [[ compe#complete() ]], default_opts)
vim.api.nvim_set_keymap('i', '<CR>', 'compe#confirm(\'<CR>\')', default_opts)
vim.api.nvim_set_keymap('i', '<C-e>', 'compe#close(\'<C-e>\')', default_opts)
vim.api.nvim_set_keymap('i', '<C-f>', 'compe#scroll({ \'delta\': +4 })', default_opts)
vim.api.nvim_set_keymap('i', '<C-d>', 'compe#scroll({ \'delta\': -4 })', default_opts)

require('telescope').setup{
  defaults = { file_ignore_patterns = {"vendor", "go.sum", "go.mod"} }
}
map('n', '<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>')
map('n', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
map('n', '<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>')
map('n', '<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>')
map('n', '<leader>ft', '<cmd>lua require(\'telescope.builtin\').lsp_document_symbols()<cr>')

vim.cmd([[
  let g:go_highlight_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_function_calls = 1
  let g:go_highlight_operators = 1
]])

require'nvim-treesitter.configs'.setup {
    ensure_installed = {
      "javascript",
      "typescript",
      "tsx",
      "html",
      "css",
      "lua",
      "rust",
      "go",
      "python",
      "json",
    },
    highlight = {
        enable = false
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
  vim.o.completeopt = "menuone,noselect"
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
  opt.termguicolors=true
  -- opt.encoding = utf-8

cmd 'autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab signcolumn=yes'
cmd 'autocmd Filetype python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab  autoindent signcolumn=yes'
cmd 'autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2  expandtab signcolumn=yes'
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
  buf_set_keymap('n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  buf_set_keymap('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  buf_set_keymap('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  buf_set_keymap('n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
  buf_set_keymap("n", "<leader>f", "<cmd>lua vim.lsp.buf.formatting()<CR>", opts)

end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {"gopls"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
