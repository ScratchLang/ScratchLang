#!/bin/bash
if [ h$1 == h-help ]; then
  echo "ScratchScript (or ./start.sh if you haven't made an alias)"
  echo
  echo "  -1      Create a project"
  echo "  -2      Remove a project"
  echo "  -3      Compile a project"
  echo "  -4      Decompile a project"
  echo "  -help      Display this help message."
else
  logo1="  _________                                                      ___                    ____"
  logo2=" /         \                                                    |   |                  |    |"
  logo3="|      ____/                                                ____|   |____              |    |"
  logo4="|    /                                                     |             |             |    |"
  logo5="|   |                                                      |____     ____|             |    |"
  logo6="|    \_____      __________    ____   ______     ________       |   |     __________   |    |______"
  logo7="|          \    /          \  |    | /      |   /  ___   \      |   |    /          \  |           |"
  logo8=" \_____     |  |    _______/  |    |    ____|  |  |   |   \     |   |   |    _______/  |    ___    |"
  logo9="       \    |  |   |          |       /        |  |   |    \    |   |   |   |          |   |   |   |"
  logo10="        |   |  |   |          |      |         |  |   |     \   |   |   |   |          |   |   |   |"
  logo11=" ______/    |  |   |_______   |      |         |  |   |   |  \  |   |   |   |_______   |   |   |   |"
  logo12="/           |  |           \  |      |         |  |___|   |\  \ |   |   |           \  |   |   |   |"
  logo13="\___________/   \__________/  |______|         \_________/  \__\|___|    \__________/  |___|   |___|"

  clear
  echo "$logo1"
  echo "$logo2"
  echo "$logo3"
  echo "$logo4"
  echo "$logo5"
  echo "$logo6"
  echo "$logo7"
  echo "$logo8"
  echo "$logo9"
  echo "$logo10"
  echo "$logo11"
  echo "$logo12"
  echo "$logo13"
  echo

  if [ h$1 == h ]; then
    if [ -d .var ]; then
      echo "Welcome to ScratchScript."
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
  if [ h$(ls) == h ]; then
    cd $(dirname $(pwd))
    rm -rf projects
    cd mainscripts
  fi
else
  cd mainscripts
fi