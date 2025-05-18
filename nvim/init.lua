vim.g.mapleader = " "

local opt = vim.opt

opt.shell = 'pwsh'
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.wrap = false
opt.tabstop = 4    -- number of tabs
opt.shiftwidth = 4 -- number of indentation
opt.softtabstop = 4
opt.iskeyword:append('-')
opt.mouse:append('a')
opt.clipboard:append('unnamedplus')
opt.encoding = 'UTF-8'
opt.completeopt = 'menuone,noinsert,noselect'
opt.textwidth = 100

-- Search
opt.incsearch = true
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
-- Behavior
-- opt.hidden = true
opt.errorbells = false
opt.swapfile = false
opt.backup = false
opt.backspace = 'indent,eol,start'
opt.splitright = true
opt.splitbelow = true
opt.autochdir = false
opt.modifiable = true
opt.encoding = 'UTF-8'

local opts = { noremap = true, silent = true }
vim.keymap.set("v", "p", '"_dP', opts)                    -- paste preserves primal yanked piece
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", opts) -- remove highlight

-- window movement
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = false })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = false })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = false })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = false })

-- only press < or > once in visual mode to indent
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- move lines up and down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

-- highlight yanking
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("lazyvim_" .. "highlight_yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ timeout = 500 })
    end,
})

if vim.g.vscode then
    local explorer = function()
        vim.fn.VSCodeNotify("workbench.view.explorer")
    end
    vim.keymap.set({ 'n', 'v' }, "<leader>e", explorer)

    local toggleSidebarVisibility = function()
        vim.fn.VSCodeNotify("workbench.action.toggleSidebarVisibility")
    end
    vim.keymap.set({ 'n', 'v' }, "<leader>m", toggleSidebarVisibility)

    local openRecent = function()
        vim.fn.VSCodeNotify("workbench.action.openRecent")
    end
    vim.keymap.set({ 'n', 'v' }, "<leader>r", openRecent)

    local quickTextSearch = function()
        vim.fn.VSCodeNotify("workbench.action.quickTextSearch")
    end
    vim.keymap.set({ 'n', 'v' }, "<leader>q", quickTextSearch)

    local openDefinitionToSide = function()
        vim.fn.VSCodeNotify("editor.action.revealDefinitionAside")
    end
    vim.keymap.set({ 'n', 'v' }, "gd", openDefinitionToSide)

    local peekTypeDefinition = function()
        vim.fn.VSCodeNotify("editor.action.peekTypeDefinition")
    end
    vim.keymap.set({ 'n', 'v' }, "gt", peekTypeDefinition)

    local peekImplementation = function()
        vim.fn.VSCodeNotify("editor.action.peekImplementation")
    end
    vim.keymap.set({ 'n', 'v' }, "gi", peekImplementation)
else
    opt.number = true
    opt.relativenumber = true
    opt.cmdheight = 1
    opt.scrolloff = 10

    vim.keymap.set("n", "<C-d>", "<C-d>zz", opts)
    vim.keymap.set("n", "<C-u>", "<C-u>zz", opts)

    vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", opts)          -- Split Vertically
    vim.keymap.set("n", "<leader>sh", ":split<CR>", opts)           -- Split Horizontally
    vim.keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>", opts) -- Toggle Minimize
end

require("config")
