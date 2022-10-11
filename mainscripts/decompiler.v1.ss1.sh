#!/bin/bash
#Decompiler coded by
#0K9090 (ThatCoder77471 on Scratch)
#No comments will be added because this version is not being programmed anymore.
#
#
echo
RED='\033[0;31m'
NC='\033[0m'
echo -e "${RED}Decompiler 1.F${NC}"
DecompCurrentDir=Stage
echo
echo -e "${RED}This version of the decompiler is deprecated. 4 block categories were added, and that's it. C-Blocks became a barrier that is almost impossible to pass for this decompiler, so I had to make a new one. Please use V2 when it is available.${NC}"
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
    echo >>var/zenity
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
  echo "Making blocks..."
  echo
  start() {
    i
    nextquote
    nextquote
    b=0
    i
    i
    getchar -\"
    i-
    i-
    if [ $b == 1 ]; then
      nextquote
      nextquote
    fi
    nextquote
    nextquote
    b=0
    i
    i
    getchar -\"
    if ! [ $b == 1 ]; then
      echo >>$DecompCurrentDir/$name.ss1 "\nscript"
      parent=1
    fi
    i-
    i-
    if [ $b == 1 ]; then
      nextquote
      nextquote
    fi
  }
  substack() {
    j=$i
    i=-1
    while :; do
      b=0
      word=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        word+=$char
      done
      if ! [ $i == $2 ]; then
        if [ "$word" == topLevel ]; then
          b=0
          while :; do
            i
            getchar -\}
            if [ $b == 1 ]; then
              break
            fi
          done
          nextquote
          b=0
          word=
          while :; do
            i
            getchar -\"
            if [ $b == 1 ]; then
              break
            fi
            word+=$char
          done
          if [ "$word" == "$1" ]; then
            echo "$word, $1"
            nextquote
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
            echo $varname
            echo "gothere"
            addblock $varname
            while :; do
              b=0
              word=
              while :; do
                i-
                getchar -\"
                if [ $b == 1 ]; then
                  break
                fi
                word+=$char
              done
              if [ "$word" == txen ]; then
                nextquote
                nextquote
              fi
            done
            break
          fi
        fi
      fi
    done
  }
  end() {
    i-
    i-
    if [ h$1 == h ]; then
      i-
    fi
    done=0
    b=0
    getchar -\}
    if [ $b == 1 ]; then
      done=1
    fi
    i
    i
    if [ h$1 == h ]; then
      i
    fi
  }
  addblock() {
    parent=0
    if [ $1 == event_broadcast ]; then
      start
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      b=0
      varvalue=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varvalue+=$char
      done
      echo >>$DecompCurrentDir/$name.ss1 "broadcast [$varvalue]"
      echo "Added block: \"broadcast [$varvalue]\""
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      i-
      i-
      if [ h$2 == h ]; then
        i-
      fi
      done=0
      b=0
      getchar -\}
      if [ $b == 1 ]; then
        done=1
      fi
      i
      i
      if [ h$2 == h ]; then
        i
      fi
      if ! [ h$done == h1 ]; then
        if [ $parent == 1 ]; then
          nextquote
          nextquote
          nextquote
          nextquote
        fi
      fi
    elif [ $1 == motion_movesteps ]; then
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>$DecompCurrentDir/$name.ss1 "\nscript"
        parent=1
      fi
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      b=0
      varvalue=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varvalue+=$char
      done
      echo >>$DecompCurrentDir/$name.ss1 "move ($varvalue) steps"
      echo "Added block: \"move ($varvalue) steps\""
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      i-
      i-
      if [ h$2 == h ]; then
        i-
      fi
      b=0
      getchar -\}
      if [ $b == 1 ]; then
        done=1
      fi
      i
      i
      if [ h$2 == h ]; then
        i
      fi
      if ! [ h$done == h1 ]; then
        if [ $parent == 1 ]; then
          nextquote
          nextquote
          nextquote
          nextquote
        fi
      fi
    elif [ $1 == control_wait ]; then
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>$DecompCurrentDir/$name.ss1 "\nscript"
        parent=1
      fi
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      b=0
      varvalue=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varvalue+=$char
      done
      echo >>$DecompCurrentDir/$name.ss1 "wait ($varvalue) seconds"
      echo "Added block: \"wait ($varvalue) seconds\""
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      i-
      i-
      if [ h$2 == h ]; then
        i-
      fi
      b=0
      getchar -\}
      if [ $b == 1 ]; then
        done=1
      fi
      i
      i
      if [ h$2 == h ]; then
        i
      fi
      if ! [ h$done == h1 ]; then
        if [ $parent == 1 ]; then
          nextquote
          nextquote
          nextquote
          nextquote
        fi
      fi
    elif [ $1 == looks_switchbackdropto ]; then
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>$DecompCurrentDir/$name.ss1 "\nscript"
        parent=1
      fi
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      b=0
      varvalue=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varvalue+=$char
      done
      echo >>$DecompCurrentDir/$name.ss1 "switch backdrop to ($varvalue)"
      echo "Added block: \"switch backdrop to ($varvalue)\""
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
    elif [ $1 == looks_switchbackdroptoandwait ]; then
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>$DecompCurrentDir/$name.ss1 "\nscript"
        parent=1
      fi
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      b=0
      varvalue=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varvalue+=$char
      done
      echo >>$DecompCurrentDir/$name.ss1 "switch backdrop to ($varvalue) and wait"
      echo "Added block: \"switch backdrop to ($varvalue) and wait\""
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
    elif [ $1 == looks_nextbackdrop ]; then
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>$DecompCurrentDir/$name.ss1 "\nscript"
        parent=1
      fi
      i-
      i-
      if [ $parent == 0 ]; then
        nextquote
        nextquote
      fi
      echo >>$DecompCurrentDir/$name.ss1 "next backdrop"
      echo "Added block: \"next backdrop\""
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      end $2
    elif [ $1 == looks_changeeffectby ]; then
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>$DecompCurrentDir/$name.ss1 "\nscript"
        parent=1
      fi
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      b=0
      varvalue=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varvalue+=$char
      done
      nextquote
      nextquote
      nextquote
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
      echo >>$DecompCurrentDir/$name.ss1 "change [$varname] effect by ($varvalue)"
      echo "Added block: \"change [$varname] effect by ($varvalue)\""
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      end $2
    elif [ $1 == looks_seteffectto ]; then
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>$DecompCurrentDir/$name.ss1 "\nscript"
        parent=1
      fi
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      b=0
      varvalue=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varvalue+=$char
      done
      nextquote
      nextquote
      nextquote
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
      echo >>$DecompCurrentDir/$name.ss1 "set [$varname)]effect to ($varvalue)"
      echo "Added block: \"set [$varname] effect to ($varvalue)\""
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      end $2
    elif [ $1 == looks_cleargraphiceffects ]; then
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>$DecompCurrentDir/$name.ss1 "\nscript"
        parent=1
      fi
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      echo >>$DecompCurrentDir/$name.ss1 "clear graphic effects"
      echo "Added block: \"clear graphic effects\""
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      end $2
    elif [ $1 == looks_backdropnumbername ]; then
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>$DecompCurrentDir/$name.ss1 "\nscript"
        parent=1
      fi
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
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
      echo >>$DecompCurrentDir/$name.ss1 "(backdrop [$varname])"
      echo "Added block: \"(backdrop [$varname])\""
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      end $2
    elif [ $1 == sound_playuntildone ]; then
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>$DecompCurrentDir/$name.ss1 "\nscript"
        parent=1
      fi
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      parent=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        parent=1
      fi
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
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
      echo >>$DecompCurrentDir/$name.ss1 "play sound ($varname) until done"
      echo "Added block: \"play sound ($varname) until done\""
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      end $2
    elif [ $1 == sound_play ]; then
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>$DecompCurrentDir/$name.ss1 "\nscript"
        parent=1
      fi
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      parent=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        parent=1
      fi
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
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
      echo >>$DecompCurrentDir/$name.ss1 "start sound ($varname)"
      echo "Added block: \"start sound ($varname)\""
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      end $2
    elif [ $1 == sound_stopallsounds ]; then
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>$DecompCurrentDir/$name.ss1 "\nscript"
        parent=1
      fi
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      echo >>$DecompCurrentDir/$name.ss1 "stop all sounds"
      echo "Added block: \"stop all sounds\""
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      end $2
    elif [ $1 == sound_changeeffectby ]; then
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>$DecompCurrentDir/$name.ss1 "\nscript"
        parent=1
      fi
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      b=0
      varvalue=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varvalue+=$char
      done
      nextquote
      nextquote
      nextquote
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
      echo >>$DecompCurrentDir/$name.ss1 "change [$varname] effect by ($varvalue)"
      echo "Added block: \"change [$varname] effect by ($varvalue)\""
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      end $2
    elif [ $1 == sound_seteffectto ]; then
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>$DecompCurrentDir/$name.ss1 "\nscript"
        parent=1
      fi
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      b=0
      varvalue=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varvalue+=$char
      done
      nextquote
      nextquote
      nextquote
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
      echo >>$DecompCurrentDir/$name.ss1 "set [$varname] effect to ($varvalue)"
      echo "Added block: \"set [$varname] effect to ($varvalue)\""
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      end $2
    elif [ $1 == sound_cleareffects ]; then
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>$DecompCurrentDir/$name.ss1 "\nscript"
        parent=1
      fi
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      echo >>$DecompCurrentDir/$name.ss1 "clear sound effects"
      echo "Added block: \"clear sound effects\""
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      end $2
    elif [ $1 == sound_changevolumeby ]; then
      start
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      b=0
      varvalue=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varvalue+=$char
      done
      echo >>$DecompCurrentDir/$name.ss1 "change volume by ($varvalue)"
      echo "Added block: \"change volume by ($varvalue)\""
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      b=0
      done=0
      i-
      i-
      i-
      getchar -\}
      i
      i
      i
      if [ $b == 1 ]; then
        done=1
      fi
    elif [ $1 == sound_setvolumeto ]; then
      start
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      b=0
      varvalue=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varvalue+=$char
      done
      echo >>$DecompCurrentDir/$name.ss1 "set volume to ($varvalue) %"
      echo "Added block: \"set volume to ($varvalue) %\""
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      b=0
      done=0
      i-
      i-
      i-
      getchar -\}
      i
      i
      i
      if [ $b == 1 ]; then
        done=1
      fi
    elif [ $1 == sound_volume ]; then
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>$DecompCurrentDir/$name.ss1 "\nscript"
        parent=1
      fi
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      echo >>$DecompCurrentDir/$name.ss1 "(volume)"
      echo "Added block: \"(volume)\""
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      end $2
    elif [ $1 == event_whenflagclicked ]; then
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>$DecompCurrentDir/$name.ss1 "\nscript"
        parent=1
      fi
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      echo >>$DecompCurrentDir/$name.ss1 "when flag clicked"
      echo "Added block: \"when flag clicked\""
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      end $2
    elif [ $1 == event_whenkeypressed ]; then
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>$DecompCurrentDir/$name.ss1 "\nscript"
        parent=1
      fi
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      varname=
      b=0
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varname+=$char
      done
      echo >>$DecompCurrentDir/$name.ss1 "when [$varname] key pressed"
      echo "Added block: \"when [$varname] key pressed\""
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      i-
      i-
      i-
      b=0
      done=0
      getchar -\}
      i
      i
      i
      if [ $b == 1 ]; then
        done=1
      fi
    elif [ $1 == event_whenstageclicked ]; then
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>$DecompCurrentDir/$name.ss1 "\nscript"
        parent=1
      fi
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      echo >>$DecompCurrentDir/$name.ss1 "when stage clicked"
      echo "Added block: \"when stage clicked\""
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      end $2
    elif [ $1 == event_whenbackdropswitchesto ]; then
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>$DecompCurrentDir/$name.ss1 "\nscript"
        parent=1
      fi
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      varname=
      b=0
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varname+=$char
      done
      echo >>$DecompCurrentDir/$name.ss1 "when backdrop switches to [$varname]"
      echo "Added block: \"when backdrop switches to [$varname]\""
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      i-
      i-
      i-
      b=0
      done=0
      getchar -\}
      i
      i
      i
      if [ $b == 1 ]; then
        done=1
      fi
    elif [ $1 == event_whengreaterthan ]; then
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      b=0
      i
      i
      getchar -\"
      if ! [ $b == 1 ]; then
        echo >>$DecompCurrentDir/$name.ss1 "\nscript"
        parent=1
      fi
      i-
      i-
      if [ $b == 1 ]; then
        nextquote
        nextquote
      fi
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      b=0
      varvalue=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varvalue+=$char
      done
      nextquote
      nextquote
      nextquote
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
      echo >>$DecompCurrentDir/$name.ss1 "when [$varname] > ($varvalue)"
      echo "Added block: \"when [$varname] > ($varvalue)\""
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      end $2
    elif [ $1 == event_whenbroadcastreceived ]; then
      start
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      b=0
      varvalue=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varvalue+=$char
      done
      echo >>$DecompCurrentDir/$name.ss1 "when i receive [$varvalue]"
      echo "Added block: \"when i receive [$varvalue]\""
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      if [ $parent == 1 ]; then
        nextquote
        nextquote
        nextquote
        nextquote
      fi
      nextquote
      i-
      i-
      i-
      b=0
      done=0
      getchar -\}
      i
      i
      i
      if [ $b == 1 ]; then
        done=1
      fi
    elif [ $1 == event_broadcastandwait ]; then
      start
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      b=0
      varvalue=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varvalue+=$char
      done
      echo >>$DecompCurrentDir/$name.ss1 "broadcast ($varvalue) and wait"
      echo "Added block: \"broadcast ($varvalue) and wait\""
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      end $2
      if ! [ h$done == h1 ]; then
        if [ $parent == 1 ]; then
          nextquote
          nextquote
          nextquote
          nextquote
        fi
      fi
    elif [ $1 == control_repeat ]; then
      start
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      b=0
      repx=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        repx+=$char
      done
      nextquote
      b=0
      get=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        get+=$char
      done
      if ! [ $get == SUBSTACK ]; then
        echo "    Warning: C-Block decompilation is very buggy. As a matter of fact, it seems to not be working right now. Or it's just very slow."
        echo
        echo "    Also, only one block (or sometimes no blocks, which causes blocks on the outside of the loop to be on the inside) is displayed in the substack. The rest of the blocks are at the bottom of the $DecompCurrentDir blocks section."
        echo
        echo >>Stage/$name.ss1 "repeat (\"$repx\") {"
        echo >>Stage/$name.ss1 ""
        echo >>Stage/$name.ss1 "}"
        echo "repeat (\"$repx\") {"
        echo
        echo "}"
        echo
      else #Continue building repeat
        nextquote
        echo
        echo "Starting repeat block."
        echo
        echo "    Warning: C-Block decompilation is very buggy. As a matter of fact, it seems to not be working right now. Or it's just very slow."
        echo
        echo "    Also, only one block (or sometimes no blocks, which causes blocks on the outside of the loop to be on the inside) is displayed in the substack. The rest of the blocks are at the bottom of the $DecompCurrentDir blocks section."
        echo
        echo >>Stage/$name.ss1 "repeat (\"$repx\") {"
        echo "repeat (\"$repx\") {"
        while :; do
          next=
          b=0
          while :; do
            i
            getchar -\"
            if [ $b == 1 ]; then
              break
            fi
            next+=$char
          done
          substack $next $i
          if [ $done == 1 ]; then
            break
          fi
        done
        i=$j
        echo >>Stage/$name.ss1 "}"
        echo "}"
        echo
      fi
      end $2
    elif [ $1 == control_forever ]; then
      start
      nextquote
      nextquote
      nextquote
      nextquote
      b=0
      while :; do
        i
        getchar -,
        if [ $b == 1 ]; then
          break
        fi
      done
      b=0
      gg=
      while :; do
        i
        getchar -\]
        if [ $b == 1 ]; then
          break
        fi
        gg+=$char
      done
      if [ $gg == "null" ]; then
        echo >>Stage/$name.ss1 "forever {"
        echo >>Stage/$name.ss1 ""
        echo >>Stage/$name.ss1 "}"
        echo "forever {"
        echo
        echo "}"
        echo
      else
        if [ $parent == 1 ]; then
          nextquote
          nextquote
          nextquote
          nextquote
        fi
        nextquote
        echo
        echo "Starting forever block. (Forever blocks don't quite work yet."
        echo
        echo >>Stage/$name.ss1 "forever {"
        echo "forever {"
        substack
        done=0
        echo >>Stage/$name.ss1 "}"
        echo "}"
        echo
        end $2
      fi
    fi
  }
  i=$(expr $i + 10)
  b=0
  novars=0
  while :; do
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
  if [ $novars = 0 ]; then
    while :; do
      nextquote
      i
      nextquote
      i
      nextquote
      i
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
      addblock $varname
      if [ h$done == h1 ]; then
        break
      fi
    done
  fi
  if [ 1 == 1 ]; then
    cd ../
    cd ../
    cd mainscripts
  fi
elif [ h$input3 == hn ] || [ h$input3 == hN ]; then
  echo "Install zenity for MSYS2, or this won't work."
else
  echo -e "${RED}Error: $input3 is not an input.${NC}"
  ./decompiler.v1.ss1.sh
fi
