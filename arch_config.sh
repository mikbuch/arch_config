#!/bin/bash

# name: arch_config.sh
# type: script
# description:
#
# Automatically load all Arch linux settings.
# Original files and this script can be found at:
# https://github.com/mikbuch/arch_config
#


############################################
#
#   FUNCITONS SECTION
#

function load_to_home_dir {
    # Copy previous bashrc to the backup directory.
    if [[ -f ~/.$FILE ]]; then
        cp ~/.$FILE $BACKUP_DIR/bashrc_$BACKUP_CODE
    fi
    # Introduce a new bashrc (with cereberus config).
    cp $CONFIG_PATH/$FILE ~/.$FILE
    }



############################################
#
# User can specify settings path
#

# Check if directory specified
if [[ $# -eq 0 ]]; then
    argument_specified=false
else
    argument_specified=true
fi

if [[ $argument_specified = false ]]; then
    printf "\nNo directory specified.\n"
    printf "Using default config location at: ~/.config/cereberus_arch\n"
    CONFIG_PATH="~/.config/cereberus_arch"
else
    CONFIG_PATH="$1"
fi


############################################
#
# Create directory containing confs
#
if [ ! -d CONFIG_PATH ]; then
    mkdir CONFIG_PATH
else
    printf "\n*** WARNING ***\n"
    printf "Directory CONFIG_PATH already exists, skipping.\n"
    printf "Remove or rename it in order to introduce new settings.\n"
fi

cd CONFIG_PATH


config_domain="https://raw.githubusercontent.com/mikbuch/arch_config/master"
fileslist_=$(curl -s $config_domain/files_list.txt)
echo $fileslist_

# Care for backup.
BACKUP_DIR=$CONFIG_PATH/backup
mkdir -p $BACKUP_DIR
# Code for particular files.
BACKUP_CODE=$(date "+%Y%m%d%H%M%S")
exit 0

# Resolve files from the `fileslist`.
for FILE in $fileslist
do
    # Download the file to the config directory.
    curl -s -o $CONFIG_PATH/$FILE $config_domain/$FILE

    
    # BASHRC
    if [[ $FILE == "bashrc" ]]; then
        load_to_home_dir
        # Source new settings.
        source ~/.bashrc

    # BASH_PROFILE
    elif [[ $FILE == "bash_profile" ]]; then
        load_to_home_dir
        # This contains only redirection to bashrc file.

    # TMUX.CONF
    elif [[ $FILE == "tmux.conf" ]]; then
        load_to_home_dir
        tmux source-file ~/.tmux.conf

    # XINITRC
    elif [[ $FILE == "xinitrc" ]]; then
        load_to_home_dir
        printf "$FILE -- updated, restart Xorg session to see the results"

    # XRESOURCES
    elif [[ $FILE == "Xresources" ]]; then
        load_to_home_dir
        printf "$FILE -- updated, restart xterm to observe changes"
    fi

done
