function advent --description "Swap to the open-adventure saves dir and run"
    mkdir -p $HOME/Games/!Saves/open-adventure
    cd $HOME/Games/!Saves/open-adventure
    command /opt/homebrew/bin/advent
    cd -
end
