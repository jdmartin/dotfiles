#Import Universal Config On Mac
switch (uname)
    case Darwin
        set -gx fish_function_path "/Users/Jon/.config/fish/functions/mac" $fish_function_path
        source ~/.config/.universal_config
        ##iTerm integration (Commenting this out seems to have fixed my weird emoji_prompt / backspace issues)
        source /Users/Jon/.iterm2/.iterm2_shell_integration.fish
   case Linux
        set -gx fish_function_path "/Users/Jon/.config/fish/functions/linux" $fish_function_path
end

set -x PROPHOSTNAME (hostname | awk '{print toupper(substr($0,1,1)) substr($0,2)}')

# Setting PATH for Python 3.11
# The original version is saved in /Users/Jon/.config/fish/config.fish.pysave
#set -x PATH "/Library/Frameworks/Python.framework/Versions/3.11/bin" "$PATH"
