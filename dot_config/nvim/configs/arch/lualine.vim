lua << EOF
require('lualine').setup({
  options = {
    theme = 'auto', -- or any theme you prefer, like 'base16'
    section_separators = {'', ''},
    component_separators = {'', ''},
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename'},
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  extensions = {'fugitive', 'quickfix'}
})
EOF
