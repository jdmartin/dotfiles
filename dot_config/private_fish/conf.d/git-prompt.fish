#Git Prompt Stuff
set normal (set_color normal)
set magenta (set_color magenta)
set yellow (set_color yellow)
set green (set_color green)
set red (set_color red)
set gray (set_color -o black)

#Git prompt colors
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'

set __fish_git_prompt_color_branch 00ecff
set __fish_git_prompt_color_untrackedfiles purple
set __fish_git_prompt_color_dirtystate brred
set __fish_git_prompt_color_stagedstate green
set __fish_git_prompt_color_upstream FFBD0C

#Git Status Chars
set __fish_git_prompt_char_dirtystate '⤲'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles '*'
set __fish_git_prompt_char_stashstate '+'
set __fish_git_prompt_char_upstream_ahead ' ↑'
set __fish_git_prompt_char_upstream_behind ' ↓'
set __fish_git_prompt_char_upstream_equal ''
