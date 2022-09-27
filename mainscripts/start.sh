#!/bin/bash
NC='\033[0m'
P='\033[0;35m'
basedir=$(dirname "$(echo "$0" | sed -e 's,\\,/,g')")
cd $basedir
if ! [ -f .var/asked ]; then
  if ! [ -f .var/vc ]; then
    echo "Would you like ScratchLang to check its version every time you start it? [Y/N]"
    read -sn 1 ff
    if [ h$ff == hy ] || [ $ff == hY ]; then
      echo >>.var/vc "Don't remove this file please."
    fi
    echo >>.var/asked "Don't remove."
  fi
fi
if [ -f .var/vc ]; then
  ver=$(sed '1!d' $(dirname $(pwd))/.version) #get version
  if ! [ h$1 == hnope ]; then
    echo "Checking version..."
    wget -q https://raw.githubusercontent.com/0K9090/ScratchLang/main/.version
    utd=1
    if ! [ "$ver" == "$(sed '1!d' .version)" ]; then
      utd=0
    fi
    if [ $utd == 0 ]; then
      echo "Your version of ScratchLang ($ver) is outdated. The current version is $(sed '1!d' .version). Would you like to update? [Y/N]"
      read -sn 1 hh
      if [ h$hh == hy ] || [ h$hh == hY ]; then
        cd ../
        cd ../
        mv ScratchLang slold
        cp -r slold/projects
        rm -rf slold
        git clone https://github.com/0K9090/ScratchLang.git
        cp projects ScratchLang
        exit
      fi
    fi
    rm .version
  fi
fi
if [ h$1 == h-help ]; then
  echo "scratchlang (or ./start.sh if you haven't created the scratchlang command)"
  echo
  echo "  -1      Create a project"
  echo "  -2      Remove a project"
  echo "  -3      Compile a project"
  echo "  -4      Decompile a project"
  echo "  -5      Export a project"
  echo "  -6      Import a project"
  echo "  -help      Display this help message."
else
  logo="
╭━━━╮╱╱╱╱╱╱╱╭╮╱╱╱╭╮╱╭╮╱╱╱╱╱╱╱╱╱╱╱╱╱╭━┳━╮
┃╭━╮┃╱╱╱╱╱╱╭╯╰╮╱╱┃┃╱┃┃╱╱╱╱╱╱╱╱╱╱╱╱╭╯╭┻╮╰╮ 
┃╰━━┳━━┳━┳━┻╮╭╋━━┫╰━┫┃╱╱╭━━┳━╮╭━━┳╯╭╯╱╰╮╰╮    
╰━━╮┃╭━┫╭┫╭╮┃┃┃╭━┫╭╮┃┃╱╭┫╭╮┃╭╮┫╭╮┃┃┃╱╱╱┃┃┃
┃╰━╯┃╰━┫┃┃╭╮┃╰┫╰━┫┃┃┃╰━╯┃╭╮┃┃┃┃╰╯┃┃┃╱╱╱┃┃┃    
╰━━━┻━━┻╯╰╯╰┻━┻━━┻╯╰┻━━━┻╯╰┻╯╰┻━╮┣╮╰╮╱╭╯╭╯
╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╭━╯┃╰╮╰┳╯╭╯
╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╰━━╯╱╰━┻━╯"
  slc=1
  clear
  echo -e "${P}$logo${NC}"
  echo
  if [ h$1 == h ] || [ h$1 == hnope ]; then
    echo "Welcome to ScratchLang $ver. (Name suggested by @MagicCrayon9342 on Scratch)"
    echo "Please select an option."
    if ! [ -f .var/devmode ]; then
      chmod 755 inputloop.sh
      ./inputloop.sh
    else
      chmod 755 devinputloop.sh
      ./devinputloop.sh
    fi
  else
    if ! [ -f .var/devmode ]; then
      chmod 755 inputloop.sh
      ./inputloop.sh $1
    else
      chmod 755 devinputloop.sh
      ./devinputloop.sh $1
    fi
  fi
fi
cd ../
if [ -d projects ]; then
  cd projects
  h=h$(ls)
  if [ "$h" == h ]; then
    cd ../
    rm -rf projects
    cd mainscripts
  fi
else
  cd mainscripts
fi
