return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		enabled = false,
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- optional but recommended
			"MunifTanjim/nui.nvim",
		},
		opts = {
			close_if_last_window = true,
			open_files_do_not_replace_types = { "terminal", "Trouble", "trouble", "qf", "Outline" },
			window = {
				mappings = {
					-- NvimTree
					-- map('n', '<C-n>', ':NvimTreeToggle<CR>', { desc = "Toggle NvimTree" })
					-- map('n', '<leader>l', ':NvimTreeFindFile<CR>', { desc = "Focus NvimTree" })
					["<C-n"] = "toggle",
					["<leader>l"] = "find_file",
					["<Tab>"] = { "toggle_preview", },
					["o"] = false, -- it lags..
					["?"] = "show_help", -- Show help popup
					["l"] = "open",
					["h"] = "close_node",
					["s"] = "open_split",
					["v"] = "open_vsplit",
				},
			},
			sort_case_insensitive = false, -- set to true for case-insensitive sorting
			default_component_configs = {
				indent = {
					indent_size = 2, -- adjust as needed
					with_markers = true,
				},
				git_status = {
					symbols = {
						-- define git symbols placement here if needed
					},
				},
				modified = {
					symbol = "[+]", -- customize as needed
				},
			},
			filesystem = {
				bind_to_cwd = true, -- Sync Neo-tree's root with Neovim's CWD
				cwd_target = {
					sidebar = "global", -- Set the global CWD when changing directories in the sidebar
				},
				filtered_items = {
					hide_dotfiles = true,
				},
			},
			log_level = "warn",
			help = {
				sort_by = "desc",
			},
			popup_border_style = "rounded",
			enable_diagnostics = true,
			diagnostics = {
				show_on_dirs = true,
				severity = {
					min = vim.diagnostic.severity.ERROR,
				},
			},
		},
	},
}
