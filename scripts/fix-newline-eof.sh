#!/bin/sh

# Quit if no folder is provided as argument
if [ $# -eq 0 ]; then
    echo "You need to specify a folder."
    exit 1
fi

for i in "$1"/*
do
  if diff /dev/null "$i" | tail -1 | grep '^\\ No newline' > /dev/null
  then
    echo >> "$i"
    echo "Fixing $i"
  fi
done
