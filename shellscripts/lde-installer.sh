#!/bin/bash
# Desktop Environment Installer
# By WE. Studio/Patrick Wu @ 2016 All rights reserved.

#Initializing Dialog

if hash dialog 2>/dev/null; then
  echo "Starting..."
else
  echo "Starting..."
  sudo apt-get update &> /dev/null
  sudo apt-get install dialog &> /dev/null
fi

dialog --title
