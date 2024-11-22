#emoji
if test "$TERM_PROGRAM" = "iTerm.app"
    set emoji (string split "\n" (cat "$HOME"/.config/fish/emoji))

    function emoji_badge --on-event fish_prompt
        iterm2_set_user_var badge (random choice $emoji)
    end
end
