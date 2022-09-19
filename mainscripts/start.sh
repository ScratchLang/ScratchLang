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
  logo1="  _____________                                                         ___                       ____"
  logo2=" /             \                                                       |   |                     |    |"
  logo3="|      ________/                                                  _____|   |_____                |    |"
  logo4="|    /                                                           |               |               |    |"
  logo5="|   |                                                            |_____     _____|               |    |"
  logo6="|    \_________      ____________    ____   ______     ________        |   |     ____________    |    |______"
  logo7="|              \    /            \  |    | /      |   /  ___   \       |   |    /            \   |           |"
  logo8=" \_________     |  |    _________/  |    |    ____|  |  |   |   \      |   |   |    _________/   |    ___    |"
  logo9="           \    |  |   |            |       /        |  |   |    \     |   |   |   |             |   |   |   |"
  logo10="            |   |  |   |            |      |         |  |   |     \    |   |   |   |             |   |   |   |"
  logo11=" __________/    |  |   |_________   |      |         |  |   |   |  \   |   |   |   |_________    |   |   |   |"
  logo12="/               |  |             \  |      |         |  |___|   |\  \  |   |   |             \   |   |   |   |"
  logo13="\_______________/   \____________/  |______|         \_________/  \__\ |___|    \____________/   |___|   |___|"

  clear
  echo $logo1
  echo $logo2
  echo $logo3
  echo $logo4
  echo $logo5
  echo $logo6
  echo $logo7
  echo $logo8
  echo $logo9
  echo $logo10
  echo $logo11
  echo $logo12
  echo $logo13
  echo
  echo "This cool logo was definitally made like this on purpose"
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