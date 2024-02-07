#!/bin/bash

if [[ $# -ne 1 ]]; then
	echo "Wrong number of arguments" >&2
	exit 1
fi

if [[ ! -e $PWD/$1 ]]; then
	echo "Course not found" >&2
	exit 1
fi

directory_name="$1_stat"

if [[ -d $directory_name ]]; then
	rm -rf "$directory_name"
fi

mkdir "$directory_name"

gcc -g -Wall hist.c -o hist.exe

./hist.exe "$1" > ./"$directory_name"/histogram.txt

gcc -g -Wall mean.c median.c min.c max.c -o prog.exe

./prog.exe > statistics.txt
