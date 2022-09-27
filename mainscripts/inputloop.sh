#!/bin/bash
RED='\033[0;31m'
NC='\033[0m'
echo
if [ h$1 == h ]; then
  echo "1. Create a project."
  echo "2. Remove a project."
  echo "3. Compile a project."
  echo "4. Decompile a .sb3 file."
  echo "5. Export project."
  echo "6. Import project."
  echo "7. Are options 3 and 4 not working? Input 7 to install dependencies.."
  echo "8. Create scratchlang command."
  echo "9. Remove scratchlang command."
  echo "A. Enable Developer Mode."
  echo "B. Exit."
  read -sn 1 input
elif [ $1 == -1 ]; then
  input=1
elif [ $1 == -2 ]; then
  input=2
elif [ $1 == -3 ]; then
  input=3
elif [ $1 == -4 ]; then
  input=4
elif [ $1 == -5 ]; then
  input=5
else
  input=6
fi
if [ h$input == h1 ]; then
  dir=$(pwd)
  echo
  echo "Name your project. Keep in mind that it cannot be empty or it will not be created properly."
  read name
  if [ h$name == h ]; then
    echo -e "${RED}Error: Project name empty.${NC}"
    exit
  fi
  echo "You named your project $name. If you want to rename it, use the File Explorer."
  cd ../
  if ! [ -d projects ]; then
    mkdir projects
  fi
  cd projects
  mkdir $name
  cd $name
  echo >>.maindir "Please don't remove this file."
  mkdir Stage
  cd Stage
  mkdir assets
  cd ../
  cd ../
  cd ../
  cp resources/cd21514d0531fdffb22204e0ec5ed84a.svg projects/$name/Stage/assets
  cd projects/$name/Stage
  echo >>$name.ss \#There should be no empty lines.
  echo >>$name.ss ss
  cd ../
  mkdir Sprite1
  cd Sprite1
  echo >>$name.ss \#There should be no empty lines.
  echo >>$name.ss ss
  mkdir assets
  cd ../
  cd ../
  cd ../
  cp resources/341ff8639e74404142c11ad52929b021.svg projects/$name/Sprite1/assets
  cp resources/c9466893cdbdda41de3ec986256e5a47.svg projects/$name/Sprite1/assets
  cd mainscripts
elif [ h$input == h2 ]; then
  cd ../
  if ! [ -d projects ]; then
    echo -e "${RED}Error: there are no projects to delete.${NC}"
    exit
  fi
  cd projects
  echo
  ls -1
  echo
  echo "Choose a project to get rid of, or input nothing to cancel."
  read pgrd
  if ! [ h$pgrd == h ]; then
    if [ -d $pgrd ]; then
      rm -rf $pgrd
    else
      echo -e "${RED}Error: directory $pgrd does not exist.${NC}"
    fi
  fi
elif [ h$input == h3 ]; then
  chmod 755 compiler.sh
  ./compiler.sh
elif [ h$input == h4 ]; then
  if [ -f .var/ds ]; then
    chmod 755 $(sed '1!d' .var/ds)
    ./$(sed '1!d' .var/ds)
  else
    chmod 755 decompiler.v2.ss1.sh
    ./decompiler.v2.ss1.sh
  fi
elif [ h$input == h5 ]; then
  cd ../
  if ! [ -d projects ]; then
    echo -e "${RED}Error: there are no projects to export.${NC}"
    exit
  fi
  cd projects
  echo
  ls -1
  echo
  echo "Choose a project to export, or input nothing to cancel."
  read pgrd
  if ! [ h$pgrd == h ]; then
    if [ -d $pgrd ]; then
      tar -cf $pgrd.ssa $pgrd #ScratchScript Archive
      cd ../
      cp projects/$pgrd.ssa exports
      rm projects/$pgrd.ssa
      echo "Your project $pgrd.ssa can be found in the exports folder."
    else
      echo -e "${RED}Error: directory $pgrd does not exist.${NC}"
    fi
  fi
elif [ h$input == h6 ]; then
  if ! [ -f .var/zenity ]; then
    echo "Do you have the command zenity? [Y/N]"
    read -sn 1 input3
  else
    input3=y
  fi
  if [ h$input3 == hY ] || [ h$input3 == hy ]; then
    import=$(zenity -file-selection -file-filter 'ScratchScript\ Archive *.ssa')
    cd ../
    if ! [ -d projects ]; then
      mkdir projects
    fi
    cd projects
    tar -xf $import
    echo "Remove .ssa file? [Y/N]"
    read -sn 1 f
    if [ h$f == hY ] || [ h$f == hy ]; then
      rm $import
    fi
  elif [ h$input3 == hN ] || [ h$input3 == hn ]; then
    echo
  else
    echo "${RED}Error: $input3 not an input.${NC}"
  fi
elif [ h$input == h7 ]; then
  echo "This only works for MSYS2/MINGW. Continue? [Y/N]"
  read -sn 1 con
  if [ h$con == hY ] || [ h$con == hy ]; then
    echo
    bit=$(getconf LONG_BIT)
    dir=$(pwd)
    cd
    mkdir zenity
    cd zenity
    if [ $bit == 64 ]; then
      wget https://github.com/ncruces/zenity/releases/download/v0.9.0/zenity_win64.zip
      version=zenity_win64
    else
      wget https://github.com/ncruces/zenity/releases/download/v0.9.0/zenity_win32.zip
      version=zenity_win32
    fi
    unzip -n $version.zip
    cp zenity.exe /usr/bin
    cd ../
    rm -rf zenity
    cd $dir
    pacman -S mingw-w64-x86_64-jq
    ./start.sh
  elif [ h$con == hN ] || [ h$con == hn ]; then
    echo
  else
    echo -e "${RED}Error: $con not an input.${NC}"
  fi
elif [ h$input == h8 ]; then
  dir=$(pwd)
  if ! [ -f .var/alias ]; then

    echo >>/usr/bin/scratchlang "cd $dir && ./start.sh \$1 \$2 \$3"
    echo >>.var/alias "This file tells the program that the command is already created. Please don't touch this."
  else
    echo "alias has already been created."
  fi
elif [ h$input == h9 ]; then
  chmod 755 rmaliasiloop.sh
  ./rmaliasiloop.sh
elif [ h$input == hA ] || [ h$input == ha ]; then
  echo >>.var/devmode "This is a devmode file. You can manually remove it to disable dev mode if you don't want to use the program to disable it for some reason."
  ./start.sh
elif [ h$input == hB ] || [ h$input == hb ]; then
  clear
else
  echo -e "${RED}Error: $input is not an input.${NC}"
  ./inputloop.sh
fi
