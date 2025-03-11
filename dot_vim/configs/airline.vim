Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'chriskempson/base16-vim'

let g:airline_theme='base16_snazzy'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_min_count = 2
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#wordcount#enabled = 1
let g:airline#extensions#wordcount#filetypes = '\vnotes|help|markdown|rst|org|text|asciidoc|tex|mail'

let g:airline#extensions#cursormode#enabled = 1

let g:cursormode_mode_func = 'mode'
let g:cursormode_color_map = {
\ "n": '#bd93f9',
\ "i": '#98c379',
\ "R": '#e06c75',
\ "v": '#61afef',
\ "V": '#61afef',
\ "\<C-V>": '#61afef',
\ }
