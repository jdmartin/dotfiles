Plug 'tpope/vim-surround'

function! SetPunctuationVariable()
    let g:punctuation_to_insert = input('Enter punctuation: ')
endfunction

function! SurroundWithPunctuation()
    call SetPunctuationVariable()
    let punctuation = g:punctuation_to_insert
    call feedkeys('ysiw' . punctuation)
endfunction

" Map a key to call SurroundWithPunctuation
noremap <Leader>p :call SurroundWithPunctuation()<CR>
