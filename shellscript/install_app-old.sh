#!/bin/bash
red=`tput setaf 1`
cyan=`tput setaf 6`
green=`tput setaf 2`
reset=`tput sgr0`
echo "${cyan}Following Apps Will Be All Installed:"
echo ""
echo "1.  GCC	        - A Powerful Code Complier"
echo "2.  Htop	- A Beautiful Process Manager"
echo "3.  Emacs	- A Powerful Code Editor"
echo "4.  Links	- A Full-featured Text-based Web Browser"
echo "5.  Fortune	- A Simple Pseudorandom Message Display Program"
echo "6.  COWSAY	- What Does Cow Say?"
echo "7.  cacademo	- A Demo For Libcaca;Just Have Some Fun Watching It!"
echo "8.  Git	        - A Commonly-used Version Control System "
echo "*****************************${reset}"
read -p "Do you want to continue?[y/n]: " option
if [ "${option}" == "y" ]; then
    echo "${green}Installing apps...${reset}"
    sudo apt-get update
    sudo apt-get upgrade -y
    sudo apt-get install gcc -y
    sudo apt-get install htop -y
    sudo apt-get install links -y
    sudo apt-get install emacs24-nox -y
    sudo apt-get install fortune -y
    sudo apt-get install cowsay -y
    sudo apt-get install caca-utils -y
    sudo apt-get install git-core -y
    echo "Complete."
else 
    echo "${red}Operation Abort.${reset}"
fi