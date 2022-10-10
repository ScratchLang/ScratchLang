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
RED='\033[0;31m'
NC='\033[0m'
echo
echo "1. Get info of package"
echo "2. Install packages"
echo "For now you have to manually update packages. Update option coming soon."
echo "3. Delete package"
if [ -f var/pe ]; then
  echo "4. Disable packages"
else
  echo "4. Enable packages"
fi
echo "5. Exit"
cd ../
cd packages
read -sn 1 jj
ccor=0
case $jj in
1)
  ccor=1
  dir=$(zenity -list $(ls -d */))
  cd $dir
  echo
  echo -e "${RED}Package:${NC} $dir"
  echo
  echo -e "${RED}Info:${NC} $(cat info.txt)"
  echo
  echo -e "${RED}Version:${NC} $(sed '1!d' version)"
  ;;
2)
  ccor=1
  echo
  read -p "Enter package to install: " pack
  if [ "h$pack" == h ]; then
    echo -e "${RED}Error: Empty argument.${NC}"
    exit
  fi
  cd ../
  cd packages
  if [ -f packages.list ]; then
    pk=$(cat packages.list)
    echo "$pk, $pack"
    if [[ "|$pk|" == *"|$pack|"* ]]; then
      b=0
      echo
      echo "Installing $pack..."
      while :; do
        ((b++))
        line=$(sed $b'!d' packages.list)
        if [[ "$line" == "|$pack|" ]]; then
          break
        fi
      done
      ((b++))
      line=$(sed $b'!d' packages.list)
      eval $line
      unzip -q $pack
      rm -rf $pack.zip
    else
      echo -e "${RED}Error: Package $pack not found. Try running './start.sh update' or 'scratchlang update.'${NC}"
    fi
  else
    echo -e "${RED}Error: No package list. Run './start.sh update' or 'scratchlang update.'${NC}"
  fi
  ;;
3)
  ccor=1
  dir=$(zenity -list $(ls -d */))
  rm -rf $dir
  ;;
4)
  ccor=1
  cd ../
  cd mainscripts
  if [ -f var/pe ]; then
    rm var/pe
  else
    echo >>var/pe
    echo "Keep in mind that packages are not reccomended, since ScratchLang is very slow with them."
  fi
  ;;
5)
  ccor=1
  cd ../
  cd mainscripts
  ./start.sh nope
  ;;
esac
if [ $ccor == 0 ]; then
  echo -e "${RED}Error: $jj is not an input.${NC}"
fi
