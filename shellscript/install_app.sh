#!/bin/bash 
# color definition
red=`tput setaf 1`
cyan=`tput setaf 6`
reset=`tput sgr0`

# spinner classes
function _spinner() {
    # $1 start/stop
    #
    # on start: $2 display message
    # on stop : $2 process exit status
    #           $3 spinner function pid (supplied from stop_spinner)

    local on_success="DONE"
    local on_fail="FAIL"
    local white="\e[1;37m"
    local green="\e[1;32m"
    local red="\e[1;31m"
    local nc="\e[0m"

    case $1 in
        start)
            # calculate the column where spinner and status msg will be displayed
            let column=$(tput cols)-${#2}-8
            # display message and position the cursor in $column column
            echo -ne ${2}
            printf "%${column}s"

            # start spinner
            i=1
            sp='\|/-'
            delay=${SPINNER_DELAY:-0.15}

            while :
            do
                printf "\b${sp:i++%${#sp}:1}"
                sleep $delay
            done
            ;;
        stop)
            if [[ -z ${3} ]]; then
                echo "spinner is not running.."
                exit 1
            fi

            kill $3 > /dev/null 2>&1

            # inform the user uppon success or failure
            echo -en "\b["
            if [[ $2 -eq 0 ]]; then
                echo -en "${green}${on_success}${nc}"
            else
                echo -en "${red}${on_fail}${nc}"
            fi
            echo -e "]"
            ;;
        *)
            echo "invalid argument, try {start/stop}"
            exit 1
            ;;
    esac
}

function start_spinner {
    # $1 : msg to display
    _spinner "start" "${1}" &
    # set global spinner pid
    _sp_pid=$!
    disown
}

function stop_spinner {
    # $1 : command exit status
    _spinner "stop" $1 $_sp_pid
    unset _sp_pid
}
# Start
echo "${cyan}Following Apps Will Be All Installed:"
echo ""
echo "Programming:"
echo "1.  GCC	        	- A Powerful Code Complier"
echo "2.  Emacs		- A Powerful Code Editor"
echo "3.  Nano*		- A User-friendly Code Editor"
echo "4.  VIM*		- A Classic Code Editor"
echo "5.  caca-utils		- Libcaca Utility"
echo "6.  Git	        	- A Commonly-used Version Control System "
echo "7.  Python*		- Python Programming Language Library"
echo ""
echo "System Utility:"
echo "1.  Htop		- A Beautiful Process Manager"
echo "2.  Midnight Commander	- A Full-featured GUI File Manager"
echo "3.  Tmux*		- A Command Split-Screen UI"
echo ""
echo "Miselleous:"
echo "1.  Links		- A Full-featured Text-based Web Browser"
echo "2.  Fortune		- A Simple Pseudorandom Message Display Program"
echo "3.  COWSAY		- What Does Cow Say?"
echo ""
echo "*They are pre-installed in System"
echo ""
echo "*****************************${reset}"
read -p "Do you want to continue?[y/n]: " option
if [ "${option}" == "y" ]; then
    start_spinner "Updating apt-get and apps..."
    sudo apt-get update &> /dev/null
    sudo apt-get upgrade -y &> /dev/null
    stop_spinner $?
    start_spinner "Installing GCC..."
    sudo apt-get install gcc -y &> /dev/null
    stop_spinner $?
    start_spinner "Instaling Emacs..."
    sudo apt-get install emacs24-nox -y &> /dev/null
    stop_spinner $?
    start_spinner "Installing Nano..."
    sudo apt-get install nano -y &> /dev/null
    stop_spinner $?
    start_spinner "Installing VIM..."
    sudo apt-get install vim -y &> /dev/null
    stop_spinner $?
    start_spinner "Installing caca-utils..."
    sudo apt-get install caca-utils -y &> /dev/null
    stop_spinner $?
    start_spinner "Installing Git..."
    sudo apt-get install git-core -y &> /dev/null
    stop_spinner $?
    start_spinner "Installing Python..."
    sudo apt-get install python3 python -y &> /dev/null
    stop_spinner $?
    start_spinner "Installing Htop..."
    sudo apt-get install htop -y &> /dev/null
    stop_spinner $?
    start_spinner "Installing Midnight Commander..."
    sudo apt-get install mc -y &> /dev/null
    stop_spinner $?
    start_spinner "Installing tmux..."
    sudo apt-get install tmux -y &> /dev/null
    stop_spinner $?
    start_spinner "Installing Links..."
    sudo apt-get install links -y &> /dev/null
    stop_spinner $?
    start_spinner "Installing Fortune..."
    sudo apt-get install fortune -y &> /dev/null
    stop_spinner $?
    start_spinner "Installing COWSAY..."
    sudo apt-get install cowsay -y &> /dev/null
    stop_spinner $?
    echo "${cyan}Complete.${reset}"
else 
    echo "${red}Operation Abort.${reset}"
fi
