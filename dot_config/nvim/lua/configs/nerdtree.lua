-- === NERDTree Configuration ===

-- Toggle Tree with Ctrl+x
-- We use a string for the command since it's a legacy Vim command
vim.keymap.set("n", "<C-x>", ":NERDTreeToggle<CR>", { 
  silent = true, 
  desc = "Toggle NERDTree" 
})
