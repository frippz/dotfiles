#!/bin/sh

if command -v svgo ; then

  BASEDIR=$(dirname $0)
  svgoConf='svgo_conf.yml'

  svgPath=$1

  if [[ -n "$svgPath" ]]; then
    svgo -f "$svgPath" -o "$svgPath" --pretty --multipass --config=${BASEDIR}/$svgoConf
  else
    echo "Usage:"
    echo "svgo.sh path/to/svg/folder"
    echo
    echo "Note: this script only handles entire folders. Do not enter direct file paths."
  fi

else

  echo "Error. svgo not found."

fi
