" === Search-Related ===

" Highlight search results
set hlsearch

" Show search results as you type
set incsearch

" Case-insensitive unless you use a capital letter
set ignorecase
set smartcase

" Briefly jump to matching bracket when inserted
set showmatch

" Use the 'Very Magic' mode by default for regex
" This makes Neovim search more like Python/Perl and less like old Vim
nnoremap / /\v

" Center the screen when jumping between search results
" This keeps your eyes in the middle of the screen
nnoremap n nzzzv
nnoremap N Nzzzv
