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
			word_diff               = false, -- disable for performance
			attach_to_untracked     = true, -- work on new files
			current_line_blame      = false, -- disable for performance
			current_line_blame_opts = {
				virt_text          = true,
				virt_text_pos      = "eol",
				delay              = 1000, -- ms
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
			on_attach               = function(bufnr)
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
				end, { expr = true })

				map('n', '[c', function()
					if vim.wo.diff then return '[c' end
					vim.schedule(function() gs.prev_hunk() end)
					return '<Ignore>'
				end, { expr = true })

				-- Actions
				map('n', '<leader>hs', gs.stage_hunk)
				map('n', '<leader>hr', gs.reset_hunk)
				map('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
				map('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
				map('n', '<leader>hS', gs.stage_buffer)
				map('n', '<leader>hu', gs.undo_stage_hunk)
				map('n', '<leader>hR', gs.reset_buffer)
				map('n', '<leader>hp', gs.preview_hunk)
				map('n', '<leader>hb', function() gs.blame_line { full = true } end)
				map('n', '<leader>hd', gs.diffthis)
				map('n', '<leader>hD', function() gs.diffthis('~') end)

				-- Toggles
				map('n', '<leader>gb', gs.toggle_current_line_blame)
				map('n', '<leader>gw', gs.toggle_word_diff)
				map('n', '<leader>gd', gs.toggle_deleted)

				-- Text object
				map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
			end,
		},
	},
}
