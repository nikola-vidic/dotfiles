-- ============================================================================
-- OPTIONS
-- ============================================================================
vim.g.mapleader = " "

if vim.loop.os_uname().sysname == 'Windows_NT' then
    vim.o.shell = 'pwsh'
    vim.o.shellcmdflag =
    '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
    vim.o.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    vim.o.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    vim.o.shellquote = ''
    vim.o.shellxquote = ''
end

vim.o.autocomplete = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 4 -- number of indentation
vim.opt.tabstop = 4    -- number of tabs
vim.opt.softtabstop = 4
vim.opt.smarttab = true
vim.opt.smartindent = true
vim.opt.autoindent = true -- Keep identation from previous line

vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.showmatch = true

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
--
-- Performance improvements
vim.opt.synmaxcol = 300  -- Syntax highlighting limit
vim.opt.updatetime = 300 -- Faster completion
vim.opt.redrawtime = 10000
vim.opt.maxmempattern = 20000

local opts = { noremap = true, silent = true }

-- window movement
vim.api.nvim_set_keymap("n", "<C-h>", "<C-w>h", { noremap = false })
vim.api.nvim_set_keymap("n", "<C-j>", "<C-w>j", { noremap = false })
vim.api.nvim_set_keymap("n", "<C-k>", "<C-w>k", { noremap = false })
vim.api.nvim_set_keymap("n", "<C-l>", "<C-w>l", { noremap = false })

local common_mappings = {
    -- { { 'v', }, 'p',     '_dP' },
    { { "n" }, "<Esc>", "<cmd>nohlsearch<CR>" },
    -- only press < or > once in visual mode to indent
    { { "v" }, "<",     "<gv" },
    { { "v" }, ">",     ">gv" },
    -- move lines up and down
    { { "v" }, "J",     ":m '>+1<CR>gv=gv" },
    { { "v" }, "K",     ":m '<-2<CR>gv=gv" },
}

for _, mapping in ipairs(common_mappings) do
    local mode, key, command = mapping[1], mapping[2], mapping[3]
    vim.keymap.set(mode, key, command, opts)
end

if vim.g.vscode then
    local mappings = {
        { { "n", "v" }, "<leader>e",  "workbench.view.explorer" },
        { { "n", "v" }, "<leader>m",  "workbench.action.toggleSidebarVisibility" },
        { { "n", "v" }, "<leader>o",  "workbench.action.openRecent" },
        { { "n", "v" }, "<leader>q",  "workbench.action.quickTextSearch" },
        { { "n" },      "<leader>ff", "actions.find" },
        { { "n" },      "<leader>fr", "references-view.findReferences" },
        { { "n" },      "<leader>r",  "editor.action.rename" },
        { { "n" },      "<leader>d",  "workbench.action.debug.start" },
        { { "n" },      "<leader>k",  "editor.debug.action.toggleBreakpoint" },
        { { "n" },      "<leader>b",  "workbench.action.tasks.build" },
        { { "n" },      "<leader>x",  "workbench.action.tasks.test" },
        { { "n" },      "gl",         "editor.action.revealDefinitionAside" },
        { { "n" },      "gd",         "editor.action.revealDefinition" },
        { { "n" },      "gi",         "editor.action.peekImplementation" },
        { { "n" },      "gt",         "editor.action.peekTypeDefinition" },
        { { "n" },      "w",          "cursorWordPartRight" },
        { { "n" },      "b",          "cursorWordPartLeft" },
        { { "n" },      "]d",         "editor.action.marker.nextInFiles" },
        { { "n" },      "[d",         "editor.action.marker.prevInFiles" },
        { { "n" },      "]c",         "editor.action.dirtydiff.next" },
        { { "n" },      "[c",         "editor.action.dirtydiff.previous" },
        { { "n" },      "]e",         "workbench.action.compareEditor.nextChange" },
        { { "n" },      "[e",         "workbench.action.compareEditor.previousChange" },
        { { "n", "v" }, "]f",         "search.action.focusNextSearchResult" },
        { { "n", "v" }, "[f",         "search.action.focusPreviousSearchResult" },
        { { "n" },      "<Tab>",      "workbench.action.nextEditorInGroup" },
        { { "n" },      "<S-Tab>",    "workbench.action.previousEditorInGroup" },
        { { "n" },      "<leader>g",  "currentBranchInfo.focus" },
        { { "n" },      "<leader>tt", "testing.runAtCursor" },
        { { "n" },      "<leader>ta", "testing.runAll" },
        { { "n" },      "<leader>tf", "testing.runCurrentFile" },
        { { "n" },      "<leader>s",  "workbench.action.showAllSymbols" },
        { { "v" },      "<leader>p",  "PowerShell.RunSelection" },
        { { "n" },      "<leader>a",  "git.diff.stageHunk" },
        { { "v" },      "<leader>a",  "git.stageSelectedRanges" },
        { { "v" },      "<leader>u",  "git.unstageSelectedRanges" },
    }

    for _, mapping in ipairs(mappings) do
        local mode, key, command = mapping[1], mapping[2], mapping[3]
        vim.keymap.set(mode, key, function()
            vim.fn.VSCodeNotify(command)
        end, opts)
    end
    vim.o.cmdheight = 1000
