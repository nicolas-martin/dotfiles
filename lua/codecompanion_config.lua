-- CodeCompanion configuration
local config = {
    display = {
        diff = {
            enabled = true,
            close_chat_at = 240, -- Close an open chat buffer if the total columns of your display are less than...
            layout = "vertical", -- vertical|horizontal split for default provider
            opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
            provider = "mini_diff", -- default|mini_diff
          },
        chat = {
            intro_message = "Welcome to CodeCompanion ✨! Press ? for options #buffer @full_stack_dev",
            icons = {
                pinned_buffer = " ",
                watched_buffer = "👀 ",
            },
            window = {
                layout = "vertical",      -- float|vertical|horizontal|buffer
                position = "right",       -- left|right|top|bottom
                border = "rounded",
                height = 0.8,
                width = 0.45,
                relative = "editor",
                full_height = true,       -- when set to false, vsplit will be used
            },
        },
        action_palette = {
            width = 95,
            height = 10,
            prompt = "Prompt ", -- Prompt used for interactive LLM calls
            provider = "telescope", -- default|telescope|mini_pick
            opts = {
                show_default_actions = true, -- Show the default actions in the action palette?
                show_default_prompt_library = true, -- Show the default prompt library in the action palette?
            },
        },
    },
    strategies = {
        chat = {
            slash_commands = {
                ["file"] = {
                    -- Location to the slash command in CodeCompanion
                    callback = "strategies.chat.slash_commands.file",
                    description = "Select a file using Telescope",
                    opts = {
                        provider = "telescope", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
                        contains_code = true
                    }
                }
            },
            adapter = "copilot",
            markdown = {
                enable = true,
                highlights = true,
                code_block_highlight = true
            }
        },
        inline = {
            adapter = "copilot",
            enable = true
        }
    }
}

-- Initialize Fidget integration if available
local ok, fidget = pcall(require, "codecompanion_fidget")
if ok then
    fidget:init()
end

return config
