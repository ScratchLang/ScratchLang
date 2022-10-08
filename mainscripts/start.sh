#!/bin/bash
RED='\033[0;31m'                                      #red
NC='\033[0m'                                          #Reset text color.
P='\033[0;35m'                                        #Purple
basedir=$(dirname "$(echo "$0" | sed -e 's,\\,/,g')") #get the base directory of start.sh
cd $basedir
#start initializing packagess
if [ -f var/pe ]; then
  if ! [ "h$1" == "hnope" ]; then
    echo "Initializing packages..."
    if [ -f plist ]; then
      rm plist
    fi
    cd ../
    cd packages
    dcount=$(ls -1d */ | wc -l) #get number of directories
    if [ -f dirlist ]; then
      rm dirlist
    fi
    echo -e "$(ls -1d */)" >>dirlist
    for ((i = 1; i <= $dcount; i++)); do
      line=$(sed $i'!d' dirlist)
      if ! [ "$line" == "package-base/" ]; then
        pname="$line"
        cd "$line"
        lcount=
        nee=$(sed -n '$=' intergrations)
        for ((k = 1; k <= $nee; k++)); do
          line=$(sed $k'!d' intergrations)
          b=0
          name=
          while :; do
            ((b++))
            l=${line:$(expr $b - 1):1}
            if [ "$l" == " " ]; then
              break
            fi
            name+=$l
          done
          echo >>$(dirname $(dirname $PWD))/mainscripts/plist "$name"
          echo >>$(dirname $(dirname $PWD))/mainscripts/plist "${pname}package.sh"
          name=
          while :; do
            ((b++))
            l=${line:$(expr $b - 1):1}
            if [ "$l" == ";" ]; then
              break
            fi
            name+=$l
          done
          echo >>$(dirname $(dirname $PWD))/mainscripts/plist "$name"
          cd ../
        done
      fi
    done
    rm dirlist
    cd ../
    cd mainscripts
  fi
  #end initializing packages
  #every package has to start after this line if the package edits start.sh
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
ver=$(sed '1!d' $(dirname $PWD)/version) #get local version
if ! [ -f var/asked ]; then              #this is in place so it only asks the below question once, ever.
  if ! [ -f var/vc ]; then               #I don't know why this is here anymore
    echo "Would you like ScratchLang to check its version every time you start it? [Y/N]"
    read -sn 1 ff
    if [ h$ff == hy ] || [ h$ff == hY ]; then
      echo >>var/vc "Don't remove this file please." #when start.sh detects this file, it will check for a new version.
    fi
    echo >>var/asked "Don't remove."
  fi
fi
if [ -f var/vc ]; then
  if ! [ h$1 == hnope ]; then
    echo "Checking version..."
    if [ -f version ]; then
      rm version
    fi
    wget -q https://raw.githubusercontent.com/0K9090/ScratchLang/main/version #get the version file from github
    utd=1
    if ! [ "$ver" == "$(sed '1!d' version)" ]; then #if local version doesn't match version from github, then set utd to 0
      utd=0
    fi
    if [ $utd == 0 ]; then #if utd = 0 then update
      echo "Your version of ScratchLang ($ver) is outdated. The current version is $(sed '1!d' version). Would you like to update? [Y/N]"
      read -sn 1 hh
      if [ h$hh == hy ] || [ h$hh == hY ]; then
        git pull origin main
      fi
      exit
    fi
    rm version
  fi
fi
if [ h$1 == hinstall ]; then #install packages
  cd ../
  cd packages
  if [ -f packages.list ]; then
    pk=$(cat packages.list)
    if [[ "$pk" == *"$2"* ]]; then
      b=0
      echo
      echo "Installing $2..."
      while :; do
        ((b++))
        line=$(sed $b'!d' packages.list)
        if [[ "$line" == *"$2"* ]]; then
          break
        fi
      done
      eval $line
      unzip -q $2
      rm -rf $2.zip
    else
      echo -e "${RED}Error: Package $2 not found. Try running './start.sh update' or 'scratchlang update.'${NC}"
    fi
  else
    echo -e "${RED}Error: No package list. Run './start.sh update' or 'scratchlang update.'${NC}"
  fi
elif [ h$1 == hupdate ]; then
  cd ../
  cd packages
  if [ -f packages.list ]; then
    rm packages.list
  fi
  wget -q https://raw.githubusercontent.com/0K9090/sl-packages/main/packages.list
elif [ h$1 == h--help ]; then #if you input argument -help then you get help commands
  echo "scratchlang (or ./start.sh if you haven't created the scratchlang command)"
  echo
  echo "  -1                Create a project"
  echo "  -2                Remove a project"
  echo "  -3                Compile a project"
  echo "  -4                Decompile a project"
  echo "  -5                Export a project"
  echo "  -6                Import a project"
  echo "  --help            Display this help message."
  echo "  install [PACKAGE] Install packages"
  echo "  update            Update the package list"
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
