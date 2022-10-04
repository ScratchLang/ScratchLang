#!/bin/bash
RED='\033[0;31m' #red
NC='\033[0m' #reset color
echo
echo "1. Pick one of the included decompilers."
echo "2. Choose your own decompiler."
echo "3. Reset to default. (decompiler.v2.ss1.sh)"
read -sn 1 inf
if [ $inf == 1 ]; then #pick one of the included decompilers
  echo
  echo "1. decompiler.v1.ss1.sh - First version of the decompiler. No longer being programmed. ScratchScript1 language."
  echo
  echo "2. decompiler.v2.ss1.sh - Latest and recommended version of the decompiler. ScratchScript1 language."
  read -sn 1 nfi
  if [ $nfi == 1 ]; then
    if [ -f var/ds ]; then
      rm var/ds #remove the file ds if it already exists
    fi
    echo >>var/ds decompiler.v1.ss1.sh #set the compiler to V1
  elif [ $nfi == 2 ]; then
    if [ -f var/ds ]; then
      rm var/ds
    fi
  else
    echo -e "${RED}Error: $nfi is not an input.${NC}"
  fi
elif [ $inf == 2 ]; then
  if [ -f var/ds ]; then
    rm var/ds
  fi
  echo >>var/ds $(zenity -file-selection -file-filter 'Chose your own decompiler.') 
elif [ $inf == 3 ]; then
  if [ -f var/ds ]; then
    rm var/ds
  fi
else
  echo -e "${RED}Error: $inf is not an input.${NC}"
fi
