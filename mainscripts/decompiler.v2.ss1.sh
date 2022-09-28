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
dcd=Stage
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
  start() {
    nextquote
    nextquote
    i
    i
    b=0
    getchar -\"
    if ! [ $b == 1 ]; then
      if [ h$1 == h ]; then
        next="fin"
      fi
    else
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
      if [ h$1 == h ]; then
        next=$varname
      fi
    fi
    nextquote
    nextquote
    i
    i
    b=0
    getchar -\"
    if ! [ $b == 1 ]; then
      if [ h$1 == h ]; then
        echo >>$dcd/$name.ss1 "\nscript"
        parent=1
      fi
    else
      b=0
      pname=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        pname+=$char
      done
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
      varname=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        varname+=$char
      done
      echo >>$dcd/$name.ss1 "broadcast [$varname]"
      echo "Added block: \"broadcast [$varname]\""
    elif [ $1 == motion_movesteps ]; then
      start
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
      echo >>$dcd/$name.ss1 "move (\"$varname\") steps"
      echo "Added block: \"move (\"$varname\") steps\""
    elif [ $1 == control_wait ]; then
      start
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
      echo >>$dcd/$name.ss1 "wait (\"$varname\") seconds"
      echo "Added block: \"wait (\"$varname\") seconds\""
    elif [ $1 == looks_switchbackdropto ]; then
      start
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
      b=0
      while :; do
        i
        getchar -\}
        if [ $b == 1 ]; then
          break
        fi
      done
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      start n
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
      echo >>$dcd/$name.ss1 "switch backdrop to (\"$varname\")"
      echo "Added block: \"switch backdrop to (\"$varname\")\""
    elif [ $1 == looks_switchbackdroptoandwait ]; then
      start
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
      b=0
      while :; do
        i
        getchar -\}
        if [ $b == 1 ]; then
          break
        fi
      done
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      start n
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
      echo >>$dcd/$name.ss1 "switch backdrop to (\"$varname\") and wait"
      echo "Added block: \"switch backdrop to (\"$varname\") and wait\""
    elif [ $1 == looks_nextbackdrop ]; then
      start
      echo >>$dcd/$name.ss1 "next backdrop"
      echo "Added block: \"next backdrop\""
    elif [ $1 == looks_changeeffectby ]; then
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
      echo >>$dcd/$name.ss1 "change [$varname] effect by (\"$varvalue\")"
      echo "Added block: \"change [$varname] effect by (\"$varvalue\")\""
    elif [ $1 == looks_backdropnumbername ]; then
      start
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
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
      echo >>$dcd/$name.ss1 "(backdrop [$word])"
      echo "Added block: \"(backdrop [$word])\""
    elif [ $1 == sound_playuntildone ]; then
      start
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
      b=0
      while :; do
        i
        getchar -\}
        if [ $b == 1 ]; then
          break
        fi
      done
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      start n
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
      echo >>$dcd/$name.ss1 "play sound (\"$varname\") until done"
      echo "Added block: \"play sound (\"$varname\") until done\""
    elif [ $1 == looks_seteffectto ]; then
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
      echo >>$dcd/$name.ss1 "set [$varname] effect to (\"$varvalue\")"
      echo "Added block: \"set [$varname] effect to (\"$varvalue\")\""
    elif [ $1 == sound_play ]; then
      start
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
      b=0
      while :; do
        i
        getchar -\}
        if [ $b == 1 ]; then
          break
        fi
      done
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      nextquote
      start n
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
      echo >>$dcd/$name.ss1 "start sound (\"$varname\")"
      echo "Added block: \"start sound (\"$varname\")\""
    elif [ $1 == sound_stopallsounds ]; then
      start
      echo >>$dcd/$name.ss1 "stop all sounds"
      echo "Added block: \"stop all sounds\""
    elif [ $1 == sound_changeeffectby ]; then
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
      echo >>$dcd/$name.ss1 "change [$varname] effect by (\"$varvalue\")"
      echo "Added block: \"change [$varname] effect by (\"$varvalue\")\""
    elif [ $1 == sound_seteffectto ]; then
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
      echo >>$dcd/$name.ss1 "set [$varname] effect to (\"$varvalue\")"
      echo "Added block: \"set [$varname] effect to (\"$varvalue\")\""
    elif [ $1 == sound_cleareffects ]; then
      start
      echo >>$dcd/$name.ss1 "clear sound effects"
      echo "Added block: \"clear sound effects\""
    elif [ $1 == sound_changevolumeby ]; then
      start
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
      echo >>$dcd/$name.ss1 "change volume by (\"$varname\")"
      echo "Added block: \"change volume by (\"$varname\")\""
    elif [ $1 == sound_volume ]; then
      start
      echo >>$dcd/$name.ss1 "(volume)"
      echo "Added block: \"(volume)\""
    elif [ $1 == event_whenflagclicked ]; then
      start
      echo >>$dcd/$name.ss1 "when flag clicked"
      echo "Added block: \"when flag clicked\""
    elif [ $1 == event_whenkeypressed ]; then
      start
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
      echo >>$dcd/$name.ss1 "when [$varname] key pressed"
      echo "Added block: \"when [$varname] key pressed\""
    elif [ $1 == event_whenstageclicked ]; then
      start
      echo >>$dcd/$name.ss1 "when stage clicked"
      echo "Added block: \"when stage clicked\""
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
      word=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        word+=$char
      done
      echo >>$dcd/$name.ss1 "when i receieve [$word]"
      echo "Added block: \"when i receieve [$word]\""
    elif [ $1 == event_broadcastandwait ]; then
      start
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
      echo >>$dcd/$name.ss1 "broadcast [$varname] and wait"
      echo "Added block: \"broadcast [$varname] and wait\""
    elif [ $1 == sound_setvolumeto ]; then
      start
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
      echo >>$dcd/$name.ss1 "set volume to (\"$varname\") %"
      echo "Added block: \"set volume to (\"$varname\") %\""
    elif [ $1 == event_whenbackdropswitchesto ]; then
      start
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
      echo >>$dcd/$name.ss1 "when backdrop switches to [$varname]"
      echo "Added block: \"when backdrop switches to [$varname]\""
    elif [ $1 == looks_cleargraphiceffects ]; then
      start
      echo >>$dcd/$name.ss1 "clear graphic effects"
      echo "Added block: \"clear graphic effects\""
    elif [ $1 == event_whengreaterthan ]; then
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
      echo >>$dcd/$name.ss1 "when [$varname] > (\"$varvalue\")"
      echo "Added block: \"when [$varname] > (\"$varvalue\")\""
    elif [ $1 == control_repeat ]; then
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
      if [ "$word" == SUBSTACK ]; then
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
        rep=$next
        per=r
        next=$varname
        echo
        echo "Starting repeat."
        echo
        echo >>$dcd/$name.ss1 "repeat ($varvalue) {"
        echo "repeat ($varvalue) {"
      else
        echo
        echo "Starting repeat."
        echo
        echo >>$dcd/$name.ss1 "repeat ($varvalue) {"
        echo "repeat ($varvalue) {"
        echo >>$dcd/$name.ss1
        echo
        echo >>$dcd/$name.ss1 "}"
        echo "}"
        echo
        echo "Ended repeat."
      fi
    elif [ $1 == control_forever ]; then
      start
      nextquote
      nextquote
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
      if [ "$word" == SUBSTACK ]; then
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
        rep=$next
        per=f
        next=$varname
        echo
        echo "Starting forever.."
        echo
        echo >>$dcd/$name.ss1 "forever {"
        echo "forever {"
      else
        echo
        echo "Starting forever."
        echo
        echo >>$dcd/$name.ss1 "forever {"
        echo "forever {"
        echo >>$dcd/$name.ss1
        echo
        echo >>$dcd/$name.ss1 "}"
        echo "}"
        echo
        echo "Ended forever."
      fi
    fi
    if ! [ $next == fin ]; then
      i=1
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
        if [ "$word" == blocks ]; then
          i
          i
          i
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
          if [ "$word" == "$next" ]; then
            nextquote
            break
          fi
        else
          if [ "$word" == topLevel ]; then
            b=0
            while :; do
              i
              getchar -\}
              if [ $b == 1 ]; then
                break
              fi
            done
            i
            i
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
            if [ "$word" == "$next" ]; then
              nextquote
              break
            fi
          fi
        fi
      done
    else
      if ! [ $rep == 0 ]; then
        next=$rep
        rep=0
        echo >>$dcd/$name.ss1 "}"
        echo "}"
        echo
        if [ h$per == hr ]; then
          echo "Ended repeat."
        elif [ h$per == hf ]; then
          echo "Ended forever."
        fi
        if ! [ $next == fin ]; then
          i=1
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
            if [ "$word" == blocks ]; then
              i
              i
              i
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
              if [ "$word" == "$next" ]; then
                nextquote
                break
              fi
            else
              if [ "$word" == topLevel ]; then
                b=0
                while :; do
                  i
                  getchar -\}
                  if [ $b == 1 ]; then
                    break
                  fi
                done
                i
                i
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
                if [ "$word" == "$next" ]; then
                  nextquote
                  break
                fi
              fi
            fi
          done
        fi
      fi
    fi
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
    rep=0
    echo "Making blocks..."
    dcd=Stage
    k=-1
    done=0
    while :; do
      i=$k
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
        if [ "$word" == parent ]; then
          k=$i
          i
          i
          b=0
          getchar -\"
          if ! [ $b == 1 ]; then
            break
          fi
        fi
        if [ "$word" == comments ]; then
          done=1
          break
        fi
      done
      if [ $done == 0 ]; then
        b=0
        while :; do
          i-
          getchar -\{
          if [ $b == 1 ]; then
            break
          fi
        done
        i
        while :; do
          nextquote
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
          addblock $word
          if [ $next == fin ]; then
            break
          fi
        done
      fi
      if [ $done == 1 ]; then
        break
      fi
    done
  fi
elif [ h$input3 == hn ] || [ h$input3 == hN ]; then
  echo "Install zenity for MSYS2, or this won't work."
else
  echo -e "${RED}Error: $input3 is not an input.${NC}"
  ./compiler.sh
fi
