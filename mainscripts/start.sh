#!/bin/bash
NC='\033[0m' #Reset text color.
P='\033[0;35m' #Purple
basedir=$(dirname "$(echo "$0" | sed -e 's,\\,/,g')") #get the base directory of start.sh
cd $basedir
if ! [ -f .var/asked ]; then #this is in place so it only asks the below question once, ever.
  if ! [ -f .var/vc ]; then #I don't know why this is here anymore
    echo "Would you like ScratchLang to check its version every time you start it? [Y/N]"
    read -sn 1 ff
    if [ h$ff == hy ] || [ $ff == hY ]; then
      echo >>.var/vc "Don't remove this file please." #when start.sh detects this file, it will check for a new version.
    fi
    echo >>.var/asked "Don't remove."
  fi
fi
if [ -f .var/vc ]; then
  ver=$(sed '1!d' $(dirname $(pwd))/.version) #get local version
  if ! [ h$1 == hnope ]; then
    echo "Checking version..."
    if [ -f .version ]; then
      rm .version
    fi
    wget -q https://raw.githubusercontent.com/0K9090/ScratchLang/main/.version #get the .version file from github
    utd=1
    if ! [ "$ver" == "$(sed '1!d' .version)" ]; then #if local version doesn't match .version from github, then set utd to 0
      utd=0
    fi
    if [ $utd == 0 ]; then #if utd = 0 then update
      echo "Your version of ScratchLang ($ver) is outdated. The current version is $(sed '1!d' .version). Would you like to update? [Y/N]"
      read -sn 1 hh
      if [ h$hh == hy ] || [ h$hh == hY ]; then
        git pull origin main
      fi
      exit
    fi
    rm .version
  fi
fi
if [ h$1 == h-help ]; then #if you input argument -help then you get help commands
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
╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╱╰━━╯╱╰━┻━╯" #logo
  slc=1
  clear
  echo -e "${P}$logo${NC}"
  echo
  if [ h$1 == h ] || [ h$1 == hnope ]; then
    echo "Welcome to ScratchLang $ver. (Name suggested by @MagicCrayon9342 on Scratch)"
    echo "Please select an option."
    if ! [ -f .var/devmode ]; then
      chmod 755 inputloop.sh
      ./inputloop.sh #if devmode is not on
    else
      chmod 755 devinputloop.sh
      ./devinputloop.sh #if demode IS on
    fi
  else
    if ! [ -f .var/devmode ]; then
      chmod 755 inputloop.sh
      ./inputloop.sh $1 #if there is an arg and devmode is not on
    else
      chmod 755 devinputloop.sh
      ./devinputloop.sh $1 #if there is an arg and devmode IS on
    fi
  fi
fi
cd ../
if [ -d projects ]; then #remove the projects folder if there is nothing in it
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
