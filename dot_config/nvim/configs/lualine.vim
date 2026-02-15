lua << EOF
require('lualine').setup({
  options = {
    theme = 'dracula',
    globalstatus = true,
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
    -- We put them in lualine_a so they HAVE to be visible and colored
    lualine_a = {
      {
        'buffers',
        show_filename_only = true,
        mode = 2, -- [1] filename.php
        max_length = vim.o.columns * 4 / 5,
        -- High contrast colors using the theme's built-in palettes
        buffers_color = {
          active = 'lualine_a_normal',     -- Bright (usually Purple/Pink)
          inactive = 'lualine_b_visual',   -- Darker but visible
        },
        symbols = { alternate_file = '' },
        separator = { left = '  ', right = '  ' },
      }
    },
    lualine_z = {'tabs'}
  },
})

-- The critical settings to make sure the UI renders
vim.opt.showtabline = 2
vim.opt.laststatus = 3
EOF
