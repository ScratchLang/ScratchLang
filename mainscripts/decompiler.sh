echo "Do you have the command zenity? [Y/N]"
read input3
echo
if [ $input3 == Y ] || [ $input3 == y ]; then
  echo "Select the .sb3 you want to decompile."
  echo
  sleep 2
  file=$(zenity -file-selection)
  echo "Name of project?"
  read name
  cd $(dirname $(pwd))
  if ! [ -d projects ]; then
    mkdir projects
  fi
  cd projects
  mkdir $name
  cd $name
  unzip $file
  echo >> .maindir "Please don't remove this file."
  mkdir Stage
  cd Stage
  mkdir assets
  cd $(dirname $(pwd))
  #Add decompilation scripts here
  if [ 1 == 1 ]; then
    cd $(dirname $(pwd))
    cd $(dirname $(pwd))
    cd mainscripts
  fi
elif [ $input3 == n ] || [ $input3 == N ]; then
  echo "Install zenity for MSYS2, or this won't work."
else
  echo "$input3 is not an input."
  ./compiler.sh
fi