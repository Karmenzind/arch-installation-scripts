#! /usr/bin/env bash
# https://github.com/Karmenzind/

clear
cd `dirname $0`
repo_dir=$PWD

source utils/commonrc

arch_choice() {
    cat << EOF
What part are you in? (default=1)
1   livecd part
2   chrooted part
3   general recommendations part
4   graphical environment part
EOF
    check_input 1234
    case $ans in 
        1) source parts/livecd_part.sh        ;;
        2) source parts/chrooted_part.sh      ;;
        3) source parts/general_rec_part.sh   ;;
        4) source parts/graphical_env_part.sh ;;
        *) echo "No action."                          ;;
    esac
}

arch_choice

cecho '\nDONE:)' $cyan
