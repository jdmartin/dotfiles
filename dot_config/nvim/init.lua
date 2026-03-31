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

-- === NATIVE PLUGIN MANAGEMENT (Neovim 0.12+) ===
-- Automate hooks (like Treesitter update)
vim.api.nvim_create_autocmd('PackChanged', {
  callback = function(ev)
    if ev.data.spec.name == 'nvim-treesitter' and ev.data.kind == 'update' then
      vim.cmd('TSUpdate')
    end
  end
})

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
    { 
      src = 'https://github.com/nvim-treesitter/nvim-treesitter', 
      version = 'master',
      build = ':TSUpdate' 
    },
    'https://github.com/folke/trouble.nvim',
    'https://github.com/nvim-lua/plenary.nvim',
    'https://github.com/nvim-lualine/lualine.nvim',
    'https://github.com/nvim-telescope/telescope-fzf-native.nvim',
    'https://github.com/nvim-telescope/telescope.nvim',
    'https://github.com/preservim/nerdtree',
    'https://github.com/chentoast/marks.nvim',
    'https://github.com/MeanderingProgrammer/render-markdown.nvim',
})

-- === Trouble Setup ===
require("trouble").setup()
vim.keymap.set("n", "<leader>d", function()
  require("trouble").toggle("diagnostics")
end, { desc = "Toggle Trouble Diagnostics" })

-- === MISC CONFIG FILES ===
local config_path = vim.fn.stdpath("config") .. "/configs/"

local vim_configs = {
  "completion",
  "floating-term",
  "formatting",
  "keymaps",
  "lsp-related",
  "lualine",
  "nerdtree",
  "search-related",
  "telescope",
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
