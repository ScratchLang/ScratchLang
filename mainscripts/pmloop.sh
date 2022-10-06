#!/bin/bash
RED='\033[0;31m'
NC='\033[0m'
cd ../
cd packages
echo
echo "1. Get info of package"
echo "2. Delete package"
read -sn 1 jj
ccor=0
case $jj in
1)
  ccor=1
  dir=$(zenity -list $(ls))
  cd $dir
  echo "Package: $dir"
  echo "Info: $(cat info.txt)"
  echo "Version: $(sed '1!d' version)"
  ;;
2)
  ccor=1
  dir=$(zenity -list $(ls))
  rm -rf $dir
  ;;
esac
if [ $ccor == 0 ]; then
  echo -e "${RED}Error: $jj is not an input.${NC}"
fi
