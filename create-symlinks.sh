#!/bin/bash
echo $HOME
# Creates symlinks for all *dot* files in the folder the script is in, except for files listed in .symlink-ignore separated by newline
# First argument specifies where to place all the symlinks

# Log the date to ~/.dotfiles/symlink_log
echo $USER >> $HOME/.dotfiles/symlink_log
echo $(date) >> $HOME/.dotfiles/symlink_log

# Generate list of all files in current folder (Without recursing into existing folders) starting with '.'
filepaths=$(
	find ~+ ! -path ~+ -name '\.*' -maxdepth 1
)

for filepath in $filepaths
do
	# filepaths contains full paths. The regex in 'sed' makes sure we get the filename only.
	filename=$(echo $filepath | sed -E 's%.*\/(.+)%\1%g');
	for fileToIgnore in $(cat $HOME/.dotfiles/symlink-ignore)
	do
		if [[ 
			$fileToIgnore == $filename
		]]; then
			echo "Ignored $filename"
			continue 2
		fi
	done	

	ln -s $filepath $1/$filename 2>> $HOME/.dotfiles/symlink_log && echo "Created symlink for $filename in path $1.";
done

# Add newline after each write to the log:
echo "" >> $HOME/.dotfiles/symlink_log
