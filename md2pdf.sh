#!/usr/bin/env sh

# Convert markdown to pdf with pandoc.
# First argument: input markdown file
# Second argument: output pdf file name
pandoc -f markdown -t pdf -o $2 $1