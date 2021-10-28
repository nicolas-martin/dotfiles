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

  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
        -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
      end,
    },
    mapping = {
      ['<C-d>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- If you want to remove the default `<C-y>` mapping, You can specify `cmp.config.disable` value.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { nme = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })
-- The nvim-cmp almost supports LSP's capabilities so You should advertise it to LSP servers..
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- -- Why do I need this for ultisnips?
-- vim.cmd([[
-- let g:UltiSnipsExpandTrigger="<tab>"
-- let g:UltiSnipsJumpForwardTrigger="<c-b>"
-- let g:UltiSnipsJumpBackwardTrigger="<c-z>"
-- ]])
-- cmd [[ let g:python3_host_prog = '/Users/nmartin/.pyenv/versions/py3nvim/bin/python' ]]
-- capabilities = vim.lsp.protocol.make_client_capabilities()
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- capabilities.textDocument.completion.completionItem.resolveSupport = {
--   properties = {
--     'documentation',
--     'detail',
--     'additionalTextEdits',
--   }
-- }


-- go imports on save
function goimports(timeout_ms)
  local context = { only = { "source.organizeImports" } }
  vim.validate { context = { context, "t", true } }

  local params = vim.lsp.util.make_range_params()
  params.context = context

  -- See the implementation of the textDocument/codeAction callback
  -- (lua/vim/lsp/handler.lua) for how to do this properly.
  local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  if not result or next(result) == nil then return end
  local actions = result[1].result
  if not actions then return end
  local action = actions[1]

  -- textDocument/codeAction can return either Command[] or CodeAction[]. If it
  -- is a CodeAction, it can have either an edit, a command or both. Edits
  -- should be executed first.
  if action.edit or type(action.command) == "table" then
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit)
    end
    if type(action.command) == "table" then
      vim.lsp.buf.execute_command(action.command)
    end
  else
    vim.lsp.buf.execute_command(action)
  end
end

cmd [[ autocmd BufWritePre *.go lua goimports(1000) ]]

local nvim_lsp = require('lspconfig')

nvim_lsp.diagnosticls.setup {
  on_attach = on_attach,
  filetypes = { 'javascript', 'javascriptreact', 'json', 'typescript', 'typescriptreact', 'css', 'less', 'scss', 'markdown', 'pandoc' },
  init_options = {
    linters = {
      eslint = {
        command = 'eslint_d',
        rootPatterns = { '.git' },
        debounce = 100,
        args = { '--stdin', '--stdin-filename', '%filepath', '--format', 'json' },
        sourceName = 'eslint_d',
        parseJson = {
          errorsRoot = '[0].messages',
          line = 'line',
          column = 'column',
          endLine = 'endLine',
          endColumn = 'endColumn',
          message = '[eslint] ${message} [${ruleId}]',
          security = 'severity'
        },
        securities = {
          [2] = 'error',
          [1] = 'warning'
        }
      },
    },
    filetypes = {
      javascript = 'eslint',
      javascriptreact = 'eslint',
      typescript = 'eslint',
      typescriptreact = 'eslint',
    },
    formatters = {
      eslint_d = {
        command = 'eslint_d',
        args = { '--stdin', '--stdin-filename', '%filename', '--fix-to-stdout' },
        rootPatterns = { '.git' },
      },
      prettier = {
        command = 'prettier',
        args = { '--stdin-filepath', '%filename' }
      }
    },
    formatFiletypes = {
      css = 'prettier',
      javascript = 'eslint_d',
      javascriptreact = 'eslint_d',
      json = 'prettier',
      scss = 'prettier',
      less = 'prettier',
      typescript = 'eslint_d',
      typescriptreact = 'eslint_d',
      json = 'prettier',
      markdown = 'prettier',
    }
  }
}
nvim_lsp.tsserver.setup {}
nvim_lsp.gopls.setup{
  cmd = {"gopls", "serve"},
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
    },
  },
  capabilities = capabilities,
}

vim.cmd([[
  let g:go_highlight_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_function_calls = 1
  let g:go_highlight_operators = 1
  let g:go_metalinter_command = "staticcheck"
  let g:go_gopls_enabled = 0
]])
  -- let g:go_fmt_command = "goimports"

map('n', '<leader>w', ':GoMetaLinter<CR>')
map('n', '<leader>r', ':GoRun<CR>')


vim.cmd([[autocmd BufNewFile,BufRead *.mo set filetype=swift]])

-- test fix for tmux+nvim
vim.cmd([[ autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID" ]])


-- local default_opts = { noremap = true, silent = true, expr = true }

require('telescope').setup{
  defaults = { 
    file_ignore_patterns = {"vendor", "go.sum", "go.mod", "module", ".git"},
    mappings = {
      i = {
        ["<C-n>"] = false,
        ["<C-p>"] = false,
        ["<esc>"] = require('telescope.actions').close,
        ["<C-[>"] = require('telescope.actions').close,
        ["<C-j>"] = require('telescope.actions').move_selection_next, 
        ["<C-k>"] = require('telescope.actions').move_selection_previous,
      },
    }
  }
}

map('n', '<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>')
map('n', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
map('n', '<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>')
map('n', '<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>')
map('n', '<leader>ft', '<cmd>lua require(\'telescope.builtin\').lsp_document_symbols()<cr>')


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
  opt.clipboard = "unnamedplus"
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
  opt.foldmethod="expr"
  opt.foldexpr="nvim_treesitter#foldexpr()"

cmd 'autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab signcolumn=yes'
cmd 'autocmd Filetype ts setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab signcolumn=yes'
cmd 'autocmd Filetype python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab  autoindent signcolumn=yes'
cmd 'autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2  expandtab signcolumn=yes'
cmd 'autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab  autoindent'
cmd 'autocmd Filetype typescriptreact setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab  autoindent'
cmd 'autocmd Filetype proto setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab'
cmd 'autocmd Filetype lua setlocal tabstop=2 shiftwidth=2 softtabstop=2  expandtab signcolumn=yes'
 


-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer

local on_attach = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  -- buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

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

nvim_lsp.motoko.setup{
  cmd = {"dfx", "_language-service"},
  filetypes = { "motoko", "mo"},
  root_dir = root_pattern("dfx.json", ".git"),
  settings = {},
  capabilities = capabilities,
}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {"gopls", "tsserver", "motoko"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
