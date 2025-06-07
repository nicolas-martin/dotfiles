return {
	"ray-x/go.nvim",
	dependencies = {
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	ft = { "go", "gomod" },
	event = { "CmdlineEnter" },
	build = ':lua require("go.install").update_all_sync()',
	opts = {
		lsp_inlay_hints = { enable = false },
		lsp_cfg = {
			settings = {
				gopls = {
					analyses = {
						shadow = false, -- disable shadow warnings
					},
				},
			},
		},
	},
	config = function(_, opts)
		-- 1) setup plugin with all opts
		require("go").setup(opts)

		-- 2) format + goimports on save
		local fmt_grp = vim.api.nvim_create_augroup("GoFormat", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = "*.go",
			group = fmt_grp,
			callback = function()
				require("go.format").goimports()
			end,
		})
	end,
}
