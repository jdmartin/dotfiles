#emoji
set emoji (string split "\n" (cat ~/.config/fish/emoji))

function emoji_badge --on-event fish_prompt
    iterm2_set_user_var badge (random choice $emoji)
end
