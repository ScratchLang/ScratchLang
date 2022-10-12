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
echo -e "${RED}Compiler 1.0${NC}"
echo
echo "Remember, both the compiler doesn't work yet."
echo
if ! [ -f var/zenity ]; then
  echo "Do you have the command zenity? [Y/N]"
  read -sn 1 input3
else
  input3=y
fi
echo
if [ h$input3 == hY ] || [ h$input3 == hy ]; then
  if ! [ -f var/zenity ]; then
    echo >>var/zenity
  fi
  echo "Select your project folder."
  echo
  sleep 2
  file=$(zenity -directory -file-selection)
  cd $file
  if [ -f .maindir ]; then
   cd Stage
    echo >>.dirs $(ls -1)
    json="{\"targets\":[{\"isStage\":true,\"name\":\"Stage\",\"variables\":" #Start of the json
    for ((i = 1; i <= $(sed -n '$=' .dirs); i++)); do
      echo
    done
    echo >>project.json $json #creates the project.json
    #pack into sb3 here
  else
    echo -e "${RED}Error: Not a project directory.${NC}"
  fi
elif [ h$input3 == hn ] || [ h$input3 == hN ]; then
  echo "Install zenity for MSYS2, or this won't work."
else
  echo -e "${RED}Error: $input3 is not an input.${NC}"
  ./compiler.sh
fi
