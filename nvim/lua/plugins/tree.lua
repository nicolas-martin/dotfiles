-- local m = require("utils")
-- TOOD: when calling NvimTreeToggle, I want to find the file in the tree
-- no matter if it's in my current working directory or not
return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons", -- Optional for file icons
		},
		config = function()
			local function my_on_attach(bufnr)
				local api = require('nvim-tree.api')
				api.config.mappings.default_on_attach(bufnr)
				-- vim.keymap.set("n", "<C-Space>", m.tree_actions_menu, { buffer = bufnr, noremap = true, silent = true })
			end
			require("nvim-tree").setup({
				on_attach = my_on_attach,
				sort = {
					sorter = "case_sensitive",
				},
				view = {
					width = 30,
				},
				renderer = {
					group_empty = true,
					indent_markers = {
						enable = true,
					},
					icons = {
						git_placement = "after",
						modified_placement = "after",
					},
				},
				filters = {
					dotfiles = true,
				},
				notify = {
					threshold = vim.log.levels.WARN,
				},
				help = {
					sort_by = "desc",
				},
				ui = {
					confirm = {
						default_yes = true,
					},
				},
				diagnostics = {
					enable = true,
					show_on_dirs = true,
					severity = {
						min = vim.diagnostic.severity.ERROR,
					},
				},
			})
		end,

	},
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-tree.lua",
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
}
