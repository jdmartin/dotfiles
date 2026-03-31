-- === Search-Related ===

-- 1. Global Options (The 'set' commands)
local opt = vim.opt

opt.hlsearch = true   -- Highlight search results
opt.incsearch = true  -- Show search results as you type
opt.ignorecase = true -- Case-insensitive search...
opt.smartcase = true  -- ...unless a capital letter is used
opt.showmatch = true  -- Briefly jump to matching bracket

-- 2. Keybindings (The 'nnoremap' commands)
local keymap = vim.keymap.set

-- Use 'Very Magic' mode by default for regex
-- This makes / feel more like modern regex (Perl/Python)
keymap("n", "/", "/\\v", { noremap = true })

-- Center the screen when jumping between search results
-- 'zz' centers the line, 'zv' opens folds if the result is hidden
keymap("n", "n", "nzzzv", { noremap = true })
keymap("n", "N", "Nzzzv", { noremap = true })

-- 3. Clear highlighting
keymap("n", "<leader>h", ":nohlsearch<CR>", { silent = true })
