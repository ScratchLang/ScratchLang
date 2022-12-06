#!/bin/bash
if [ "$1" == "1" ]; then
  if [ "$2" == "HHHHFFFFFFSDFSHDFSKDFGDSILGFSDIIMPOSSIBLEPATHOTESFEE" ]; then
    rm /usr/bin/scratchlang
  else
    if [ "$3" == "1" ]; then
      echo >>/usr/bin/scratchlang "cd $2 && python scratchlang.py \$*"
    elif [ "$3" == "2" ]; then
      echo >>/usr/bin/scratchlang "cd $2 && python3 scratchlang.py \$*"
    else
      echo >>/usr/bin/scratchlang "cd $2 && py scratchlang.py \$*"
    fi
  fi
elif [ "$1" == 2 ]; then # This script is not needed anymore, but I don't want to remove it for some reason...
  # https://stackoverflow.com/questions/10679188/casing-arrow-keys-in-bash
  escape_char=$(printf "\u1b")
  read -t 0.01 -rsn1 mode # get 1 character
  if [ "$mode" == "$escape_char" ]; then
    read -rsn2 mode # read 2 more chars
  fi
  case $mode in
  '[A')
    echo "up"
    ;;
  '[B')
    echo "do"
    ;;
  '[D')
    echo "le"
    ;;
  '[C')
    echo "ri"
    ;;
  *)
    echo "$mode"
    ;;
  esac
fi
