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
vim.o.background = "dark"
cmd [[colorscheme gruvbox]]
g.mapleader = ','

local nvim_lsp = require('lspconfig')

-- Setup nvim-cmp.
local luasnip = require'luasnip'
local cmp = require'cmp'
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	formatting = {
		fields = { 'kind', 'abbr', 'menu' }, -- change the order so the icon appear first
			-- Show where the completion opts are coming from
			format = require("lspkind").cmp_format({
					option = 'default',
					mode = 'symbol',
					maxwidth = 50,
					ellipsis_char = '...',
					with_text = true,
					menu = {
							nvim_lsp = "[LSP]",
							luasnip = "[snip]",
							nvim_lua = "[nvim]",
							path = "[path]",
							buffer = "[buffer]",
							nvim_lsp_signature_help = "[param]",
					},
			}),
	},
	experimental = {
		-- I like the new menu better(?)
		native_menu = false,
	},
	-- autocomplete
	snippet = {
		expand = function(args)
        luasnip.lsp_expand(args.body)
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = {
		['<C-p>'] = cmp.mapping.select_prev_item(),
		['<C-n>'] = cmp.mapping.select_next_item(),
		-- Add tab support
		-- ['<S-Tab>'] = cmp.mapping.select_prev_item(),
		-- ['<Tab>'] = cmp.mapping.select_next_item(),
		['<C-d>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.close(),
		['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
	},
	-- Installed sources
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'luasnip' },
		{ name = 'path' },
		{ name = 'buffer', keyword_length = 3 },
		{ name = 'nvim_lsp_signature_help' },
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
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

vim.cmd([[
	let g:go_highlight_types = 1
	let g:go_highlight_fields = 1
	let g:go_highlight_functions = 1
	let g:go_highlight_function_calls = 1
	let g:go_highlight_operators = 1
	let g:python3_host_prog = '/usr/local/bin/python3'	
]])

-- let g:go_metalinter_command = 'golangci-lint'

map('n', '<leader>w', ':GoMetaLinter<CR>')
map('n', '<leader>r', ':GoRun<CR>')

-- test fix for tmux+nvim
-- vim.cmd([[ autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID" ]])

-- local default_opts = { noremap = true, silent = true, expr = true }

require('telescope').setup{
	extensions = {
		fzf = {
			fuzzy = true,										 -- false will only do exact matching
			override_generic_sorter = true,  -- override the generic sorter
			override_file_sorter = true,		 -- override the file sorter
			case_mode = "smart_case",				 -- or "ignore_case" or "respect_case"
																			 -- the default case_mode is "smart_case"
		}
	},
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
				["<leader>q"] = require('telescope.actions').send_selected_to_qflist + require('telescope.actions').open_qflist,
			},
		}
	}
}
require('telescope').load_extension('fzf')

require'nvim-treesitter.configs'.setup {
	ensure_installed = {"javascript", "typescript", "tsx", "html", "css", "lua", "rust", "go", "python", "json", "ruby"},
	highlight = {
			enable = false
	},
	playground = { enable = true },
	query_linter = {
		enable = true,
		use_virtual_text = true,
		lint_events = { "BufWrite", "CursorHold" },
	},
}
vim.keymap.set({ "i", "s" }, "<C-k>", function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    end
end, { silent = true })
vim.keymap.set({ "i", "s" }, "<C-j>", function()
    if luasnip.jumpable( -1) then
        luasnip.jump( -1)
    end
end, { silent = true })

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
map('n', 'Q', '<nop>')
map('n', ']q', ':cn<CR>') -- quickfix navigation
map('n', '[q', ':cp<CR>')
map('n', '<leader>)', '<cmd>set nu! rnu!<CR>') -- toggle relativenumber and numbers
map('x', 'p', 'P') -- xnoremap p P



-- Default settings
vim.opt.mouse = ""
vim.opt.cmdheight = 2
vim.opt.expandtab = true								-- tabs are tabs vs expandtab tabs are space
vim.opt.showcmd = true										 -- show command in bottom bar
vim.opt.lazyredraw = true									 -- redraw only when we need to.
vim.opt.showmatch = true								 -- highlight matching [{()}]
vim.opt.incsearch = true									 -- search as characters are entered
vim.opt.hlsearch = true										 -- highlight matches
vim.opt.relativenumber = true
vim.opt.autowrite = true
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 5									-- Keep some distance from the bottom
vim.opt.sidescrolloff = 5							-- Keep some distance while side scrolling
vim.opt.backup = false										-- No backup file
vim.opt.swapfile = false									-- NOTE: Experimental No swap file
vim.opt.writebackup = false
vim.opt.foldlevelstart = 20						-- Opens X amount of fold at the start - Can't use nofoldenable
	-- opt.splitright = true									-- Split window appears right the current one.
	opt.autoread = true										 -- Auto reloads the file when modifications were made
	opt.ignorecase = true
	opt.termguicolors=true
	opt.foldmethod="expr"
	opt.foldexpr="nvim_treesitter#foldexpr()"
	vim.o.completeopt = "menuone,noinsert,noselect"
	vim.opt.shortmess = vim.opt.shortmess + "c"

cmd 'autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab signcolumn=yes'
cmd 'autocmd Filetype rust setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab signcolumn=yes'
-- cmd 'autocmd Filetype rust setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab signcolumn=yes'
cmd 'autocmd Filetype ts setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab signcolumn=yes'
cmd 'autocmd Filetype python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab	autoindent signcolumn=yes'
cmd 'autocmd Filetype yaml setlocal tabstop=4 shiftwidth=4 softtabstop=4	expandtab signcolumn=yes'
cmd 'autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab	autoindent'
cmd 'autocmd Filetype typescriptreact setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab  autoindent'
cmd 'autocmd Filetype proto setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab'
cmd 'autocmd Filetype lua setlocal tabstop=2 shiftwidth=2 softtabstop=2  noexpandtab signcolumn=yes'

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
	buf_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.get()<CR>', opts)
	buf_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
	buf_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
	buf_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.set_loclist()<CR>', opts)
	buf_set_keymap("n", "<leader>f", "<cmd>lua vim.buf.formatting()<CR>", opts)
	-- toggle line number for pairing

end

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
local opts = {
  tools = {
    runnables = {
      use_telescope = true,
    },
    inlay_hints = {
      auto = true,
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
    on_attach = on_attach,
	  capabilities = capabilities,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
}

require("rust-tools").setup(opts)

nvim_lsp.bufls.setup{
	on_attach = on_attach,
	capabilities = capabilities,
}

nvim_lsp.solargraph.setup{
	on_attach = on_attach,
	capabilities = capabilities,
}

nvim_lsp.tsserver.setup{
	on_attach = on_attach,
	capabilities = capabilities,
}

nvim_lsp.lua_ls.setup{
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
			completion = {
        callSnippet = "Replace"
      },
			runtime = {
				-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
				version = 'LuaJIT',
			},
			diagnostics = {
				disable = {"lowercase-global"},
				-- Get the language server to recognize the `vim` global
				globals = {'vim'},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = vim.api.nvim_get_runtime_file("", true),
			},
			-- Do not send telemetry data containing a randomized but unique identifier
			telemetry = {
				enable = false,
			},
		},
	},
}

nvim_lsp.gopls.setup{
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		gopls = {
			analyses = {
				unusedparams = true,
				nilness = true,
			},
			staticcheck = true,
		},
	},
	flags = {
		debounce_text_changes = 150,
	},
}
