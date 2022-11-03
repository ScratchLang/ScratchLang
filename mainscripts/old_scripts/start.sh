#!/bin/bash
RED='\033[0;31m'               #red
NC='\033[0m'                   #Reset text color.
P='\033[0;35m'                 #Purple
basedir=$(dirname "${0/\\//}") #get the base directory of start.sh
cd "$basedir" || exit          #enter the base directory path/ScratchLang/mainscripts
#start initializing packagess
if [ -f var/pe ]; then            #if a file called pe exists
  if ! [ "h$1" == "hnope" ]; then #if it is not being ran from another file
    echo "Initializing packages..."
    if [ -f plist ]; then #if a file named plist already exists, remove it
      rm plist
    fi
    cd ../                        #go to base directory of current dir path/ScratchLang
    cd packages || exit           #go into the packages directory /path/ScratchLang/packages
    dcount=$(ls -1d ./*/ | wc -l) #get number of directories
    if [ -f dirlist ]; then       #if a file named dirlist already exists, remove it
      rm dirlist
    fi
    echo -e "$(ls -1d ./*/)" >>dirlist          #echo all directories to the file dirlist
    for ((i = 1; i <= dcount; i++)); do         #repeat for how many directories there are
      line=$(sed "$i"'!d' dirlist)              #get line $i of dirlist
      if ! [ "$line" == "package-base/" ]; then #do this if the current line does not equal package-base/
        pname="$line"                           #set the name of the directory to the line $i of dirname
        cd "$line" || exit                      #enter the package directory path/ScratchLang/packages/PACKAGEDIR
        nee=$(sed -n '$=' intergrations)        #set this variable to the line count of the file intergrations
        for ((k = 1; k <= nee; k++)); do        #repeat for the line count of the file intergrations
          line=$(sed "$k"'!d' intergrations)    #set the variable to line $k of the file intergrations
          b=0
          name=
          while :; do              #repeat until char $l of $line equals a space
            ((b++))                #change $b by 1
            l=${line:$((b - 1)):1} #get the ${b}nth char from $line
            if [ "$l" == " " ]; then
              break
            fi
            name+=$l #add the value of $l to the variable $name
          done
          echo >>../../mainscripts/plist "$name"              #echo the var $name to the file plist
          echo >>../../mainscripts/plist "${pname}package.sh" #echo more stuff to the file plist
          name=
          while :; do
            ((b++))
            l=${line:$((b - 1)):1}
            if [ "$l" == ";" ]; then
              break
            fi
            name+=$l
          done
          echo >>../../mainscripts/plist "$name"
          cd ../ #go to base directory path/ScratchLang/packages
        done
      fi
    done
    rm dirlist             #remove the dirlist file
    cd ../                 #go to base directory path/ScratchLang
    cd mainscripts || exit #go to path/ScratchLang/mainscripts
  fi
  #end initializing packages
  #every package has to start after this line if the package edits start.sh
  getnextp() { #package intergration scripts, don't worry about these
    res=0
    small=$1
    execute=
    while :; do
      ((res++))
      if [ "$res" -gt "$(sed -n '$=' plist)" ]; then
        break
      fi
      reser=$(sed "$res"'!d' plist)
      if [ "$reser" == "$0" ]; then
        ((res++))
        ((res++))
        reser=$(sed "$res"'!d' plist)
        if [ "$reser" -lt "$small" ]; then
          small="$reser"
          ((res--))
          reser=$(sed "$res"'!d' plist)
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
          getnextp "$1"
        fi
        if [ "${BASH_LINENO[0]}" == "$small" ]; then
          cd ../
          ./packages/"$execute"
          cd mainscripts || exit
          don=1
        fi
      fi
    fi
  }
  trap 'step $npl' DEBUG
fi
cd ../
ver=$(sed '1!d' version) #get local version
cd mainscripts || exit
if ! [ -f var/asked ]; then #this is in place so it only asks the below question once, ever.
  if ! [ -f var/vc ]; then  #I don't know why this is here anymore
    echo "Would you like ScratchLang to check its version every time you start it? [Y/N]"
    read -rsn 1 ff                                   #read user input
    if [ h"$ff" == hy ] || [ h"$ff" == hY ]; then    #if y is input
      echo >>var/vc "Don't remove this file please." #when start.sh detects this file, it will check for a new version.
    fi
    echo >>var/asked "Don't remove this file please."
  fi
