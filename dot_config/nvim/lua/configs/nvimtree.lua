-- 1. Disable netrw (Best practice: also keep these in init.lua)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- 2. Optional: Enable 24-bit color
vim.opt.termguicolors = true

local status_ok, nvimtree = pcall(require, "nvim-tree")
if not status_ok then
  return
end

-- 3. Define the on_attach function to handle internal keybinds
local function my_on_attach(bufnr)
  local api = require("nvim-tree.api")

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- Load all default mappings first
  api.config.mappings.default_on_attach(bufnr)

  -- IMPORTANT: Unmap <C-x> inside the tree buffer so it doesn't conflict 
  -- with your global toggle key. 
  vim.keymap.del('n', '<C-x>', { buffer = bufnr })
end

-- 4. Setup nvim-tree
nvimtree.setup({
  on_attach = my_on_attach, -- This is the secret sauce
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

-- 5. The Global Toggle Mapping
-- We use a function call here to ensure it works even if focus is lost.
vim.keymap.set("n", "<C-x>", function()
  require("nvim-tree.api").tree.toggle({ focus = true, find_file = true })
end, { 
  silent = true, 
  desc = "Toggle nvim-tree" 
})
