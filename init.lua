require('plugins')
-- require('/Users/nma/dev/dotfiles/mapping')

vim.g.mapleader = ','
vim.g.font='JetBrainsMonoNL Nerd Font'
vim.opt.foldmethod="expr"
vim.opt.foldexpr="nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart=99
vim.opt.scrolloff = 5 -- Keep some distance from the bottom
vim.opt.sidescrolloff=5 -- Keep some distance while side scrolling
vim.opt.clipboard = "unnamedplus"
vim.opt.incsearch = true -- search as characters are entered
vim.opt.hlsearch = true -- highlight matches
vim.opt.showmatch = true -- highlight matching [{()}]
vim.opt.relativenumber = true
vim.opt.expandtab = true -- tabs are tabs vs expandtab tabs are spacc
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' } -- Completion options
vim.opt.writebackup = false
vim.opt.swapfile = false -- NOTE: Experimental No swap file
vim.opt.ignorecase = true
vim.opt.filetype = 'on' -- Enable filetype detection
-- vim.opt.signcolumn = 'yes' -- Always show sign column
vim.opt.smartcase = true -- Ignore case if all lowercase  
vim.cmd [[colorscheme gruvbox]]

vim.cmd 'autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab signcolumn=yes'
vim.cmd 'autocmd Filetype rust setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab signcolumn'
vim.cmd 'autocmd Filetype ts setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab signcolumn'
vim.cmd 'autocmd Filetype python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab	autoindent signcolumn'
vim.cmd 'autocmd Filetype yaml setlocal tabstop=4 shiftwidth=4 softtabstop=4	expandtab signcolumn'
vim.cmd 'autocmd Filetype javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 noexpandtab signcolumn'
vim.cmd 'autocmd Filetype typescriptreact setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab signcolumn'
vim.cmd 'autocmd Filetype proto setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab signcolumn'
vim.cmd 'autocmd Filetype lua setlocal tabstop=2 shiftwidth=2 softtabstop=2  noexpandtab'


local function map(mode, lhs, rhs, opts)
	local options = {noremap = true}
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map('n', '<leader>rc', ':source $MYVIMRC<CR>')
map('n', '<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>')
map('n', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
map('n', '<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>')
map('n', '<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>')
map('n', '<leader>ft', '<cmd>lua require(\'telescope.builtin\').lsp_document_symbols()<cr>')
map('n', '<leader>fT', '<cmd>lua require(\'telescope.builtin\').lsp_dynamic_workspace_symbols()<cr>')
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

local nvim_lsp = require'lspconfig'
local cmp = require'cmp'
local luasnip = require'luasnip'
require("luasnip.loaders.from_vscode").lazy_load()
require'lsp_signature'.setup({
    bind = true,
    handler_opts = {
      border = "rounded"
    }
})

require'nvim-treesitter.configs'.setup {
	ensure_installed = {"javascript", "typescript", "tsx", "html", "css", "lua", "rust", "go", "python", "json", "ruby"},
	highlight = {
	  enable = true,
	  -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
	  -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
	  -- Using this option may slow down your editor, and you may see some duplicate highlights.
	  -- Instead of true it can also be a list of languages
	  additional_vim_regex_highlighting = false,
	}
}

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
							-- nvim_lsp_signature_help = "[param]",
					},
			}),
	},
	experimental = {
		-- I like the new menu better(?)
		-- native_menu = false,
	},
	-- autocomplete
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	completion = { completeopt = "menu,menuone,noinsert" },
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
		{ name = 'luasnip', max_item_count = 5 },
		{ name = 'nvim_lua'},
		{ name = 'path' },
		{ name = 'buffer', keyword_length = 3 },
		-- { name = 'nvim_lsp_signature_help' },
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
require('telescope').load_extension('fzf')
require('telescope').setup{
	extensions = {
		fzf = {
			fuzzy = true,-- false will only do exact matching
			override_generic_sorter = true,  -- override the generic sorter
			override_file_sorter = true,-- override the file sorter
			case_mode = "smart_case",-- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
		},
	},
	defaults = {
		-- ignore_symbols = {"field", "struct"},
		file_ignore_patterns = {"vendor", "go.sum", "go.mod", "module", ".git", "gen", "*.pb.go", "mod", "Cellar", "mocks"},
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
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

local on_attach = function(client, bufnr)
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
	local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

	require "lsp_signature".on_attach({
    bind = true,
    handler_opts = {
      border = "rounded"
    }
  }, bufnr)
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

nvim_lsp.move_analyzer.setup{
	on_attach = on_attach,
	capabilities = capabilities,
}

nvim_lsp.bashls.setup{
	on_attach = on_attach,
	capabilities = capabilities,
}

nvim_lsp.ts_ls.setup{
	on_attach = on_attach,
	capabilities = capabilities,
}

nvim_lsp.gopls.setup{
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		gopls = {
			gofumpt = true,
			analyses = {
				unusedparams = true,
				nilness = true,
			},
			directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
			semanticTokens = true,
			usePlaceholders = true,
			completeUnimported = true,
		},
	},
	flags = {
		debounce_text_changes = 150,
	},
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
