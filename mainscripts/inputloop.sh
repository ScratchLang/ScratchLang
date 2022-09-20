#!/bin/bash
echo
if [ h$1 == h ]; then
  echo "1. Create a project."
  echo "2. Remove a project."
  echo "3. Compile a project"
  echo "4. Decompile a .sb3 file."
  echo "5. Are options 1 and 2 not working? Input 4 to install dependencies."
  echo "6. Create alias."
  echo "7. Remove alias."
  echo "8. Enable Developer Mode."
  echo "9. Exit."
  read -sn 1 input
elif [ $1 == -1 ]; then
  input=1
elif [ $1 == -2 ]; then
  input=2
elif [ $1 == -3 ]; then
  input=3
else
  input=4
fi
if [ h$input == h1 ]; then
  dir=$(pwd)
  echo
  echo "Name your project. Keep in mind that it cannot be empty or it will not be created properly."
  read name
  echo
  echo "You named your project $name. If you want to rename it, use the File Explorer."
  cd $(dirname $(pwd))
  if ! [ -d projects ]; then
  mkdir projects
  fi
  cd projects
  mkdir $name
  cd $name
  echo >> .maindir "Please don't remove this file."
  mkdir Stage
  cd Stage
  mkdir assets
  cd $(dirname $(pwd))
  cd $(dirname $(pwd))
  cd $(dirname $(pwd))
  cp resources/cd21514d0531fdffb22204e0ec5ed84a.svg projects/$name/Stage/assets
  cd projects/$name/Stage
  echo >> $name.ss \#There should be no empty lines.
  echo >> $name.ss ss
  cd $(dirname $(pwd))
  mkdir Sprite1
  cd Sprite1
  echo >> $name.ss \#There should be no empty lines.
  echo >> $name.ss ss
  mkdir assets
  cd $(dirname $(pwd))
  cd $(dirname $(pwd))
  cd $(dirname $(pwd))
  cp resources/costume1.svg projects/$name/Sprite1/assets
  cp resources/costume2.svg projects/$name/Sprite1/assets
  cd mainscripts
elif [ h$input == h2 ]; then
  cd $(dirname $(pwd))
  cd projects
  echo
  ls -1
  echo
  echo "Choose a project to get rid of, or input nothing to cancel."
  read pgrd
  if ! [ h$pgrd == h ]; then
    if [ -d $pgrd ]; then
      rm -rf $pgrd
    fi
  fi
elif [ h$input == h3 ]; then
  echo "Exe or Shell?"
  read cs
  if [ h$cs == hExe ] || [ h$cs == hexe ]; then
    if ! [ -f compile.exe ]; then
      gcc -o compile.exe 2.c
    fi
    ./compile.exe
  elif [ h$cs == hShell ] || [ h$cs == hshell ]; then
    chmod 755 compiler.sh
    ./compiler.sh
  else
    echo "Error: $cs not an input."
  fi
elif [ h$input == h4 ]; then
  echo "Exe or Shell?"
  read cs
  if [ h$cs == hExe ] || [ h$cs == hexe ]; then
    if ! [ -f decompiler.exe ]; then
      gcc -o decompiler.exe 3.c
    fi
    ./decompile.exe
  elif [ h$cs == hShell ] || [ h$cs == hshell ]; then
    chmod 755 decompiler.sh
    ./decompiler.sh
  else
    echo "Error: $cs not an input."
  fi
elif [ h$input == h5 ]; then
  pacman -S mingw-w64-x86_64-gcc
  ./start.sh
elif [ h$input == h6 ]; then
  dir=$(pwd)
  if ! [ -f .var/alias ]; then
    cp ~/.bashrc .var
    echo >> ~/.bashrc
    echo >> ~/.bashrc "alias scratchlang='cd $dir && ./start.sh'"
    echo >> .var/alias "This file tells the program that the alias is already created. Please don't touch this."
    echo
    echo "Please restart your terminal."
  else
    echo "alias has already been created."
  fi
elif [ h$input == h7 ]; then
  chmod 755 rmaliasiloop.sh
  ./rmaliasiloop.sh
elif [ h$input == h8 ]; then
  echo >> .var/devmode "This is a devmode file. You can manually remove it to disable dev mode if you don't want to use the program to disable it for some reason."
  ./start.sh
elif [ h$input = h9 ]; then
  clear
else
  echo "$input is not an input!"
  ./inputloop.sh
fi