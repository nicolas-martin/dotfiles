local cmp = require('cmp')
local luasnip = require('luasnip')
local lspkind = require("lspkind")

-- Set up the GitHub icon color for Copilot
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
        formatting = {
                fields = { 'kind', 'abbr', 'menu' }, -- change the order so the icon appear first
                -- Show where the completion opts are coming from
                format = lspkind.cmp_format({
                        mode = 'symbol',
                        maxwidth = 50,
                        ellipsis_char = '...',
                        symbol_map = { Copilot = "", },
                        menu = {
                                nvim_lsp = "[LSP]",
                                luasnip = "[snip]",
                                nvim_lua = "[nvim]",
                                path = "[path]",
                                buffer = "[buffer]",
                                copilot = "[GitHub]",
                        },
                }),
        },
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
        mapping = cmp.mapping.preset.insert({
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
        }),
        sources = {
                { name = 'nvim_lsp' },
                { name = 'luasnip',                max_item_count = 5 },
                { name = 'copilot' },
                { name = 'nvim_lua' },
                { name = 'path' },
                { name = 'buffer',                 keyword_length = 3 },
                { name = 'nvim_lsp_signature_help' },
        },
})

-- Use buffer source for `/`
cmp.setup.cmdline('/', {
        sources = {
                { name = 'buffer' }
        }
})

-- -- -- Use cmdline & path source for ':'
cmp.setup.cmdline(':', {
        sources = cmp.config.sources({
                { name = 'path' }
        }, {
                { name = 'cmdline' }
        })
})
