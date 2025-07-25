-- Ensure lazy.nvim is installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable", -- latest stable release
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Set leader key
vim.g.mapleader = ','

-- Load plugins using lazy.nvim
require("lazy").setup({
	--@type require('lazy').spec
	spec = {
		-- add LazyVim and import its plugins
		-- They're so good, should find the best one/configs
		-- and extract them
		-- { "LazyVim/LazyVim", import = "lazyvim.plugins" },
		-- import/override with your plugins
		{ import = "plugins" },
	},
	defaults = {
		notify = function(msg)
			vim.schedule(function()
				vim.notify(msg, vim.log.levels.INFO, { title = "!Lazy.nvim" })
			end)
		end,
	},

	change_detection = { enabled = false },
	install = { colorscheme = { "catppuccin", "habamax" } },
	checker = { enabled = false },
	lockfile = "~/dotfiles/nvim/lua/config/lazy-lock.json",
	performance = {
		rtp = {
			---@type string[] list any plugins you want to disable here
			disabled_plugins = {
				"gzip",
				"matchit",
				"matchparen",
				"netrwPlugin",
				"tarPlugin",
				"tohtml",
				"tutor",
				"zipPlugin",
			},
		},
	},
})
