#!/bin/bash
echo
if ! [ -f .var/.bashrc ]; then
  echo "Error: alias has not been created or .var/.bashrc file has been deleted."
  exit
fi
echo "WARNING: This will remove the scratchlang command."
echo "Continue? [Y/N]"
read -sn 1 input2
echo
if [ h$input2 == hY ] || [ h$input2 == hy ]; then
  rm /usr/bin/scratchlang
elif [ h$input2 == hn ] || [ h$input2 == hN ]; then
  echo
else
  echo "$input2 is not an option."
  ./rmaliasiloop.sh
fi
