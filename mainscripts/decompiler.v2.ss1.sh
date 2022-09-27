#!/bin/bash
#Decompiler coded by
#0K9090 (ThatCoder77471 on Scratch)
#
#
#
echo
RED='\033[0;31m'
NC='\033[0m'
echo -e "${RED}Decompiler 2.0${NC}"
DecompCurrentDir=Stage
echo
echo "Remember, both the compiler and decompiler don't work yet. The decompiler can extract the sb3, define variables, build lists, load broadcasts, and decompile some blocks, but it can't do anything else yet."
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
  echo -e "Select the .sb3 you want to decompile. ${RED}WARNING! THE NAME OF THE FILE CANNOT HAVE ANY SPACES OR IT WILL NOT UNZIP CORRECTLY!!!${NC}"
  sleep 2
  file=$(zenity -file-selection -file-filter 'Scratch SB3 *.sb3')
  echo
  echo -e "Name of project? ${RED}Keep in mind that it cannot be empty or it will not be created properly.${NC}"
  read name
  echo
  cd ../
  if ! [ -d projects ]; then
    mkdir projects
  fi
  cd projects
  if [ -d $name ]; then
    echo "Project $name already exists. Replace? [Y/N]"
    read -sn 1 anss
    if [ h$anss == hY ] || [ h$anss == hy ]; then
      rm -rf $name
    else
      exit
    fi
    echo
  fi
  echo "Decompiling project..."
  echo
  sleep 1
  mkdir $name
  cd $name
  echo >>.maindir "Please don't remove this file."
  echo "Extracting .sb3..."
  echo
  unzip $file
  echo
  echo >>.maindir "Please don't remove this file."
  mkdir Stage
  cd Stage
  mkdir assets
  #Starting decomp scripts for stage
  cd ../
  jsonfile=$(cat project.json)
  i=55
  getchar() { #stops loop when it detects char $1
    if ! [ -$2 == -++ ]; then
      char=${jsonfile:$i:1}
      if [ -$char == "$1" ]; then
        b=1
      fi
    else
      if ! [ -$char == "$1" ]; then
        char=${jsonfile:$(expr $i + 1):1}
        if [ -$char == "$1" ]; then
          b=1
        fi
        char=${jsonfile:$i:1}
      else
        char=
      fi
    fi
  }
  nextquote() { #main while loop
    b=0
    while :; do
      i
      getchar -\"
      if [ $b == 1 ]; then
        break
      fi
    done
  }
  i() { #change i by 1
    ((i++))
  }
  i-() {
    ((i--))
  }
  #Decompile variables
  echo "Defining variables..."
  echo
  while :; do
    nextquote
    i
    nextquote
    b=0
    novars=0
    while :; do #repeat until char = [
      i
      getchar -\[
      if [ $b == 1 ]; then
        break
      fi
      getchar -\}
      if [ $b == 1 ]; then
        novars=1
        break
      fi
    done
    if [ $novars == 0 ]; then
      i
      b=0
      varname=
      while :; do
        i
        getchar -\" ++
        varname+=$char
        if [ $b == 1 ]; then
          break
        fi
      done
      i
      i
      b=0
      varvalue=
      while :; do
        i
        getchar -\] ++
        varvalue+=$char
        if [ $b == 1 ]; then
          break
        fi
      done
      if ! [ -f Stage/$name.ss1 ]; then
        echo >>Stage/$name.ss1 "#There should be no empty lines."
        echo >>Stage/$name.ss1 ss1
        echo >>Stage/$name.ss1 "\prep"
      fi
      echo >>Stage/$name.ss1 $varname=$varvalue #Use echo >> if 2nd arg contains variables
      echo "Added variable \"$varname\". Value:"
      echo $varvalue
      echo
      b=0
      varname=
      i
      i
      isub=2
      getchar -\}
      if [ $b == 1 ]; then
        break
      fi
      i=$(expr $i - $isub)
    fi
    if [ $novars == 1 ]; then
      echo >>Stage/$name.ss1 "#There should be no empty lines."
      echo >>Stage/$name ss1
      echo >>Stage/$name.ss1 "\prep"
      break
    fi
  done #Finish compiling variables, lists next
  echo "Building lists..."
  echo
  i=$(expr $i + 9)
  while :; do
    nextquote
    i
    nextquote
    b=0
    novars=0
    while :; do
      i
      getchar -\[
      if [ $b == 1 ]; then
        break
      fi
      getchar -\}
      if [ $b == 1 ]; then
        novars=1
        break
      fi
    done
    if [ $novars == 0 ]; then
      i
      b=0
      listname=
      while :; do
        i
        getchar -\" ++
        listname+=$char
        if [ $b == 1 ]; then
          break
        fi
      done
      i
      i
      i
      i
      b=0
      getchar -\]
      if ! [ $b == 1 ]; then
        b=0
        getchar -\"
        if ! [ $b == 0 ]; then
          b=0
          while :; do
            b=0
            varname=
            while :; do
              i
              getchar -\"
              if [ $b == 1 ]; then
                break
              fi
              varname+=$char
            done
            i
            b=0
            getchar -\]
            if ! [ $b == 1 ]; then
              echo >>lists $varname,
              i
            else
              echo >>lists $varname
              break
            fi
          done
        else
          b=0
          i-
          while :; do
            b=0
            varname=
            while :; do
              i
              getchar -,
              if [ $b == 1 ]; then
                break
              fi
              getchar -\]
              if [ $b == 1 ]; then
                break
              fi
              varname+=$char
            done
            b=0
            getchar -\]
            if ! [ $b == 1 ]; then
              echo >>lists $varname,
            else
              echo >>lists $varname
              break
            fi
          done
        fi
        echo >>Stage/$name.ss1 $listname=$(echo $(cat lists) | sed 's/ //g')
        echo "Added list \"$listname\". Contents:"
        echo $(cat lists) | sed 's/ //g'
        echo
        rm lists
      else
        echo >>Stage/$name.ss1 $listname=,
        echo "Added list \"$listname\". Contents:"
        echo "Nothing."
        echo
        if [ $novars == 1 ]; then
          break
        fi
      fi
    fi
    if [ $novars == 1 ]; then
      break
    fi
    i
    i
    b=0
    getchar -\}
    if [ $b == 1 ]; then
      break
    fi
  done #Load broadcasts next
  echo "Loading broadcasts..."
  echo
  i=$(expr $i + 14)
  b=0
  novars=0
  while :; do #repeat until char = [
    i
    getchar -\"
    if [ $b == 1 ]; then
      break
    fi
    getchar -\}
    if [ $b == 1 ]; then
      novars=1
      break
    fi
  done
  if [ $novars == 0 ]; then
    while :; do
      i
      nextquote
      nextquote
      b=0
      varname=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varname+=$char
      done
      echo >>Stage/$name.ss1 {broadcast}=$varname
      echo "Loaded broadcast $varname"
      echo
      i
      b=0
      getchar -\}
      if [ $b == 1 ]; then
        break
      fi
      i
      i
    done
  fi
  echo -e "${RED}Decompiler V2 is not working right now. (The reason it did the above stuff is because I am too lazy to reprogram absolutely everything, so I kept the var, list, and broadcast decomp scripts.) If you want, you could enable developer mode and input D to change the decompiler to a different version.${NC}"
elif [ h$input3 == hn ] || [ h$input3 == hN ]; then
  echo "Install zenity for MSYS2, or this won't work."
else
  echo -e "${RED}Error: $input3 is not an input.${NC}"
  ./compiler.sh
fi
