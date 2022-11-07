#!/bin/bash
if [ "$1" == "1" ]; then
  if [ "$2" == "HHHHFFFFFFSDFSHDFSKDFGDSILGFSDIIMPOSSIBLEPATHOTESFEE" ]; then
    rm /usr/bin/scratchlang
  else
    echo >>/usr/bin/scratchlang "cd $2 && python3 scratchlang.py \$1 \$2 \$3"
  fi
elif [ "$1" == 2 ]; then
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
