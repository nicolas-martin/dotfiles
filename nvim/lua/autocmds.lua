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

-- force spaces in YAML
autocmd("FileType", {
	pattern = "yaml",
	callback = function()
		vim.opt_local.expandtab = true -- use spaces
		vim.opt_local.tabstop = 4
		vim.opt_local.shiftwidth = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.signcolumn = "yes"
	end,
})
local files = { "rust",
	"javascript",
	"typescript",
	"typescriptreact",
	"proto",
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


vim.api.nvim_create_user_command("Vins", function(opts)
	local expr = opts.args
	local ok, result = pcall(load("return " .. expr))
	if ok then
		print(vim.inspect(result))
	else
		print("Error evaluating expression: " .. result)
	end
end, { nargs = 1, desc = "Evaluate and inspect a Lua expression" })

vim.cmd [[
  cabbrev <expr> vi getcmdline() == "vi" ? "lua print(vim.inspect(" : getcmdline()
]]


-- local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*.go",
--   callback = function()
--    require('go.format').goimports()
--   end,
--   group = format_sync_grp,
-- })
--
-- Format on save
-- false causes some issue
-- true causes weird formatting..
-- BUG: https://github.com/neovim/neovim/issues/33224
-- autocmd("BufWritePre", {
-- 	callback = function()
-- 		vim.lsp.buf.format({ async = false })
-- 	end,
-- })

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("lsp", { clear = true }),
	callback = function(args)
		local ft = vim.bo[args.buf].filetype
		-- skip go since we're already setting it up in the plugin
		if ft == "go" then return end
		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = args.buf,
			callback = function()
				vim.lsp.buf.format { async = false, id = args.data.client_id }
			end,
		})
	end,
})

-- Format json with jq pipe
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = "*.json",
	callback = function()
		local buf = vim.api.nvim_get_current_buf()
		local input = table.concat(vim.api.nvim_buf_get_lines(buf, 0, -1, false), "\n")

		local result = vim.system({ "jq", "." }, { stdin = input }):wait()

		if result.code == 0 then
			local output = vim.split(result.stdout, "\n", { trimempty = true })
			vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
		else
			vim.notify("jq error: " .. result.stderr, vim.log.levels.ERROR)
		end
	end,
})
