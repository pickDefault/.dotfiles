#!/bin/bash
# Creates symlinks for all files in the folder the script is in, except for files listed in .symlink-ignore separated by newline
# First argument specifies where to place all the symlinks
echo $(date) >> ~/.dotfiles/symlink_log
filepaths=$(
	find ~+ ! -path ~+ -name '\.*' -maxdepth 1
)

for filepath in $filepaths
do
	filename=$(echo $filepath | sed -E 's%.*\/(.+)%\1%g');
	for fileToIgnore in $(cat ~/.dotfiles/symlink-ignore)
	do
		if [[ 
			$fileToIgnore == $filename
		]]; then
			echo "Ignored $filename"
			continue 2
		fi
	done	

	ln -s $filepath $1/$filename 2>> ~/.dotfiles/symlink_log && echo "Created symlink for $filename in path $1.";
done

# Add newline after each write to the log:
echo "" >> ~/.dotfiles/symlink_log
