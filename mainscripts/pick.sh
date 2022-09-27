#!/bin/bash
RED='\033[0;31m'
NC='\033[0m'
echo
echo "1. Pick one of the included decompilers."
echo "2. Choose your own decompiler."
echo "3. Reset to default. (decompiler.v2.ss1.sh)"
read -sn 1 inf
if [ $inf == 1 ]; then
  echo
  echo "1. decompiler.v1.ss1.sh - First version of the decompiler. No longer being programmed. ScratchScript1 language."
  echo
  echo "2. decompiler.v2.ss1.sh - Latest and recommended version of the decompiler. ScratchScript1 language."
  read -sn 1 nfi
  if [ $nfi == 1 ]; then
    if [ -f .var/ds ]; then
      rm .var/ds
    fi
    echo >>.var/ds decompiler.v1.ss1.sh
  elif [ $nfi == 2 ]; then
    if [ -f .var/ds ]; then
      rm .var/ds
    fi
    if [ -f .var/ds ]; then
      rm .var/ds
    fi
  else
    echo -e "${RED}Error: $nfi is not an input.${NC}"
  fi
elif [ $inf == 2 ]; then
  if [ -f .var/ds ]; then
    rm .var/ds
  fi
  echo >>.var/ds $(zenity -file-selection -file-filter 'Shell Script Program *.sh')
elif [ $inf == 3 ]; then
  if [ -f .var/ds ]; then
    rm .var/ds
  fi
else
  echo -e "${RED}Error: $inf is not an input.${NC}"
fi
