#Add name of virtualenv to prompt... in color.
function create_prompt --description 'Provide obvious indication of root'
    set -l mynameis (whoami)
    set -l rootindicator (set_color red)\# (set_color normal)
    if test "$mynameis" = "root"
        printf '%s %s%s%s%s%s%s> ' (set_color ccb3ff)(echo $PROPHOSTNAME)(set_color normal) (echo $rootindicator) (set_color 63C563) (prompt_pwd) (set_color normal) (virtualenv_prompt) (fish_git_prompt)
    else
        printf '%s %s%s%s%s%s> ' (set_color ccb3ff)(echo $mynameis)(set_color normal) (set_color 63C563) (prompt_pwd) (set_color normal) (virtualenv_prompt) (fish_git_prompt)
    end
end

function virtualenv_prompt --description 'Shows current virtual environment, if present'
    if set -q "VIRTUAL_ENV"
        echo -n -s (set_color -b 272936 ff69b4) " (" ( basename "$VIRTUAL_ENV") ")" (set_color normal) ""
    end
end

function status_and_time --description 'Shows timestamp and status of previous command'
    echo (date '+%H:%M:%S') [$status]" "
end

#Bring it all together
function fish_prompt --description 'Write out the prompt'
    create_prompt
end
