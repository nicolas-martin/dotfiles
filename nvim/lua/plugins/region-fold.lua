return {
	{
		dir = "/Users/nma/dev/region-folding",
		"nicolas-martin/region-folding.nvim",
		dev = true,
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			region_text = { start = "#region", ending = "#endregion" },
			fold_indicator = "▼",
		}
	}
}
