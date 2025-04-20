local use_local = vim.fn.getenv("NVIM_REGION_FOLDING_DEV") == "1"
local dev_path = "/Users/nma/dev/region-folding"

return {
    dir = use_local and dev_path or nil,
    url = not use_local and "https://github.com/nicolas-martin/region-folding.nvim" or nil,
    name = "region-folding.nvim",
    event = {"BufReadPost", "BufNewFile"},
	enabled = use_local,
	opts = {
        debug = true
	},
    dependencies = {"nvim-treesitter/nvim-treesitter"}
}
