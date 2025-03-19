-- Avante configuration
local avante_config = {
	-- debug = true,
	provider = "copilot",             -- Using Anthropic/Claude as provider
	behaviour = {
		enable_cursor_planning_mode = true, -- enable cursor planning mode!
	},
	anthropic = {
		api_key_name = "cmd:pass nico/anthropic", -- Using pass command to get API key
	},
	web_search_engine = {                   -- Web search configuration
		provider = "brave",
		brave = {
			api_key_name = "cmd:pass nico/brave", -- Using pass command to get Brave API key
		},
	},
	options = {
		planning_mode = true, -- Enable planning mode for better model compatibility
	},
}

require('avante').setup(avante_config)
