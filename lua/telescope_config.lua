local telescope = require('telescope')
local actions = require('telescope.actions')

-- Define diagnostic icons
local diagnostic_icons = {
        error = "", -- Using a red 'x' icon
        warn = "", -- Using a yellow warning icon
        info = " ", -- Using a blue info icon
        hint = "", -- Using a blue lightbulb icon
}

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
                        "%.next/.*", -- Next.js build output
                        "dist/.*",   -- Common build output directory
                        "build/.*",  -- Common build output directory
                        "%.pb%.go",  -- Generated protobuf
                        "%.gen%.go", -- Generated Go files
                        "go%.sum",
                        "go%.mod",
                        "package%-lock%.json",
                        "package%.json",
                        "yarn%.lock",
                        "%.map",        -- Source maps
                        "%.min%.js",    -- Minified JS
                        "%.min%.css",   -- Minified CSS
                        "%.bundle%.js", -- Bundled JS
                        "Cellar/.*",
                        "mocks/.*",
                        "%.test%.", -- Test files
                        "%.spec%.", -- Test files
                        "%.d%.ts",  -- TypeScript declaration files
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
                        layout_config = {
                                preview_width = 0.6,
                        },
                        entry_maker = function(entry)
                                local make_entry = require("telescope.make_entry")
                                local default_maker = make_entry.gen_from_lsp_symbols()
                                local entry_tbl = default_maker(entry)

                                if entry_tbl then
                                        -- Define kind icons with both numeric and string keys
                                        local kind_icons = {
                                                ["Text"] = "󰉿",
                                                ["Method"] = "󰆧",
                                                ["Function"] = "󰊕",
                                                ["Constructor"] = "",
                                                ["Field"] = "󰜢",
                                                ["Variable"] = "󰀫",
                                                ["Class"] = "󰠱",
                                                ["Interface"] = "",
                                                ["Module"] = "",
                                                ["Property"] = "󰜢",
                                                ["Unit"] = "󰑭",
                                                ["Value"] = "󰎠",
                                                ["Enum"] = "",
                                                ["Keyword"] = "󰌋",
                                                ["Snippet"] = "",
                                                ["Color"] = "󰏘",
                                                ["File"] = "󰈙",
                                                ["Reference"] = "󰈇",
                                                ["Folder"] = "󰉋",
                                                ["EnumMember"] = "",
                                                ["Constant"] = "󰏿",
                                                ["Struct"] = "󰙅",
                                                ["Event"] = "",
                                                ["Operator"] = "󰆕",
                                                ["TypeParameter"] = "",
                                        }

                                        entry_tbl.display = function()
                                                local win_width = vim.api.nvim_win_get_width(0)
                                                local icon = kind_icons[entry.kind] or "? "
                                                local kind_name = entry.kind or "Unknown"

                                                local type_display = string.format(" (%s)", kind_name:lower())
                                                local icon_display = string.format("%s ", icon)

                                                local space_index = string.find(entry.text, " ")
                                                local name = string.sub(entry.text, space_index + 1)

                                                local max_name_width = win_width - #type_display - #icon_display - 5
                                                local name_display = name
                                                if #name > max_name_width then
                                                        name_display = string.sub(name, 1, max_name_width - 3) .. "..."
                                                else
                                                        name_display = name .. string.rep(" ", max_name_width - #name)
                                                end

                                                return icon_display .. name_display .. type_display
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
                                -- Use the default diagnostic entry maker as base
                                local default_maker = make_entry.gen_from_diagnostics()
                                local entry_tbl = default_maker(entry)

                                -- Just modify the display to be simpler
                                if entry_tbl then
                                        local severity = string.lower(entry.type or "unknown")
                                        local icon = diagnostic_icons[severity] or "?"
                                        local filename = vim.fn.fnamemodify(entry.filename or "", ":t")
                                        local message = entry.message or entry.text or ""

                                        entry_tbl.display = function()
                                                local win_width = vim.api.nvim_win_get_width(0)
                                                local filename_display = string.format(" (%s)", filename)
                                                local icon_display = string.format("%s ", icon)

                                                -- Calculate available space for message
                                                local max_msg_width = win_width - #filename_display - #icon_display - 5
                                                local msg_display = message
                                                if #message > max_msg_width then
                                                        msg_display = string.sub(message, 1, max_msg_width - 3) .. "..."
                                                else
                                                        msg_display = message ..
                                                            string.rep(" ", max_msg_width - #message)
                                                end

                                                return icon_display .. msg_display .. filename_display
                                        end
                                end

                                return entry_tbl
                        end,
                },
        }
}

-- Load telescope extensions
telescope.load_extension('fzf')
