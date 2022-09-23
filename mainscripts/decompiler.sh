#!/bin/bash
#Decompiler coded by
#0K9090 (ThatCoder77471 on Scratch)
#
#
#
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
  echo "Select the .sb3 you want to decompile. WARNING! THE NAME OF THE FILE CANNOT HAVE ANY SPACES OR IT WILL NOT UNZIP CORRECTLY!!!"
  sleep 2
  file=$(zenity -file-selection -file-filter 'Scratch SB3 *.sb3')
  echo
  echo "Name of project? Keep in mind that it cannot be empty or it will not be created properly."
  read name
  echo
  cd $(dirname $(pwd))
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
  echo "Extracting .sb3..."
  echo
  unzip $file
  echo
  echo >>.maindir "Please don't remove this file."
  mkdir Stage
  cd Stage
  mkdir assets
  #Starting decomp scripts for stage
  cd $(dirname $(pwd))
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
  #Decompile variables
  echo "Defining variables..."
  echo
  while :; do
    b=0
    while :; do
      ((i++))
      getchar -\"
      if [ $b == 1 ]; then
        break
      fi
    done
    ((i++))
    b=0
    while :; do
      ((i++))
      getchar -\"
      if [ $b == 1 ]; then
        break
      fi
    done
    b=0
    novars=0
    while :; do #repeat until char = [
      ((i++))
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
      ((i++))
      b=0
      varname=
      while :; do
        ((i++))
        getchar -\" ++
        varname+=$char
        if [ $b == 1 ]; then
          break
        fi
      done
      ((i++))
      ((i++))
      b=0
      varvalue=
      while :; do
        ((i++))
        getchar -\] ++
        varvalue+=$char
        if [ $b == 1 ]; then
          break
        fi
      done
      if ! [ -f Stage/$name.ss ]; then
        echo >>Stage/$name.ss "#There should be no empty lines."
        echo >>Stage/$name.ss ss
        echo >>Stage/$name.ss "\prep"
      fi
      echo >>Stage/$name.ss $varname=$varvalue #Use echo >> if 2nd arg contains variables
      echo "Added variable \"$varname\". Value:"
      echo $varvalue
      echo
      b=0
      varname=
      ((i++))
      ((i++))
      isub=2
      getchar -\}
      if [ $b == 1 ]; then
        break
      fi
      i=$(expr $i - $isub)
    fi
    if [ $novars == 1 ]; then
      echo >>Stage/$name.ss "#There should be no empty lines."
      echo >>Stage/$name ss
      echo >>Stage/$name.ss "\prep"
      break
    fi
  done #Finish compiling variables, lists next
  echo "Building lists..."
  echo
  i=$(expr $i + 9)
  while :; do
    b=0
    while :; do
      ((i++))
      getchar -\"
      if [ $b == 1 ]; then
        break
      fi
    done
    ((i++))
    b=0
    while :; do
      ((i++))
      getchar -\"
      if [ $b == 1 ]; then
        break
      fi
    done
    b=0
    novars=0
    while :; do
      ((i++))
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
      ((i++))
      b=0
      listname=
      while :; do
        ((i++))
        getchar -\" ++
        listname+=$char
        if [ $b == 1 ]; then
          break
        fi
      done
      ((i++))
      ((i++))
      ((i++))
      ((i++))
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
              ((i++))
              getchar -\"
              if [ $b == 1 ]; then
                break
              fi
              varname+=$char
            done
            ((i++))
            b=0
            getchar -\]
            if ! [ $b == 1 ]; then
              echo >>lists $varname,
              ((i++))
            else
              echo >>lists $varname
              break
            fi
          done
        else
          b=0
          ((i--))
          while :; do
            b=0
            varname=
            while :; do
              ((i++))
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
        echo >>Stage/$name.ss $listname=$(echo $(cat lists) | sed 's/ //g')
        echo "Added list \"$listname\". Contents:"
        echo $(cat lists) | sed 's/ //g'
        echo
        rm lists
      else
        echo >>Stage/$name.ss $listname=,
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
    ((i++))
    ((i++))
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
    ((i++))
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
      ((i++))
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      varname=
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varname+=$char
      done
      echo >>Stage/$name.ss {broadcast}=$varname
      echo "Loaded broadcast $varname"
      echo
      ((i++))
      b=0
      getchar -\}
      if [ $b == 1 ]; then
        break
      fi
      ((i++))
      ((i++))
    done
  fi
  echo "Making blocks..."
  echo
  addblock() {
    parent=0
    if [ $1 == event_broadcast ]; then
      ((i++))
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>Stage/$name.ss "\nscript"
        parent=1
      fi
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      varvalue=
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varvalue+=$char
      done
      echo >>Stage/$name.ss "broadcast ($varvalue)"
      echo "Added block: \"broadcast ($varvalue)\""
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      ((i--))
      ((i--))
      ((i--))
      done=0
      b=0
      getchar -\}
      if [ $b == 1 ]; then
        done=1
      fi
      ((i++))
      ((i++))
      ((i++))
      if ! [ h$done == h1 ]; then
        if [ $parent == 1 ]; then
          b=0
          while :; do
            ((i++))
            getchar -\"
            if [ $b == 1 ]; then
              break
            fi
          done
          b=0
          while :; do
            ((i++))
            getchar -\"
            if [ $b == 1 ]; then
              break
            fi
          done
          b=0
          while :; do
            ((i++))
            getchar -\"
            if [ $b == 1 ]; then
              break
            fi
          done
          b=0
          while :; do
            ((i++))
            getchar -\"
            if [ $b == 1 ]; then
              break
            fi
          done
        fi
      fi
    elif [ $1 == motion_movesteps ]; then
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>Stage/$name.ss "\nscript"
        parent=1
      fi
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      varvalue=
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varvalue+=$char
      done
      echo >>Stage/$name.ss "move ($varvalue) steps"
      echo "Added block: \"move ($varvalue) steps\""
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      ((i--))
      ((i--))
      ((i--))
      b=0
      getchar -\}
      if [ $b == 1 ]; then
        done=1
      fi
      ((i++))
      ((i++))
      ((i++))
      if ! [ h$done == h1 ]; then
        if [ $parent == 1 ]; then
          b=0
          while :; do
            ((i++))
            getchar -\"
            if [ $b == 1 ]; then
              break
            fi
          done
          b=0
          while :; do
            ((i++))
            getchar -\"
            if [ $b == 1 ]; then
              break
            fi
          done
          b=0
          while :; do
            ((i++))
            getchar -\"
            if [ $b == 1 ]; then
              break
            fi
          done
          b=0
          while :; do
            ((i++))
            getchar -\"
            if [ $b == 1 ]; then
              break
            fi
          done
        fi
      fi
    elif [ $1 == control_wait ]; then
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>Stage/$name.ss "\nscript"
        parent=1
      fi
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      varvalue=
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varvalue+=$char
      done
      echo >>Stage/$name.ss "wait ($varvalue) seconds"
      echo "Added block: \"wait ($varvalue) seconds\""
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      ((i--))
      ((i--))
      ((i--))
      b=0
      getchar -\}
      if [ $b == 1 ]; then
        done=1
      fi
      ((i++))
      ((i++))
      ((i++))
      if ! [ h$done == h1 ]; then
        if [ $parent == 1 ]; then
          b=0
          while :; do
            ((i++))
            getchar -\"
            if [ $b == 1 ]; then
              break
            fi
          done
          b=0
          while :; do
            ((i++))
            getchar -\"
            if [ $b == 1 ]; then
              break
            fi
          done
          b=0
          while :; do
            ((i++))
            getchar -\"
            if [ $b == 1 ]; then
              break
            fi
          done
          b=0
          while :; do
            ((i++))
            getchar -\"
            if [ $b == 1 ]; then
              break
            fi
          done
        fi
      fi
    elif [ $1 == looks_switchbackdropto ]; then
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>Stage/$name.ss "\nscript"
        parent=1
      fi
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      if [ $parent == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      varvalue=
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varvalue+=$char
      done
      echo >>Stage/$name.ss "switch backdrop to ($varvalue)"
      echo "Added block: \"switch backdrop to ($varvalue)\""
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
    elif [ $1 == looks_switchbackdroptoandwait ]; then
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>Stage/$name.ss "\nscript"
        parent=1
      fi
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      if [ $parent == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      varvalue=
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varvalue+=$char
      done
      echo >>Stage/$name.ss "switch backdrop to ($varvalue) and wait"
      echo "Added block: \"switch backdrop to ($varvalue) and wait\""
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
    elif [ $1 == looks_nextbackdrop ]; then
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>Stage/$name.ss "\nscript"
        parent=1
      fi
      ((i--))
      ((i--))
      if [ $parent == 0 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      echo >>Stage/$name.ss "next backdrop"
      echo "Added block: \"next backdrop\""
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      if [ $parent == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      ((i--))
      ((i--))
      ((i--))
      done=0
      b=0
      getchar -\}
      if [ $b == 1 ]; then
        done=1
      fi
      ((i++))
      ((i++))
      ((i++))
    elif [ $1 == looks_changeeffectby ]; then
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>Stage/$name.ss "\nscript"
        parent=1
      fi
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      varvalue=
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varvalue+=$char
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      varname=
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varname+=$char
      done
      echo >>Stage/$name.ss "change ($varname) effect by ($varvalue)"
      echo "Added block: \"change ($varname) effect by ($varvalue)\""
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      if [ $parent == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      ((i--))
      ((i--))
      ((i--))
      done=0
      b=0
      getchar -\}
      if [ $b == 1 ]; then
        done=1
      fi
      ((i++))
      ((i++))
      ((i++))
    elif [ $1 == looks_seteffectto ]; then
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>Stage/$name.ss "\nscript"
        parent=1
      fi
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      varvalue=
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varvalue+=$char
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      varname=
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varname+=$char
      done
      echo >>Stage/$name.ss "set ($varname) effect to ($varvalue)"
      echo "Added block: \"set ($varname) effect to ($varvalue)\""
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      if [ $parent == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      ((i--))
      ((i--))
      ((i--))
      done=0
      b=0
      getchar -\}
      if [ $b == 1 ]; then
        done=1
      fi
      ((i++))
      ((i++))
      ((i++))
    elif [ $1 == looks_cleargraphiceffects ]; then
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>Stage/$name.ss "\nscript"
        parent=1
      fi
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      echo >>Stage/$name.ss "clear graphic effects"
      echo "Added block: \"clear graphic effects\""
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      if [ $parent == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      ((i--))
      ((i--))
      ((i--))
      done=0
      b=0
      getchar -\}
      if [ $b == 1 ]; then
        done=1
      fi
      ((i++))
      ((i++))
      ((i++))
    elif [ $1 == looks_backdropnumbername ]; then
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      ((i++))
      ((i++))
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>Stage/$name.ss "\nscript"
        parent=1
      fi
      ((i--))
      ((i--))
      if [ $b == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      varname=
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varname+=$char
      done
      echo >>Stage/$name.ss "(backdrop ($varname))"
      echo "Added block: \"(backdrop ($varname))\""
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      if [ $parent == 1 ]; then
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
        b=0
        while :; do
          ((i++))
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
        done
      fi
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      ((i--))
      ((i--))
      ((i--))
      done=0
      b=0
      getchar -\}
      if [ $b == 1 ]; then
        done=1
      fi
      ((i++))
      ((i++))
      ((i++))
    fi
  }
  i=$(expr $i + 10)
  b=0
  novars=0
  while :; do
    ((i++))
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
  if [ $novars = 0 ]; then
    while :; do
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      ((i++))
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      ((i++))
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      ((i++))
      b=0
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      varname=
      while :; do
        ((i++))
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varname+=$char
      done
      addblock $varname
      if [ h$done == h1 ]; then
        break
      fi
    done
  fi
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
