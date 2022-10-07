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
      reser=$(sed $res'!d' plist)
      if [ "$reser" == "$0" ]; then
        ((res++))
        ((res++))
        reser=$(sed $res'!d' plist)
        if [ "$reser" -lt "$small" ]; then
          small="$reser"
          ((res--))
          reser=$(sed $res'!d' plist)
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
          getnextp $1
        fi
        if [ "${BASH_LINENO[0]}" == "$small" ]; then
          cd ../
          ./packages/$execute
          cd mainscripts
          don=1
        fi
      fi
    fi
  }
  trap "step $npl" DEBUG
fi
RED='\033[0;31m' #red
NC='\033[0m' #reset color
echo
if ! [ -f var/alias ]; then #detect if scratchlang command has been created
  echo -e "${RED}Error: scratchlang command has not been created or var/alias file has been deleted.${NC}"
  exit
fi
echo -e "${RED}WARNING:${NC} This will remove the scratchlang command."
echo "Continue? [Y/N]"
read -sn 1 input2
echo
if [ h$input2 == hY ] || [ h$input2 == hy ]; then
  rm /usr/bin/scratchlang #remove scratchlang command
  rm var/alias
elif [ h$input2 == hn ] || [ h$input2 == hN ]; then
  echo
else
  echo -e "${RED}$input2 is not an option.${NC}"
  ./rmaliasiloop.sh
fi
