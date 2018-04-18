#!/bin/bash
echo "Initializing Bash On Ubuntu On Windows..."
sudo ./init_bashrc.sh
echo "Finished initializing .bashrc."
sudo ./install_app.sh
echo "Finished installing essential apps."
echo "done."
echo "Opening Hexo Installer..."
sudo ./hexo.sh
