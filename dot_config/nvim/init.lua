-- === BASIC SETTINGS ===
-- Force Neovim to see the Homebrew path (common for ARM64 Macs)
vim.env.PATH = "/opt/homebrew/bin:" .. vim.env.PATH

-- Using vim.opt (global, window, and buffer-local options)
vim.opt.encoding = "utf-8"
vim.opt.number = true             -- Show line numbers
vim.opt.relativenumber = true     -- Show relative line numbers
vim.opt.confirm = true            -- Confirm on quit if unsaved changes
vim.opt.clipboard:append("unnamed") -- Use system clipboard
vim.opt.selection = "exclusive"   -- Don't grab gutter when selecting
vim.opt.swapfile = false          -- No swapfile
vim.opt.backspace = "indent,eol,start"
vim.opt.wildmenu = true           -- Wildmenu on
vim.opt.wildoptions = "pum"       -- Popup menu style
vim.opt.mouse = "a"               -- Enable mouse in all modes
vim.opt.path:append("**")

-- Tell Neovim to ignore these folders when searching
vim.opt.wildignore:append({ "*/node_modules/*", "*/.git/*", "*/vendor/*", "*/target/*" })

-- Enable 'wildmenu' for a much better UI when you hit Tab
vim.opt.wildmenu = true
vim.opt.wildmode = "longest:full,full"

-- === NATIVE PLUGIN MANAGEMENT (Neovim 0.12+) ===
-- Define and Load Plugins
vim.pack.add({
    'https://github.com/dracula/vim',
    'https://github.com/hrsh7th/cmp-nvim-lsp',
    'https://github.com/hrsh7th/cmp-buffer',
    'https://github.com/hrsh7th/cmp-path',
    'https://github.com/hrsh7th/cmp-cmdline',
    'https://github.com/hrsh7th/nvim-cmp',
    'https://github.com/neovim/nvim-lspconfig',
    'https://github.com/williamboman/mason.nvim',
    'https://github.com/williamboman/mason-lspconfig.nvim',
    'https://github.com/nvimtools/none-ls.nvim',
    'https://github.com/folke/trouble.nvim',
    'https://github.com/nvim-lualine/lualine.nvim',
    'https://github.com/nvim-tree/nvim-web-devicons',
    'https://github.com/akinsho/bufferline.nvim',
    'https://github.com/chentoast/marks.nvim',
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
    'https://github.com/nvim-tree/nvim-tree.lua',
    'https://github.com/lewis6991/gitsigns.nvim',
})

-- === Trouble Setup ===
require("trouble").setup()

vim.keymap.set("n", "<leader>d", function()
  require("trouble").toggle({ mode = "diagnostics", focus = true })
end, { desc = "Toggle Trouble Diagnostics (Focused)" })

-- === MISC CONFIG FILES ===
local config_path = vim.fn.stdpath("config") .. "/configs/"

local vim_configs = {
  "bufferline",
  "completion",
  "floating-term",
  "formatting",
  "gitsigns",
  "keymaps",
  "lsp-related",
  "lualine",
  "nvimtree",
  "search-related",
  "theme-tweaks",
}

for _, file in ipairs(vim_configs) do
  if file:match("%.vim$") then
    vim.cmd.source(vim.fn.stdpath("config") .. "/configs/" .. file)
  else
    -- This looks in ~/.config/nvim/lua/configs/
    require("configs." .. file)
  end
end

-- Loading native lua config
require("configs.marks") -- This looks for ~/.config/nvim/lua/marks.lua or configs/marks.lua

-- Source local tweaks if they exist
local local_vimrc = vim.fn.stdpath("config") .. "/vimrc.local"
if vim.fn.filereadable(local_vimrc) == 1 then
  vim.cmd.source(local_vimrc)
end

-- Persistent undo across sessions/restarts
vim.opt.undofile = true
vim.opt.undodir = "/private/tmp/nvim-undo//"
vim.opt.undolevels = 10000

local undodir = "/private/tmp/nvim-undo"
if vim.fn.isdirectory(undodir) == 0 then
  vim.fn.mkdir(undodir, "p", tonumber("700", 8))
end

local function read_patterns(path)
  path = vim.fn.expand(path)
  if vim.fn.filereadable(path) == 0 then
    return {}
  end
  local patterns = {}
  for _, line in ipairs(vim.fn.readfile(path)) do
    line = line:match("^%s*(.-)%s*$") -- trim
    if line ~= "" and not line:match("^#") then
      table.insert(patterns, line)
    end
  end
  return patterns
end

local sensitive_patterns = read_patterns("~/.config/nvim/sensitive_patterns.txt")

if #sensitive_patterns > 0 then
  vim.api.nvim_create_autocmd({ "BufReadPre", "BufNewFile" }, {
    pattern = sensitive_patterns,
    callback = function()
      vim.opt_local.undofile = false
      vim.opt_local.swapfile = false
    end,
  })
end
