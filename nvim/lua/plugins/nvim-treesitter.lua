local config = function()
    require("nvim-treesitter.configs").setup({
        build = ":TSUpdate",
        autotag = {
            enable = true,
        },
        ensure_installed = {
            "c_sharp",
            "dockerfile",
            "git_config",
            "git_rebase",
            "gitignore",
            "html",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "python",
            "rust",
            "yaml",
        },
        auto_install = true,
        highlight = {
            enable = false,
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<CR>",
                node_incremental = "<CR>",
                scope_incremental = false,
                node_decremental = "<BS>",
            },
        },
    })
end

return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    config = config,
}
