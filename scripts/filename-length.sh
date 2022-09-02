#!/bin/bash
maxlen=0

for file in `find $1 -type f` ; do

    len=`echo "$file" | awk -F\/ '{printf "%s", $NF}' | wc -c`
    [ $len -gt $maxlen ] && maxlen=$len && maxfile=$file

done

echo $maxlen $maxfile
