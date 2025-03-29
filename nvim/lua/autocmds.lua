local autocmd = vim.api.nvim_create_autocmd

-- toggles the ft if there's no exntension
-- but that also means that the auto detect ft for conf
-- wont work
autocmd({ "BufReadPost", "BufEnter", "BufWritePost" }, {
	pattern = "*/[^./]*", -- matches files without "." in the filename
	callback = function(args)
		local bufnr = args.buf

		vim.defer_fn(function()
			if not vim.api.nvim_buf_is_valid(bufnr) then return end

			local line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""

			if line:match("^#!.*bash") then
				if vim.bo[bufnr].filetype ~= "bash" then
					vim.bo[bufnr].filetype = "bash"
				end
			else
				vim.defer_fn(function()
					local ft = vim.bo[bufnr].filetype
					if ft == "bash" then
						vim.bo[bufnr].filetype = ""
					end
				end, 150)
			end
		end, 50)
	end,
})

-- FileType specific settings
autocmd("FileType", {
	pattern = "go",
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.expandtab = false
		vim.opt_local.signcolumn = "yes"
	end,
})

local conf = { "conf", "bash" }

autocmd("FileType", {
	pattern = conf,
	callback = function()
		vim.opt_local.tabstop = 2
		vim.opt_local.shiftwidth = 2
		vim.opt_local.softtabstop = 2
		vim.opt_local.expandtab = false
		vim.opt_local.signcolumn = "yes"
	end,
})

local files = { "rust",
	"javascript",
	"typescript",
	"typescriptreact",
	"proto",
	"yaml",
	"lua",
	"javascriptreact",
}

autocmd("FileType", {
	pattern = files,
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.expandtab = false
		vim.opt_local.signcolumn = "yes"
	end,
})

-- Format on save
autocmd("BufWritePre", {
	callback = function()
		vim.lsp.buf.format({ async = false })
	end,
})

-- close if nvim-tree is the last buffer
vim.api.nvim_create_autocmd("BufEnter", {
	group = vim.api.nvim_create_augroup("NeoTreeAutoClose", { clear = true }),
	callback = function()
		-- defer check to allow buffer switch to complete
		vim.defer_fn(function()
			local wins = vim.api.nvim_list_wins()
			local real_win_count = 0
			local neo_tree_win = nil

			for _, win in ipairs(wins) do
				local buf = vim.api.nvim_win_get_buf(win)
				local ft = vim.api.nvim_buf_get_option(buf, "filetype")
				if ft ~= "neo-tree" then
					real_win_count = real_win_count + 1
				else
					neo_tree_win = win
				end
			end

			-- if no real windows, only neo-tree left
			if real_win_count == 0 and neo_tree_win then
				vim.cmd("quit")
			end
		end, 50) -- 50ms delay gives time for file picker to switch buffer
	end,
})
