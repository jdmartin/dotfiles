-- === TELESCOPE CONFIGURATION ===

local status, telescope = pcall(require, 'telescope')
if not status then return end

local previewers = require('telescope.previewers')

telescope.setup({
  defaults = {
    -- 1. Use plain text previewers (Fast & Reliable on Pis)
    file_previewer = previewers.cat.new,
    grep_previewer = previewers.vimgrep.new,
    qflist_previewer = previewers.qflist.new,

    -- 2. Visual settings (Clean & Functional)
    -- If Monaco doesn't show the magnifying glass, change to "Find:"
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
      hidden = true
    },
  },
})

-- Safely load the FZF extension (compiled C-extension)
pcall(telescope.load_extension, 'fzf')
