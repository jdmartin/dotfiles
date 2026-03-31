-- === FLOATING TERMINAL ===

local term_state = {
  buf = -1,
  win = -1,
}

local function toggle_floating_terminal()
  -- 1. If the window exists and is valid, close it
  if vim.api.nvim_win_is_valid(term_state.win) then
    vim.api.nvim_win_close(term_state.win, true)
    return -- Exit early after closing
  end

  -- 2. If the buffer isn't valid, create one
  if not vim.api.nvim_buf_is_valid(term_state.buf) then
    term_state.buf = vim.api.nvim_create_buf(false, true)
    -- Set a specific name so it's easy to find in :ls
    vim.api.nvim_buf_set_name(term_state.buf, "FloatTerm")
  end

  -- 3. Calculate dynamic size (80% of screen)
  local width = math.floor(vim.opt.columns:get() * 0.8)
  local height = math.floor(vim.opt.lines:get() * 0.8)
  local col = math.floor((vim.opt.columns:get() - width) / 2)
  local row = math.floor((vim.opt.lines:get() - height) / 2)

  -- 4. Open the window
  term_state.win = vim.api.nvim_open_win(term_state.buf, true, {
    relative = 'editor',
    width = width,
    height = height,
    col = col,
    row = row,
    style = 'minimal',
    border = 'rounded',
  })

  -- 5. Start the terminal ONLY if it's not already a terminal buffer
  if vim.bo[term_state.buf].buftype ~= 'terminal' then
    vim.fn.termopen(vim.opt.shell:get())
  end

  -- 6. UI Tweaks
  vim.cmd("startinsert")

  -- 7. Terminal-mode Keymap: Esc to return to Normal Mode
  vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { buffer = term_state.buf, silent = true })
end

-- Set the keymap using the local function directly
vim.keymap.set("n", "<Leader>f", toggle_floating_terminal, { desc = "Toggle Floating Terminal" })

-- Optional: Export it if you ever want to call it from other lua files
return {
  toggle = toggle_floating_terminal
}
