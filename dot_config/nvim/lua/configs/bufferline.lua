-- === BUFFERLINE CONFIGURATION ===
vim.opt.termguicolors = true  -- required for bufferline

local status, bufferline = pcall(require, "bufferline")
if not status then return end

bufferline.setup({
  options = {
    mode = "buffers",
    numbers = "ordinal",
    close_command = "bdelete! %d",
    right_mouse_command = nil,
    left_mouse_command = "buffer %d",
    middle_mouse_command = "bdelete! %d",
    indicator = {
      style = "icon",
      icon = "▎",
    },
    name_formatter = function(buf)
      return vim.fn.fnamemodify(buf.path, ":t")
    end,
    buffer_close_icon = "x",
    close_icon = "x",
    modified_icon = "●",
    left_trunc_marker = "",
    right_trunc_marker = "",
    show_buffer_close_icons = true,
    show_close_icon = true,
    separator_style = "thin",
    always_show_bufferline = true,
    offsets = {
      {
        filetype = "NvimTree",
        text = "File Explorer",
        highlight = "Directory",
        separator = true,
      }
    },
  },
})

-- Keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<leader>bd", ":bdelete!<CR>",        opts)  -- close current buffer
vim.keymap.set("n", "<leader>bn", ":BufferLineCycleNext<CR>", opts)  -- next buffer
vim.keymap.set("n", "<leader>bp", ":BufferLineCyclePrev<CR>", opts)  -- prev buffer
-- Jump to buffer by number (Alt+1 through Alt+5)
for i = 1, 5 do
  vim.keymap.set("n", "<A-" .. i .. ">", ":BufferLineGoToBuffer " .. i .. "<CR>", opts)
end
