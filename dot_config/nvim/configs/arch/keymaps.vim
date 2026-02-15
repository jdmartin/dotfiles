" Custom Keymappings

"Close all panes and quit without saving
nnoremap <Leader>, :qa!<CR>:FloatermKill<CR>

"Tab and Shift Tab
xnoremap <Tab> :s/^/\t/<CR>:nohl<CR>
xnoremap <S-Tab> :s/^\t//<CR>:nohl<CR>

" Use Tab for CoC completion in insert mode
inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <silent><expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <silent><expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

"open terminal below all splits
cabbrev bterm bo term

"keep selection when using > or < to change indent
vnoremap < <gv
vnoremap > >gv

"new tab
nnoremap <Leader>t :tabnew<CR>

"open file under cursor in new tab always
nnoremap gf :tabe <cfile><CR>

"map :%s/ to <leader>s
nnoremap <leader>s :%s/

" Jump to the next diagnostic (error, warning, etc.)
nmap <silent> <leader>e <cmd>lua vim.diagnostic.goto_next({ severity = vim.diagnostic.severity.ERROR })<CR>
" Jump to the previous diagnostic (error, warning, etc.)
nmap <silent> <leader>E <cmd>lua vim.diagnostic.goto_prev({ severity = vim.diagnostic.severity.ERROR })<CR>

" clear search
nnoremap <leader><space> :noh<CR>

" Run jq to pretty print json
if executable('jq')
    nnoremap <Leader>j :%!jq .<CR>
endif

" Select all
nnoremap <Leader>a ggVG<CR>
