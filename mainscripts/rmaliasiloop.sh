#!/bin/bash
RED='\033[0;31m' #red
NC='\033[0m' #reset color
echo
if ! [ -f .var/alias ]; then #detect if scratchlang command has been created
  echo -e "${RED}Error: scratchlang command has not been created or .var/alias file has been deleted.${NC}"
  exit
fi
echo -e "${RED}WARNING:${NC} This will remove the scratchlang command."
echo "Continue? [Y/N]"
read -sn 1 input2
echo
if [ h$input2 == hY ] || [ h$input2 == hy ]; then
  rm /usr/bin/scratchlang #remove scratchlang command
  rm .var/alias
elif [ h$input2 == hn ] || [ h$input2 == hN ]; then
  echo
else
  echo -e "${RED}$input2 is not an option.${NC}"
  ./rmaliasiloop.sh
fi
