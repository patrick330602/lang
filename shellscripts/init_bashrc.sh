#!/bin/bash
green=`tput setaf 2`
reset=`tput sgr0`
echo "${green}Importing .bashrc settings...${reset}"
echo "" >> ~/.bashrc
echo "# apt-get aliases" >> ~/.bashrc
echo "alias install='sudo apt-get install'" >> ~/.bashrc
echo "alias remove='sudo apt-get remove'" >> ~/.bashrc
echo "alias autoremove='sudo apt-get autoremove'" >> ~/.bashrc
echo "alias update='sudo apt-get update'" >> ~/.bashrc
echo "alias upgrade='sudo apt-get upgrade'" >> ~/.bashrc
echo "${green}done.${reset}"
