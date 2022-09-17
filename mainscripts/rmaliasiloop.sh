echo "WARNING: This will revert the .bashrc to before you created the ScratchScript alias."
echo "That means any aliases you created after creating the ScratchScript alias will be erased."
echo "Continue? [Y/N]"
read input2
if [ $input2 == Y ] || [ $input2 == y ]; then
  rm ~/.bashrc
  rm .var/alias
  cp .var/.bashrc ~/
  rm .var/.bashrc
  echo "Please restart your terminal."
elif [ $input2 == n ] || [ $input2 == N ]; then
  echo
else
  echo "$input2 is not an option."
  ./rmaliasiloop.sh
fi