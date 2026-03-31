-- === Theme Tweaks ===

-- 1. Dracula Initial Setup
vim.g.dracula_colorterm = 0
vim.cmd([[colorscheme dracula]])

-- 2. Highlight Overrides
-- Using the Neovim API for better performance and clarity
local set_hl = vim.api.nvim_set_hl

-- Line Numbers: Subtle dark grey
set_hl(0, "LineNr", { fg = "#44475a", bg = "NONE" })

-- Search: Grey text on blue background
set_hl(0, "Search", { fg = "#f8f8f2", bg = "#6272a4" })

-- CursorLine: Horizontal highlight
vim.opt.cursorline = true
set_hl(0, "CursorLine", { bg = "#3e3e3e", ctermbg = 235 })

-- 3. iTerm2 Cursor Shape & Color
-- Neovim handles cursor shapes via 'guicursor' instead of 't_SI' escape codes.
-- This is much cleaner and works across most modern terminals.
if os.getenv("TERM_PROGRAM") == "iTerm.app" then
  vim.opt.guicursor = {
    -- n-v-c: Normal, Visual, Command-line (Block cursor, Indiglo-ish color)
    "n-v-c:block-Cursor-blinkwait175-blinkoff150-blinkon175",
    -- i-ci-ve: Insert, Command-line Insert, Visual-exclude (Vertical bar, Green)
    "i-ci-ve:ver25-CursorInsert-blinkwait175-blinkoff150-blinkon175",
    -- r-cr: Replace (Underline, Orange)
    "r-cr:hor20-CursorReplace-blinkwait175-blinkoff150-blinkon175",
  }

  -- Define the highlight groups used in 'guicursor' above
  set_hl(0, "Cursor", { bg = "#5ac499", fg = "black" })        -- Normal (Indiglo)
  set_hl(0, "CursorInsert", { bg = "#00FF00", fg = "black" })  -- Insert (Green)
  set_hl(0, "CursorReplace", { bg = "#ffb86c", fg = "black" }) -- Replace (Orange)
end
