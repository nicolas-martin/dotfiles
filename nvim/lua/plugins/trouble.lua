return {
	"folke/trouble.nvim",
	cmd = "Trouble",
	event = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		require("trouble").setup({
			focus = true, -- Focus the window when opened
			modes = {
				lsp_references = {
					focus = true, -- Focus the window when opened
					auto_close = true,
				},
				diagnostics = {
					focus = true, -- Focus the window when opened
					auto_open = false,
					auto_close = true,
				},
			},
			warn_no_results = false,
		})
	end,
	keys = { {
		"<leader>xt",
		"<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
		desc = "trouble diagnostics",
	}, {
		"<leader>xT",
		"<cmd>Trouble diagnostics toggle focus=true<cr>",
		desc = "project diagnostics",
	}, {
		"<leader>xs",
		"<cmd>Trouble symbols toggle focus=true<cr>",
		desc = "symbols",
	},
	},
}
