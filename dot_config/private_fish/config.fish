#Import Universal Config On Mac
switch (uname)
case Darwin
    set -l mac_functions_path "/Users/Jon/.config/fish/functions/mac"
    if not contains -- "$mac_functions_path" $fish_function_path
        set -gx fish_function_path "$mac_functions_path" $fish_function_path
    end
    source ~/.config/.universal_config
    ##iTerm integration (Commenting this out seems to have fixed my weird emoji_prompt / backspace issues)
    source /Users/Jon/.iterm2/.iterm2_shell_integration.fish
case Linux
    set -l mynameis (whoami)
    if test $mynameis = "root":
        set -f the_path "/root"
    else
        set -f the_path "/home/$mynameis"
    end
    set -l linux_functions_path "$the_path/.config/fish/functions/linux"
    if not contains -- "$linux_functions_path" $fish_function_path
        set -gx fish_function_path "$linux_functions_path" $fish_function_path
    end
end

set -x PROPHOSTNAME (hostname | awk '{print toupper(substr($0,1,1)) substr($0,2)}')

# Setting PATH for Python 3.11
# The original version is saved in /Users/Jon/.config/fish/config.fish.pysave
#set -x PATH "/Library/Frameworks/Python.framework/Versions/3.11/bin" "$PATH"
