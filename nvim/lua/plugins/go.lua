return {
	"ray-x/go.nvim",
	dependencies = { -- optional packages
		"ray-x/guihua.lua",
		"neovim/nvim-lspconfig",
		"nvim-treesitter/nvim-treesitter",
	},
	-- https://github.com/ray-x/go.nvim?tab=readme-ov-file#configuration
	config = function()
		require("go").setup(
			{
				lsp_inlay_hints = { enable = false },
			})
	end,
	opts = {
		-- test goimports on save
		goimports = "gopls",
	},
	event = { "CmdlineEnter" },
	ft = { "go", 'gomod' },
	build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
}
