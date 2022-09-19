#!/bin/bash
echo
echo "Remember, both the compiler and decompiler don't work yet. The decompiler extracts the .sb3, but it can't make it into the ScratchScript format yet."
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
  echo "Select the .sb3 you want to decompile. WARNING! THE NAME OF THE FILE CANNOT HAVE ANY SPACES OR IT WILL NOT UNZIP CORRECTLY!!!"
  sleep 2
  file=$(zenity -file-selection)
  echo
  echo "Name of project? Keep in mind that it cannot be empty or it will not be created properly."
  read name
  cd $(dirname $(pwd))
  if ! [ -d projects ]; then
    mkdir projects
  fi
  cd projects
  mkdir $name
  cd $name
  unzip $file
  echo >> .maindir "Please don't remove this file."
  mkdir Stage
  cd Stage
  mkdir assets
  cd $(dirname $(pwd))
  #Add decompilation scripts here
  if [ 1 == 1 ]; then
    cd $(dirname $(pwd))
    cd $(dirname $(pwd))
    cd mainscripts
  fi
elif [ h$input3 == hn ] || [ h$input3 == hN ]; then
  echo "Install zenity for MSYS2, or this won't work."
else
  echo "$input3 is not an input."
  ./compiler.sh
fi