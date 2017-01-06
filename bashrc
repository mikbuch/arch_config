#
# ~/.bashrc
#
#
# Introductory comments:
#
############################################
# FONT SETTINGS
#
# The best way to set font is to create /etc/vconsole.conf
# file:
#
# echo 'FONT=ter-u32b.psf.gz' >> /etc/vconsole.conf
#
# It is global font setting and it is initiated at 
# boot. If you don't want this global setting or you wish
# to have user-specific font put th following line in your
# ~/.bashrc file:
#
# setfont /usr/share/kbd/consolefonts/ter-u32b.psf.gz
#
############################################

# Stay away from the voodoo (color changes, it can mess up with line wrapping in the terminal).
# http://askubuntu.com/a/24422

cyan=$(tput setaf 6) # \e[36m
blue=$(tput setaf 4) # \e[34m
reset=$(tput sgr0)   # \e[0m
PS1='[\[$blue\]\u\[$reset\] \W]$ '

# Start tmux session on login.
#if command -v tmux>/dev/null; then
#    [[ ! $TERM =~  screen ]] && [ -z $TMUX ] && exec tmux
#fi

# COMMANDS ALIASES
config_dir='/home/cereberus/.config/cereberus/arch'
alias b='$config_dir/brightness.sh'
alias c='$config_dir/colors.sh'
alias e='evince'
alias i='firefox -new-window'
alias iq='firefox -new-window --private'
alias l='ls -l --color=auto'
alias lx='lynx duckduckgo.com'
alias lxn='lynx wiki.archlinux.org/index.php/Netctl'
alias pa='ping www.archlinux.org'
alias m='mplayer -fs'

if [ "$(whoami)" != 'root' ]; then
    USER_PREFIX='/home'
else
    USER_PREFIX=''
fi

# DIRECTORIES ALIASES
# alias d='cd $USER_PREFIX/$USER/Downloads'
alias d='cd /home/cereberus/Downloads'
alias g='cd /home/cereberus/git'
alias t='cd /tmp'

export LANG=en_US.UTF-8
export LC_MESSAGES="C"

# Required for python-vtk wrap
# http://stackoverflow.com/a/24412030
python_dir='/usr/lib/python2.7/site-packages'
vtk_dir='/usr/lib/python2.7/site-packages/vtk'
vtk_bin_dir='/home/cereberus/Downloads/VTK-7.1.0/lib'
if [ -d $vtk_dir ]; then
    export PYTHONPATH=$python_dir 
    export PYTHONPATH="$PYTHONPATH:"$vtk_dir 
    # export PYTHONPATH="$PYTHONPATH:"$vtk_bin_dir 
fi

# Required for ctrl+s vim save.
stty -ixon
