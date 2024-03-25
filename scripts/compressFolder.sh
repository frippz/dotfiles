#!/bin/bash

# Check if a folder name was provided
if [ -z "$1" ]; then
  echo "Usage: $0 folder-name"
  exit 1
fi

FOLDER_NAME=$1

# Check if the folder exists
if [ ! -d "$FOLDER_NAME" ]; then
  echo "The folder '$FOLDER_NAME' does not exist."
  exit 1
fi

# Compress the folder
tar -cvjf "${FOLDER_NAME}.tar.bz2" "$FOLDER_NAME"

echo "$FOLDER_NAME has been compressed to ${FOLDER_NAME}.tar.bz2."
