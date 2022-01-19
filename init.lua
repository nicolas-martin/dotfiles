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

-- Setup nvim-cmp.
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    -- Add tab support
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },

  -- Installed sources
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' },
    { name = 'path' },
    { name = 'buffer' },
  },
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline('/', {
	sources = {
		{ name = 'buffer' }
	}
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(':', {
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

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

map('n', '<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>')
map('n', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
map('n', '<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>')
map('n', '<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>')
map('n', '<leader>ft', '<cmd>lua require(\'telescope.builtin\').lsp_document_symbols()<cr>')


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
  -- opt.foldexpr="nvim_treesitter#foldexpr()"

cmd 'autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab signcolumn=yes'
cmd 'autocmd Filetype rust setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab signcolumn=yes'
cmd 'autocmd Filetype ts setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab signcolumn=yes'
cmd 'autocmd Filetype python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab  autoindent signcolumn=yes'
cmd 'autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2  noexpandtab signcolumn=yes'
cmd 'autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab  autoindent'
cmd 'autocmd Filetype typescriptreact setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab  autoindent'
cmd 'autocmd Filetype proto setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab'
cmd 'autocmd Filetype lua setlocal tabstop=2 shiftwidth=2 softtabstop=2  noexpandtab signcolumn=yes'
cmd 'autocmd Filetype motoko setlocal tabstop=2 shiftwidth=2 softtabstop=2  noexpandtab signcolumn=yes'

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
}

local configs = require 'lspconfig.configs'
local util = require 'lspconfig/util'


configs.motoko = {
  default_config = {
    cmd = {"dfx", "_language-service", "nft"},
    filetypes = { "motoko", "mo", "gdmo"},
    root_dir = function(fname)
      return util.root_pattern '*.mo'(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
    end,
  },
  docs = {
    description = [[]],
    default_config = {
      root_dir = [[root_pattern("dfx.json", ".git")]],
    },
  },
}
require('lspconfig').motoko.setup{}

local opts = {
    tools = {
        autoSetHints = true,
        hover_with_actions = true,
        runnables = {
            use_telescope = true
        },
        inlay_hints = {
            show_parameter_hints = false,
            parameter_hints_prefix = "",
            other_hints_prefix = "",
        },
    },

    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {
        -- on_attach is a callback called when the language server attachs to the buffer
        -- on_attach = on_attach,
        settings = {
            -- to enable rust-analyzer settings visit:
            -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
            ["rust-analyzer"] = {
                -- enable clippy on save
                checkOnSave = {
                    command = "clippy"
                },
            }
        }
    },
}

require('rust-tools').setup(opts)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {"gopls", "tsserver", "motoko", "rust_analyzer"}
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end
