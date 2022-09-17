logo1="  ________________                                                                  _____                          ____"
logo2=" /                \                                                                |     |                        |    |"
logo3="|      ___________/                                                         _______|     |_______                 |    |"
logo4="|    /                                                                     |                     |                |    |"
logo5="|   |                                                                      |_______       _______|                |    |"
logo6="|    \____________      _______________    ____   ________     __________          |     |     _______________    |    |______"
logo7="|                 \    /               \  |    | /        |   /  _____   \         |     |    /               \   |           |"
logo8=" \____________     |  |    ____________/  |    |    ______|  |  |     |   \        |     |   |    ____________/   |    ___    |"
logo9="              \    |  |   |               |        |         |  |     |    \       |     |   |   |                |   |   |   |"
logo10="               |   |  |   |               |        |         |  |     |     \      |     |   |   |                |   |   |   |"
logo11=" _____________/    |  |   |____________   |        |         |  |     |   |  \     |     |   |   |____________    |   |   |   |"
logo12="/                  |  |                \  |        |         |  |_____|   |\  \    |     |   |                \   |   |   |   |"
logo13="\__________________/   \_______________/  |________|         \___________/  \__\   |_____|    \_______________/   |___|"
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