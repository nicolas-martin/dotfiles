-- Load plugins
require('plugins')

vim.g.mapleader = ',' -- Set leader key

-- Options
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevelstart = 99
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.clipboard = "unnamedplus"
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.showmatch = true
vim.opt.relativenumber = true
vim.opt.expandtab = true
vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.cmd [[colorscheme Terafox]]

-- Autocommands (using Lua API)
local autocmd = vim.api.nvim_create_autocmd

-- FileType specific settings
autocmd("FileType", {
    pattern = "go",
    callback = function()
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
        vim.opt_local.expandtab = false
        vim.opt_local.signcolumn = "yes"
    end,
})

autocmd("FileType", {
    pattern = {"rust", "javascript", "typescriptreact", "proto", "yaml"},
    callback = function()
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
        vim.opt_local.expandtab = true
        vim.opt_local.signcolumn = "yes"
    end,
})

-- Key Mapping
default_opts = { noremap = true, silent = true }
local map = vim.keymap.set
map('n', '<leader>rc', ':source $MYVIMRC<CR>', default_opts)
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', default_opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', default_opts)
map('n', '<leader>fb', '<cmd>Telescope buffers<cr>', default_opts)
map('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', default_opts)
map('n', '<C-n>', ':NERDTreeToggle<CR>', default_opts)
map('n', '<C-j>', '<C-w>j', default_opts)
map('n', '<C-k>', '<C-w>k', default_opts)
map('n', '<C-l>', '<C-w>l', default_opts)
map('n', '<C-h>', '<C-w>h', default_opts)

-- Treesitter setup
require('nvim-treesitter.configs').setup {
    ensure_installed = {"javascript", "typescript", "tsx", "html", "css", "lua", "rust", "go", "python", "json"},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
    },
    indent = { enable = true },
}

-- Completion setup
local cmp = require'cmp'
local luasnip = require'luasnip'
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
    }),
    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
})

-- LSP Config
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function(client, bufnr)
    local buf_set_keymap = vim.api.nvim_buf_set_keymap
    local buf_opts = { noremap = true, silent = true }
    buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', buf_opts)
    buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', buf_opts)
end

require'lspconfig'.gopls.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        gopls = {
            gofumpt = true,
            analyses = {
                unusedparams = true,
                nilness = true,
            },
        },
    },
}

require'lspconfig'.pyright.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Telescope setup
require('telescope').setup{
    defaults = {
        file_ignore_patterns = {"vendor", ".git", "node_modules", "*.pb.go", "gen"},
        layout_config = {
            horizontal = { width = 0.9, preview_cutoff = 120 },
        },
    },
    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
    },
}
require('telescope').load_extension('fzf')

-- Rust Tools
require('rust-tools').setup({
    tools = {
        inlay_hints = {
            auto = true,
            show_parameter_hints = false,
            other_hints_prefix = "",
        },
    },
    server = {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            ['rust-analyzer'] = {
                checkOnSave = {
                    command = "clippy",
                },
            },
        },
    },
})

-- Disable unused built-in plugins
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
