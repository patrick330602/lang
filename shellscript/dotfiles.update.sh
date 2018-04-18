#!/bin/bash
cp ~/.bashrc ~/Documents/dotfiles
cp ~/.zshrc ~/Documents/dotfiles
echo "Shell Configurations(zshrc,bashrc) Copied"
cp ~/.compton.conf ~/Documents/dotfiles
echo "Compton Configuration(compton.conf) Copied"
cp ~/.Xresources ~/Documents/dotfiles
cp ~/.xinitrc ~/Documents/dotfiles
cp ~/.xinputrc ~/Documents/dotfiles
echo "X Server Configurations(Xresources,xinitrc,xinputrc) Copied"
cp -r ~/.i3 ~/Documents/dotfiles 
cp ~/.i3blocks.conf ~/Documents/dotfiles
echo "i3 Window Manager Configurations(including i3,i3block,i3bar adn custom script) Copied"
cp ~/.gitconfig ~/Documents/dotfiles
echo "Git Configuration(gitconfig) Copied"
cp ~/.tmux.conf ~/Documents/dotfiles
echo "TMUX Configuration(tmux.conf) Copied"
cp ~/.vimperatorrc ~/Documents/dotfiles
echo "Vimperator Configuration(vimperatorrc) Copied"
cp ~/.vimrc ~/Documents/dotfiles
echo "Vi Improved Configuration(vimrc) Copied"
cp ~/.conkyrc ~/Documents/dotfiles
echo "Conky Configuration(conkyrc) Copied"
