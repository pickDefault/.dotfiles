#!/bin/sh
# Functionality for toggling Spotify music in the tmux status bar
# This script must be in the same folder as the music script!

# Pass flag (-g for global, -w for window... see tmux options)

# Setting default flag:
flag=${1:--g} 
# See https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html#:~:text=When%20not%20performing,only%20for%20existence.

# Assuming the music is shown on the right side
music_option=$(tmux show-option $flag status-right)

# Assuming the music script is music.sh
echo $music_option | grep 'music.sh' 1> /dev/null

# 'grep' exited with code 0 if it found 'music.sh' in the queried music_option
if [[ $? = 0 ]] 
then
	tmux set-option $flag status-right ""
	exit 0
else
	tmux set-option $flag status-right "#[fg=colour214, bg=colour237] #[fg=colour237, bg=colour214] #(~/.dotfiles/tmux-scripts/music.sh) #[fg=colour248, bg=colour239]"
	exit 1
fi
