local M = {}

function M.log(msg)
	local logfile = vim.fn.stdpath("cache") .. "/cmp-debug.log"
	local f = io.open(logfile, "a")
	if f then
		f:write(os.date("%Y-%m-%d %H:%M:%S") .. " - " .. msg .. "\n")
		f:close()
	end
end

return M
