local telescope = require('telescope')
local actions = require('telescope.actions')

telescope.setup {
        extensions = {
                fzf = {
                        fuzzy = true,                   -- false will only do exact matching
                        override_generic_sorter = true, -- override the generic sorter
                        override_file_sorter = true,    -- override the file sorter
                        case_mode = "smart_case",       -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
                },
        },
        defaults = {
                vimgrep_arguments = {
                        'rg',
                        '--color=never',
                        '--no-heading',
                        '--with-filename',
                        '--line-number',
                        '--column',
                        '--smart-case'
                },
                -- ignore_symbols = {"field", "struct"},
                file_ignore_patterns = { 
                        "vendor/.*",
                        "node_modules/.*",
                        "%.git/.*",
                        "%.next/.*",  -- Next.js build output
                        "dist/.*",    -- Common build output directory
                        "build/.*",   -- Common build output directory
                        "%.pb%.go",   -- Generated protobuf
                        "%.gen%.go",  -- Generated Go files
                        "go%.sum",
                        "go%.mod",
                        "package%-lock%.json",
                        "package%.json",
                        "yarn%.lock",
                        "%.map",      -- Source maps
                        "%.min%.js",  -- Minified JS
                        "%.min%.css", -- Minified CSS
                        "%.bundle%.js", -- Bundled JS
                        "Cellar/.*",
                        "mocks/.*",
                        "%.test%.",   -- Test files
                        "%.spec%.",   -- Test files
                        "%.d%.ts",    -- TypeScript declaration files
                },
                layout_config = {
                        width = 0.95,        -- 95% of screen width
                        preview_width = 0.6, -- 60% of telescope window for preview
                        horizontal = {
                                width = { padding = 0.15 },
                                preview_width = 0.6,
                        },
                },
                symbol_width = 50, -- Increase symbol name display width
                mappings = {
                        i = {
                                ["<C-n>"] = false,
                                ["<C-p>"] = false,
                                ["<esc>"] = actions.close,
                                ["<C-[>"] = actions.close,
                                ["<C-j>"] = actions.move_selection_next,
                                ["<C-k>"] = actions.move_selection_previous,
                                ["<leader>q"] = actions.send_selected_to_qflist + actions.open_qflist,
                        },
                }
        },
        pickers = {
                lsp_document_symbols = {
                        symbol_width = 50,   -- Wider symbol names in document symbols
                        preview_width = 0.6, -- Wider preview for symbols
                },
                lsp_workspace_symbols = {
                        symbol_width = 50,   -- Wider symbol names in workspace symbols
                        preview_width = 0.6, -- Wider preview for symbols
                }
        }
}

-- Load telescope extensions
telescope.load_extension('fzf')
