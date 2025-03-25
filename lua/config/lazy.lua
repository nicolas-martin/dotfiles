-- Ensure lazy.nvim is installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
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
	defaults = {
		notify = function(msg)
			vim.schedule(function()
				vim.notify(msg, vim.log.levels.INFO, { title = "!Lazy.nvim" })
			end)
		end,
	},
	spec = { { import = "plugins" } },
	install = { colorscheme = { "habamax" } },
	-- colorscheme = function()
	-- 	require("tokyonight").load()
	-- end,
	checker = { enabled = false },
	lockfile = "~/dotfiles/lua/config/lazy-lock.json",
	performance = {
		rtp = {
			---@type string[] list any plugins you want to disable here
			disabled_plugins = {
				-- "gzip",
				-- "matchit",
				-- "matchparen",
				"netrwPlugin",
				-- "tarPlugin",
				-- "tohtml",
				-- "tutor",
				-- "zipPlugin",
			},
		},
	},
})
