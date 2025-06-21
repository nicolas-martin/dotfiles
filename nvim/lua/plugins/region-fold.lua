return {
	{
		dir = "/Users/nma/dev/region-folding",
		name = "region-folding",
		event = { "BufReadPost", "BufNewFile" },
		priority = 1000,
		config = function()
			-- Debug info
			print("Loading region-folding plugin...")

			local ok, plugin = pcall(require, 'region-folding')
			if not ok then
				print("❌ Failed to load region-folding: " .. tostring(plugin))
				return
			end

			plugin.setup({
				region_text = { start = "#region", ending = "#endregion" },
				space_after_comment = true,
				fold_indicator = "▼",
				debug = false,
			})
			print("✅ Region-folding plugin loaded successfully")
		end,
	}
}
