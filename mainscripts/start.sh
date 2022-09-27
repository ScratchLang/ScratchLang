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
  echo "Checking version..."
  ver=$(sed '1!d' $(dirname $(pwd))/.version)
  utd=1
  #Add version checking scripts here when I figure out how. Maybe with wget or curl.
  if [ utd == 0 ]; then
    echo "Please update your ScratchLang version by cloning the repo again. To transfer your projects, copy and paste the projects folder into the new ScratchLang repo directory, or you can export all of them and import them in the new ScratchLang."
    echo
    echo "This process may be made automatic soon."
    exit
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
  if [ h$1 == h ]; then
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
