require('telescope').setup({
    defaults = {
        file_ignore_patterns = { "vendor", ".git", "node_modules", "*.pb.go", "gen" },
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
})

require('telescope').load_extension('fzf')
