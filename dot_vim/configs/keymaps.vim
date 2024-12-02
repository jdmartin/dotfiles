" Custom Keymappings

"Close all panes and quit without saving
nnoremap <Leader>, :qa!<CR>:FloatermKill<CR>

"Tab and Shift Tab
xnoremap <Tab> :s/^/\t/<CR>:nohl<CR>
xnoremap <S-Tab> :s/^\t//<CR>:nohl<CR>

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

"jump to next ALE error
nmap <silent> <leader>e <Plug>(ale_next_wrap)

" jump to the first ALE error
nmap <silent> <leader>E :ALEFirst<CR>

" clear search
nnoremap <leader><space> :noh<CR>

" Run jq to pretty print json
nnoremap <Leader>j :%!jq .<CR>

" Select all
nnoremap <Leader>a ggVG<CR>
