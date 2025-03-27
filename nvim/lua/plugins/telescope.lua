return {
	{
		"nvim-telescope/telescope.nvim",
		cmd = "Telescope",
		dependencies = {
			"nvim-lua/plenary.nvim",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		config = function()
			-- signs = {
			-- 	text = {
			-- 		[vim.diagnostic.severity.ERROR] = ' ',
			-- 		[vim.diagnostic.severity.WARN] = ' ',
			-- 		[vim.diagnostic.severity.INFO] = ' ',
			-- 		[vim.diagnostic.severity.HINT] = '',
			-- 	},
			-- 	texthl = {
			-- 		[vim.diagnostic.severity.ERROR] = "DiagnosticError",
			-- 		[vim.diagnostic.severity.WARN] = "DiagnosticWarn",
			-- 		[vim.diagnostic.severity.INFO] = "DiagnosticInfo",
			-- 		[vim.diagnostic.severity.HINT] = "DiagnosticHint",
			-- 	},
			-- },
			vim.fn.sign_define("DiagnosticSignError", { text = "", texthl = "DiagnosticError" })
			vim.fn.sign_define("DiagnosticSignWarn", { text = "", texthl = "DiagnosticWarn" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = "", texthl = "DiagnosticInfo" })
			vim.fn.sign_define("DiagnosticSignHint", { text = "", texthl = "DiagnosticHint" })
			local actions = require('telescope.actions')

			-- Helper function for right-aligned display
			local format_with_right_align = function(icon_str, main_str, type_str)
				local win_width = vim.api.nvim_win_get_width(0)

				-- handle icon: string or { text, hl_group }
				local icon_display, icon_width
				if type(icon_str) == "table" then
					icon_display = { string.format("%s ", icon_str[1]), icon_str[2] }
					icon_width = vim.fn.strwidth(icon_str[1]) + 1
				else
					icon_display = string.format("%s ", icon_str)
					icon_width = vim.fn.strwidth(icon_display)
				end

				-- strip `[Kind] ` prefix from name
				main_str = main_str:gsub("^%[[^%]]+%]%s*", "")

				local type_display = string.format(" (%s)", type_str:lower())
				local type_width = vim.fn.strwidth(type_display)
				local main_width = vim.fn.strwidth(main_str)

				local max_main_width = win_width - type_width - icon_width - 2
				local main_display = main_str
				if main_width > max_main_width then
					main_display = string.sub(main_str, 1, max_main_width - 3) .. "..."
				end

				local displayer = require("telescope.pickers.entry_display").create {
					separator = "",
					items = {
						{ width = icon_width },
						{ width = win_width - icon_width - type_width - 2 },
						{ width = type_width,                             right_justify = true },
					},
				}

				return displayer {
					icon_display,
					main_display,
					{ type_display, "TelescopeResultsComment" },
				}
			end

			local function get_sign_icon(name)
				-- { name = "DiagnosticSignError", text = "", texthl = "DiagnosticError" }
				local sign = vim.fn.sign_getdefined(name)[1]
				return sign and sign.text or "?"
			end

			-- Define diagnostic icons
			local diagnostic_icons = {
				error = get_sign_icon("DiagnosticSignError"),
				warn  = get_sign_icon("DiagnosticSignWarn"),
				info  = get_sign_icon("DiagnosticSignInfo"),
				hint  = get_sign_icon("DiagnosticSignHint"),
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
					respect_gitignore = true,
				},
				pickers = {
					lsp_dynamic_workspace_symbols = {
						-- path_display = { "truncate" },
						layout_config = {
							preview_width = 0.6,
						},
						entry_maker = (function()
							local allowed_kinds = {
								["Function"] = true,
								["Method"] = true,
								["Struct"] = true,
								["Class"] = true,
								["Interface"] = true,
								["Enum"] = true,
								["Module"] = true,
								["Constructor"] = true,
								["Field"] = true,
								["Constant"] = true,
								["Variable"] = true,
							}

							return function(entry)
								if not allowed_kinds[entry.kind] then
									print("?Skipping lsp ws symbols", entry.kind)
									return nil
								end

								local make_entry = require("telescope.make_entry")
								local lspkind = require("lspkind")
								local default_maker = make_entry.gen_from_lsp_symbols()
								local entry_tbl = default_maker(entry)

								if entry_tbl then
									local kind = entry.kind or "Unknown"
									local icon = lspkind.symbolic(kind, { mode = "symbol" }) or "? "
									local hl_group = "CmpItemKind" .. kind:gsub("%s", "")

									entry_tbl.display = function()
										return format_with_right_align({ icon, hl_group }, entry.text, kind)
									end
								end

								return entry_tbl
							end
						end)()
					},
					lsp_document_symbols = {
						layout_config = {
							preview_width = 0.4,
						},
						entry_maker = function(entry)
							local lspkind = require("lspkind")
							local allowed_kinds = {
								["Function"] = true,
								["Method"] = true,
								["Struct"] = true,
								["Class"] = true,
								["Constant"] = true,
								["Field"] = true,
								["Variable"] = true,
							}
							if not allowed_kinds[entry.kind] then
								print("Skipping lsp doc symbols", entry.kind)
								return nil
							end
							local make_entry = require("telescope.make_entry")
							local default_maker = make_entry.gen_from_lsp_symbols()
							local entry_tbl = default_maker(entry)

							if entry_tbl then
								local kind = entry.kind or "Unknown"
								local icon = lspkind.symbolic(kind, { mode = "symbol" }) or "? "
								local hl_group = "CmpItemKind" .. kind:gsub("%s", "")
								local name = entry.text or "<none>"

								entry_tbl.display = function()
									return format_with_right_align({ icon, hl_group }, name, kind)
								end
							end

							return entry_tbl
						end,
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
