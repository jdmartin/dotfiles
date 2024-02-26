function man --description "wrap the 'man' manual page opener to use color in formatting"
    # based on this group of settings and explanation for them:
    # http://boredzo.org/blog/archives/2016-08-15/colorized-man-pages-understood-and-customized
    # converted to fish shell syntax thanks to this page:
    # http://askubuntu.com/questions/522599/how-to-get-color-man-pages-under-fish-shell/650192

    # start of bold:
    ##  set -x LESS_TERMCAP_mb (printf "\e[1;31m")
    ##  set -x LESS_TERMCAP_md (printf "\e[1;31m")
    # end of all formatting:
    ##  set -x LESS_TERMCAP_me (printf "\e[0m")

    # start of standout (inverted):
    #set -x LESS_TERMCAP_so (printf "\e[1;44;33m")
    # end of standout (inverted):
    #set -x LESS_TERMCAP_se (printf "\e[0m")
    # (no change – I like the default)

    # start of underline:
    #set -x LESS_TERMCAP_us (printf "\e[1;32m")
    # end of underline:
    #set -x LESS_TERMCAP_ue (printf "\e[0m")
    # (no change – I like the default)

# Dracula
    set -x LESS_TERMCAP_mb (printf '\e[1;31m')      # begin bold
    set -x LESS_TERMCAP_md (printf '\e[1;34m')      # begin blink
    set -x LESS_TERMCAP_so (printf '\e[01;45;37m')  # begin reverse video
    set -x LESS_TERMCAP_us (printf '\e[01;36m')     # begin underline
    set -x LESS_TERMCAP_me (printf '\e[0m')         # reset bold/blink
    set -x LESS_TERMCAP_se (printf '\e[0m')         # reset reverse video
    set -x LESS_TERMCAP_ue (printf '\e[0m')         # reset underline

  env man $argv
end
