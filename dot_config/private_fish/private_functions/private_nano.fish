function nano --description 'Run the best editor -- nano'
    if test "$TERM_PROGRAM" = "iTerm.app"
        iterm2_set_user_var badge
    end
    command nano $argv
end
