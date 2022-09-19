#!/bin/bash
echo
echo "Remember, both the compiler and decompiler don't work yet."
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
    echo >> .var/zenity
  fi
  echo "Select the project directory."
  echo
  sleep 2
  file=$(zenity -directory -file-selection)
  cd $file
  if [ -f .maindir ]; then
    echo >> .dirs $(ls -1)
    json={\"targets\":[{\"isStage\":true,\"name\":\"Stage\",\"variables\": #Start of the json
    for i in {1..$(sed -n '$=' .dirs)} #Starts compiling the json
    do
      if [ $i == 1 ]; then
        cd Stage
        block=$(sed $i'.dirs')
        if [ block == "when flag clicked" ]; then
          echo
        fi
      else
        block=$(sed $i'.dirs')
        if [ block == "when flag clicked" ]; then
          echo
        fi
      fi
    done
    echo >> project.json $json #creates the project.json
    #pack into sb3 here
  else
    echo "Error: Not a project directory."
  fi
elif [ h$input3 == hn ] || [ h$input3 == hN ]; then
  echo "Install zenity for MSYS2, or this won't work."
else
  echo "$input3 is not an input."
  ./compiler.sh
fi