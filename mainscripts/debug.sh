#!/bin/bash
#debug scratchscript files
RED='\033[0;31m'
NC='\033[0m'
if ! [ -f $1 ]; then
  echo -e "${RED}Error: file $1 does not exist."
  exit
fi
b=0
while :; do
  ((b++))
  if [ $b -gt "$(sed -n '$=' $1)" ]; then
    break
  fi
  line=$(sed $b'!d' $1)
done