fi
if [ -f var/vc ]; then
  if ! [ h"$1" == hnope ]; then #start checking version
    echo "Checking version..."
    if [ -f version ]; then #if the version file already exists, remove it
      rm version
    fi
    wget -q https://raw.githubusercontent.com/ScratchLang/ScratchLang/main/version #get the version file from github
    utd=1
    if ! [ "$ver" == "$(sed '1!d' version)" ]; then #if local version doesn't match version from github, then set utd to 0
      utd=0
    fi
    if [ $utd == 0 ]; then #if utd = 0 then update
      echo "Your version of ScratchLang ($ver) is outdated. The current version is $(sed '1!d' version). Would you like to update? [Y/N]"
      read -rsn 1 hh #get user input
      if [ h"$hh" == hy ] || [ h"$hh" == hY ]; then
        git pull origin main #pull the latest version from github
      fi
      exit
    fi
    rm version
  fi
fi
if [ h"$1" == hinstall ]; then #install packages, don't worry about this
  cd ../
  cd packages || exit
  if [ -f packages.list ]; then
    pk=$(cat packages.list)
    if [[ "|$pk|" == *"|$2|"* ]]; then
      b=0
      echo
      echo "Installing $2..."
      while :; do
        ((b++))
        line=$(sed "$b"'!d' packages.list)
        if [[ "$line" == "|$2|" ]]; then
          break
        fi
      done
      ((b++))
      line=$(sed "$b"'!d' packages.list)
      eval "$line"
      unzip -q "$2"
      rm -rf "$2".zip
    else
      echo -e "${RED}Error: Package $2 not found. Try running './start.sh update' or 'scratchlang update.'${NC}"
    fi
  else
    echo -e "${RED}Error: No package list. Run './start.sh update' or 'scratchlang update.'${NC}"
  fi
elif [ h"$1" == hupdate ]; then #update package list
  cd ../
  cd packages || exit
  if [ -f packages.list ]; then
    rm packages.list
  fi
  wget -q https://raw.githubusercontent.com/0K9090/sl-packages/main/packages.list #download from github
elif [ h"$1" == h--help ]; then                                                   #if you input argument -help then you get help commands
  echo "scratchlang (or ./start.sh if you haven't created the scratchlang command)"
  echo
  echo "  -1                Create a project"
  echo "  -2                Remove a project"
  echo "  -3                Compile a project"
  echo "  -4                Decompile a project"
  echo "  -5                Export a project"
  echo "  -6                Import a project"
  echo "  --debug [FILE]    Debug a ScratchScript file"
  echo "  --help            Display this help message."
  echo "  install [PACKAGE] Install packages"
  echo "  update            Update the package list"
elif [ h"$1" == h--debug ]; then #debug a ScratchScript file, not working yet.
  if [ "h$2" == h ]; then
    echo -e "${RED}Error: No file provided for debug.${NC}"
  else
    chmod 755 debug.sh
    ./debug.sh "$2"
  fi
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
  clear
  echo -e "${P}$logo${NC}"
  echo
  if [ h"$1" == h ] || [ h"$1" == hnope ]; then
    echo "Welcome to ScratchLang $ver. (Name suggested by @MagicCrayon9342 on Scratch)"
    echo "Please select an option."
    if ! [ -f var/devmode ]; then
      chmod 755 inputloop.sh
      ./inputloop.sh #if devmode is not on
    else
      chmod 755 devinputloop.sh
      ./devinputloop.sh #if demode IS on
    fi
  else
    if ! [ -f var/devmode ]; then
      chmod 755 inputloop.sh
      ./inputloop.sh "$1" #if there is an arg and devmode is not on
    else
      chmod 755 devinputloop.sh
      ./devinputloop.sh "$1" #if there is an arg and devmode IS on
    fi
  fi
fi
cd ../
if [ -d projects ]; then #remove the projects folder if there is nothing in it
  cd projects || exit
  h=h$(ls)
  if [ "$h" == h ]; then
    cd ../
    rm -rf projects
    cd mainscripts || exit
  fi
else
  cd mainscripts || exit
fi
