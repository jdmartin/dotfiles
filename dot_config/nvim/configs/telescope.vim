lua << EOF
local telescope = require('telescope')
local previewers = require('telescope.previewers')

telescope.setup({
  defaults = {
    -- 1. Use the 'cat' previewer (plain text) instead of the 'buffer' previewer
    -- This avoids the buggy highlighters completely.
    file_previewer = previewers.cat.new,
    grep_previewer = previewers.vimgrep.new,
    qflist_previewer = previewers.qflist.new,

    -- 2. Visual settings
    prompt_prefix = " 🔍 ",
    selection_caret = "  ",
    sorting_strategy = "ascending",
    layout_config = {
      horizontal = {
        prompt_position = "top",
        preview_width = 0.5,
      },
      width = 0.9,
      height = 0.8,
    },
  },
  pickers = {
    find_files = {
      -- Let's go back to standard Telescope file finding
      -- but keep it simple to ensure the list isn't empty.
      hidden = true
    },
  },
})

pcall(telescope.load_extension, 'fzf')
EOF
