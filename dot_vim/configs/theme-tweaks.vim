let g:dracula_colorterm=0
color dracula

" Customize line number/search highlight colors.
"hi LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE
"hi Search cterm=NONE ctermfg=grey ctermbg=blue

" Highlight cursor: cursorline for horiz., cursorcolumn for vert.
set cursorline
highlight CursorLine cterm=NONE ctermbg=242 guibg=#3e3e3e

" Change cursor shape between insert and normal mode in iTerm2.app
if $TERM_PROGRAM =~ "iTerm"
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"  " Vertical bar in insert mode
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"  " Block in normal mode
    let &t_SR = "\<Esc>]50;CursorShape=2\x7"  " Underline in replace mode

    let &t_SI .= "\<Esc>]12;#00FF00\x7"  " Green cursor in insert mode
    let &t_EI .= "\<Esc>]12;#5ac499\x7"  " Indiglo cursor in normal mode
    let &t_SR .= "\<Esc>]12;#ffb86c\x7"  " Orange cursor in replace mode
endif

