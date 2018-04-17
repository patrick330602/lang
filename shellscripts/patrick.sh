#!/bin/bash
# basic Data Initialising

green=`tput setaf 2`
reset=`tput sgr0`
password=`echo "PK" | sha256sum | base64 | head -c 32`

# Initialising

if [ -f /etc/contrl.$password ]; then
  echo "Do not run the setup again."
  exit 1
else
  if hash dialog 2>/dev/null; then
    echo "${green}Starting Initializer...${reset}"
  else
    echo "${green}Starting Initializer...${reset}"
    sudo apt-get update  &> /dev/null
    sudo apt-get install dialog  &> /dev/null
  fi

  dialog --title "CAUTION" --backtitle "PK WSL Device Initializer" --keep-window --msgbox "Make sure you are sudo-run this script" 7 30 \
  --and-widget --title "WSL Device Initializer" --keep-window\
  --backtitle "By WE. Studio @ 2015-2016. All rights reserved." \
  --yesno "Are you sure you want to start? This will:
  -Initialize .bashrc
  -Dbus And X Server Fix
  -Install following apps:
    GCC,Emacs,caca-utils,Git,Python,Htop,Midnight  
    Commander,Links,Fortune,cowsay
  -Set up Hexo Web Platform
  -Install HUB" 14 60 

  
  # Get exit status
  response=$?

  case $response in
    0)
      echo "0" | dialog --gauge "Importing .bashrc settings..." 10 70 0
      echo "" >> /home/PK/.bashrc
      echo "# apt-get aliases" >> /home/PK/.bashrc
      echo "alias install='sudo apt-get install'" >> /home/PK/.bashrc
      echo "alias remove='sudo apt-get remove'" >> /home/PK/.bashrc
      echo "alias autoremove='sudo apt-get autoremove'" >> /home/PK/.bashrc
      echo "alias update='sudo apt-get update'" >> /home/PK/.bashrc
      echo "alias upgrade='sudo apt-get upgrade'" >> /home/PK/.bashrc
      echo "" >> /home/PK/.bashrc
      echo "# Fixes" >> /home/PK/.bashrc
      echo "alias hub='/mnt/f/wsl/hub.sh'" >> /home/PK/.bashrc
      echo "3" | dialog --gauge "Updating System..." 10 70 0
      sudo apt-get update &> /dev/null
      sudo apt-get upgrade -y &> /dev/null
      echo "7" | dialog --gauge "Installing GCC..." 10 70 0
      sudo apt-get install gcc -y &> /dev/null
      echo "17" | dialog --gauge "Installing caca-utils..." 10 70 0
      sudo apt-get install caca-utils -y &> /dev/null
      echo "22" | dialog --gauge "Installing Git..." 10 70 0
      sudo apt-get install git-core -y &> /dev/null
      echo "29" | dialog --gauge "Installing Python..." 10 70 0
      sudo apt-get install python3 python -y &> /dev/null
      echo "34" | dialog --gauge "Installing Midnight Commander..." 10 70 0
      sudo apt-get install mc -y &> /dev/null
      echo "40" | dialog --gauge "Installing Links..." 10 70 0
      sudo apt-get install links -y &> /dev/null
      echo "45" | dialog --gauge "Installing Fortune..." 10 70 0
      sudo apt-get install fortune -y &> /dev/null
      echo "47" | dialog --gauge "Installing COWSAY..." 10 70 0
      sudo apt-get install cowsay -y &> /dev/null
      echo "49" | dialog --gauge "Hexo Installation
      Installing Node.js..." 10 70 0
      sudo apt-get install nodejs -y &> /dev/null
      echo "54" | dialog --gauge "Hexo Installation
      Installing Node Package Manager..." 10 70 0
      sudo apt-get install npm -y &> /dev/null
      echo "58" | dialog --gauge "Hexo Installation
      Create a symbolic link for node..." 10 70 0
      sudo ln -s /usr/bin/nodejs /usr/bin/node &> /dev/null
      echo "59" | dialog --gauge "Hexo Installation
      Updating Node Package Manager..." 10 70 0
      sudo npm install npm -g &> /dev/null
      echo "62" | dialog --gauge "Hexo Installation
      Installing Module n..." 10 70 0
      sudo npm install n -g &> /dev/null
      echo "64" | dialog --gauge "Hexo Installation
      Updating Node.js to Latest Stable..." 10 70 0
      sudo n stable &> /dev/null
      echo "67" | dialog --gauge "Hexo Installation
      Installing Hexo..." 10 70 0
      sudo npm install -g hexo-cli &> /dev/null
      echo "70" | dialog -gauge "Ruby Installation
      Add repository to apt-get..." 10 70 0
      sudo apt-add-repository ppa:brightbox/ruby-ng -y &> /dev/null
      echo "75" | dialog -gauge "Ruby Installation
      Updating apt-get..." 10 70 0
      sudo apt-get update &> /dev/null
      echo "78" | dialog -gauge "Ruby Installation
      Installing ruby..." 10 70 0
      sudo apt-get install ruby2.3 ruby2.3-dev -y &> /dev/null
      echo "83" | dialog -gauge "Ruby Installation
      IUpdating gem..." 10 70 0
      sudo gem update --system  &> /dev/null
      echo "100" | dialog --gauge "Finishing..." 10 70 0 &> /dev/null
      dialog --title "Almost Done.." --clear --msgbox " You have Successfully initialized Bash On Ubuntu On Windows 10. Please Make Sure Visual C++ X Server is installed, and restart the Bash prompt.
      
      Enjoy coding!" 10 50
        clear
        exit
      ;;
    1)
      dialog --clear --msgbox "Action Cancelled." 6 15
      clear
      exit
      ;;
    255)
      dialog --clear --msgbox "Action Cancelled." 6 15
      clear
      exit
      ;;
  esac
fi
