" floating_terminal.vim - Custom floating terminal setup for Neovim

" Map for opening and closing the floating terminal with <Leader>f
nnoremap <Leader>f :lua toggle_floating_terminal()<CR>

" Lua function to toggle a floating terminal
lua << EOF
function _G.toggle_floating_terminal()
  -- Check if we already have an open floating terminal window
  local floating_win_id = nil
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.api.nvim_buf_get_option(buf, 'buftype') == 'terminal' then
      floating_win_id = win
      break
    end
  end

  -- If a floating terminal is already open, close it
  if floating_win_id then
    vim.api.nvim_win_close(floating_win_id, true)
  else
    -- Otherwise, create a new floating terminal
    local buf = vim.api.nvim_create_buf(false, true)
    local win = vim.api.nvim_open_win(buf, true, {
      relative = 'editor',
      width = 100,
      height = 36,
      col = 0,
      row = 0,
      style = 'minimal',  -- No borders for a cleaner look
      border = 'rounded', -- Optional: rounded borders for aesthetics
    })
    vim.fn.termopen(vim.o.shell)

    -- Set the terminal buffer as modifiable after the terminal has started
    vim.api.nvim_buf_set_option(buf, 'modifiable', true)

    -- Ensure the terminal window is focused
    vim.api.nvim_set_current_win(win)

    -- Key mappings to exit terminal mode automatically and switch to normal mode
    vim.api.nvim_buf_set_keymap(buf, 't', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(buf, 't', '<Leader>q', [[<Cmd>q!<CR>]], { noremap = true, silent = true })
  end
end
EOF

