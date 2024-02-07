#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Wrong number of arguments" >&2
    exit 1
fi

# Flag to indicate if the course file is found
course_found=false

# Iterate over all files in the current directory
for file in "$PWD/$1".*; do
    # Check if the file matches the specified pattern
    if [[ -e "$file" ]]; then
    	stats="$file"
        course_found=true
        break
    fi
done

# If course file is not found, print error message and exit
if [[ $course_found == false ]]; then
    echo "Course not found" >&2
    exit 1
fi

directory_name="$1_stat"

if [[ -d $directory_name ]]; then
    rm -rf "$directory_name"
fi

mkdir "$directory_name"

gcc -g -Wall hist.c -o hist.exe

./hist.exe "$stats" > ./"$directory_name"/statistics.txt

gcc -g -Wall mean.c -o mean.exe
gcc -g -Wall median.c -o median.exe
gcc -g -Wall min.c -o min.exe
gcc -g -Wall max.c -o max.exe
ls -l
mean=$(./mean.exe "$stats")

median=$(./median.exe "$stats")

min=$(./min.exe "$stats")

max=$(./max.exe "$stats")

echo -e "$mean\t$median\t$min\t$max" > ./"$directory_name"/histogram.txt
