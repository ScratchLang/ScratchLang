#!/bin/bash
#Decompiler coded by
#0K9090 (ThatCoder77471 on Scratch)
#
# cd ../ goes to the prev directory
#
if [ -f var/pe ]; then
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
echo
RED='\033[0;31m'
NC='\033[0m'
echo -e "${RED}Decompiler 2.0${NC}"
dcd=Stage
echo "Remember, both the compiler and decompiler don't work yet. The decompiler can extract the sb3, define variables, build lists, load broadcasts, and decompile some blocks, but it can't do anything else yet."
echo
if ! [ -f var/zenity ]; then
  echo "Do you have the command zenity? [Y/N]"
  read -sn 1 input3
else
  input3=y
fi
echo
if [ h$input3 == hY ] || [ h$input3 == hy ]; then #Continue if you have the command zenity
  if ! [ -f var/zenity ]; then
    echo >>var/zenity
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
  nq() { #main while loop
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
    nq
    nq
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
    nq
    nq
    i
    i
    b=0
    getchar -\"
    if ! [ $b == 1 ]; then #if parent equals null
      if [ h$1 == h ]; then
        echo >>$dcd/project.ss1 "\nscript"
        echo
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
  start2() {
    nq
    nq
    i
    i
    b=0
    getchar -\"
    if ! [ $b == 1 ]; then
      if [ h$1 == h ]; then
        con="fin" #if next equals null, then set the variable next to fin
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
        con=$varname #if next is not null, set next to whatever it is
      fi
    fi
    nq
    nq
    i
    i
    b=0
    getchar -\"
    if ! [ $b == 1 ]; then #if parent equals null
      if [ h$1 == h ]; then
        echo >>$dcd/project.ss1 "\nscript"
        echo
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
  ops=()
  addop() { #function to decomp operators
    if [ $1 == operator_equals ]; then
      start2
      nq
      nq
      nq
      nq
      nq
      b=0
      o1=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        o1+=$char
      done
      nq
      nq
      nq
      b=0
      o2=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        o2+=$char
      done
      addt+="<($o1) = ($o2)>"
    elif [ $1 == operator_gt ]; then
      start2
      nq
      nq
      nq
      nq
      nq
      b=0
      o1=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        o1+=$char
      done
      nq
      nq
      nq
      b=0
      o2=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        o2+=$char
      done
      addt+="<($o1) > ($o2)>"
    elif [ $1 == operator_lt ]; then
      start2
      nq
      nq
      nq
      nq
      nq
      b=0
      o1=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        o1+=$char
      done
      nq
      nq
      nq
      b=0
      o2=
      while :; do
        i
        getchar -\"
        if [ $b == 1 ]; then
          break
        fi
        o2+=$char
      done
      addt+="<($o1) < ($o2)>"
    elif [ $1 == operator_and ]; then
      start2
      nq
      nq
      nq
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
      if [ "$word" == "OPERAND2" ]; then
        b=0
        vi=$i
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
          addt+="<<> and "
          nq
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
          if [ $word == "OPERAND1" ] || [ "$word" == "OPERAND2" ]; then
            b=0
            vi=$i
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
              addt+="<>>"
            else
              i=$vi
              nq
              b=0
              op1=
              while :; do
                i
                getchar -\"
                if [ $b == 1 ]; then
                  break
                fi
                op1+=$char
              done
              wy=$i
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
                  if [ "$word" == $op1 ]; then
                    break
                  fi
                  i=$(expr $i + 10)
                fi
              done
              nq
              nq
              nq
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
              addop $word
              addt+=">"
            fi
          else
            addt+="<>>"
          fi
        else
          i=$vi
          nq
          b=0
          op1=
          while :; do
            i
            getchar -\"
            if [ $b == 1 ]; then
              break
            fi
            op1+=$char
          done
          wy=$i
          addt+="<"
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
              if [ "$word" == $op1 ]; then
                break
              fi
              i=$(expr $i + 10)
            fi
          done
          nq
          nq
          nq
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
          addop $word
          i=$wy
          addt+=" and "
          nq
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
          if [ "$word" == "OPERAND1" ]; then
            b=0
            vi=$i
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
              addt+="<>>"
              i=$vi
            else
              i=$vi
              nq
              b=0
              op2=
              while :; do
                i
                getchar -\"
                if [ $b == 1 ]; then
                  break
                fi
                op2+=$char
              done
              wy=$i
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
                  if [ "$word" == $op2 ]; then
                    break
                  fi
                  i=$(expr $i + 10)
                fi
              done
              nq
              nq
              nq
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
              addop $word
              addt+=">"
            fi
          else
            addt+="<>>"
          fi
        fi
      else
        addt+="<<> and <>>"
      fi
    elif [ $1 == operator_or ]; then
      start2
      nq
      nq
      nq
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
      if [ "$word" == "OPERAND2" ]; then
        b=0
        vi=$i
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
          addt+="<<> or "
          nq
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
          if [ $word == "OPERAND1" ]; then
            b=0
            vi=$i
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
              addt+="<>>"
            else
              i=$vi
              nq
              b=0
              op1=
              while :; do
                i
                getchar -\"
                if [ $b == 1 ]; then
                  break
                fi
                op1+=$char
              done
              wy=$i
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
                  if [ "$word" == $op1 ]; then
                    break
                  fi
                  i=$(expr $i + 10)
                fi
              done
              nq
              nq
              nq
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
              addop $word
              addt+=">"
            fi
          else
            addt+="<>>"
          fi
        else
          i=$vi
          nq
          b=0
          op1=
          while :; do
            i
            getchar -\"
            if [ $b == 1 ]; then
              break
            fi
            op1+=$char
          done
          wy=$i
          addt+="<"
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
              if [ "$word" == $op1 ]; then
                break
              fi
              i=$(expr $i + 10)
            fi
          done
          nq
          nq
          nq
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
          addop $word
          i=$wy
          addt+=" or "
          nq
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
          if [ $word == "OPERAND1" ]; then
            b=0
            vi=$i
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
              addt+="<>>"
            else
              i=$vi
              nq
              b=0
              op1=
              while :; do
                i
                getchar -\"
                if [ $b == 1 ]; then
                  break
                fi
                op1+=$char
              done
              wy=$i
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
                  if [ "$word" == $op1 ]; then
                    break
                  fi
                  i=$(expr $i + 10)
                fi
              done
              nq
              nq
              nq
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
              addop $word
              addt+=">"
            fi
          else
            addt+="<>>"
          fi
        fi
      else
        addt+="<<> or <>>"
      fi
    fi
  }
  addblock() {
    parent=0
    addt=
    #Comments explaining what the scripts do will be added soon.
    if [ $1 == event_broadcast ]; then #Broadcast block
      start
      nq
      nq
      nq
      nq
      nq
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
      echo >>$dcd/project.ss1 "broadcast [$varname]"
      echo -e "${RED}Added block:${NC} \"broadcast [$varname]\""
    elif [ $1 == motion_movesteps ]; then #move () steps block
      start
      nq
      nq
      nq
      nq
      nq
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
      echo >>$dcd/project.ss1 "move (\"$varname\") steps"
      echo -e "${RED}Added block:${NC} \"move (\"$varname\") steps\""
    elif [ $1 == control_wait ]; then #wait () seconds block
      start
      nq
      nq
      nq
      nq
      nq
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
      echo >>$dcd/project.ss1 "wait (\"$varname\") seconds"
      echo -e "${RED}Added block:${NC} \"wait (\"$varname\") seconds\""
    elif [ $1 == looks_switchbackdropto ]; then #switch backdrop to () block
      start
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      b=0
      while :; do
        i
        getchar -\}
        if [ $b == 1 ]; then
          break
        fi
      done
      nq
      nq
      nq
      nq
      nq
      nq
      start n
      nq
      nq
      nq
      nq
      nq
      nq
      nq
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
      echo >>$dcd/project.ss1 "switch backdrop to (\"$varname\")"
      echo -e "${RED}Added block:${NC} \"switch backdrop to (\"$varname\")\""
    elif [ $1 == looks_switchbackdroptoandwait ]; then #switch backdrop to () and wait block
      start
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      b=0
      while :; do
        i
        getchar -\}
        if [ $b == 1 ]; then
          break
        fi
      done
      nq
      nq
      nq
      nq
      nq
      nq
      start n
      nq
      nq
      nq
      nq
      nq
      nq
      nq
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
      echo >>$dcd/project.ss1 "switch backdrop to (\"$varname\") and wait"
      echo -e "${RED}Added block:${NC} \"switch backdrop to (\"$varname\") and wait\""
    elif [ $1 == looks_nextbackdrop ]; then #next backdrop block
      start
      echo >>$dcd/project.ss1 "next backdrop"
      echo -e "${RED}Added block:${NC} \"next backdrop\""
    elif [ $1 == looks_changeeffectby ]; then #change [] effect by () block
      start
      nq
      nq
      nq
      nq
      nq
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
      nq
      nq
      nq
      nq
      nq
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
      echo >>$dcd/project.ss1 "change [$varname] effect by (\"$varvalue\")"
      echo -e "${RED}Added block:${NC} \"change [$varname] effect by (\"$varvalue\")\""
    elif [ $1 == looks_backdropnumbername ]; then #(backdrop []) block
      start
      nq
      nq
      nq
      nq
      nq
      nq
      nq
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
      echo >>$dcd/project.ss1 "(backdrop [$word])"
      echo -e "${RED}Added block:${NC} \"(backdrop [$word])\""
    elif [ $1 == sound_playuntildone ]; then #play sound () until done block
      start
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      b=0
      while :; do
        i
        getchar -\}
        if [ $b == 1 ]; then
          break
        fi
      done
      nq
      nq
      nq
      nq
      nq
      nq
      start n
      nq
      nq
      nq
      nq
      nq
      nq
      nq
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
      echo >>$dcd/project.ss1 "play sound (\"$varname\") until done"
      echo -e "${RED}Added block:${NC} \"play sound (\"$varname\") until done\""
    elif [ $1 == looks_seteffectto ]; then #set [] effect to () block
      start
      nq
      nq
      nq
      nq
      nq
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
      nq
      nq
      nq
      nq
      nq
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
      echo >>$dcd/project.ss1 "set [$varname] effect to (\"$varvalue\")"
      echo -e "${RED}Added block:${NC} \"set [$varname] effect to (\"$varvalue\")\""
    elif [ $1 == sound_play ]; then #start sound () block
      start
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      nq
      b=0
      while :; do
        i
        getchar -\}
        if [ $b == 1 ]; then
          break
        fi
      done
      nq
      nq
      nq
      nq
      nq
      nq
      start n
      nq
      nq
      nq
      nq
      nq
      nq
      nq
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
      echo >>$dcd/project.ss1 "start sound (\"$varname\")"
      echo -e "${RED}Added block:${NC} \"start sound (\"$varname\")\""
    elif [ $1 == sound_stopallsounds ]; then #stop all sounds block
      start
      echo >>$dcd/project.ss1 "stop all sounds"
      echo -e "${RED}Added block:${NC} \"stop all sounds\""
    elif [ $1 == sound_changeeffectby ]; then #change [] effect by () block
      start
      nq
      nq
      nq
      nq
      nq
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
      nq
      nq
      nq
      nq
      nq
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
      echo >>$dcd/project.ss1 "change [$varname] effect by (\"$varvalue\")"
      echo -e "${RED}Added block:${NC} \"change [$varname] effect by (\"$varvalue\")\""
    elif [ $1 == sound_seteffectto ]; then #set [] effect to () block
      start
      nq
      nq
      nq
      nq
      nq
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
      nq
      nq
      nq
      nq
      nq
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
      echo >>$dcd/project.ss1 "set [$varname] effect to (\"$varvalue\")"
      echo -e "${RED}Added block:${NC} \"set [$varname] effect to (\"$varvalue\")\""
    elif [ $1 == sound_cleareffects ]; then #clear sound effects block
      start
      echo >>$dcd/project.ss1 "clear sound effects"
      echo -e "${RED}Added block:${NC} \"clear sound effects\""
    elif [ $1 == sound_changevolumeby ]; then #change volume by () block
      start
      nq
      nq
      nq
      nq
      nq
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
      echo >>$dcd/project.ss1 "change volume by (\"$varname\")"
      echo -e "${RED}Added block:${NC} \"change volume by (\"$varname\")\""
    elif [ $1 == sound_volume ]; then #(volume) block
      start
      echo >>$dcd/project.ss1 "(volume)"
      echo -e "${RED}Added block:${NC} \"(volume)\""
    elif [ $1 == event_whenflagclicked ]; then #when flag clicked block
      start
      echo >>$dcd/project.ss1 "when flag clicked"
      echo -e "${RED}Added block:${NC} \"when flag clicked\""
    elif [ $1 == event_whenkeypressed ]; then #when [] key pressed block
      start
      nq
      nq
      nq
      nq
      nq
      nq
      nq
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
      echo >>$dcd/project.ss1 "when [$varname] key pressed"
      echo -e "${RED}Added block:${NC} \"when [$varname] key pressed\""
    elif [ $1 == event_whenstageclicked ]; then #when stage clicked block
      start
      echo >>$dcd/project.ss1 "when stage clicked"
      echo -e "${RED}Added block:${NC} \"when stage clicked\""
    elif [ $1 == event_whenbroadcastreceived ]; then #when i receive [] block
      start
      nq
      nq
      nq
      nq
      nq
      nq
      nq
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
      echo >>$dcd/project.ss1 "when i receieve [$word]"
      echo -e "${RED}Added block:${NC} \"when i receieve [$word]\""
    elif [ $1 == event_broadcastandwait ]; then #broadcast [] and wait block
      start
      nq
      nq
      nq
      nq
      nq
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
      echo >>$dcd/project.ss1 "broadcast [$varname] and wait"
      echo -e "${RED}Added block:${NC} \"broadcast [$varname] and wait\""
    elif [ $1 == sound_setvolumeto ]; then #set volume to () % block
      start
      nq
      nq
      nq
      nq
      nq
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
      echo >>$dcd/project.ss1 "set volume to (\"$varname\") %"
      echo -e "${RED}Added block:${NC} \"set volume to (\"$varname\") %\""
    elif [ $1 == event_whenbackdropswitchesto ]; then #when backdrop switches to [] block
      start
      nq
      nq
      nq
      nq
      nq
      nq
      nq
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
      echo >>$dcd/project.ss1 "when backdrop switches to [$varname]"
      echo -e "${RED}Added block:${NC} \"when backdrop switches to [$varname]\""
    elif [ $1 == looks_cleargraphiceffects ]; then #clear graphic effects block
      start
      echo >>$dcd/project.ss1 "clear graphic effects"
      echo -e "${RED}Added block:${NC} \"clear graphic effects\""
    elif [ $1 == event_whengreaterthan ]; then #when [] > () block
      start
      nq
      nq
      nq
      nq
      nq
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
      nq
      nq
      nq
      nq
      nq
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
      echo >>$dcd/project.ss1 "when [$varname] > (\"$varvalue\")"
      echo -e "${RED}Added block:${NC} \"when [$varname] > (\"$varvalue\")\""
    elif [ $1 == control_repeat ]; then #repeat () {}block
      cbt=1
      start
      nq
      nq
      nq
      nq
      nq
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
      nq
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
        nq
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
        echo -e "${RED}Starting repeat.${NC}"
        echo
        echo >>$dcd/project.ss1 "repeat (\"$varvalue\") {"
        echo "repeat (\"$varvalue\") {"
      else
        echo
        echo -e "${RED}Starting repeat.${NC}"
        echo
        echo >>$dcd/project.ss1 "repeat (\"$varvalue\") {"
        echo "repeat (\"$varvalue\") {"
        echo >>$dcd/project.ss1
        echo
        echo >>$dcd/project.ss1 "}"
        echo "}"
        echo
        echo -e "${RED}Ended repeat.${NC}"
      fi
    elif [ $1 == control_forever ]; then #forever {} block
      cbt=1
      start
      nq
      nq
      nq
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
          echo -e "${RED}Starting forever.${NC}"
          echo
          echo >>$dcd/project.ss1 "forever {"
          echo "forever {"
          echo >>$dcd/project.ss1
          echo
          echo >>$dcd/project.ss1 "}"
          echo "}"
          echo
          echo -e "${RED}Ended forever.${NC}"
        else
          i=$z
          nq
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
          echo -e "${RED}Starting forever.${NC}"
          echo
          echo >>$dcd/project.ss1 "forever {"
          echo "forever {"
        fi
      else
        echo
        echo -e "${RED}Starting forever.${NC}"
        echo
        echo >>$dcd/project.ss1 "forever {"
        echo "forever {"
        echo >>$dcd/project.ss1
        echo
        echo >>$dcd/project.ss1 "}"
        echo "}"
        echo
        echo -e "${RED}Ended forever.${NC}"
      fi
    elif [ $1 == control_if ]; then #if <> {} block
      cbt=1
      start
      nq
      nq
      nq
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
      echo
      echo -e "${RED}Starting if.${NC}"
      echo
      if [ $word == CONDITION ]; then
        nq
        b=0
        con=
        while :; do
          i
          getchar -\"
          if [ $b == 1 ]; then
            break
          fi
          con+=$char
        done
        v=$i
        i=1
        while :; do
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
            if [ "$word" == opcode ]; then
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
          if [ "$word" == "$con" ]; then
            break
          fi
          i=$(expr $i + 10)
        done
        while :; do
          nq
          nq
          nq
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
          addop $word
          if [ $con == fin ]; then
            break
          fi
        done
        echo >>$dcd/project.ss1 "if $addt then {"
        echo "if $addt then {"
        i=$v
        nq
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
          nq
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
          ci+=('i')
          per=i
          ((cm++))
        else
          echo >>$dcd/project.ss1
          echo
          echo >>$dcd/project.ss1 "}"
          echo "}"
          echo
          echo -e "${RED}Ended if.${NC}"
        fi
      else
        echo >>$dcd/project.ss1 "if <> then {"
        echo "if <> then {"
        echo >>$dcd/project.ss1
        echo
        echo >>$dcd/project.ss1 "}"
        echo "}"
        echo
        echo -e "${RED}Ended if.${NC}"
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
            nq
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
              nq
              break
            fi
            i=$(expr $i + 10)
          fi
        fi
      done
    else
      if ! [ "h$rep" == h0 ]; then
        if [ $cm -gt 0 ]; then #if not rep=0 then it was compiling a c-block
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
            echo >>$dcd/project.ss1 "}"
            echo "}"
            if [ $p == $cm ]; then
              break
            fi
          done
          cm=0
          echo
          if [ h$per == hr ]; then #$per is the c-block identity. r=repeat, f=forever
            echo -e "${RED}Ended repeat.${NC}"
          elif [ h$per == hf ]; then
            echo -e "${RED}Ended forever.${NC}"
          elif [ h$per == hi ]; then
            echo -e "${RED}Ended if.${NC}"
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
                  nq
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
                    nq
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
    nq
    i
    nq
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
      if ! [ -f Stage/project.ss1 ]; then
        echo >>Stage/project.ss1 "#There should be no empty lines."
        echo >>Stage/project.ss1 ss1
        echo >>Stage/project.ss1 "\prep"
      fi
      echo >>Stage/project.ss1 $varname=$varvalue #Use echo >> if 2nd arg contains variables
      echo -e "${RED}Added variable:${NC} \"$varname\"."
      echo -e "${RED}Value:${NC} $varvalue"
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
      echo >>Stage/project.ss1 "#There should be no empty lines."
      echo >>Stage/$name ss1
      echo >>Stage/project.ss1 "\prep"
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
      nq
      i
      nq
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
        list=$(cat lists | tr '\n' ' ')
        list=$(echo $list | tr -d ' ')
        echo >>Stage/project.ss1 "$listname=$list"
        echo -e "${RED}Added list:${NC} \"$listname\"."
        echo -e "${RED}Contents:${NC} $list"
        echo
        rm lists
      else
        echo >>Stage/project.ss1 $listname=,
        echo -e "${RED}Added list:${NC} \"$listname\"."
        echo -e "${RED}Contents:${NC} Nothing."
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
    while :; do #repeat until char = "
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
    nq
  fi
  if [ $novars == 0 ]; then
    while :; do
      i
      nq
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
      echo >>Stage/project.ss1 {broadcast}=$varname
      echo -e "${RED}Loaded broadcast:${NC} \"$varname\""
      echo
      i
      b=0
      getchar -\}
      if [ $b == 1 ]; then
        break
      fi
      i
      i
      nq
    done
    rep=0
    cbt=0
    echo "Making blocks..."
    echo
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
          nq
          nq
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
    line=$(sed $q'!d' $dcd/project.ss1)
  }
  gpsvar() {
    per=$(echo "scale = 2; $q / $(sed -n '$=' $dcd/project.ss1) * 100" | bc)
    pb=$(tput cols)
    ps=$(echo "scale = 2; $per / 100 * $pb" | bc)
    per+="%"
  }
  x=0
  getper() {
    gpsvar
    ps=$(printf '%.*f\n' 0 $ps)
    pbr=
    for ((v = 1; v <= $ps; v++)); do
      pbr+="#"
    done
    echo -e "$per done. \e[2A"
    echo -e "$pbr"
  }
  echo
  q=0
  while :; do
    ((q++))
    getper
    gql
    echo >>$dcd/a.txt "$line"
    if [ "$line" == "\nscript" ]; then
      break
    fi
  done
  r=0
  ff() {
    ((q++))
    getper
    gql
    if [[ "$line" == *"repeat ("* ]] || [[ "$line" == *"forever {"* ]] || [[ "$line" == *"if <"* ]]; then
      indent=
      m=0
      while :; do
        ((m++))
        if [ $m -gt $r ]; then
          break
        fi
        indent+="  "
      done
      echo >>$dcd/a.txt "$indent""$line"
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
        indent=
        m=0
        if [ "$line" == \} ]; then
          ((r--))
        fi
        while :; do
          ((m++))
          if [ $m -gt $r ]; then
            break
          fi
          indent+="  "
        done
        echo >>$dcd/a.txt "$indent""$line"
      else
        echo >>$dcd/a.txt "$line"
      fi
    fi
  }
  while :; do
    ff
    if [ "$q" == "$(sed -n '$=' $dcd/project.ss1)" ]; then
      break
    fi
  done
  mv $dcd/project.ss1 $dcd/b.txt
  mv $dcd/a.txt $dcd/project.ss1
  rm $dcd/b.txt
  echo
  cd ../
  echo
  echo -e "${RED}Your project can be found in $PWD/$name.${NC}"
elif [ h$input3 == hn ] || [ h$input3 == hN ]; then
  echo "Install zenity for MSYS2, or this won't work."
else
  echo -e "${RED}Error: $input3 is not an input.${NC}"
  ./decompiler.v2.ss1.sh
fi
