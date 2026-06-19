-- === LUALINE CONFIGURATION ===
vim.opt.laststatus = 3
local status, lualine = pcall(require, "lualine")
if not status then return end

local function undo_count()
  local ut = vim.fn.undotree()
  if ut.seq_last == 0 then
    return ""
  end
  return string.format("↺%d/%d", ut.seq_cur, ut.seq_last)
end

local function is_persisted()
  if not vim.bo.undofile then
    return false
  end
  local fname = vim.api.nvim_buf_get_name(0)
  if fname == "" then
    return false
  end
  return vim.fn.filereadable(vim.fn.undofile(fname)) == 1
end

local function undo_color()
  local ut = vim.fn.undotree()
  if ut.seq_last == 0 then
    return {}
  end
  if ut.seq_cur < ut.seq_last then
    return { fg = "#7dcfff" } -- cyan: you're back in history, redo available
  end
  return is_persisted() and { fg = "#8fbc8f" } or { fg = "#e0af68" } -- green = on disk, amber = memory-only
end

lualine.setup({
  options = {
    theme = 'dracula',
    globalstatus = true,
    icons_enabled = true,
    section_separators = { left = ' ', right = ' ' },
    component_separators = { left = '|', right = '|' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      'branch',
      'b:gitsigns_status',
      'lsp_status',
      "require'lsp-status'.status()",
      {
        function()
          local bufnr = vim.api.nvim_get_current_buf()
          local row = vim.api.nvim_win_get_cursor(0)[1] - 1
          local marks = vim.api.nvim_buf_get_extmarks(
            bufnr, -1, { row, 0 }, { row, -1 }, { details = true }
          )
          for _, mark in ipairs(marks) do
            local vt = mark[4] and mark[4].virt_text
            if vt then
              for _, chunk in ipairs(vt) do
                if chunk[1] and chunk[1] ~= '' then
                  return chunk[1]:match('^(.-)%s*%-') or chunk[1]
                end
              end
            end
          end
          return ''
        end,
        color = { fg = '#888888' },
      },
    },
    lualine_c = { 'filename' },
    lualine_x = {
      {
        undo_count,
        color = undo_color,
        cond = function() return vim.fn.undotree().seq_last > 0 end,
      },
      'searchcount',
      'encoding',
      'filesize',
      'filetype',
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
})
