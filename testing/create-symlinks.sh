#!/bin/sh
# Creates symlinks for all files in the folder the script is in, except for files listed in .symlink-ignore separated by newline

filepaths=$(
	find ~+ ! -path ~+ -name '\.*' -maxdepth 1
)

for filepath in $filepaths
do
	echo $filepath
	filename=$(echo $filepath | sed -E 's%.*\/(.+)%\1%g');
	echo "Filename: $filename"
	for fileToIgnore in $(cat ~/.dotfiles/symlink-ignore)
	do
	echo "Testing $fileToIgnore against $filename..."
		if [[ $fileToIgnore == $filename ]]; then
			echo "Ignored $filename"
			continue 2
		fi
	done

	if [[ $filename == $(cat ~/.dotfiles/symlink-ignore) ]]; then
		cat ~/.dotfiles/symlink-ignore
		continue
	fi

	ln -sf $filepath $1/$filename;
done
