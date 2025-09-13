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

" CoC diagnostics toggle
nnoremap <silent> <leader>E :CocList diagnostics<CR>

" Toggle lopen/lclose with ALE
let g:loclist_visible = 0

function! ToggleLocationList()
  if g:loclist_visible
    lclose
    let g:loclist_visible = 0
  else
    lopen
    let g:loclist_visible = 1
  endif
endfunction

nnoremap <silent> <Leader>e :call ToggleLocationList()<CR>

" clear search
nnoremap <leader><space> :noh<CR>

" Select all
nnoremap <Leader>a ggVG<CR>

" Insert Date in NA format: Mon d, year
inoremap <Leader>; <C-r>=strftime('%b %d, %Y')<CR>

" Move to next window
nnoremap <leader><Tab> <C-W>w

" Move to previous window
nnoremap <leader><S-Tab> <C-W>W

" Shortcut to allow calling jq from a .json file
if executable('jq')
  augroup JqPrettyPrint
    autocmd!
    " Normal mode: whole buffer formatting (only for JSON files)
    autocmd FileType json nnoremap <buffer> <Leader>j :call JqPrettyBuffer()<CR>
  augroup END

  " Visual mode: selection formatting (for ALL filetypes)
  vnoremap <Leader>j :<C-u>call JqPrettyVisual()<CR>
endif

" Pretty-print entire buffer with jq
function! JqPrettyBuffer()
  let l:orig = getline(1, '$')
  let l:jq_out = system('jq .', join(l:orig, "\n"))
  if v:shell_error == 0
    call setline(1, split(l:jq_out, "\n"))
  else
    echohl ErrorMsg | echom "jq failed: " . substitute(l:jq_out, '\n\+$', '', '') | echohl None
  endif
endfunction

" Pretty-print visual selection with jq
function! JqPrettyVisual()
  let l:orig = getline("'<", "'>")
  let l:jq_out = system('jq .', join(l:orig, "\n"))
  if v:shell_error == 0
    call setline("'<", split(l:jq_out, "\n"))
  else
    echohl ErrorMsg | echom "jq failed: " . substitute(l:jq_out, '\n\+$', '', '') | echohl None
  endif
endfunction

