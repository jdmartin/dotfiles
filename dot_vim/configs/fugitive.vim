Plug 'tpope/vim-fugitive'

autocmd! FileType qf nnoremap <buffer> <Enter> <C-w><Enter><C-w>L

"open git log without opening the first commit
function! ToggleGitLog() abort
  " Check if a quickfix window is already open
  for win in range(1, winnr('$'))
    if getwinvar(win, '&buftype') ==# 'quickfix'
      cclose
      return
    endif
  endfor
  " Otherwise, open the log (no auto-jump to first commit)
  Gclog!
endfunction

nnoremap <silent> <Leader>gl :call ToggleGitLog()<CR>
