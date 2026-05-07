require('gitsigns').setup({
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 300,
    virt_text_pos = 'right_align',
  },
  current_line_blame_formatter = '<author>, <author_time:%R>',
})
