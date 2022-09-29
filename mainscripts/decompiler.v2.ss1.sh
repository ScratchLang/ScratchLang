#!/bin/bash
#Decompiler coded by
#0K9090 (ThatCoder77471 on Scratch)
#
# cd ../ goes to the prev directory
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
if [ h$input3 == hY ] || [ h$input3 == hy ]; then #Continue if you have the command zenity
  if ! [ -f .var/zenity ]; then
    echo >>.var/zenity
  fi
  echo -e "Select the .sb3 you want to decompile. ${RED}WARNING! THE NAME OF THE FILE CANNOT HAVE ANY SPACES OR IT WILL NOT UNZIP CORRECTLY!!!${NC}"
  sleep 2
  file=$(zenity -file-selection -file-filter 'Scratch SB3 *.sb3') #Select .sb3
  echo
  echo -e "Name of project? ${RED}Keep in mind that it cannot be empty or it will not be created properly.${NC}" #Name your project
  read name
  echo
  if [ h$name == h ]; then
    echo -e "${RED}Error: Project name cannot be empty.${NC}"
  fi
  cd ../
  if ! [ -d projects ]; then
    mkdir projects #Create projects directory if it doesn't exist
  fi
  cd projects
  if [ -d $name ]; then
    echo "Project $name already exists. Replace? [Y/N]" #If a project named the same thing you named it, then replace it
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
  mkdir $name #Create a directory named the project name
  cd $name
  echo >>.maindir "Please don't remove this file." #This tells the compiler that it's in the right directory.
  echo "Extracting .sb3..."
  echo
  unzip $file #unzip the .sb3
  echo
  echo >>.maindir "Please don't remove this file."
  mkdir Stage
  cd Stage
  mkdir assets #Create the assets folder
  #Starting decomp scripts for stage
  cd ../
  jsonfile=$(cat project.json) #Get the project.json in a variable.
  i=55
  getchar() {
    if ! [ -$2 == -++ ]; then
      char=${jsonfile:$i:1} #get char index i from $jsonfile. the first char is 0, and it goes from left to right.
      if [ -$char == "$1" ]; then
        b=1 #if the char index from i equals $1, then set b to 1.
      fi
    else
      if ! [ -$char == "$1" ]; then
        char=${jsonfile:$(expr $i + 1):1}
        if [ -$char == "$1" ]; then
          b=1 #if the char index from i + 1 equals $1, then set b to 1. Don't use this one.
        fi
        char=${jsonfile:$i:1}
      else
        char=
      fi
    fi
  }
  nextquote() { #main while loop
    b=0
    while :; do   #infinite loop
      i           #change i by 1
      getchar -\" #detect if char index from i equals "
      if [ $b == 1 ]; then
        break #stop infinite loop if char index from i equals "
      fi
    done
  }
  i() { #change i by 1
    ((i++))
  }
  i-() { #change i by -1
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
        next="fin" #if next equals null, then set the variable next to fin
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
        next=$varname #if next is not null, set next to whatever it is
      fi
    fi
    nextquote
    nextquote
    i
    i
    b=0
    getchar -\"
    if ! [ $b == 1 ]; then #if parent equals null
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
  cm=0
  ci=()
  ca=()
  alreadydiddone=()
  addblock() {
    parent=0
    #Comments explaining what the scripts do will be added soon.
    if [ $1 == event_broadcast ]; then #Broadcast block
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
    elif [ $1 == motion_movesteps ]; then #move () steps block
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
    elif [ $1 == control_wait ]; then #wait () seconds block
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
    elif [ $1 == looks_switchbackdropto ]; then #switch backdrop to () block
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
    elif [ $1 == looks_switchbackdroptoandwait ]; then #switch backdrop to () and wait block
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
    elif [ $1 == looks_nextbackdrop ]; then #next backdrop block
      start
      echo >>$dcd/$name.ss1 "next backdrop"
      echo "Added block: \"next backdrop\""
    elif [ $1 == looks_changeeffectby ]; then #change [] effect by () block
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
    elif [ $1 == looks_backdropnumbername ]; then #(backdrop []) block
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
    elif [ $1 == sound_playuntildone ]; then #play sound () until done block
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
    elif [ $1 == looks_seteffectto ]; then #set [] effect to () block
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
    elif [ $1 == sound_play ]; then #start sound () block
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
    elif [ $1 == sound_stopallsounds ]; then #stop all sounds block
      start
      echo >>$dcd/$name.ss1 "stop all sounds"
      echo "Added block: \"stop all sounds\""
    elif [ $1 == sound_changeeffectby ]; then #change [] effect by () block
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
    elif [ $1 == sound_seteffectto ]; then #set [] effect to () block
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
    elif [ $1 == sound_cleareffects ]; then #clear sound effects block
      start
      echo >>$dcd/$name.ss1 "clear sound effects"
      echo "Added block: \"clear sound effects\""
    elif [ $1 == sound_changevolumeby ]; then #change volume by () block
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
    elif [ $1 == sound_volume ]; then #(volume) block
      start
      echo >>$dcd/$name.ss1 "(volume)"
      echo "Added block: \"(volume)\""
    elif [ $1 == event_whenflagclicked ]; then #when flag clicked block
      start
      echo >>$dcd/$name.ss1 "when flag clicked"
      echo "Added block: \"when flag clicked\""
    elif [ $1 == event_whenkeypressed ]; then #when [] key pressed block
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
    elif [ $1 == event_whenstageclicked ]; then #when stage clicked block
      start
      echo >>$dcd/$name.ss1 "when stage clicked"
      echo "Added block: \"when stage clicked\""
    elif [ $1 == event_whenbroadcastreceived ]; then #when i receive [] block
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
    elif [ $1 == event_broadcastandwait ]; then #broadcast [] and wait block
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
    elif [ $1 == sound_setvolumeto ]; then #set volume to () % block
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
    elif [ $1 == event_whenbackdropswitchesto ]; then #when backdrop switches to [] block
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
    elif [ $1 == looks_cleargraphiceffects ]; then #clear graphic effects block
      start
      echo >>$dcd/$name.ss1 "clear graphic effects"
      echo "Added block: \"clear graphic effects\""
    elif [ $1 == event_whengreaterthan ]; then #when [] > () block
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
    elif [ $1 == control_repeat ]; then #repeat () {}block
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
        ca+=($next)
        rep=$next
        next=$varname
        ci+=('r')
        per=r
        ((cm++))
        echo
        echo "Starting repeat."
        echo
        echo >>$dcd/$name.ss1 "repeat (\"$varvalue\") {"
        echo "repeat (\"$varvalue\") {"
      else
        echo
        echo "Starting repeat."
        echo
        echo >>$dcd/$name.ss1 "repeat (\"$varvalue\") {"
        echo "repeat (\"$varvalue\") {"
        echo >>$dcd/$name.ss1
        echo
        echo >>$dcd/$name.ss1 "}"
        echo "}"
        echo
        echo "Ended repeat."
      fi
    elif [ $1 == control_forever ]; then #forever {} block
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
        z=$i
        b=0
        while :; do
          i
          getchar -\]
          if [ $b == 1 ]; then
            break
          fi
        done
        i-
        b=0
        getchar -\"
        if [ $b == 0 ]; then
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
        else
          i=$z
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
          ca+=($next)
          rep=$next
          ci+=('f')
          per=f
          ((cm++))
          next=$varname
          echo
          echo "Starting forever.."
          echo
          echo >>$dcd/$name.ss1 "forever {"
          echo "forever {"
        fi
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
    if ! [ $next == fin ]; then #if not next equals fin do these
      i=2                       #the below scripts look for "opcode", which is the end of most opcodes. It goes to the next "}" then looks at the thing in quotes after that. That is the block ID. It uses this to compile all the blocks in order.
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
          if [ "$word" == opcode ]; then
            b=0
            while :; do
              i-
              getchar -\"
              if [ $b == 1 ]; then
                break
              fi
            done
            b=0
            while :; do
              i-
              getchar -\"
              if [ $b == 1 ]; then
                break
              fi
            done
            b=0
            while :; do
              i-
              getchar -\"
              if [ $b == 1 ]; then
                break
              fi
            done
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
            i=$(expr $i + 10)
          fi
        fi
      done
    else
      if ! [ $rep == 0 ]; then
        if [ $cm -gt 0 ]; then #if not rep=0 then it was compiling a c-block9
          ok=$ca
          e=0
          unset ca[-1]
          if [ h$ca == h ]; then
            ca=("$ok")
            e=1
          fi
          next=$rep
          rep=0
          if ! [ $cm == 0 ]; then
            rep=${ca[-1]}
          fi
          p=0
          while :; do
            ((p++))
            echo >>$dcd/$name.ss1 "}"
            echo "}"
            if [ $p == $cm ]; then
              break
            fi
          done
          cm=0
          echo
          if [ h$per == hr ]; then #$per is the c-block identity. r=repeat, f=forever
            echo "Ended repeat."
          elif [ h$per == hf ]; then
            echo "Ended forever."
          fi
          unset ci[-1]
          per=${ci}
          if [ $e == 1 ]; then
            ca=
          fi
          next=$rep
          if [ h$next == h ]; then
            next=fin
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
                if [ "$word" == opcode ]; then
                  b=0
                  while :; do
                    i-
                    getchar -\"
                    if [ $b == 1 ]; then
                      break
                    fi
                  done
                  b=0
                  while :; do
                    i-
                    getchar -\"
                    if [ $b == 1 ]; then
                      break
                    fi
                  done
                  b=0
                  while :; do
                    i-
                    getchar -\"
                    if [ $b == 1 ]; then
                      break
                    fi
                  done
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
                  i=$(expr $i + 10)
                fi
              fi
            done
          fi
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
    i
    i
    b=0
    getchar -\}
    if [ $b == 1 ]; then
      novars=1
      i-
      i-
    else
      i-
      i-
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
    fi
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
    if [ "$word" == broadcasts ]; then
      break
    fi
  done
  b=0
  novars=0
  i
  i
  i
  b=0
  getchar -\}
  if [ $b == 1 ]; then
    novars=1
    i-
    i-
  else
    i-
    i-
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
    nextquote
  fi
  if [ $novars == 0 ]; then
    while :; do
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
      nextquote
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
  #add spaces
  echo
  echo "Indenting code to make it easier to read (This may take a while depending on how big your project is)..."
  echo
  gql() {
    line=$(sed $q'!d' $dcd/$name.ss1)
  }
  q=0
  while :; do
    ((q++))
    gql
    echo >>$dcd/a.txt "$line"
    if [ "$line" == "\nscript" ]; then
      break
    fi
  done
  r=0
  ff() {
    ((q++))
    gql
    if [[ "$line" == *"repeat ("* ]] || [[ "$line" == *"forever {"* ]]; then
      intent=
      m=0
      while :; do
        ((m++))
        if [ $m -gt $r ]; then
          break
        fi
        intent+="  "
      done
      echo >>$dcd/a.txt "$intent""$line"
      ((r++))
      while :; do
        ff
        gql
        if [ "$line" == \} ]; then
          break
        fi
      done
    else
      if [ $r -gt 0 ]; then
        intent=
        m=0
        if [ "$line" == \} ]; then
          ((r--))
        fi
        while :; do
          ((m++))
          if [ $m -gt $r ]; then
            break
          fi
          intent+="  "
        done
        echo >>$dcd/a.txt "$intent""$line"
      else
        echo >>$dcd/a.txt "$line"
      fi
    fi
  }
  while :; do
    ff
    if [ "$q" == "$(sed -n '$=' $dcd/$name.ss1)" ]; then
      break
    fi
  done
  mv $dcd/$name.ss1 $dcd/b.txt
  mv $dcd/a.txt $dcd/$name.ss1
  rm $dcd/b.txt
elif [ h$input3 == hn ] || [ h$input3 == hN ]; then
  echo "Install zenity for MSYS2, or this won't work."
else
  echo -e "${RED}Error: $input3 is not an input.${NC}"
  ./compiler.sh
fi
