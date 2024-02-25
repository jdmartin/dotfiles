function bash --description 'Run bash with no .bash_profile'
    command /opt/homebrew/bin/bash --init-file ~/.config/bash/bashrc --noprofile $argv
end
