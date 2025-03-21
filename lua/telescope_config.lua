local telescope = require('telescope')
local actions = require('telescope.actions')

-- Helper function for right-aligned display
local format_with_right_align = function(icon_str, main_str, type_str)
	local win_width = vim.api.nvim_win_get_width(0)

	-- Format displays
	local icon_display = string.format("%s ", icon_str)
	local type_display = string.format(" (%s)", type_str:lower())

	-- Calculate accurate display widths
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
	-- TelescopeResultsIdentifier - What you're currently using (blue in most themes)
	-- TelescopeResultsConstant - Usually a different color like purple
	-- TelescopeResultsFunction - Often orange or yellow
	-- TelescopeResultsMethod - Similar to function, but sometimes distinct
	-- TelescopeResultsOperator - Often pink or red
	-- TelescopeResultsVariable - Typically light blue or cyan
	-- TelescopeResultsNumber - Usually distinct color for numbers
	-- TelescopeResultsComment - Often muted/gray
	-- TelescopeSelection - The highlight for selected items
	-- TelescopeMatching - Used for matched text during searches
	return displayer {
		{ icon_display },
		{ main_display },
		{ type_display, "TelescopeResultsComment" },
	}
end

-- Define diagnostic icons
local diagnostic_icons = {
	error = "",     -- Using a red 'x' icon
	warn = "",      -- Using a yellow warning icon
	info = " ",     -- Using a blue info icon
	hint = "",      -- Using a blue lightbulb icon
}

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

telescope.setup {
	extensions = {
		fzf = {
			fuzzy = true,                               -- false will only do exact matching
			override_generic_sorter = true,             -- override the generic sorter
			override_file_sorter = true,                -- override the file sorter
			case_mode = "smart_case",                   -- or "ignore_case" or "respect_case" the default case_mode is "smart_case"
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
		file_ignore_patterns = {
			-- Go-specific dependency patterns
			"github%.com/[^/]+/[^/]+",             -- Any GitHub repository
			"golang%.org/x/[^/]+",                 -- Go standard extended libraries
			"gopkg%.in/[^/]+",                     -- Gopkg libraries
			"go%.uber%.org/[^/]+",                 -- Uber Go libraries
			"/go/pkg/mod/.*",                      -- Go module cache
			"/usr/local/go/.*",                    -- Go installation

			-- More aggressive Go patterns (from diagnostics)
			"github%.com/.*",               -- All GitHub repos (more aggressive)
			"golang%.org/.*",               -- All golang.org packages
			"gopkg%.in/.*",                 -- All gopkg.in packages
			"go%.uber%.org/.*",             -- All go.uber.org packages
			"%w+%.%w+/.*",                  -- Any domain-based import
			"%(go%.mod%)",                  -- go.mod files as seen in diagnostics

			-- System paths
			"/usr/.*",             -- All usr directories
			"/opt/.*",             -- All opt directories

			-- Common external code patterns
			"vendor/.*",
			"node_modules/.*",
			"%.git/.*",
			"%.next/.*",             -- Next.js build output
			"dist/.*",               -- Common build output directory
			"build/.*",              -- Common build output directory

			-- Generated files
			"%.pb%.go",              -- Generated protobuf
			"%.gen%.go",             -- Generated Go files

			-- Config files
			"go%.sum",
			"go%.mod",
			"package%-lock%.json",
			"package%.json",
			"yarn%.lock",

			-- Other common patterns
			"%.map",                    -- Source maps
			"%.min%.js",                -- Minified JS
			"%.min%.css",               -- Minified CSS
			"%.bundle%.js",             -- Bundled JS
			"Cellar/.*",
			"mocks/.*",
			"%.test%.",             -- Test files
			"%.spec%.",             -- Test files
			"%.d%.ts",              -- TypeScript declaration files
			"/usr/include/.*",
			"/usr/lib/.*",
		},
		layout_config = {
			width = 0.95,             -- 95% of screen width
			-- preview_width = 0.6, -- 60% of telescope window for preview
			horizontal = {
				width = { padding = 0.15 },
				preview_width = 0.6,                 -- test remove?.. or the other oen
			},
		},
		symbol_width = 50,         -- Increase symbol name display width
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
		-- Ignore files in external dependencies and filter node_modules
		path_display = { "truncate" },
		respect_gitignore = true,
	},
	pickers = {
		lsp_document_symbols = {
			layout_config = {
				preview_width = 0.4,
			},
			-- Add symbols to ignore in LSP document symbols
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
				-- Add/remove what you need
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
			-- Ignore node_modules and other external directories
			-- additional_args = function()
			--         return {
			--                 "--ignore-directory=node_modules/",
			--                 "--ignore-directory=vendor/",
			--                 "--ignore-directory=.git/",
			--                 -- Add more directories to ignore
			--         }
			-- end,
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
				-- Filter out common go module diagnostic messages
				-- if entry.text and (
				--             entry.text:match("is not used in this module") or
				--             entry.text:match("is not in your go%.mod file")
				--     ) then
				--         return nil
				-- end

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
	}
}

-- Load telescope extensions
telescope.load_extension('fzf')
