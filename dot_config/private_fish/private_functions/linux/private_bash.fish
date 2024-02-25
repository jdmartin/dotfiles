function bash --description 'Run bash with no .bash_profile'
    command /bin/bash --init-file ~/.config/bash/bashrc --noprofile $argv
end
