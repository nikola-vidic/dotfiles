local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- local options = {
--
--     defaults = {
--         lazy = true,
--     },
--     rtp = {
--         disabled_plugins = {
--             "gzip",
--             "matchit",
--             "matchparen",
--             "netrwPlugin",
--             "tarPlugin",
--             "tohtml",
--             "tutor",
--             "zipPlugin",
--         },
--     },
--     change_detection = {
--         notify = true,
--     },
-- }

local plugins = {}

-- import your plugins
if vim.g.vscode then
	plugins = { { import = "plugins" } }
else
	plugins = {
		{ import = "plugins" },
		{ import = "plugins.nvim" },
	}
end
-- require("lazy").setup(plugins, options)
require("lazy").setup({
	spec = plugins,
	-- automatically check for plugin updates
	checker = { enabled = false },
})
