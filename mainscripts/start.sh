#!/bin/bash
if [ h$1 == h-help ]; then
  echo "scratchlang (or ./start.sh if you haven't made an alias)"
  echo
  echo "  -1      Create a project"
  echo "  -2      Remove a project"
  echo "  -3      Compile a project"
  echo "  -4      Decompile a project"
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
                                                                
  clear
  echo "$logo"
  echo

  if [ h$1 == h ]; then
    if [ -d .var ]; then
      echo "Welcome to ScratchLang. (Name suggested by @MagicCrayon9342 on Scratch)"
      echo "Please select an option."
      if ! [ -f .var/devmode ]; then
        chmod 755 inputloop.sh
        ./inputloop.sh
      else
        chmod 755 devinputloop.sh
        ./devinputloop.sh
      fi
    else
      echo "You have to be in the \"mainscripts\" directory for this to work."
    fi
  else
    if [ -d .var ]; then
      if ! [ -f .var/devmode ]; then
        chmod 755 inputloop.sh
        ./inputloop.sh $1
      else
        chmod 755 devinputloop.sh
        ./devinputloop.sh $1
      fi
    else
      echo "You have to be in the \"mainscripts\" directory for this to work."
    fi
  fi
fi
cd $(dirname $(pwd))
if [ -d projects ]; then
  cd projects
  h=h$(ls)
  if [ "$h" == h ]; then
    cd $(dirname $(pwd))
    rm -rf projects
    cd mainscripts
  fi
else
  cd mainscripts
fi