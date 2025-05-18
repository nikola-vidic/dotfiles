local config = function()
    require("nvim-surround").setup({})
end

return {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    config = config
}
