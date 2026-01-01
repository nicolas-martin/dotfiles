return {
	{
		"milanglacier/minuet-ai.nvim",
		event = "BufReadPre",
		enabled = false,
		opts = {
			notify = "debug",
			provider = "codestral",
			n_completions = 3,
			add_single_line_entry = true,
			virtualtext = {
				keymap = {
					-- accept whole completion
					accept = "<Tab>",
					-- accept one line
					accept_line = "<A-a>",
					-- accept n lines (prompts for number)
					accept_n_lines = "<A-z>",
					-- Cycle to prev completion item, or manually invoke completion
					prev = "<A-[>",
					-- Cycle to next completion item, or manually invoke completion
					next = "<A-]>",
					dismiss = "<A-e>",
				},
			},
			provider_options = {
				codestral = {
					-- api_key = 'pass show nico/ministral',
					api_key = 'CODESTRAL_API_KEY',
					optional = {
						max_tokens = 256,
						stop = { "\n\n" },
					},
				},
				gemini = {
					optional = {
						generationConfig = {
							maxOutputTokens = 256,
						},
						safetySettings = {
							{
								-- HARM_CATEGORY_HATE_SPEECH,
								-- HARM_CATEGORY_HARASSMENT
								-- HARM_CATEGORY_SEXUALLY_EXPLICIT
								category = "HARM_CATEGORY_DANGEROUS_CONTENT",
								-- BLOCK_NONE
								threshold = "BLOCK_ONLY_HIGH",
							},
						},
					},
				},
			},
		},
	},
}
