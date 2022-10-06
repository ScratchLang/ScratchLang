#!/bin/bash
RED='\033[0;31m' #red
NC='\033[0m'     #reset color
echo
echo "1. Pick one of the included decompilers."
echo "2. Choose your own decompiler."
echo "3. Reset to default. (decompiler.v2.ss1.sh)"
read -sn 1 inf
corr=0
case $inf in
1)
  corr=1
  echo
  echo "1. decompiler.v1.ss1.sh - First version of the decompiler. No longer being programmed. ScratchScript1 language."
  echo
  echo "2. decompiler.v2.ss1.sh - Latest and recommended version of the decompiler. ScratchScript1 language."
  read -sn 1 nfi
  corr=0
  case $nfi in
  1)
    corr=1
    if [ -f var/ds ]; then
      rm var/ds #remove the file ds if it already exists
    fi
    echo >>var/ds decompiler.v1.ss1.sh #set the compiler to V1
    ;;
  2)
    corr-1
    if [ -f var/ds ]; then
      rm var/ds
    fi
    ;;
  esac
  if [ $corr = 0 ]; then
    echo -e "${RED}Error: $nfi is not an input.${NC}"
  fi
  ;;
2)
  corr=1
  if [ -f var/ds ]; then
    rm var/ds
  fi
  echo >>var/ds $(zenity -file-selection -file-filter 'Chose your own decompiler.')
  ;;
3)
  corr=1
  if [ -f var/ds ]; then
    rm var/ds
  fi
  ;;

esac
if [ $corr = 0 ]; then
  echo -e "${RED}Error: $inf is not an input.${NC}"
fi
