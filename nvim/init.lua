vim.g.mapleader = " "

vim.opt.shell = "pwsh"

vim.opt.expandtab = true
vim.opt.shiftwidth = 4 -- number of indentation
vim.opt.tabstop = 4    -- number of tabs
vim.opt.softtabstop = 4

vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true -- Keep identation from previous line

-- Enable break indent
vim.opt.breakindent = true

-- Store undos between sessions
vim.opt.undofile = true

vim.opt.wrap = false
vim.opt.iskeyword:append("-")
vim.opt.mouse:append("a")
vim.opt.clipboard:append("unnamedplus")
vim.opt.encoding = "UTF-8"
vim.opt.completeopt = "menuone,noinsert,noselect"

-- Search
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

-- No bell
vim.opt.errorbells = false
--
-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

local opts = { noremap = true, silent = true }

-- window movement
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = false })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = false })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = false })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = false })

-- Always show relative line numbers
vim.opt.number = true
vim.opt.relativenumber = true
-- Keep signcolumn on by default
vim.opt.signcolumn = "yes"
-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

local common_mappings = {
	-- { { 'v', }, 'p',     '_dP' },
	{ { "n" },      "<Esc>",     ":noh<CR>" },
	-- only press < or > once in visual mode to indent
	{ { "v" },      "<",         "<gv" },
	{ { "v" },      ">",         ">gv" },
	-- move lines up and down
	{ { "v" },      "J",         ":m '>+1<CR>gv=gv" },
	{ { "v" },      "K",         ":m '<-2<CR>gv=gv" },
	{ { "n", "v" }, "<leader>s", ":SearchWeb<CR>" },
}

for _, mapping in ipairs(common_mappings) do
	local mode, key, command = mapping[1], mapping[2], mapping[3]
	vim.keymap.set(mode, key, command, opts)
end

-- highlight yanking
vim.api.nvim_create_autocmd("TextYankPost", {
	group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank({ timeout = 500 })
	end,
})

if vim.g.vscode then
	local mappings = {
		{ { "n" },      "[d",         "editor.action.marker.prevInFiles" },
		{ { "n" },      "]d",         "editor.action.marker.nextInFiles" },
		{ { "n" },      "<leader>ta", "testing.runAll" },
		{ { "n" },      "<leader>tf", "testing.runCurrentFile" },
		{ { "n" },      "<leader>ff", "actions.find" },
		{ { "n" },      "<leader>fr", "references-view.findReferences" },
		{ { "n" },      "<leader>g",  "currentBranchInfo.focus" },
		{ { "n" },      "<leader>r",  "editor.action.rename" },
		{ { "n" },      "<leader>tt", "testing.runAtCursor" },
		{ { "n" },      "<leader>b",  "workbench.action.tasks.build" },
		{ { "n" },      "<S-Tab>",    "workbench.action.previousEditorInGroup" },
		{ { "n" },      "<Tab>",      "workbench.action.nextEditorInGroup" },
		{ { "n" },      "b",          "cursorWordPartLeft" },
		{ { "n" },      "gd",         "editor.action.revealDefinition" },
		{ { "n" },      "gi",         "editor.action.peekImplementation" },
		{ { "n" },      "gl",         "editor.action.revealDefinitionAside" },
		{ { "n" },      "gt",         "editor.action.peekTypeDefinition" },
		{ { "n" },      "w",          "cursorWordPartRight" },
		{ { "n", "v" }, "[f",         "search.action.focusPreviousSearchResult" },
		{ { "n", "v" }, "]f",         "search.action.focusNextSearchResult" },
		{ { "n", "v" }, "<leader>e",  "workbench.view.explorer" },
		{ { "n", "v" }, "<leader>m",  "workbench.action.toggleSidebarVisibility" },
		{ { "n", "v" }, "<leader>o",  "workbench.action.openRecent" },
		{ { "n", "v" }, "<leader>q",  "workbench.action.quickTextSearch" },
		{ { "v" },      "<leader>p",  "PowerShell.RunSelection" },
	}

	for _, mapping in ipairs(mappings) do
		local mode, key, command = mapping[1], mapping[2], mapping[3]
		vim.keymap.set(mode, key, function()
			vim.fn.VSCodeNotify(command)
		end)
	end
else
	local mappings = {
		{ { "n" },      "<C-d>",      "<C-d>zz" },
		{ { "n" },      "<C-u>",      "<C-u>zz" },
		{ { "n" },      "<leader>sv", ":vsplit<CR>" },    -- Split Vertically
		{ { "n" },      "<leader>sh", ":split<CR>" },     -- Split Horizontally
		{ { "n" },      "<leader>sm", ":MaximizerToggle<CR>" }, -- Toggle Minimize
		{ { "n" },      "-",          "<cmd>Oil --float<CR>" },
		{ { "v", "n" }, "<C-s>",      ":w<CR>" },
	}

	for _, mapping in ipairs(mappings) do
		local mode, key, command = mapping[1], mapping[2], mapping[3]
		vim.keymap.set(mode, key, command, opts)
	end

	vim.pack.add {
		"https://github.com/neovim/nvim-lspconfig",
		"https://github.com/stevearc/oil.nvim",
	}

	require("oil").setup()

	vim.cmd.colorscheme("catppuccin")

	-- Enable for all clients
	vim.lsp.on_type_formatting.enable()
	-- Enable for a specific client
	vim.api.nvim_create_autocmd('LspAttach', {
		callback = function(args)
			vim.o.signcolumn = "yes:1"
			local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
			if client:supports_method('textDocument/completion') then
				vim.o.complete = 'o,.,w,b,u'
				vim.o.completeopt = 'menu,menuone,popup,noinsert'
				vim.lsp.completion.enable(true, client.id, args.buf)
			end
		end,
	})
end
