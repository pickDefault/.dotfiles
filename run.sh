#!/bin/sh
# Script for compiling and then running different source codes

# Prepare arguments for the compiled binary
declare -a prog_args
prog_name=$0
lang=$1
file=$2
non_prog_args=3 # Amount of arguments that are not to be passed to the program as parameters

# Helper functions:
remove_filetype () {
    # Remove file type
    # Example: 'foo.c -> foo'
    compiled_name=$(echo $file | sed -E 's/(.+)?\..*/\1/')        
}

# Check if enough parameters were given:
if [[ ${#@} -le 1 ]]
then
    echo ${#@}
    echo "Not enough parameters.\nUsage: run <language> <file> [args..]"
    exit -1
fi

# C implementation:
if [[ $lang = "c" || $lang = "C" ]]
then {
    if [[ $file = "" ]]
    then
        echo "Missing file to compile & run"
        exit 2
    fi

    for ((argIndex=non_prog_args;argIndex<=${#@};argIndex++)) 
    do
    prog_args[$((argIndex-non_prog_args))]=${!argIndex}
    done

    remove_filetype
    clang -g -O0 -o $compiled_name $file && ./$compiled_name "${prog_args[@]}"
    
    exit 0
}
else {
    echo "Unrecognized language '$lang'"
} fi