return {
	-- Essential editing plugins
	{ "tpope/vim-repeat" },
	{ "tpope/vim-surround" },
	{ "tpope/vim-commentary" },
	-- File explorer
	{
		"preservim/nerdtree",
		enabled = false,
		init = function()
			local log_file = vim.fn.expand("~/.config/nvim/event_log.txt")

			local function log_event(event)
				local log_entry = string.format(
					"[%s] Event: %s, File: %s\n",
					os.date("%Y-%m-%d %H:%M:%S"),
					event.event,
					event.file or "N/A"
				)
				local file = io.open(log_file, "a")
				if file then
					file:write(log_entry)
					file:close()
				else
					print("Error: Unable to open log file.")
				end
			end

			vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
				callback = log_event,
			})

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

			-- Set up window navigation mappings for NERDTree buffer
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "nerdtree",
				callback = function()
					local opts = { buffer = true, noremap = true, silent = true }
					vim.keymap.set('n', '<C-h>', '<C-w>h', opts)
					vim.keymap.set('n', '<C-j>', '<C-w>j', opts)
					vim.keymap.set('n', '<C-k>', '<C-w>k', opts)
					vim.keymap.set('n', '<C-l>', '<C-w>l', opts)
				end
			})

			-- Auto open NERDTree when opening a directory
			vim.api.nvim_create_autocmd("VimEnter", {
				callback = function()
					if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) > 0 then
						-- Change to the directory
						vim.cmd("cd " .. vim.fn.argv(0))
						-- Open NERDTree in the current directory
						vim.cmd("NERDTreeToggle")
						-- Focus the other window
						-- vim.cmd("wincmd p")
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
