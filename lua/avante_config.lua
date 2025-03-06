-- Avante configuration
local avante_config = {
        debug = true,
        provider = "anthropic",  -- Using Anthropic/Claude as provider
        anthropic = {
                api_key_name = "cmd:pass nico/anthropic",  -- Using pass command to get API key
        },
        web_search = {  -- Web search configuration
                provider = "brave",
                brave = {
                        api_key_name = "cmd:pass nico/brave",  -- Using pass command to get Brave API key
                },
        },
        options = {
                planning_mode = true,  -- Enable planning mode for better model compatibility
        },
}

-- Print the configuration to validate loading
print("Avante config:", vim.inspect(avante_config))

require('avante').setup(avante_config)
