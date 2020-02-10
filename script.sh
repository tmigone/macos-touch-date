#!/bin/bash

TARGET_DIRECTORY=$1
FILE_TYPE=jpg

echo "Target directory: $TARGET_DIRECTORY"

for f in "$TARGET_DIRECTORY"/*.*;
do
  if [[ $f == *$FILE_TYPE ]]; then

    echo "Processing $f..."

    # Get file name
    IFS='/' read -ra ADDR <<< "$f"
    FILE_NAME_FULL=${ADDR[${#ADDR[@]}-1]}
    IFS='.' read -ra ADDR <<< "$FILE_NAME_FULL"
    FILE_NAME=${ADDR[0]}

    # Get timestamp
    IFS='_' read -ra ADDR <<< "$FILE_NAME"
    FILE_DATE=${ADDR[1]}
    FILE_TIME=${ADDR[2]}
    FILE_TIMESTAMP=$FILE_DATE${FILE_TIME:0:4}

    # Update creation and modification date
    touch -mt $FILE_TIMESTAMP "$f"

    echo "Set timestamp: $FILE_TIMESTAMP for $f"

  fi
done
