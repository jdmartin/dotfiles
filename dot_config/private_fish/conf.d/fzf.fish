# Set up fzf key bindings
fzf --fish | source

export FZF_CTRL_T_OPTS="
    --height 60% 
    --border sharp 
    --layout reverse 
    --prompt '∷ ' 
    --pointer ▶ 
    --marker ⇒''"

export FZF_CTRL_R_OPTS="
    --height 60% 
    --border sharp 
    --layout reverse 
    --prompt '∷ ' 
    --pointer ▶ 
    --marker ⇒'' 
    --preview 'echo {1..}'
    --preview-window up:hidden:wrap 
    --bind 'ctrl-/:change-preview-window(30%|60%|90%|)'
    --bind 'ctrl-v:execute(echo {2..} | view - > /dev/tty)' 
    --bind 'ctrl-t:track+clear-query' 
    --bind 'ctrl-y:execute-silent(echo -n {1..} | pbcopy)+abort' 
    --color header:italic 
    --header 'Press CTRL-Y to copy command into clipboard'"
