-- require('telescope').load_extension('fzf')
-- require('telescope').setup {
--         extensions = {
--                 fzf = {
--                         fuzzy = true,                   -- false will only do exact matching
--                         override_generic_sorter = true, -- override the generic sorter
--                         override_file_sorter = true,    -- override the file sorter
--                         case_mode = "smart_case",       -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
--                 },
--         },
--         defaults = {
--                 -- ignore_symbols = {"field", "struct"},
--                 file_ignore_patterns = { "vendor", "go.sum", "go.mod", "module", ".git", "gen", "*.pb.go", "mod", "Cellar", "mocks" },
--                 mappings = {
--                         i = {
--                                 ["<C-n>"] = false,
--                                 ["<C-p>"] = false,
--                                 ["<esc>"] = require('telescope.actions').close,
--                                 ["<C-[>"] = require('telescope.actions').close,
--                                 ["<C-j>"] = require('telescope.actions').move_selection_next,
--                                 ["<C-k>"] = require('telescope.actions').move_selection_previous,
--                                 ["<leader>q"] = require('telescope.actions').send_selected_to_qflist + require('telescope.actions').open_qflist,
--                         },
--                 }
--         }
-- }
-- lua/telescope_config.lua
local telescope = require('telescope')

telescope.setup({
        defaults = {
                file_ignore_patterns = { "vendor", ".git", "node_modules", "*.pb.go", "gen", "mocks" },
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
        }
})

telescope.load_extension('fzf')
