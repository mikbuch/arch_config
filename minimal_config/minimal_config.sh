#!/bin/bash -e

config_domain="https://raw.githubusercontent.com/mikbuch/arch_config/master/minimal_config"


if [ type curl &> /dev/null ]; then

    ### CURL SECTION ###
    # Arch-default
    echo "### Attempting CURL ###"
    curl -s -o ~/.bashrc "$config_domain/.bashrc"
    source ~/.bashrc

    curl -s -o ~/.config/openbox/rc.xml "$config_domain/rc.xml"
    openbox --reconfigure

    curl -s -o ~/.vimrc "$config_domain/.vimrc"

else

    ### WGET SECTION ###
    # Debian-default
    echo "### Attempting WGET ###"
    wget -O ~/.bashrc "$config_domain/.bashrc"
    source ~/.bashrc

    wget -O ~/.config/openbox/lxde-rc.xml "$config_domain/rc.xml"
    openbox --reconfigure

    wget -O ~/.vimrc "$config_domain/.vimrc"

fi


echo "EOF"
