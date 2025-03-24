return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			local actions = require('telescope.actions')

			-- Helper function for right-aligned display
			local format_with_right_align = function(icon_str, main_str, type_str)
				local win_width = vim.api.nvim_win_get_width(0)
				local icon_display = string.format("%s ", icon_str)
				local type_display = string.format(" (%s)", type_str:lower())
				local icon_width = vim.fn.strwidth(icon_display)
				local type_width = vim.fn.strwidth(type_display)
				local main_width = vim.fn.strwidth(main_str)

				-- Calculate available width and truncate if needed
				local max_main_width = win_width - type_width - icon_width - 2
				local main_display = main_str
				if main_width > max_main_width then
					main_display = string.sub(main_str, 1, max_main_width - 3) .. "..."
				end

				-- Create a display line with proper alignment
				local displayer = require("telescope.pickers.entry_display").create {
					separator = "",
					items = {
						{ width = icon_width },
						{ width = win_width - icon_width - type_width - 2 },
						{ width = type_width,                             right_justify = true },
					},
				}

				return displayer {
					{ icon_display },
					{ main_display },
					{ type_display, "TelescopeResultsComment" },
				}
			end

			-- Define diagnostic icons
			local diagnostic_icons = {
				error = "", -- Using a red 'x' icon
				warn = "", -- Using a yellow warning icon
				info = " ", -- Using a blue info icon
				hint = "", -- Using a blue lightbulb icon
			}

			-- Define LSP kind icons
			local kind_icons = {
				["Text"] = "󰉿",
				["Method"] = "󰆧",
				["Function"] = "󰊕",
				["Constructor"] = "",
				["Field"] = "󰜢",
				["Variable"] = "󰀫",
				["Class"] = "󰠱",
				["Interface"] = "",
				["Module"] = "",
				["Property"] = "󰜢",
				["Unit"] = "󰑭",
				["Value"] = "󰎠",
				["Enum"] = "",
				["Keyword"] = "󰌋",
				["Snippet"] = "",
				["Color"] = "󰏘",
				["File"] = "󰈙",
				["Reference"] = "󰈇",
				["Folder"] = "󰉋",
				["EnumMember"] = "",
				["Constant"] = "󰏿",
				["Struct"] = "󰙅",
				["Event"] = "",
				["Operator"] = "󰆕",
				["TypeParameter"] = " ",
			}

			require('telescope').setup({
				defaults = {
					vimgrep_arguments = {
						'rg',
						'--color=never',
						'--no-heading',
						'--with-filename',
						'--line-number',
						'--column',
						'--smart-case',
						'--hidden'
					},
					file_ignore_patterns = {
						-- Go-specific dependency patterns
						"github%.com/[^/]+/[^/]+",
						"golang%.org/x/[^/]+",
						"gopkg%.in/[^/]+",
						"go%.uber%.org/[^/]+",
						"/go/pkg/mod/.*",
						"/usr/local/go/.*",
						"github%.com/.*",
						"golang%.org/.*",
						"gopkg%.in/.*",
						"go%.uber%.org/.*",
						"%w+%.%w+/.*",
						"%(go%.mod%)",
						"/usr/.*",
						"/opt/.*",
						"vendor/.*",
						"node_modules/.*",
						"%.git/.*",
						"%.next/.*",
						"dist/.*",
						"build/.*",
						"%.pb%.go",
						"%.gen%.go",
						"go%.sum",
						"go%.mod",
						"package%-lock%.json",
						"package%.json",
						"yarn%.lock",
						"%.map",
						"%.min%.js",
						"%.min%.css",
						"%.bundle%.js",
						"Cellar/.*",
						"mocks/.*",
						"%.test%.",
						"%.spec%.",
						"%.d%.ts",
						"/usr/include/.*",
						"/usr/lib/.*",
					},
					layout_config = {
						width = 0.95,
						horizontal = {
							width = { padding = 0.15 },
							preview_width = 0.6,
						},
					},
					symbol_width = 50,
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
					},
					path_display = { "truncate" },
					respect_gitignore = true,
				},
				pickers = {
					lsp_document_symbols = {
						layout_config = {
							preview_width = 0.4,
						},
						symbols = {
							"class",
							"function",
							"method",
							"constructor",
							"interface",
							"module",
							"property",
							"variable",
							"struct",
							"enum",
						},
						entry_maker = function(entry)
							local make_entry = require("telescope.make_entry")
							local default_maker = make_entry.gen_from_lsp_symbols()
							local entry_tbl = default_maker(entry)

							if entry_tbl then
								entry_tbl.display = function()
									local icon = kind_icons[entry.kind] or "? "
									local kind_name = entry.kind or "Unknown"
									local space_index = string.find(entry.text, " ")
									local name = string.sub(entry.text, space_index + 1)

									return format_with_right_align(icon, name, kind_name)
								end
							end

							return entry_tbl
						end,
					},
					lsp_workspace_symbols = {
						layout_config = {
							preview_width = 0.6,
						},
					},
					live_grep = {
						layout_config = {
							preview_width = 0.6,
						},
					},
					diagnostics = {
						layout_config = {
							preview_width = 0.30,
						},
						wrap_results = true,
						entry_maker = function(entry)
							local make_entry = require("telescope.make_entry")
							local default_maker = make_entry.gen_from_diagnostics()
							local entry_tbl = default_maker(entry)

							if entry_tbl then
								entry_tbl.display = function()
									local severity = string.lower(entry.type or "unknown")
									local icon = diagnostic_icons[severity] or "?"
									local filename = vim.fn.fnamemodify(entry.filename or "", ":t")
									local message = entry.message or entry.text or ""

									return format_with_right_align(icon, message, filename)
								end
							end

							return entry_tbl
						end,
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

			-- Load extensions
			require('telescope').load_extension('fzf')
		end,
	},
}

