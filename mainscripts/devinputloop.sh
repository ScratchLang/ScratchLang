echo
echo "1. Create a project."
echo "2. Compile a project"
echo "3. Decompile a .sb3 file."
echo "4. Are options 1 and 2 not working? Input 4 to install dependencies."
echo "5. Create alias."
echo "6. Remove alias."
echo "7. Disable Developer Mode."
echo "8. Delete all variables."
echo "9. Prepare for commit and push."
echo "10. Exit."
read input
if [ $input == 1 ]; then
  echo
  echo "Name your project."
  read name
  echo
  echo "You named your project $name. If you want to rename it, use the File Explorer."
elif [ $input == 2 ]; then
  if ! [ -f compile.exe ]; then
    gcc -o compile.exe 2.c
  fi
  ./compile.exe
elif [ $input == 3 ]; then
  if ! [ -f decompile.exe ]; then
    gcc -o decompile.exe 3.c
  fi
  ./decompile.exe
elif [ $input == 4 ]; then
  pacman -S  #get gcc install command when internet is restored
  ./start.sh
elif [ $input == 5 ]; then
  dir=$(pwd)
  if ! [ -f .var/alias ]; then
    cp ~/.bashrc .var
    echo >> ~/.bashrc
    echo >> ~/.bashrc "alias ScratchScript='cd $dir && ./start.sh'"
    echo >> .var/alias "This file tells the program that the alias is already created. Please don't touch this."
    echo "Please restart your terminal."
  else
    echo "alias has already been created."
  fi
elif [ $input == 6 ]; then
  chmod 755 rmaliasiloop.sh
  ./rmaliasiloop.sh
elif [ $input == 7 ]; then
  rm .var/devmode
  ./start.sh
elif [ $input == 8 ]; then
  if [ -f .var/.bashrc ]; then
    rm .var/.bashrc
  fi
  if [ -f .var/alias ]; then
    rm .var/alias
  fi
  if [ -f .var/devmode ]; then
    rm .var/devmode
  fi
elif [ $input == 9 ]; then
  if [ -f .var/.bashrc ]; then
    rm .var/.bashrc
  fi
  if [ -f .var/alias ]; then
    rm .var/alias
  fi
  if [ -f .var/devmode ]; then
    rm .var/devmode
  fi
  if [ -f compile.exe ]; then
    rm compile.exe
  fi
  if [ -f decompile.exe ]; then
    rm decompile.exe
  fi
elif [ $input = 10 ]; then
  clear
else
  echo "$input is not an input!"
  ./inputloop.sh
fi