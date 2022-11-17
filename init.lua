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
-- require("cmp_nvim_ultisnips").setup {}
-- local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")
local cmp = require'cmp'
cmp.setup({
	formatting = {
		fields = { 'kind', 'abbr', 'menu' }, -- change the order so the icon appear first
			-- Show where the completion opts are coming from
			format = require("lspkind").cmp_format({
					option = 'default',
					mode = 'symbol',
					maxwidth = 50,
					with_text = true,
					menu = {
							ultisnips = "[snip]",
							nvim_lua = "[nvim]",
							nvim_lsp = "[LSP]",
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
				vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.

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
		['<CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Insert, select = true }),
		-- ["<Tab>"] = cmp.mapping( function(fallback) cmp_ultisnips_mappings.expand_or_jump_forwards(fallback) end,
		--			{ "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }),
		-- ["<S-Tab>"] = cmp.mapping( function(fallback) cmp_ultisnips_mappings.jump_backwards(fallback) end,
		--			{ "i", "s", --[[ "c" (to enable the mapping in command mode) ]] }),
	},
	-- Installed sources
	sources = {
		{ name = 'nvim_lsp' },
		{ name = 'ultisnips' }, -- For ultisnips users.
		{ name = 'path' },
		{ name = 'buffer', keyword_length = 3 },
		{ name = 'nvim_lsp_signature_help' },
	},
	flags = {
		debounce_text_changes = 150,
	},
	sorting = {
			comparators = {
				cmp.config.compare.offset,
				cmp.config.compare.exact,
				cmp.config.compare.score,

				-- copied from cmp-under, but I don't think I need the plugin for this.
				-- I might add some more of my own.
				function(entry1, entry2)
					local _, entry1_under = entry1.completion_item.label:find "^_+"
					local _, entry2_under = entry2.completion_item.label:find "^_+"
					entry1_under = entry1_under or 0
					entry2_under = entry2_under or 0
					if entry1_under > entry2_under then
						return false
					elseif entry1_under < entry2_under then
						return true
					end
				end,

				cmp.config.compare.kind,
				cmp.config.compare.sort_text,
				cmp.config.compare.length,
				cmp.config.compare.order,
			},
	},
})

require('gitsigns').setup{
  -- unchanged default settings
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}

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
-- TODO: I can delete this?
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


vim.cmd([[
	let g:go_highlight_types = 1
	let g:go_highlight_fields = 1
	let g:go_highlight_functions = 1
	let g:go_highlight_function_calls = 1
	let g:go_highlight_operators = 1
	let g:go_metalinter_command = "staticcheck"
	let g:go_gopls_enabled = 0
	let g:python3_host_prog = '/usr/local/bin/python3'	

]])

-- let g:go_fmt_command = "goimports"

map('n', '<leader>w', ':GoMetaLinter<CR>')
map('n', '<leader>r', ':GoRun<CR>')

-- test fix for tmux+nvim
vim.cmd([[ autocmd VimEnter * :silent exec "!kill -s SIGWINCH $PPID" ]])

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
map('n', ']q', ':cn<CR>')
map('n', '[q', ':cp<CR>')

-- -- always paste from the unamed register
-- map('n', 'p', '"0p')
-- map('v', 'p', '"0p')
-- get rid of the evil ex mode

-- Default settings
	opt.cmdheight = 2
	opt.expandtab = true								-- tabs are tabs vs expandtab tabs are space
	opt.showcmd = true										 -- show command in bottom bar
	opt.lazyredraw = true									 -- redraw only when we need to.
	opt.showmatch = true								 -- highlight matching [{()}]
	opt.incsearch = true									 -- search as characters are entered
	opt.hlsearch = true										 -- highlight matches
	-- opt.noshowmode = true									-- don't show modes (use airline instead)"
	opt.relativenumber = true
	opt.autowrite = true
	vim.o.completeopt = "menu", "menuone", "noselect"
	opt.clipboard = "unnamedplus"
	opt.scrolloff = 5									-- Keep some distance from the bottom
	opt.sidescrolloff = 5							-- Keep some distance while side scrolling
	opt.backup = false										-- No backup file
	opt.swapfile = false									-- NOTE: Experimental No swap file
	opt.writebackup = false
	-- opt.foldmethod = syntax					 -- Code folding
	opt.foldlevelstart = 20						-- Opens X amount of fold at the start - Can't use nofoldenable
	-- opt.splitright = true									-- Split window appears right the current one.
	opt.autoread = true										 -- Auto reloads the file when modifications were made
	opt.ignorecase = true
	opt.termguicolors=true
	-- opt.encoding = utf-8
	opt.foldmethod="expr"
	opt.foldexpr="nvim_treesitter#foldexpr()"
	vim.opt.shortmess:append "c"

require'nvim-web-devicons'.setup {
 -- your personnal icons can go here (to override)
 -- you can specify color or cterm_color instead of specifying both of them
 -- DevIcon will be appended to `name`
 override = {
	zsh = {
		icon = "",
		color = "#428850",
		cterm_color = "65",
		name = "Zsh"
	}
 };
 -- globally enable default icons (default to false)
 -- will get overriden by `get_icons` option
 default = true;
}

cmd 'autocmd Filetype go setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab signcolumn=yes'
cmd 'autocmd Filetype rust setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab signcolumn=yes'
cmd 'autocmd Filetype ts setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab signcolumn=yes'
cmd 'autocmd Filetype python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab	autoindent signcolumn=yes'
cmd 'autocmd Filetype yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2	noexpandtab signcolumn=yes'
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
	buf_set_keymap("n", "<leader>0", "<cmd>set nu! rnu!<CR>", opts)

end

nvim_lsp.solargraph.setup{
	on_attach = on_attach,
	capabilities = capabilities,
}

nvim_lsp.tsserver.setup{
	on_attach = on_attach,
	capabilities = capabilities,
}

nvim_lsp.sumneko_lua.setup{
	on_attach = on_attach,
	capabilities = capabilities,
	settings = {
		Lua = {
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


-- TODO: DOES THIS EVEN WORK?
-- SEEMS LIKE IT OVERRIDES THE SETUP
-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- local servers = {"gopls", "tsserver", "sumneko_lua"}
-- -- local servers = {"gopls", "tsserver"}
-- for _, lsp in ipairs(servers) do
--	nvim_lsp[lsp].setup {
--		on_attach = on_attach,
--		capabilities = capabilities,
--	}
-- end
