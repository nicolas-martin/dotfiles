return {
	{
		enabled = false,
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",

		config = {
			filetypes = {
				yaml = true,
			},
			-- TODO: Panel can be slow?
			panel = { enabled = false },
			suggestion = {
				-- TODO: Let blink cmp take over
				enabled = false,
				auto_trigger = false,
				hide_during_completion = true,
				debounce = 25,
				keymap = {
					accept = false,
					accept_word = false,
					accept_line = "<Tab>",
					next = false,
					prev = false,
					dismiss = false,
				},
			},
		},
	},
}
