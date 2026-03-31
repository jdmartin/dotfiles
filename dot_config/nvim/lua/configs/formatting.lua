-- === FORMATTING & EDITOR BEHAVIOR ===

local opt = vim.opt

opt.wrap = true           -- Always wrap long lines
opt.expandtab = true      -- Use spaces instead of tabs
opt.tabstop = 4           -- Number of spaces a tab counts for
opt.shiftwidth = 4        -- Size of an indent

-- Security: Mitigate ACE vulnerability by disabling modelines
opt.modelines = 0
opt.modeline = false

-- Show matching brackets
opt.showmatch = true      -- (Implied by matchtime, but good to be explicit)
opt.matchtime = 2         -- Tenths of a second to show matching brackets
