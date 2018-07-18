#!/bin/bash

# See https://www.howtogeek.com/358596/how-to-fix-blurry-fonts-on-macos-mojave-with-subpixel-antialiasing/
#

PS3='Select font smoothing: '
options=(
  "Light font smoothing"
  "Medium font smoothing"
  "Heavy font smoothing"
  "No font smoothing"
  "Quit"
)

select opt in "${options[@]}"
do
  case $opt in
    "Light font smoothing")
      defaults -currentHost write -globalDomain AppleFontSmoothing -int 1
      break
      ;;
    "Medium font smoothing")
      defaults -currentHost write -globalDomain AppleFontSmoothing -int 2
      break
      ;;
    "Heavy font smoothing")
      defaults -currentHost write -globalDomain AppleFontSmoothing -int 3
      break
      ;;
    "No font smoothing")
      defaults -currentHost write -globalDomain AppleFontSmoothing -int 0
      break
      ;;
    "Quit")
      break
      ;;
    *) echo "invalid option $REPLY";;
  esac
done
