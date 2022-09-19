#!/bin/bash
echo
echo "WARNING: This will revert the .bashrc to before you created the ScratchScript alias."
echo "That means any aliases you created after creating the ScratchScript alias will be erased."
echo "Continue? [Y/N]"
read -sn 1 input2
echo
if [ h$input2 == hY ] || [ h$input2 == hy ]; then
  rm ~/.bashrc
  rm .var/alias
  cp .var/.bashrc ~/
  rm .var/.bashrc
  echo "Please restart your terminal."
elif [ h$input2 == hn ] || [ h$input2 == hN ]; then
  echo
else
  echo "$input2 is not an option."
  ./rmaliasiloop.sh
fi