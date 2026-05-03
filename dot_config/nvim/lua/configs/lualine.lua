-- === LUALINE CONFIGURATION ===
vim.opt.laststatus = 3
local status, lualine = pcall(require, "lualine")
if not status then return end
lualine.setup({
  options = {
    theme = 'dracula',
    globalstatus = true,
    icons_enabled = true,
    section_separators = { left = ' ', right = ' ' },
    component_separators = { left = '|', right = '|' },
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_e = {'searchcount'},
    lualine_x = {'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
})
