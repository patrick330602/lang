#!/bin/bash
function hexo_generate()
{
    dialog --title "Hexo - Website Generation" --backtitle "Patrick WSL Hub" --radiolist "Choose Website:" 10 40 3 \
        1 "westudio.website" on \
        2 "blog.website" off 2> info
    choice=$(cat info)  
    echo "0" | dialog --title "Hexo - Website Generation" --backtitle "Patrick WSL Hub" --gauge "Swtiching to the folder..." 10 70 0
    case $choice in
	    1) cd /mnt/f/westudio.website/;;
	    2) cd /mnt/f/blog.website/;;
    esac
    echo "3" | dialog --title "Hexo - Website Generation" --backtitle "Patrick WSL Hub" --gauge "Cleaning Previously Generated Files..." 10 70 0
    hexo clean &> /dev/null
    echo "30" | dialog --title "Hexo - Website Generation" --backtitle "Patrick WSL Hub" --gauge "Generating Files..." 10 70 0
    hexo generate &> /dev/null
    echo "100" | dialog --title "Hexo - Website Generation" --backtitle "Patrick WSL Hub" --gauge "Generating Files..." 10 70 0
    dialog --backtitle "Patrick WSL Hub" --clear --msgbox "File Generated." 6 15
}
function hexo_post()
{
    dialog --title "Hexo - New Post" --backtitle "Patrick WSL Hub" --radiolist "Choose Website:" 10 40 3 \
        1 "westudio.website" on \
        2 "blog.website" off 2> info1
    choice1=$(cat info1)
    case $choice1 in
	    1)
        dialog --title "Hexo - New Post" --backtitle "Patrick WSL Hub" --radiolist "Choose Post Type:" 10 40 3 \
        Draft "Draft" on \
        Page "Page" off \
        Post "Post" off \
        Release "App Release" off 2> info2
        choice2=$(cat info2)
        ;;
	    2)
        dialog --title "Hexo - New Post" --backtitle "Patrick WSL Hub" --radiolist "Choose Post Type:" 10 40 3 \
        Draft "Draft" on \
        Page "Page" off \
        Post "Post" off 2> info2
        choice2=$(cat info2)
        ;;
    esac
    dialog --inputbox "Enter your Post filename:" 8 40 2>answer
    data=$(cat answer)
    dialog --title "Hexo - New Post" --backtitle "Patrick WSL Hub" --infobox "Creating..." 6 15
    case $choice1 in
	    1) cd /mnt/f/westudio.website/;;
	    2) cd /mnt/f/blog.website/;;
    esac
    hexo new $choice2 $data
    dialog --backtitle "Patrick WSL Hub" --clear --msgbox "New Post Created." 6 15
}
function tmlr_download()
{
    if [ ! -f /mnt/p/ ]; then
        dialog --clear --msgbox "Please mount Dirve P first." 8 15
    else
        echo "0" | dialog --gauge "Downloading Likes...
        This might take a while." 10 70 0
        cd /mnt/p/ &> /dev/null
        ruby export.rb likes mmkaydaybyday lGA39V0glP5wDBch4eK0dRx78gU9EJwGolvl2jXgQZ6Dm8zS7o &> /dev/null
        echo "50" | dialog --gauge "Downloading Posts...
        This might take a while." 10 70 0
        ruby export.rb posts mmkaydaybyday lGA39V0glP5wDBch4eK0dRx78gU9EJwGolvl2jXgQZ6Dm8zS7o &> /dev/null
        dialog --clear --msgbox "Download Complete." 6 15
    fi
}
function start_xfce()
{
    xfce4-session  
}
#
# set infinite loop
#
while true
do

### display main menu ###
dialog --clear --backtitle "Patrick WSL Hub" \
--title "[ M A I N - M E N U ]" \
--menu "You can use the UP/DOWN arrow keys, the first \n\
letter of the choice as a hot key, or the \n\
number keys 1-9 to choose an option.\n\
Choose the TASK" 16 50 5 \
HexoGen "Hexo - Website Generation" \
HexoNew "Hexo - New Post" \
TmlrDown "Drive P Tumblr Downloader" \
LDE "Start Linux Desktop Environment" \
Exit "Exit to the shell" 2> input

menuitem=$(cat input)


# make decsion 
case $menuitem in
	HexoGen) hexo_generate;;
	HexoNew) hexo_post;;
    TmlrDown) tmlr_download;;
    LDE) start_xfce;;
	Exit) clear; break;;
esac

done
