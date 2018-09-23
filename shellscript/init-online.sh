#!/bin/bash
echo "Initializing Bash On Ubuntu On Windows..."
wget -qO- https://ap.westudio.ml/sources/sh/init_bashrc.sh | sh
echo "Finished initializing .bashrc."
wget -qO- https://ap.westudio.ml/sources/sh/install_app.sh | sh
echo "Finished installing essential apps."
echo "done."
