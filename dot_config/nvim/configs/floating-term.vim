nnoremap <Leader>f :lua toggle_floating_terminal()<CR>

lua << EOF
-- 1. Create a persistent state (outside the function)
local term_state = {
  buf = -1,
  win = -1,
}

function _G.toggle_floating_terminal()
  -- 2. If the window exists and is valid, close it
  if vim.api.nvim_win_is_valid(term_state.win) then
    vim.api.nvim_win_close(term_state.win, true)
  else
    -- 3. If the buffer isn't valid, create one
    if not vim.api.nvim_buf_is_valid(term_state.buf) then
      term_state.buf = vim.api.nvim_create_buf(false, true)
    end

    -- 4. Calculate dynamic size (80% of screen)
    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local col = math.floor((vim.o.columns - width) / 2)
    local row = math.floor((vim.o.lines - height) / 2)

    -- 5. Open the window
    term_state.win = vim.api.nvim_open_win(term_state.buf, true, {
      relative = 'editor',
      width = width,
      height = height,
      col = col,
      row = row,
      style = 'minimal',
      border = 'rounded',
    })

    -- 6. Start the terminal ONLY if it's not already a terminal buffer
    if vim.bo[term_state.buf].buftype ~= 'terminal' then
      vim.fn.termopen(vim.o.shell)
    end
    
    -- 7. Always enter Insert Mode when opening
    vim.cmd("startinsert")

    -- 8. Terminal-specific escape logic (so you can hit Esc to exit terminal mode)
    vim.api.nvim_buf_set_keymap(term_state.buf, 't', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
  end
end
EOF
