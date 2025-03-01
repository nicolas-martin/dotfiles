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
                file_ignore_patterns = { "vendor", "go.sum", "go.mod", "module", ".git", "gen", "*.pb.go", "mod", "Cellar", "mocks" },
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
        }
}

-- Load telescope extensions
telescope.load_extension('fzf')
