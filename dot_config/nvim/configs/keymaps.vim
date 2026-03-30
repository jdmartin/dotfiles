" === BASIC NAVIGATION & UI ===

" Close all panes and quit without saving
nnoremap <Leader>, :qa!<CR>:FloatermKill<CR>

" Toggle Search Highlighting
nnoremap <leader><space> :noh<CR>

" Toggle between relative and absolute line numbers
nnoremap <Leader>rn :set relativenumber!<CR>

" Select all
nnoremap <Leader>a ggVG<CR>

" Move between windows (from your Vim config)
nnoremap <leader><Tab> <C-W>w
nnoremap <leader><S-Tab> <C-W>W

" Tabs
nnoremap <Leader>t :tabnew<CR>
nnoremap gf :tabe <cfile><CR>

" Map :%s/ to <leader>s
nnoremap <leader>s :%s/

" Command abbreviation for terminal
cabbrev bterm bo term

" Keep selection when indenting in Visual Mode
vnoremap < <gv
vnoremap > >gv

" === TAB INDENTATION (Visual Mode) ===
xnoremap <Tab> :s/^/\t/<CR>:nohl<CR>
xnoremap <S-Tab> :s/^\t//<CR>:nohl<CR>

" --- Telescope Search Mappings ---

" Find Files (Old Ctrl-P style)
nnoremap <C-p> <cmd>lua require('telescope.builtin').find_files()<cr>

" Live Grep (Search text inside files - requires ripgrep)
nnoremap <leader>lg <cmd>lua require('telescope.builtin').live_grep()<cr>

" Search Open Buffers
nnoremap <leader>b <cmd>lua require('telescope.builtin').buffers()<cr>

" Search LSP Symbols (Shows all functions/variables in current file)
nnoremap <leader>is <cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>

" Resume last search (Very handy!)
nnoremap <leader>rr <cmd>lua require('telescope.builtin').resume()<cr>

" === LSP & DIAGNOSTICS (The Built-in Way) ===

" Navigation (Jump to Errors)
nnoremap <silent> <leader>e <cmd>lua vim.diagnostic.jump({ count = 1, severity = vim.diagnostic.severity.ERROR })<CR>
nnoremap <silent> <leader>E <cmd>lua vim.diagnostic.jump({ count = -1, severity = vim.diagnostic.severity.ERROR })<CR>

" Toggle Trouble (Your diagnostic list)
nnoremap <leader>xx <cmd>Trouble diagnostics toggle<cr>

" Insert Date (NA format)
inoremap <Leader>; <C-r>=strftime('%b %d, %Y')<CR>

" === JQ SMART FORMATTING ===
if executable('jq')
    " Format entire buffer in JSON files
    autocmd FileType json nnoremap <buffer> <Leader>j :%!jq .<CR>
    " Format visual selection in ANY file
    vnoremap <Leader>j :!jq .<CR>
endif
