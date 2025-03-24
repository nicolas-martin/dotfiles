return {
	-- Essential editing plugins
	{ "tpope/vim-repeat" },
	{ "tpope/vim-surround" },
	{ "tpope/vim-commentary" },
	-- File explorer
	{
		"preservim/nerdtree",
		init = function()
			-- Disable netrw completely
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1
			vim.g.loaded_netrwSettings = 1
			vim.g.loaded_netrwFileHandlers = 1

			-- NERDTree configuration
			-- Don't open NERDTree in buffers like quickfix, terminals, etc
			vim.g.NERDTreeIgnore = { '^node_modules$' }
			vim.g.NERDTreeMinimalUI = 1
			-- Don't replace the current buffer when opening files
			vim.g.NERDTreeCustomOpenArgs = {
				['file'] = { where = 'p', reuse = 'all', keepopen = 1 }
			}

			-- Auto open NERDTree when opening a directory
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) > 0 then
						-- Change to the directory
						vim.cmd("cd " .. vim.fn.argv(0))
						-- Open NERDTree in the current directory
						vim.cmd("NERDTree")
						-- Focus the other window
						vim.cmd("wincmd p")
					end
				end,
			})

			-- Close vim if NERDTree is the only window remaining
			vim.api.nvim_create_autocmd("BufEnter", {
				callback = function()
					if vim.fn.winnr("$") == 1 and vim.bo.filetype == "nerdtree" then
						vim.cmd("quit")
					end
				end,
			})
		end,
		cmd = { "NERDTree", "NERDTreeToggle", "NERDTreeFind" }
	}, -- Git integration
	{
		"tpope/vim-fugitive",
		cmd = { "Git", "Gstatus", "Gblame", "Gpush", "Gpull" }
	}, -- Status line
	{
		"nvim-lualine/lualine.nvim",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		event = "VeryLazy",
		opts = {
			options = {
				theme = "auto"
			}
		}
	}, -- Colorschemes
	{
		"EdenEast/nightfox.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme nightfox]])
		end
	} }
