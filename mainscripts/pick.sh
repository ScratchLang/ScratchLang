#!/bin/bash
if [ -f var/pe ]; then
  getnextp() {
    res=0
    small=$1
    execute=
    while :; do
      ((res++))
      if [ "$res" -gt "$(sed -n '$=' plist)" ]; then
        break
      fi
      reser=$(sed "$res"'!d' plist)
      if [ "$reser" == "$0" ]; then
        ((res++))
        ((res++))
        reser=$(sed "$res"'!d' plist)
        if [ "$reser" -lt "$small" ]; then
          small="$reser"
          ((res--))
          reser=$(sed "$res"'!d' plist)
          execute=$reser
          ((res++))
        fi
      fi
    done
    don=2
  }
  npl=999999999
  don=1
  step() {
    if [ -d var ]; then
      if [[ "$(cat plist)" == *"$0"* ]]; then
        if [ "$don" == 1 ]; then
          getnextp "$1"
        fi
        if [ "${BASH_LINENO[0]}" == "$small" ]; then
          cd ../
          ./packages/"$execute"
          cd mainscripts || exit
          don=1
        fi
      fi
    fi
  }
  trap 'step $npl' DEBUG
fi
RED='\033[0;31m' #red
NC='\033[0m'     #reset color
echo
echo "1. Pick one of the included decompilers."
echo "2. Choose your own decompiler."
echo "3. Reset to default. (decompilerpy.v1.ss1.py)"
read -rsn 1 inf
corr=0
case $inf in
1)
  corr=1
  echo
  echo "1. decompiler.v1.ss1.sh - First version of the decompiler. No longer being programmed. ScratchScript1 language."
  echo
  echo "2. decompiler.v2.ss1.sh - Most up-to-date version of the decompiler. ScratchScript1 language."
  echo
  echo "3. decompilerpy.v1.ss1.py - Decompiler V2 remade in Python for speed and more capabilities. ScratchScript 1 language."
  read -rsn 1 nfi
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
    corr=1
    if [ -f var/ds ]; then
      rm var/ds
    fi
    ;;
  3)
    corr=1
    if [ -f var/ds ]; then
      rm var/ds
    fi
    echo >>var/ds py
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
  zenity -file-selection -file-filter 'Chose your own decompiler.' >>var/ds
  ;;
3)
  corr=1
  if [ -f var/ds ]; then
    rm var/ds
  fi
  echo >>var/ds py
  ;;

esac
if [ $corr = 0 ]; then
  echo -e "${RED}Error: $inf is not an input.${NC}"
fi
