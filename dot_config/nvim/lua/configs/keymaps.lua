-- === keymaps.lua ===
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- === BASIC NAVIGATION & UI ===

-- Close all panes and quit without saving
keymap("n", "<Leader>,", ":qa!<CR>:FloatermKill<CR>", opts)

-- Toggle Search Highlighting
keymap("n", "<leader><space>", ":noh<CR>", opts)

-- Toggle between relative and absolute line numbers
keymap("n", "<Leader>rn", ":set relativenumber!<CR>", opts)

-- Select all
keymap("n", "<Leader>a", "ggVG<CR>", opts)

-- Move between windows (from your Vim config)
keymap("n", "<leader><Tab>", "<C-W>w", opts)
keymap("n", "<leader><S-Tab>", "<C-W>W", opts)

-- Tabs
keymap("n", "<Leader>t", ":tabnew<CR>", opts)
keymap("n", "gf", ":tabe <cfile><CR>", opts)

-- Map :%s/ to <leader>s (Note: no <CR> because we want to type the rest)
keymap("n", "<leader>s", ":%s/", { noremap = true })

-- Command abbreviation for terminal
vim.cmd([[cabbrev bterm bo term]])

-- Keep selection when indenting in Visual Mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- === TAB INDENTATION (Visual Mode) ===
-- xnoremap handles visual mode specifically
keymap("x", "<Tab>", ":s/^/\\t/<CR>:nohl<CR>", opts)
keymap("x", "<S-Tab>", ":s/^\\t//<CR>:nohl<CR>", opts)

-- Find settings
vim.keymap.set("n", "<C-p>", ":find *", { noremap = true })

-- --- Telescope Search Mappings ---

-- local builtin = require('telescope.builtin')

-- Find Files (Old Ctrl-P style)
-- keymap("n", "<C-p>", builtin.find_files, opts)

-- Live Grep (Search text inside files - requires ripgrep)
-- keymap("n", "<leader>lg", builtin.live_grep, opts)

-- Search Open Buffers
-- keymap("n", "<leader>b", builtin.buffers, opts)

-- Search LSP Symbols (Shows all functions/variables in current file)
-- keymap("n", "<leader>is", builtin.lsp_document_symbols, opts)

-- Resume last search (Very handy!)
-- keymap("n", "<leader>rr", builtin.resume, opts)

-- === LSP & DIAGNOSTICS (The Built-in Way) ===

-- Navigation (Jump to Errors)
keymap("n", "<leader>e", function()
    vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })
end, opts)

keymap("n", "<leader>E", function()
    vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })
end, opts)

-- Toggle Trouble (Your diagnostic list)
keymap("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", opts)

-- Insert Date (NA format)
keymap("i", "<Leader>;", function()
    return os.date("%b %d, %Y")
end, { expr = true })

-- === JQ SMART FORMATTING ===
if vim.fn.executable('jq') == 1 then
    -- Format entire buffer in JSON files
    vim.api.nvim_create_autocmd("FileType", {
        pattern = "json",
        callback = function()
            keymap("n", "<Leader>j", ":%!jq .<CR>", { buffer = true, noremap = true })
        end,
    })
    -- Format visual selection in ANY file
    keymap("v", "<Leader>j", ":!jq .<CR>", opts)
end
