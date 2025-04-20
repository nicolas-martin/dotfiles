return {
    "nma/region-folding.nvim",
    event = {"BufReadPost", "BufNewFile"},
    config = function()
        require("region-folding").setup()
    end,
    dependencies = {"nvim-treesitter/nvim-treesitter"}
}
