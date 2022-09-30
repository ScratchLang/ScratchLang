#!/bin/bash
RED='\033[0;31m'
NC='\033[0m'
echo
echo -e "${RED}Compiler 1.0${NC}"
echo
echo "Remember, both the compiler doesn't work yet."
echo
if ! [ -f .var/zenity ]; then
  echo "Do you have the command zenity? [Y/N]"
  read -sn 1 input3
else
  input3=y
fi
echo
if [ h$input3 == hY ] || [ h$input3 == hy ]; then
  if ! [ -f .var/zenity ]; then
    echo >>.var/zenity
  fi
  echo "Select the project directory. (Not the directory called \"Projects\", your project dir inside the directory Projects.)"
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