else
    local mappings = {
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
        'https://github.com/stevearc/oil.nvim',
    }

    require("oil").setup()

    vim.cmd.colorscheme("catppuccin")
end


-- ============================================================================
-- USER COMMANDS
-- ============================================================================

-- highlight yanking
vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ timeout = 500 })
    end,
})

vim.keymap.set({ 'v', 'n' }, '<leader>c', ':GitWebUiUrlCopy<CR>')

local function get_real_path()
    local p = vim.fn.expand("%:p")

    -- VSCode WSL remote path?
    if p:match("^vscode%-remote://") then
        -- Decode %2B → +
        local decoded = p:gsub("%%2B", "+")

        -- Extract distro and path
        local distro, wsl_path =
            decoded:match("^vscode%-remote://wsl%+(.-)(/.+)$")

        if distro and wsl_path then
            return {
                is_wsl = true,
                distro = distro,
                path = wsl_path,
            }
        end
    end

    -- Normal Windows path
    return {
        is_wsl = false,
        path = p,
    }
end

vim.api.nvim_create_user_command('GitWebUiUrlCopy', function(arg)
    local info = get_real_path()
    local file_path_abs = info.path

    -- Convert file to directory
    local dir = info.path:gsub("[/\\]+$", "") -- strip trailing slash
    dir = vim.fn.fnamemodify(dir, ":h")    -- get directory

    local line_start = arg.line1
    local line_end = arg.line2

    local cmd_relative_path
    local cmd_git_origin
    local cmd_git_branch

    if info.is_wsl then
        cmd_relative_path = string.format('wsl -d %s git -C "%s" ls-files --full-name "%s"', info.distro, dir,
            file_path_abs)
        cmd_git_origin = string.format('wsl -d %s git -C %s remote get-url origin', info.distro, dir)
        cmd_git_branch = string.format('wsl -d %s git -C %s branch --show-current', info.distro, dir)
    else
        cmd_relative_path = string.format('git -C "%s" ls-files --full-name "%s"', dir, file_path_abs)
        cmd_git_origin = string.format('git -C %s remote get-url origin', dir)
        cmd_git_branch = string.format('git -C %s branch --show-current', dir)
    end

    local cmd_handle_relative_path = io.popen(cmd_relative_path)
    local file_path_relative = cmd_handle_relative_path:read("*a")
    file_path_relative = string.gsub(file_path_relative, "%s+$", "")
    cmd_handle_relative_path:close()

    local cmd_handle_git_origin = io.popen(cmd_git_origin)
    local git_origin = cmd_handle_git_origin:read("*a")
    git_origin = string.gsub(git_origin, "%s+$", "")
    cmd_handle_git_origin:close()

    local cmd_handle_git_branch = io.popen(cmd_git_branch)
    local git_branch = cmd_handle_git_branch:read("*a")
    git_branch = string.gsub(git_branch, "%s+$", "")
    cmd_handle_git_branch:close()

    local url = ''
    if string.match(git_origin, 'gitlab') then
        for host, user, project in string.gmatch(git_origin, 'git@([^:]+):(.+)/([^/]+).git') do
            url = 'http://' ..
                host ..
                '/' ..
                user ..
                '/' ..
                project ..
                '/-/blob/' ..
                git_branch .. '/' .. file_path_relative .. '?ref_type=heads' .. '#L' .. line_start .. '-' .. line_end
            break
        end
    elseif string.match(git_origin, 'azure.com') then
        line_end = line_end + 1
        for host, org, dir, project in string.gmatch(git_origin, 'git@ssh%.([^:]+):v3/([^/]+)/([^/]+)/([^\n]+)') do
            url = 'https://' ..
                host ..
                '/' ..
                org ..
                '/' ..
                dir ..
                '/_git/' ..
                project ..
                '?path=/' ..
                file_path_relative ..
                '&version=GB' ..
                git_branch .. '&line=' .. line_start .. '&lineEnd=' .. line_end ..
                '&lineStartColumn=1&lineEndColumn=1&lineStyle=plain&_a=contents'
            break
        end
    end

    url = string.gsub(url, "%s+$", "")
    -- Copy to clipboard.
    vim.fn.setreg('+', url)
end, { force = true, range = true, nargs = 0, desc = 'Copy to clipboard a URL to a git webui for the current line' })
