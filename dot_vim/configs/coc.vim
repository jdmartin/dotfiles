Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Autoformat Go on save
autocmd BufWritePre *.go :call CocAction('format')

" Autoformat Fish on save
autocmd BufWritePre *.fish silent! %!fish_indent

" Detect Bash files by shebang
autocmd BufRead,BufNewFile * if getline(1) =~# '^#!.*\<\(bash\|sh\)\>' | set filetype=sh | endif

" Autosort Python Imports
autocmd BufWritePre *.py :CocCommand python.sortImports

" Autoformat CSS/SCSS on save using Prettier
autocmd BufWritePre *.css,*.scss,*.sass :CocCommand prettier.formatFile

let g:coc_global_extensions = [
\ 'coc-go',
\ 'coc-html',
\ 'coc-prettier',
\ 'coc-pyright',
\ 'coc-sh',
\ 'coc-tsserver'
\ ]
