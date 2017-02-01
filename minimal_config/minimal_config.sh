#!/bin/bash

config_domain="https://raw.githubusercontent.com/mikbuch/arch_config/minimal_config/master"

curl -s -o ~/.bashrc $config_domain/.bashrc
source ~/.bashrc

curl -s -o ~/.config/openbox/rc.xml $config_domain/rc.xml
# Arch has "rc.xml", debian "lxde-rc.xml"
cp ~/.config/openbox/rc.xml ~/.config/openbox/lxde-rc.xml
openbox --reconfigure

curl -s -o ~/.vimrc $config_domain/.vimrc
