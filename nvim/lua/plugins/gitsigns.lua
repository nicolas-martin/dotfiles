return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			signs                   = {
				add          = { text = '┃' },
				change       = { text = '┃' },
				delete       = { text = '_' },
				topdelete    = { text = '‾' },
				changedelete = { text = '~' },
				untracked    = { text = '┆' },
			},
			signcolumn              = true, -- show gutter icons
			numhl                   = true, -- highlight line numbers
			linehl                  = false,
			word_diff               = true, -- intra-line diffs
			attach_to_untracked     = true, -- work on new files
			current_line_blame      = true, -- git blame at cursor
			current_line_blame_opts = {
				virt_text          = false,
				virt_text_pos      = "eol",
				delay              = 500, -- ms
				ignore_whitespace  = false,
				virt_text_priority = 50,
			},
			sign_priority           = 15, -- above diagnostics/TODOs
			update_debounce         = 200, -- ms file-watch debounce
			max_file_length         = 20000, -- skip huge files
			preview_config          = { -- hover window style
				border   = "rounded",
				style    = "minimal",
				relative = "cursor",
				row      = 1,
				col      = 0,
			},
		},
	},
}
