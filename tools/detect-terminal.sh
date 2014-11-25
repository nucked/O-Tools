#!/bin/bash
rm runat x-terminal &>/dev/null
sudo update-alternatives --display x-terminal-emulator 2>&1 | tee x-terminal
term=$(cat x-terminal | grep 'xfce-termminal' )
if [[ $term == "" ]]; then
  term=$(cat x-terminal | grep 'gnome-terminal');
 else
   echo 'xfce-terminal' > runat
   rm x-terminal
   exit
fi
if [[ $term == "" ]]; then
 term=$(cat x-terminal | grep 'konsole');
 else
   echo 'gnome-terminal' > runat
   rm x-terminal
   exit
fi
if [[ $term == "" ]]; then
  term=$(cat x-terminal | grep 'lxterm');
else
  echo 'konsole' > runat
  rm x-terminal
  exit
fi
if [[ $term == "" ]]; then
  echo 'xtem' > runat
  rm x-terminal
else
  echo 'lxterm' > runat
  rm x-terminal
fi
exit
