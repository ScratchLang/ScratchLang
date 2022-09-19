echo "Do you have the command zenity? [Y/N]"
read input3
echo
if [ $input3 == Y ] || [ $input3 == y ]; then
  echo "Select the project directory."
  echo
  sleep 2
  file=$(zenity -directory -file-selection)
  cd $file
  if [ -f .maindir ]; then
    echo >> .dirs $(ls -1)
    json={\"targets\":[{\"isStage\":true,\"name\":\"Stage\",\"variables\": #Start of the json
    for each ((i=1; i<=$(sed -n '$=' .dirs); i++)) #Starts compiling the json
    do
      if [ $i == 1 ]; then
        cd Stage
        block=$(sed $i'.dirs')
        if [ block == "when flag clicked" ]; then
          echo
        fi
      else
        block=$(sed $i'.dirs')
        if [ block == "when flag clicked" ]; then
          echo
        fi
      fi
    done
    echo >> project.json $json #creates the project.json
  else
    echo "Error: Not a project directory."
  fi
elif [ $input3 == n ] || [ $input3 == N ]; then
  echo "Install zenity for MSYS2, or this won't work."
else
  echo "$input3 is not an input."
  ./compiler.sh
fi