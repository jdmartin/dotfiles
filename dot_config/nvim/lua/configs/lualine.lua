-- === LUALINE CONFIGURATION ===

-- 1. Essential UI settings for Global Status and Tabline
vim.opt.showtabline = 2
vim.opt.laststatus = 3

-- 2. Safely load lualine
local status, lualine = pcall(require, "lualine")
if not status then return end

lualine.setup({
  options = {
    theme = 'dracula',
    globalstatus = true,
    icons_enabled = false,
    section_separators = { left = ' ', right = ' ' },
    component_separators = { left = '|', right = '|' },
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  tabline = {
    -- Buffers in the tabline for easy navigation
    lualine_a = {
      {
        'buffers',
        show_filename_only = true,
        mode = 2, -- Showing index and filename
        max_length = vim.opt.columns:get() * 4 / 5,
        buffers_color = {
          active = 'lualine_a_normal',
          inactive = 'lualine_b_visual',
        },
        symbols = { alternate_file = '' },
        separator = { left = '  ', right = '  ' },
      }
    },
    lualine_z = {'tabs'}
  },
})
